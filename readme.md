# Server Performance Stats Script

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A comprehensive Bash script for analyzing and monitoring Linux server performance metrics in real-time.

## 📋 Project Overview

`server-stats.sh` is a lightweight, portable shell script designed to provide quick insights into server performance and system health. It displays essential metrics including CPU usage, memory consumption, disk utilization, and process information.

**Project URL**: [roadmap.sh/projects/server-stats](https://roadmap.sh/projects/server-stats)

## ✨ Features

### Core Metrics
- ✅ **Total CPU Usage** - Real-time CPU utilization statistics
- ✅ **Memory Usage** - Free vs Used memory with percentages
- ✅ **Disk Usage** - Available vs Used disk space with percentages
- ✅ **Top 5 CPU Processes** - Processes consuming most CPU resources
- ✅ **Top 5 Memory Processes** - Processes using most RAM

### Bonus Metrics (Stretch Goals)
- 🌟 **System Information** - Hostname, OS version, kernel version
- 🌟 **Uptime** - System uptime in human-readable format
- 🌟 **Load Average** - 1, 5, and 15-minute load averages
- 🌟 **Logged In Users** - Currently active user sessions
- 🌟 **Failed Login Attempts** - Recent failed SSH/login attempts

## 📊 Sample Output

```
==================== System Information ====================
Hostname: ubuntu-server
OS Version: Ubuntu 22.04.3 LTS
Kernel Version: 5.15.0-89-generic

==================== Uptime ====================
up 7 days, 14 hours, 32 minutes

==================== Load Average ====================
Load Average:  0.45, 0.52, 0.48

==================== Logged In Users ====================
john     pts/0        2024-11-16 10:30 (192.168.1.100)
admin    pts/1        2024-11-16 09:15 (192.168.1.50)

==================== Failed Login Attempts ====================
Recent failed SSH logins:
Nov 16 08:23:15 ubuntu sshd[12345]: Failed password for invalid user admin

==================== CPU Usage ====================
%Cpu(s):  12.5 us,  3.2 sy,  0.0 ni, 83.8 id,  0.3 wa,  0.0 hi,  0.2 si

==================== Memory Usage ====================
               total        used        free      shared  buff/cache   available
Mem:            15Gi       8.2Gi       2.1Gi       256Mi       5.0Gi       6.5Gi
Swap:          2.0Gi       512Mi       1.5Gi

Memory Used Percentage:
Used: 54.67%

==================== Disk Usage ====================
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   28G   20G  59% /

Disk Used Percentage:
Used: 56.00%

==================== Top 5 Processes by CPU ====================
  PID COMMAND         %CPU
 1234 node            15.2
 5678 mysqld           8.5
 9101 java             4.3
 1121 python3          2.1
 3141 nginx            1.8

==================== Top 5 Processes by Memory ====================
  PID COMMAND         %MEM
 5678 mysqld          12.3
 9101 java             8.7
 1234 node             6.5
 2233 redis-server     3.2
 4455 postgres         2.9

==================== Completed ====================
```

## 🚀 Quick Start

### Prerequisites

- Linux-based operating system (Ubuntu, Debian, CentOS, RHEL, etc.)
- Bash shell (version 4.0+)
- Standard Linux utilities: `top`, `free`, `df`, `ps`, `uptime`, `who`
- `sudo` access (for failed login attempts feature)

### Installation

1. **Download the script**
   ```bash
   wget https://raw.githubusercontent.com/RushikeshGhodke/server-performance-stats/main/server-stats.sh
   # OR
   curl -O https://raw.githubusercontent.com/RushikeshGhodke/server-performance-stats/main/server-stats.sh
   ```

2. **Make it executable**
   ```bash
   chmod +x server-stats.sh
   ```

3. **Run the script**
   ```bash
   ./server-stats.sh
   ```

### Alternative: Direct Execution

```bash
bash server-stats.sh
```

## 📖 Usage

### Basic Usage

```bash
# Run the script
./server-stats.sh

# Run with sudo for full features (recommended)
sudo ./server-stats.sh
```

### Save Output to File

```bash
# Save to text file
./server-stats.sh > server-report.txt

# Save with timestamp
./server-stats.sh > server-report-$(date +%Y%m%d-%H%M%S).txt
```

### Schedule Regular Monitoring

Add to crontab for automated monitoring:

```bash
# Edit crontab
crontab -e

# Run every hour and save to log
0 * * * * /path/to/server-stats.sh >> /var/log/server-stats.log 2>&1

# Run every day at midnight
0 0 * * * /path/to/server-stats.sh > /var/log/server-stats-$(date +\%Y\%m\%d).log
```

## 🔍 Metrics Explained

### CPU Usage
- **us (user)**: CPU time spent in user space
- **sy (system)**: CPU time spent in kernel space
- **id (idle)**: CPU idle time percentage
- **wa (wait)**: Time waiting for I/O operations

### Memory Usage
- **total**: Total installed RAM
- **used**: RAM currently in use
- **free**: Completely unused RAM
- **available**: RAM available for new applications
- **buff/cache**: RAM used for buffers and cache

### Disk Usage
- **Size**: Total disk capacity
- **Used**: Space currently occupied
- **Avail**: Available free space
- **Use%**: Percentage of disk utilized

### Load Average
- First number: 1-minute load average
- Second number: 5-minute load average
- Third number: 15-minute load average

*Rule of thumb: Load should be less than number of CPU cores*

## 🛠️ Customization

### Modify Disk Partition

By default, the script monitors the root partition (`/`). To monitor a different partition:

```bash
# Edit line 43
df -h /home  # Monitor /home partition
```

### Change Top Processes Count

To show top 10 processes instead of 5:

```bash
# Edit lines 50 and 55
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11  # Changed from 6 to 11
ps -eo pid,comm,%mem --sort=-%mem | head -n 11
```

### Add Custom Metrics

Add network statistics:

```bash
echo "==================== Network Statistics ===================="
ifconfig | grep -E "RX packets|TX packets"
echo ""
```


## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Rushikesh Ghodke**

- GitHub: [@RushikeshGhodke](https://github.com/RushikeshGhodke)
- Project: [server-performance-stats](https://github.com/RushikeshGhodke/server-performance-stats)

---

**⭐ If you find this useful, please consider giving it a star!**

**💡 Pro Tip**: Combine with `watch` for continuous monitoring:
```bash
watch -n 5 './server-stats.sh'  # Update every 5 seconds
```