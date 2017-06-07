#!/bin/bash
# CASTOR: Cautiva Audit Script
# v0.0
#
# ingenieria@cautivatech.com
#

# packages needed
#yum install sos -y

# harvesting
echo "Recopilando status"
sysreport  --name $(hostname)  --batch 2&> /dev/null
sosreport  --name $(hostname)  --batch 2&> /dev/null
SOSPACKAGE="/tmp/sosreport_ALL-$(hostname).tgz"
tar czf $SOSPACKAGE  /etc /var/spool/cron /var/mail/root /var/log/sa /tmp/s?sreport*

# recuperacion
# OPCION 1: vía scp
cat <<EOF> /tmp/key
-----BEGIN DSA PRIVATE KEY-----
MIIBuwIBAAKBgQC8wsW8Gv0hDZ2pTy5ZghvuizYdjXtpZ7jKCtdMs/K4fv8V0zA6
d9bAkv6UXs206Jq+XYlD2eHjtZDP730IrlWT/BYEI5pMlMsoh+LkYu5HKAyM9Un6
4nVMWm1tEw7PNYnW+9HDBx8zminQKtZmCh7voN20YHtvGErgAmgXRzFgywIVAJyc
xvnANeWvijypIXjfQCFDcFllAoGAJgKy2QgvsaicYI0avxBDr6h8nfKLl8DoIvzN
uvLq3LNeKudZqsI0JBC8nPI58MVbP9g5gEiH6VZqjNUjBrAkXYA1lNZDUyRIM+bR
/BT5bxcI76XvK0iHSlU2oLCszEox1Y5MKezuEn786oac7X5iz5rEhBz0q+5AVofe
xaPZtKICgYEAmla8+1p6vJPw72Qyeja0cVtXrvVSXi8qHIDVF5X7VnQiRgK7o5AM
yn2YFDntZlUGMxZkeM0a/fICZVbD8srYpXDHJH1nk6kmElOSH1b6a5rRgrJ0q3Ut
JEHTpKcUxSYdhHXpezJHiUHDsPzWuzckiKujVStJxndFvOyD58sRBdoCFFkuMCVz
A61XB+qj/75M6/ecE7tj
-----END DSA PRIVATE KEY-----
EOF

scp -i /tmp/key $SOSPACKAGE 161.131.236.2:~/sosreport/
