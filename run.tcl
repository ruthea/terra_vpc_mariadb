#!/bin/tclsh
puts "SETTING CONFIGURATION"
dbset db mysql
diset connection mysql_host 10.0.2.20
diset connection mysql_port 3306
diset tpcc mysql_user dba
diset tpcc mysql_password demo_password
diset tpcc mysql_count_ware 800
diset tpcc mysql_partition true
diset tpcc mysql_num_vu 64
diset tpcc mysql_storage_engine innodb
print dict
buildschema
