#!/bin/bash

echo "==================== System Information ===================="
echo "Hostname: $(hostname)"
echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"
echo "Kernel Version: $(uname -r)"
echo ""

echo "==================== Uptime ===================="
uptime -p
echo ""

echo "==================== Load Average ===================="
uptime | awk -F'load average:' '{ print "Load Average: " $2 }'
echo ""

echo "==================== Logged In Users ===================="
who
echo ""

echo "==================== Failed Login Attempts ===================="
if command -v faillog &> /dev/null; then
    sudo faillog -a | head
elif command -v journalctl &> /dev/null; then
    echo "Recent failed SSH logins:"
    journalctl -u ssh -b --priority=3 | grep -i "failed"
else
    echo "Failed login tool not found on this system."
fi
echo ""

echo "==================== CPU Usage ===================="
top -bn1 | grep "Cpu(s)"
echo ""

echo "==================== Memory Usage ===================="
free -h
echo ""
echo "Memory Used Percentage:"
free | awk '/Mem:/ {printf("Used: %.2f%%\n", $3/$2 * 100)}'
echo ""

echo "==================== Disk Usage ===================="
df -h /
echo ""
echo "Disk Used Percentage:"
df | awk '/\/$/ {printf("Used: %.2f%%\n", $3/($2) * 100)}'
echo ""

echo "==================== Top 5 Processes by CPU ===================="
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

echo "==================== Top 5 Processes by Memory ===================="
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

echo "==================== Completed ===================="
