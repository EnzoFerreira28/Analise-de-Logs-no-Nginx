#!/bin/bash

# Pega o diretório do script atual
#
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define a pasta de logs como sendo "logs" no nível superior ao script
#
LOG="${1:-"$SCRIPT_DIR/../logs/nginx-access.log"}"

echo "Top 5 IPs com mais requisições:"
awk '{print $1}' $LOG | sort | uniq -c | sort -rn | head -5

echo ""
echo "Top 5 caminhos mais acessados:"
awk '{print $7}' $LOG | sort | uniq -c | sort -rn | head -5

echo ""
echo "Top 5 códigos de status HTTP:"
awk '{print $9}' $LOG | grep -E '^[0-9]+$'  | sort | uniq -c | sort -rn | head -5

echo ""
echo "Top 5 user agents:"
awk -F'"' '{print $6}' $LOG | sort | uniq -c | sort -rn | head -5
