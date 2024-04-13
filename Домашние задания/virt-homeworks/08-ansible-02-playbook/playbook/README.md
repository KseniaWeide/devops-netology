###Описание Playbook

site.yml Устанавливает на хосты clickhouse и vector
В inventory/prod.yml задаем хосты docker
Поднимаем группу хостов docker-compose.yml
group_vars/clickhouse/vars.yml Переменные по версиям и устанавливаемому ПО от clickhouse
group_vars/vector.yml Переменные по версиям и устанавливаемому ПО от Vector