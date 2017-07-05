#!/bin/sh

# configuracion base
tar czf etc.tgz /etc \
                /root/.ssh \
                /var/adm/messages \
                /var/log/syslog

# version
showrev -a

# status de firewall
ipfstat
ipfstat -s

# paquetes instalados
pkginfo

# networking
echo "ipadm show-addr" >> /
dladm show-phys
ifconfig -a
netstat -in
netstat -r

# ultimos logins
last

# procesos
ps -auxw

# exports
/etc/exports
shareall

# filesystems
/etc/vfstab
/etc/dfs/dfstab
/etc/dfs/sharetab


