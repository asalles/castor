#!/bin/bash
#
# CASTOR: Cautiva Audit Script
# v0.5
#
# ingenieria@cautivatech.com
#

# packages needed
#yum install sos -y

# harvesting
echo "Proceso de recopilacion de datos ... [ OK ]"
sysreport  --name $(hostname)  --batch 2&> /tmp/castor.1.log
sosreport  --name $(hostname)  --batch 2&> /tmp/castor.2.log
last > /tmp/notas
echo "== ">> /tmp/notas 
SOSPACKAGE="/tmp/sosreport_ALL-$(hostname)_$(date +%Y%m%d_%H%M).tgz"
tar czf $SOSPACKAGE  /etc /var/spool/cron /var/mail/root /root/.ssh /tmp/s?sreport* /tmp/notas /var/tmp/s?sreport* /tmp/castor.1.log /tmp/castor.2.log 2&> /tmp/castor.3.log
echo "[ FINISHED ] "

# recuperacion
echo "Proceso de envio de datos ... [ OK ]"
# OPCION 1: vía scp
cat <<EOF> /tmp/key
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAuuEEp54pLvkBnfa2PLHrJt5Ggi8L0DsSgIZ8TiQq9sX3Ucs+
j6mpiAPHGxGdwSqUzs5T5+SYEWFQtW4+G1Y/v4s5FFs0Eb98iOkxvQzwqbDJ0lnM
VPcgd845QvOshkmsZNgYMOydcfHoaA1EbnqekifSmCcQtTKCjXT33fYVuLbUR+EF
P8Fzt/hff2GQ7hOrnWCGBbVfGmqghX9T4/PvToeHGyyGyvv/BXUEK9s4pcE6E02B
JDQ5j3hOHECh6Qff6OSQnhayeLzxEhJL7h70nybUKjH2JG18u1B511NhGCDGDXMg
NgtQwCNJtub6cdB1rKXvdcxNrkNYIMpNYAu7LwIDAQABAoIBABIU1YN2TRvLYfmr
tkQ3Hr57AS11adoy7P5chMh2vWV1EBHs7VevHcUYQHqBANeAzDcaRYoJVyFPXiS/
zuiMNszMprAuhuI0udLxZSuaheqVPWHJ6HhMFOsim+27b/TqSfDT67tIGY+9zTPM
HNPnr1IK4lhwZzBw+6q+J4FlXwKpG4utC5PEgTjE1BObA5ncYtNeJgn7BXQTdqXq
24UijHzl1Q22jMuXZ3y+f0NFYVU2WC3zgJxT6oDPYjco6paHOc3yGeb3oVNlDXwP
OiBYP5YKa2kRPGNJGPHl3BvrmpJq7292Su8YntMCf4qY8CocjOrCoOWLb7L228ZW
X/GpaHECgYEA5uAMYkQMGl54QrBNPILrXaIR+EBWbl4v/Ey7zyV8TD4CzBJs5Jxb
vTXCbeNjzrbLSYkOJJmmdw4U00XIuxO/yoAGovZ3im/k0nYd3OuXLIUzyD7rSgtF
+pSBmWxGxZQp5DLKvL5N7CMtckSI6pnT0TEIVJ4DQtHx2T2rBfSHxwkCgYEAzzdH
hpGbY+AuFR7kPPenNQBQZP1nrwFj1Q6Dl3odTJwSerMDmYlqPGU8nodCdiRtLucy
dcfbmqtMqyQt8zWd+3GCpymElGR5SkmRHE34iz+yeSWBzJOqEA9cGSZjREU0ngNI
fRafUaczq2WXKGNSolSibElraNS0s1z1moEkBncCgYAZSzqQGXxp9yedxsrvcjhv
Da6CUCon9VG0hoOc8jJn9/M+gFZFxYuXcyhV+a+ZmhUzfTx7bgn6ySQm8WJIfKVq
fhQ8DlySYifjluU2qujpC77clWgZuJp2FYcNU/t88fqU8aucegz3bfMwramCak/2
fzS2cIlS7MVeU49FG8E0YQKBgGexFua9GFA7T3QcOERV/WMlXBWdRPQrMuTb1XfI
kL7UXt7tk8CSJgpA8ru1ncl24vgUk4ii0T6tt7jwatoIm5zGqYWy3fhP6u4EsEvE
rLopzsqWvUQ9JF3TAdhIAGaaZwEnTW/jESiQDegX9zMruJ8o0Pp1Jv2XazFSNEjz
lK5zAoGAQvtQwLfxduEGv4KN1N2l6oiRtPo7Qq8P4jVBe57szgxmYQTfto29dMnh
jTAAy/6yHVxyNK64qaXwhjG4OR8K8/l1d7o7WVURh7DrD6ZM902cG1XCZO8pnCy8
NEIAMiPUORWcl2tTdSVY7kAGUInm8thZU0RZkadQ78KI29Usj3o=
-----END RSA PRIVATE KEY-----
EOF
chmod 400 /tmp/key

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /tmp/key $SOSPACKAGE sosreport@161.131.236.2:~/sosreport/
rm -rf /tmp/key
echo "[ FINISHED ]"
