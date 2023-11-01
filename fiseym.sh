#!/bin/bash

# <GNUBHCkalitarro> firewalld - selinux - yum  搭建

systemctl stop firewalld
systemctl disable firewalld
fire=$?
# 关闭防火墙

echo 'SELINUX=disabled' > /etc/selinux/config
echo 'SELINUXTYPE=targeted' >> /etc/selinux/config
setenforce 0
set=$?
# 关闭selinux

mount /dev/cdrom /mnt
cdrom=$?
# 挂载镜像

echo '/dev/cdrom              /mnt                    iso9660 defaults        0 0' >> /etc/fstab
fs=$?
# 开机自动挂载

rm -rf /etc/yum.repos.d/*
echo '[123]' > /etc/yum.repos.d/123.repo
echo 'name=123' >> /etc/yum.repos.d/123.repo
echo 'baseurl=file:///mnt' >> /etc/yum.repos.d/123.repo
echo 'enabled=1' >> /etc/yum.repos.d/123.repo
echo 'gpgcheck=0' >> /etc/yum.repos.d/123.repo
yum=$?
# 写入yum 

clear

echo ' _____      _      ____    ____     ___  '
echo '|_   _|    / \    |  _ \  |  _ \   / _ \ '
echo '  | |     / _ \   | |_) | | |_) | | | | |'
echo '  | |    / ___ \  |  _ <  |  _ <  | |_| |'
echo '  |_|   /_/   \_\ |_| \_\ |_| \_\  \___/    --- 由GNUBHCkalitarro提供'



echo '_______________________________________________________________'
[ $fire = 0 ] && echo "<yes>	永久关闭防火墙" || echo "<no>	永久关闭防火墙"
[ $set = 0 ] && echo "<yes>	永久关闭seLinux" || echo "<no>	永久关闭seLinux"
[ $cdrom = 0 ] && echo "<yes>	挂载/dev/cdrom到/mnt" || echo "<no>	挂载/dev/cdrom到/mnt" 
[ $fs = 0 ] && echo "<yes>	将/dev/cdrom写入到/etc/fstab" || echo "<no>	将/dev/cdrom写入到/etc/fstab"
[ $yum = 0 ] && echo "<yes>	创建yum仓库" || echo "<no>	创建yum仓库"



echo "当前执行时间为:`date`"
echo "当前用户为：$USER"
echo "最后一次此脚本更新日期为：2023-9-12"
echo '_______________________________________________________________'

read -p "是否配置ip（y/n）：" ipyn

if [ $ipyn = "y" ]
then
	read -p "输入ip地址:" ip
	echo 'TYPE=Ethernet' > /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'PROXY_METHOD=none' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'BROWSER_ONLY=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'BOOTPROTO=static' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV4_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6INIT=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6_AUTOCONF=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6_DEFROUTE=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6_FAILURE_FATAL=no' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'IPV6_ADDR_GEN_MODE=stable-privacy' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'NAME=ens33' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'DEVICE=ens33' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'ONBOOT=yes' >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo "IPADDR=$ip" >> /etc/sysconfig/network-scripts/ifcfg-ens33
	echo 'NETMASK=255.255.255.0' >> /etc/sysconfig/network-scripts/ifcfg-ens33
fi
systemctl restart network


