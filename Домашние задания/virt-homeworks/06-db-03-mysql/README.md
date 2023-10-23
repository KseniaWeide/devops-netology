# Домашнее задание к занятию "3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

- Решение поднять mysql
```bash
# cat docker-compose.yml
version: '3.6'

volumes:
  data-mysql:
  bkp-mysql:
services:
  db:
   image: mysql:8
   restart: always
   container_name: mmm
   environment:
      MYSQL_ROOT_PASSWORD: 7777
   volumes:
      - data-mysql:/var/lib/mysql
      - bkp-mysql:/home/bkp-mysql
   ports:
      - "3306:3306"
```
- Решение переход в управляющую консоль mysql
```bash
#docker-compose up -d

#docker cp test_dump.sql mmm:/tmp
Preparing to copy...
Copying to container - 4.096kB
Successfully copied 4.096kB to mmm:/tmp
#docker exec -it mmm bash
#bash-4.4# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
```
- решение вызова статуса
```sql
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		9
Current database:
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.32 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			5 hours 57 min 43 sec

Threads: 2  Questions: 6  Slow queries: 0  Opens: 119  Flush tables: 3  Open tables: 38  Queries per second avg: 0.000
--------------
```
- Решение по работе с БД
```sql
mysql> create database test_db;
Query OK, 1 row affected (0.01 sec)
mysql> source /tmp/test_dump.sql
....
Query OK, 0 rows affected (0.00 sec)
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
mysql> select * from orders where price>300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

- Решение создание пользователя
```sql
mysql> CREATE USER 'test'@'localhost'
    -> IDENTIFIED WITH mysql_native_password BY 'test-pass'
    -> WITH MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 1
    -> ATTRIBUTE '{"family":"Pretty", "name":"James"}';
Query OK, 0 rows affected (0.01 sec)
```

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

- Решение
```sql
mysql> GRANT SELECT ON test_db.* TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.00 sec)
```

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

- Решение
```sql
mysql> SELECT ATTRIBUTE FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+---------------------------------------+
| ATTRIBUTE                             |
+---------------------------------------+
| {"name": "James", "family": "Pretty"} |
+---------------------------------------+
1 row in set (0.00 sec)
```


## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.
```sql
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00061125 | SET profiling = 1 |
+----------+------------+-------------------+
1 row in set, 1 warning (0.00 sec)
```

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

- Ответ - InnoDB

```sql
mysql> SHOW TABLE STATUS;
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2023-03-04 16:05:21 | 2023-03-04 16:05:21 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.01 sec)
```
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
```sql
mysql> ALTER TABLE orders ENGINE MyISAM;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
- на `InnoDB`
```sql
mysql> ALTER TABLE orders ENGINE InnoDB;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0
```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

```bash
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
#innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

#### настройки 
##размер буфера
innodb_buffer_pool_size = 1840M
##настройка скорости IO
innodb_io_capacity = 1000
innodb_flush_log_at_trx_commit = 2
##сжатие файлов таблиц
innodb_file_per_table = 1
innodb_file_format = Barracuda
##лог с незаконченными таблицами
innodb_log_buffer_size = 1M
##лог операций
innodb_log_file_size = 100M

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/
```
