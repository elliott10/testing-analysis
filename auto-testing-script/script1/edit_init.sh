#!/bin/bash
## $1: ip_linux_host

ip_linux_host=$1

line2bottom=`tail /etc/rc.local -n 2 |head -n 1`

sed '$d' -i /etc/rc.local
sed '$d' -i /etc/rc.local

if [ "$line2bottom" == "" ]; then 
    echo "ip=\`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print \$2}'|tr -d 'addr:'\`
    echo \$ip | nc -q 0 $ip_linux_host 5556
    return 0" >> /etc/rc.local
else
    echo "      echo \$ip | nc -q 0 $ip_linux_host 5556
    return 0" >> /etc/rc.local
fi
