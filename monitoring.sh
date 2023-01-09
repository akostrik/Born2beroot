#!/bin/bash
     architecture=$(uname -a)
nb_physical_procs=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
 nb_virtual_procs=$(grep "^processor"  /proc/cpuinfo |               wc -l)
              ram=$(free -m            | awk 'NR  == 2      {printf "%s/%sMB (%.2f%%)",$3,$2,$3*100/$2     }')
              mem=$(df -h              | awk '$NF == "/"    {printf "%d/%dGb (%s)    ",$3,$2,$5            }')
   proc_util_rate=$(free               | awk '$1  == "Mem:" {printf "%.2f            ",$3/$2*100           }')
 last_reboot_time=$(who -b             | awk '              {printf $3,$4                                  }')
    lvm_is_active=$(lsblk   | grep lvm | awk '              {if ($1) {printf "yes";exit;} else printf "no" }')
   nb_connections=$(netstat -an | grep CONNECTED | wc -l)
         nb_users=$(users | wc -w)
               ip=$(hostname -I)
              mac=$(ip link show | awk '$1=="link/ether" {printf $2}')
 nb_commamds_sudo=$(journalctl _COMM=sudo | grep COMMAMD | wc -l)

wall "
#Architecture: $architecture
#The number of physical processors: $nb_physical_procs
#The number of virtual processors: $nb_virtual_procs
#Memory Usage: $ram
#Disk Usage: $mem
#CPU load: $proc_util_rate
#Last reboot: $last_reboot_time
#LVM use: $lvm_is_active
#Connexions TCP: $nb_connections
#User log: $nb_users
#Network: IP $ip ($mac)
#Sudo: $nb_commands_sudo" # broadcast the information on all terminals

# wall = write all = сообщение на терминалах всех вошедших в систему пользователей
# awk утилита для обработки строк (извлечь лишь второй столбец из текстового файла, ...)
# df имя устройства, общее колво блоков, общ диск простр-во, используемое диск простр-во, доступн диск прост-во, точки монтирования
