resource "local_file" "hosts_cfg" {
  depends_on = [ yandex_compute_instance.web, yandex_compute_instance.wm-disk]
  content = templatefile("${path.module}/hosts.tftpl",

    { web = yandex_compute_instance.web,
      wm-each = yandex_compute_instance.vm-each,
      wm-disk = [yandex_compute_instance.wm-disk]
     }
  )

  filename = "${abspath(path.module)}/hosts.cfg"
}


resource "null_resource" "web_hosts_provision" {
#Ждем создания инстанса
depends_on = [yandex_compute_instance.vm-each]

#Добавление ПРИВАТНОГО ssh ключа в ssh-agent
 provisioner "local-exec" {
    command = "eval $(ssh-agent -s) && echo $? | cat ~/.ssh/id_ed25519 | ssh-add -"
 }
 
 provisioner "local-exec" {
 command = "sleep 30"
 }
#Запуск ansible-playbook
 provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
 }
    triggers = {
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
      ssh_public_key     = "${file("~/.ssh/id_ed25519.pub")}" # при изменении переменной
    }

}
