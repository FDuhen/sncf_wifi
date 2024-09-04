# sncf_wifi
Bash script, tested on MacOS, used to ease the SNCF Wifi Connection

## How to use this script ? 
1- Clone the project or download the connect_wifi.sh file.  
2- Open a Terminal and set the script as executable.   
```
chmod a+x connect_wifi.sh
```
3- Execute the script 
```
./connect_wifi.sh
```
4- When prompted, enter your password (used to update your DNS configuration)  
5- The script will stay 'alive' until you enter a key as described in your Terminal.  
Once you write any key and press Enter, your DNS configuration will be rolled back to your old configuration.   

If you closed the Terminal while the script was pending, and want to find back your old configuration, it's saved in /tmp/dns_backup.txt