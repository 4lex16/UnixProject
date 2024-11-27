
# Installation Guide for CheckMK

## Set up the website (Debian)

1. In your terminal enter: 
<br> wget https://download.checkmk.com/checkmk/2.3.0p21/check-mk-raw-2.3.0p21_0.bookworm_amd64.deb <br> 
this pulls the checkmk package into your directory (You might want to check if its the most recent version [here](https://checkmk.com/download?method=cmk&edition=cre&version=2.3.0p21&platform=debian&os=bookworm&type=cmk&google_analytics_user_id=))

2. Then you enter:
<br> `sudo apt install ./check-mk-raw-2.3.0p21_0.bookworm_amd64.deb` <br>
which installs all the packages and dependencies

3. To create the monitoring site enter:
<br> `omd create siteName` <br>
this will output a big message but you want to lookout for is:

    * the link -> `http://your_server_ip/siteName`
    * admin user name -> `cmkadmin`
    * password -> `auto generated password`

    You can change the password by typing:
    `htpasswd -m ~/etc/htpasswd cmkadmin`

4. To start the sitee enter:
<br> `sudo omd start siteName` <br>

## Adding Hosts

When adding hosts you need to download an agent file on all of the computers you want to monitor

1. To install the agent:

    1. Go to the checkmk website you just created (`http://your_server_ip/siteName`)
    2. In the sidebar on the left, click setup (Gear Wheel)
    3. Among the options you will look for **Agents** and click **Linux** under it
    4. On the page, look for **Packaged Agents** (Usually the first one) and click the first one
    5. Once downloaded you want to install it on your computer by running the command:
    <br> `sudo apt install ./pathto/check-mk-agent_version_num_all.deb` <br>

2. To add Host:
    
    1. Go back to checmk website (`http://your_server_ip/siteName`)
    2. In the sidebar on the left, click setup (Gear Wheel)
    3. Among the options you will look for **Hosts** and click **Hosts** under it
    4. Click **add host** option at the top
    5. Enter the hostname
    5. Under **Network address** check the IPv4 address and add the IP of your target machine
    6. Click **Save & run service discovery** option at the top
    7. Refresh the page a few times until you see a bunch of stuff
    8. Click **Accept All** option at the top
    9. On the top right hand corder of the page, click on **Changes** (Warning Logo)
    10. Click **Activate on selected sites** option on the top

3. To add additional Hosts repeat the 2 steps above on the other machines


