#!/bin/bash

ip=$1
if [ ! -n "$ip" ]
then
	echo "the ip param can not be empty!"
	exit
fi

#截取网卡设备名
enp=$(ls /etc/sysconfig/network-scripts/ | egrep ifcfg | grep en.* | awk -F "-" '{print $2}')

#网卡路径
enpway=/etc/sysconfig/network-scripts/ifcfg-$enp

#截取路由
#若未找到 netstat 命令, 则请先安装’net-tools‘
#rt=$(netstat -rn | head -3 | tail -1 | awk -F "" '{print $2}')

#修改配置文件
#sed -i 's/dhcp/static/g' $enpway
#sed -i '/ONBOOT/c ONBOOT=yes' $enpway
sed -i "/IPADDR=/c IPADDR=\"$ip\"" $enpway

#这里我们已经有这些内容了所以不用追加
#追加配置内容
#cat >>/etc/sysconfig/network-scripts/ifcfg-$enp <<EOF

#NM_CONTROLLED=no
#IPADDR=$ip

#GATEWAY=$rt
#NETMASK=255.255.255.0
#DNS1=223.5.5.5
#DNS2=8.8.8.8
#EOF

#重启网卡
systemctl restart network
