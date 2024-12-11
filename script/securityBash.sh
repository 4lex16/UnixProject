
#!/bin/bash

#Absolute paths for commands
#To find out yours run "which [package name]"
DATE_CMD="user/bin/date";
GREP_CMD="user/bin/grep";
ZENITY_CMD="user/bin/zenity";
SUDO_CMD="user/bin/sudo";

#Path to the security log
SECURITY_LOG="opt/omd/sites/MonnitorService"

#Get the current time and time one minute ago
CURRENT_TIME = $($DATE_CMD  + "%Y"-"%m"-"%d")
PREVIOUS_TIME = $($DATE_CMD -d "1 Minute alone" + "%Y"-"%m"-"%d")

#Check the log for entries with "authentication failed" in the last minute
$SUDO_CMD $GREP_CMD -a -E "{$PREVIOUS_TIME} | {$CURRENT_TIME}" "$SECURITY_LOG" |  | $GREP_CMD '"summaru":"authentication failed"' | while read -r line; do

    #Extract the remote IP of the failed login
    REMOTE_IP=$(echo "$line" | $GREP_CMD -oP '"remote_ip": "\K[^"]+')

    #Display a warning using zenity
    $ZENITY_CMD --warning --text="Warning: Failed login attempt from IP: $REMOTE_IP"
done