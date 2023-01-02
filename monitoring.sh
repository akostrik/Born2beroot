#!/bin/bash
arc=$(uname -a)

# The architecture of your operating system and its kernel version

# The number of physical processors
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

#The number of virtual processors
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)

#The current available RAM on your server and its utilization rate as a percentage
fram=$(free -m | awk '$1 == "Mem:" {print $2}')

# The current available memory on your server and its utilization rate as a percentage
uram=$(free -m | awk '$1 == "Mem:" {print $3}')

# The current utilization rate of your processors as a percentage
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# The date and time of the last reboot
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')

# Whether LVM is active or not
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')

# Whether LVM is active or not
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')

# The number of active connections
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')

# The number of users using the server
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')

# The IPv4 address of your server and its MAC (Media Access Control) address
lvmt=$(lsblk | grep "lvm" | wc -l)

# The number of commands executed with the sudo program
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)

#You need to install net tools for the next step [$ sudo apt install net-tools]
ctcp=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l) # journalctl should be running as sudo but our script is running as root so we don't need in sudo here
wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lb
	#LVM use: $lvmu
	#Connexions TCP: $ctcp ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" # broadcast our system information on all terminals

#!/bin/bash
#wall $'#Architecture: ' `hostnamectl | grep "Operating System" | cut -d ' ' -f5- ` `awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'` `arch` \
#$'\n#CPU physical: '`cat /proc/cpuinfo | grep processor | wc -l` \
#$'\n#vCPU:  '`cat /proc/cpuinfo | grep processor | wc -l` \
#$'\n'`free -m | awk 'NR==2{printf "#Memory Usage: %s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }'` \
#$'\n'`df -h | awk '$NF=="/"{printf "#Disk Usage: %d/%dGB (%s)", $3,$2,$5}'` \
#$'\n'`top -bn1 | grep load | awk '{printf "#CPU Load: %.2f\n", $(NF-2)}'` \
#$'\n#Last boot: ' `who -b | awk '{print $3" "$4" "$5}'` \
#$'\n#LVM use: ' `lsblk |grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"} }'` \
#$'\n#Connection TCP:' `netstat -an | grep ESTABLISHED |  wc -l` \
#$'\n#User log: ' `who | cut -d " " -f 1 | sort -u | wc -l` \
#$'\nNetwork: IP ' `hostname -I`"("`ip a | grep link/ether | awk '{print $2}'`")" \
#$'\n#Sudo:  ' `grep 'sudo ' /var/log/auth.log | wc -l`