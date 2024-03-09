# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

![img.png](img.png)
## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

`ansible-playbook -i inventory/test.yml site.yml`

![img_1.png](img_1.png)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

![img_2.png](img_2.png)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

`docker run -dt --name ubuntu  pycontribs/ubuntu && \
docker run -dt --name centos7  pycontribs/centos:7 `

![img_3.png](img_3.png)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

`ansible-playbook -i inventory/prod.yml site.yml` 

![img_4.png](img_4.png)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

![img_6.png](img_6.png)

6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![img_5.png](img_5.png)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

`ansible-vault encrypt_string "deb default fact"`

 `ansible-vault encrypt_string "el default fact"`

![img_7.png](img_7.png)

9. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

`ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`

![img_8.png](img_8.png)

10. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

`ansible-doc -l -t connection`

ansible.builtin.local          execute on controller


12. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

![img_9.png](img_9.png)

13. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![img_10.png](img_10.png)

14. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
15. Предоставьте скриншоты результатов запуска команд.


