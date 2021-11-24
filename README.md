# Passtools
A Swiss army knife of tools including: Password manager with built in generator, encrypted local and online backup, along with other encryption and archiving tools.

Included functionality that could backup the password directory to an online service, and then if anything happened to the local directory, it could be downloaded from the cloud and reinstated. All user input has validation to prevent any errors or crashes due to invalid entries. 

All passwords are housed in a hidden folder and encrypted with a passphrase of the user’s choice. While the backup archive that is uploaded is also encrypted and the filename is randomized to make it harder for people to scrape the website and potentially find the file.

# Notes
This was an application written for an end of year project for my Linux scripting course. I was tasked to build a simple script that would automate a series of commands. It started with a password generator and evolved into other utilities that I would find useful. Encrypt/Decrypt files, Archive/Unarchive Files, and a File Share Utility. 

# How-To-Use
1. Download script and make executable: chmod +x Passtools.sh
2. Execute by: ./Passtools.sh

# To-Do
Add a check to determine if Curl is installed.
