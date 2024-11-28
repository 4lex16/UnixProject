
# System Monitoring and Automation Tasks

## Task 1 (11/25/2024) - Monitoring Tasks Using Shell Scripts

### 1. Creating the Script
Create a shell script for automating monitoring tasks such as checking disk usage, monitoring process statuses, and updating system performance data.

```bash
sudo nano /usr/local/bin/system_monitor.sh
```

### Script: `system_monitor.sh`

```bash
#!/bin/bash

# Set the threshold for disk usage (e.g., 80%)
DISK_THRESHOLD=80

# Log file to save performance data
LOG_FILE="/var/log/system_monitor.log"

# Function to check disk usage
check_disk_usage() {
    echo "Checking disk usage..."
    DISK_USAGE=$(df -h | grep '^/dev' | awk '{ print $5 }' | sed 's/%//g')
    for usage in $DISK_USAGE; do
        if [ $usage -gt $DISK_THRESHOLD ]; then
            echo "Warning: Disk usage is above ${DISK_THRESHOLD}%!"
            echo "$(date): WARNING - Disk usage exceeded ${DISK_THRESHOLD}% on /dev/sda" >> $LOG_FILE
        fi
    done
}

# Function to check running processes
check_processes() {
    echo "Checking for specific processes..."
    PROCESSES=("nginx" "apache2" "mysql")
    for process in "${PROCESSES[@]}"; do
        if ps aux | grep -v grep | grep -q $process; then
            echo "$process is running."
        else
            echo "$process is NOT running! Please check."
            echo "$(date): ALERT - $process is not running!" >> $LOG_FILE
        fi
    done
}

# Function to update system performance data (CPU and memory usage)
update_performance_data() {
    echo "Updating system performance data..."
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*//" | awk '{print 100 - $1}')
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "$(date): CPU Usage: ${CPU_USAGE}% | Memory Usage: ${MEM_USAGE}%" >> $LOG_FILE
}

# Main function to call all monitoring functions
main() {
    echo "Starting system monitoring script..."
    check_disk_usage
    check_processes
    update_performance_data
    echo "Monitoring complete. Logs saved to $LOG_FILE."
}

# Run the main function
main
```

---

## Task 2 (11/28/2024) - Making the Script Executable and Configuring Log Permissions

1. Make the script executable.
   ```bash
   sudo chmod +x /usr/local/bin/system_monitor.sh
   ```
2. Create and configure the log file.
   ```bash
   sudo touch /var/log/system_monitor.log
   sudo chmod 666 /var/log/system_monitor.log
   ```

---

## Task 3 (11/28/2024) - Setting Up Cron Jobs to Automate the Script

1. Install `cron`:
   ```bash
   sudo apt update
   sudo apt install cron
   ```
2. Ensure `cron` is running:
   ```bash
   sudo systemctl enable cron
   sudo systemctl start cron
   ```
3. Add a `cron` job to run the script every 5 minutes:
   ```bash
   crontab -e
   ```
   Add the following line:
   ```
   */5 * * * * /usr/local/bin/system_monitor.sh
   ```
4. Save and exit (`CTRL + O` and `CTRL + X`).
5. Verify the `cron` job:
   ```bash
   crontab -l
   ```

---

## Task 4 (11/28/2024) - Fetching Data from Checkmk and Automating Actions

### Prerequisites

1. **Enable the Checkmk API:**
   - Log in to Checkmk.
   - Navigate to **Global Settings > API integration**.
   - Enable the REST API if not already enabled.

2. **Create an API User:**
   - Go to **Users** in the Checkmk web interface.
   - Add a user with API access.
   - Assign necessary permissions for the required data.

### Script: `checkmk_monitor.sh`

```bash
#!/bin/bash

# Script to fetch monitoring data from Checkmk, check for critical states,
# log the findings, and send notifications.

# Set variables
API_USER="automation_user"             # Checkmk automation user (format: username@site)
API_PASS="your_secret_password"        # Password for the automation user
CHECKMK_URL="http://<checkmk-server>"  # Base URL for your Checkmk instance
SITE_NAME="check_mk"                   # Checkmk site name
SERVICE_API_URL="$CHECKMK_URL/$SITE_NAME/check_mk/api/1.0/domain-types/service/collections/all"
LOG_FILE="/var/log/checkmk_monitor.log" # Log file location
ALERT_EMAIL="admin@example.com"         # Email address to send alerts

# Function to fetch service data from Checkmk API
fetch_service_data() {
    echo "$(date): Fetching service data from Checkmk..." >> $LOG_FILE
    RESPONSE=$(curl -s -u "$API_USER:$API_PASS" -X GET "$SERVICE_API_URL")
    if [ $? -ne 0 ] || [ -z "$RESPONSE" ]; then
        echo "$(date): ERROR - Failed to fetch data from Checkmk API." >> $LOG_FILE
        exit 1
    fi
    echo "$RESPONSE"
}

# Function to parse critical services from the API response
find_critical_services() {
    local response=$1
    echo "$response" | jq -r '.[] | select(.state == "CRITICAL") | .description'
}

# Function to send email alerts for critical services
send_alert_email() {
    local critical_services=$1
    SUBJECT="Checkmk Alert: Critical Services Detected"
    BODY="The following services are in a critical state:\n\n$critical_services"
    echo -e "$BODY" | mail -s "$SUBJECT" "$ALERT_EMAIL"
    echo "$(date): Alert email sent to $ALERT_EMAIL." >> $LOG_FILE
}

# Function to log critical services
log_critical_services() {
    local critical_services=$1
    echo "$(date): Critical services detected:" >> $LOG_FILE
    echo "$critical_services" >> $LOG_FILE
}

# Main function to perform all monitoring tasks
main() {
    echo "$(date): Starting Checkmk monitoring script..." >> $LOG_FILE
    SERVICE_DATA=$(fetch_service_data)
    CRITICAL_SERVICES=$(find_critical_services "$SERVICE_DATA")
    if [ ! -z "$CRITICAL_SERVICES" ]; then
        log_critical_services "$CRITICAL_SERVICES"
        send_alert_email "$CRITICAL_SERVICES"
    else
        echo "$(date): No critical services detected." >> $LOG_FILE
    fi
    echo "$(date): Monitoring script completed." >> $LOG_FILE
}

# Run the main function
main
```

---

## Related Repository
[GitHub: Hotel Management Application](https://github.com/4lex16/UnixProject.git)
