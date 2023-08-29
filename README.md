# wazuh-telegram
Integration Wazuh Telegram with Active Response

I created this script because using the Wazuh integration module, the alerts on Telegram were delayed.

In this way they were normalized.

I hope it helps you too.

1) Create File

      sudo vi /var/ossec/active-response/bin/wazuh-telegram.sh

2) Paste the Script - wazuh-telegram.sh

3) Set permissions

chmod 750 /var/ossec/active-response/bin/wazuh-telegram.sh
chown root:wazuh /var/ossec/active-response/bin/wazuh-telegram.sh

4) Config Ossec.conf




