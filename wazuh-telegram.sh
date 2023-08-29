CHAT_ID="-XXXXXX" #Modify
HOOK_URL="https://api.telegram.org/botXXXXXXXXXXXXXXXXX/sendMessage" #Modify

# Log file
LOG_AR="/var/ossec/logs/active-responses.log"

# Captura o alerta passado pelo Wazuh em formato json e salva na variavel ALERTA
read -r ALERTA

ACAO=$(echo "$ALERTA" | jq -r '.command' | tr -d "\"")
AGENT_NAME=$(echo "$ALERTA" | jq -r '.parameters.alert.agent.name' | tr -d "\"")
RULE_DESCRIPTION=$(echo "$ALERTA" | jq -r '.parameters.alert.rule.description' | tr -d "\"")
RULE_LEVEL=$(echo "$ALERTA" | jq -r '.parameters.alert.rule.level' | tr -d "\"")
RULE_GROUPS=$(echo "$ALERTA" | jq -r '.parameters.alert.rule.groups' | tr -d "\"")



# Logando
echo "$(date) $0 $ALERTA" >> "$LOG_AR"

# Generate request payload with formatted message
MSG_DATA=$(jq -n --arg CHAT_ID "$CHAT_ID" \
                --arg DESCRIPTION "$RULE_DESCRIPTION" \
                --arg ALERT_LEVEL "$RULE_LEVEL" \
                --arg AGENT "$AGENT_NAME" \
                --arg GROUPS "$RULE_GROUPS" \
                '{ chat_id: $CHAT_ID,
                text: "Alerta Empresa\n\nDescrição: \($DESCRIPTION)\n\nAlert Level: \($ALERT_LEVEL)\n\nGrupos: \($GROUPS)\n\nAgente: \($AGENT)"
                }')

# Send the request
curl -X POST -H "Content-Type: application/json" -H "Accept-Charset: UTF-8" -d "$MSG_DATA" "$HOOK_URL"

exit 0
