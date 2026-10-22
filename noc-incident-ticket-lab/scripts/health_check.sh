#!/usr/bin/env bash
# Local NOC health check for an Ubuntu lab. Reports status; does not remediate.
set -u

echo "================================"
echo " NOC SERVER HEALTH CHECK"
echo " Host: $(hostname)"
echo " Time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "================================"

echo
echo "[1] Root filesystem usage"
df -h /

echo
echo "[2] Apache service status"
if systemctl is-active --quiet apache2; then
    echo "Apache status: RUNNING"
else
    echo "Apache status: NOT RUNNING"
fi

echo
echo "[3] TCP listener on port 80"
if ss -lnt | awk 'NR > 1 {print $4}' | grep -Eq '(^|\[::\]|\*)?:80$|^0\.0\.0\.0:80$|^\[::\]:80$'; then
    echo "Port 80: LISTENING (review ss output if needed)"
    ss -lntp | grep ':80' || true
else
    echo "Port 80: NO LISTENER DETECTED"
fi

echo
echo "[4] Local HTTP response"
if command -v curl >/dev/null 2>&1; then
    if curl -sS --max-time 5 -o /dev/null -w 'HTTP status: %{http_code}\n' http://localhost; then
        echo "HTTP request: COMPLETED"
    else
        echo "HTTP request: FAILED"
    fi
else
    echo "curl is not installed; install it with: sudo apt install curl"
fi

echo
echo "Health check complete. Investigate failures before taking action."
