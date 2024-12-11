
# Setup Guide for Mathew's Script

This script is used to give the server a visual warning when someone fails to loggin correctly

when surrounded by {curly braces} it means that you can replace them with your own names or directories

## Dependencies
Install zenity which allows us to open message boxes with custom messages
- `sudo apt install zenity`

## 1. Write the script and give it permission

1. Run command `sudo nano {filename}.sh` and add the contents of the securityBash.sh (You can also download the file)
2. You want to double check the paths that were laid out.
    - The Absolute paths can be checked using `which {package name}`
    - Double check the security file by using one of the commands that find the location of files.
3. Give it executable permissioms by using the command `sudo chmod +x {filename}.sh`

## 2. Edit the visudo file (User Permissions)

1. Type `sudo visudo` and that will automaticly allow you to edit that file using nano.
2. All the way at the bottom on the line that specifies your user, in my case it would be `osboxes`. You want to change that line to `osboxes ALL=(ALL) NOPASSWD: ALL`

## 3. Edit your bashrc file

1. Type `sudo .bashrc` to edit the bashrc file which allows you to edit the environment.
2. We will make the warning appear on the main monitor so we will type `export DISPLAY=:0 && /usr/bin/xhost + SI:localuser:{username}`

## 4. Add crontab service

1. Type `crontab -e` to edit crontab file, this allows you to add services that you want to be repeated every once in a while.
2. Add to the file `* * * * * DISPLAY=:0 /home/{username}/securityBash.sh` (The stars are included and intentional)
