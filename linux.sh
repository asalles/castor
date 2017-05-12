#!/bin/bash
# CASTOR: Cautiva Audition Script "The Onlys Ricopileichor"
# v0.0
#
# ingenieria@cautivatech.com
#

# packages needed
# yum install sos -y

# harvesting
echo "Recopilando status"
sysreport  --name $(hostname)  --batch 2&> /dev/null
sosreport  --name $(hostname)  --batch 2&> /dev/null
tar czf /tmp/sosreport-etc-$(hostname).tgz  /etc /var/spool/cron /var/mail/root /var/log/sa
ORIGEN="/tmp/sosreport*"

# recuperacion
echo "Ingrese destino sftp/ssh (ej. IP_SERVER:/PATH)"
read DESTINO
scp /var/$ORIGEN $ORIGEN $DESTINO
