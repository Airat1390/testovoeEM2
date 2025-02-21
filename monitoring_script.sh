#!/bin/bash

# Проверка наличия процесса 'test'
if pgrep -f "test" > /dev/null; then
    # Если процесс найден, отправляем запрос по HTTPS
    RESPONSE=$(curl -s -w "%{http_code" -o /dev/null -X POST https://example.com/monitoring_endpoint)
    if [ "$RESPONSE -eq 200" ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Successfully pinged monitoring server." >> /var/log/monitoring.log
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Failed to reach monitoring server. Status code: $RESPONSE" >> /var/log/monitoring.log
    fi
else
    # Если процесса нет, ничего не делаем
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Process 'test' is not running." >> /var/log/monitoring.log
fi

