#!/bin/bash

server1=akostrik2@127.0.0.1      # server IP
server2=akostrik2@10.0.2.15
server3=10.0.2.15
server4=127.0.0.1
server5=akostrik@127.0.0.1
server6=akostrik@10.0.2.15
port1=4242                 # port
port2=2222
connect_timeout=5       # Connection timeout

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server1 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server1 over port $port1 is possible"
else
   echo "SSH connection to $server1 over port $port1 is not possible"
fi

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server2 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server2 over port $port1 is possible"
else
   echo "SSH connection to $server2 over port $port1 is not possible"
fi

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server3 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server3 over port $port1 is possible"
else
   echo "SSH connection to $server3 over port $port1 is not possible"
fi

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server4 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server4 over port $port1 is possible"
else
   echo "SSH connection to $server4 over port $port1 is not possible"
fi

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server5 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server5 over port $port1 is possible"
else
   echo "SSH connection to $server5 over port $port1 is not possible"
fi

ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server6 -p $port1 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server6 over port $port1 is possible"
else
   echo "SSH connection to $server6 over port $port1 is not possible"
fi




ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=$connect_timeout $server1 -p $port2 'exit 0'
if [ $? == 0 ];then
   echo "SSH Connection to $server1 over port $port2 is possible"
else
   echo "SSH connection to $server1 over port $port2 is not possible"
fi
