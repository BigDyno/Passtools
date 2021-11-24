#!/bin/bash

# Filename = Script.txt
# Author = Dave Van Dorsten
# Created = March 22 2021
# Modified = March April 01 2021

## Colour Codes
nocol="\033[39m"
black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
lightgray="\033[37m"
darkgray="\033[90m"
lightred="\033[91m"
lightgreen="\033[92m"
lightyellow="\033[93m"
lightblue="\033[94m"
lightmagenta="\033[95m"
lightcyan="\033[96m"
white="\033[97m"

# Pass Man Function
PASS_MAN () {

# Read command being used at a Here document -r backslash does not escape -d continue until first char of delim is read= ''
read -r -d '' MANBANNER << EOM
██████╗  █████╗ ███████╗███████╗    ███╗   ███╗ █████╗ ███╗   ██╗
██╔══██╗██╔══██╗██╔════╝██╔════╝    ████╗ ████║██╔══██╗████╗  ██║
██████╔╝███████║███████╗███████╗    ██╔████╔██║███████║██╔██╗ ██║
██╔═══╝ ██╔══██║╚════██║╚════██║    ██║╚██╔╝██║██╔══██║██║╚██╗██║
██║     ██║  ██║███████║███████║    ██║ ╚═╝ ██║██║  ██║██║ ╚████║
╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
-----------------------------------------------------------------
EOM
	# IF .passwords folder exists
	if [[ -d "$HOME/.passwords" ]]; then
		continue
	else
		clear
		echo "$MANBANNER"
		echo -e "Welcome to my Password Manager.\nA hidden folder will be created in your HOME directory.\nPassword files will be contained in ENCRYPTED files."
		read -p "Continue? (Y/n): "
		# IF user input is equal to 'y' OR string is empty
		if [[ "$REPLY" == "y" ]] || [[ -z "$REPLY" ]]; then
			# Make new directory under the home directory
			mkdir "$HOME/.passwords"
			# READ command used for confirm and pause
			read -p "Folder has been created, press ANY key to continue: "
		# ELSE do 'this'
		else
			echo -e "${red}Quitting...${nocol}"
			# Sleep counter (pauses script for n seconds)
			sleep 2
			# Exits Script
			exit 0
		fi
	fi
	# WHILE loop used to maintain menu structure and user validation return
	while true; do
		clear
		echo "$MANBANNER"
		echo -e "1. Decrypt and View Password\n2. Generate Password\n3. Add Custom Password\n4. Backup\n5. Restore Backup From Cloud\n6. Cloud URL\n\n0. Back to Main Menu"
		read -p "-> "
		# Colour Arrow Echo argument as string 
		#read -p "$(echo -e $magenta"-->"$nocol)"
		
		# IF user input equals '0'
		if [[ "$REPLY" == 0 ]]; then
			# RUN 'MENU' function
			MENU
		fi
	# IF user input equals '1'
	if [[ "$REPLY" == 1 ]]; then
		echo -e "\nStored Passwords: \n"
		# LIST '.gpg' files sending errors to null. xargs used to format to remove everything exept filename (basename) '-n 1 spacing'. sending errors to null.
		ls "$HOME/.passwords/"*.gpg 2>/dev/null | xargs -n 1 basename 2>/dev/null
		echo ""
		# FILENAME reads input from user
		read -p "Enter Filename (.gpg is assumed): " fname
		# IF FILENAME string is empty OR file DOES NOT exist then 'do this'
		if [[ -z "$fname" ]] || [[ ! -f "$HOME/.passwords/$fname.gpg" ]];then
			read -p "Invalid Filename, press ANY key to CONTINUE"
		else
			# GPG is an OpenPGP encryption and signing tool. '-d decrypt' Homefolder/userinput
			gpg --no-symkey-cache -d "$HOME/.passwords/$fname.gpg"
			# READ command used for confirm and pause
			read -p "ANY key to CONTINUE or q to QUIT: "
		fi
		# IF user input equals 'q' then 'do this'
		if [[ "$REPLY" == "q" ]];then
			clear
			# RUN 'MENU' function
			MENU
		fi
	fi
	# IF user input equals '2'
	if [[ "$REPLY" == 2 ]]; then
		# WHILE loop used to maintain menu structure and user validation return
		while true; do
		# PASSWORDLENGTH reads input from user
		read -p "Enter Length of Password [1-30 Max]: " plength
	# IF PASSWORDLENGTH variable is with regular expression range '01-09, 10-19, 20-29, and 30'
	if [[ "$plength" =~ ^[1-9]$|^1[0-9]$|^2[0-9]$|^30$ ]]; then
		break
	else
		echo "Please enter a value between 0-30"
	fi
	done
	# WHILE loop used to maintain menu structure and user validation return
	while true; do
		read -p "Include Uppercase Characters? (Y/n): " uppercase
		# IF user input variable UPPERCASE equals 'y' OR string is empty
		if [[ "$uppercase" == "y" ]] || [[ -z "$uppercase" ]];then
			# Change UPPERCASE variable to 'A-Z'
			uppercase="A-Z"
			break
		fi
		# IF user input variable UPPERCASE equals 'n'
		if [[ "$uppercase" == "n" ]];then
			# Change UPPERCASE variable to '' (blank string)
			uppercase=""
			break
		else
			echo "Please enter (Y/n)"
		fi
	done
	# WHILE loop used to maintain menu structure and user validation return
	while true; do
		# SYMBOLS reads input from user
		read -p "Include Symbols? (Y/n): " symbols
		# IF user input variable SYMBOLS equals 'y' OR string is empty
		if [[ "$symbols" == "y" ]] || [[ -z "$symbols" ]];then
			# Change SYMBOLS variable to...
			symbols="!@#$%"
			break
		fi
		# IF user input variable SYMBOLS equals 'n'
		if [[ "$symbols" == "n" ]];then
			symbols=""
			break
		else
			echo "Please enter (Y/n)"
		fi
	done
	# WHILE loop used to maintain menu structure and user validation return
	while true; do
		# NUMBERS variable reads input from user
		read -p "Include Numbers? (Y/n): " numbers
		# IF user input variable NUMBERS equals 'y' OR string is empty
		if [[ "$numbers" == "y" ]] || [[ -z "$numbers" ]];then
			# Change NUMBERS variable to...
			numbers="1234567890"
			break
		fi
		# IF user input variable NUMBERS equals 'n'
		if [[ "$numbers" == "n" ]];then
			numbers=""
			break
		else
			echo "Please enter (Y/n)"
		fi
	done
	echo ""
	read -p "Type p to PRINT to SCREEN, or ANY key to SAVE to ENCRYPTED file: "
	if [[ "$REPLY" == "p" ]]; then
		# Location of special files that can serve as number generators. They access environmental noise collected from drivers and other sources.
		# 'tr' translates(outputs characters) '-d' deletes characters (do not translate) '-c' use the complement of SET1
		# Characters to include using a-z and user input variables. Head '-c' use n amount of characters
		</dev/urandom tr -dc "a-z"$uppercase$symbols$numbers | head -c$plength
		echo -e "\n\n"
	else
	while true; do
		#SOMEFILENAME user input
		read -p "Please enter Filename: " sname
		if [[ -z "$sname" ]];then
			echo "Invalid Filename"
		else
			# Grouping commands together so I can add a return character to the string and output to file
			{
			</dev/urandom tr -dc "a-z"$uppercase$symbols$numbers | head -c$plength
			echo -e "\n"
			} > "$HOME/.passwords/"$sname
			# GPG is an OpenPGP encryption and signing tool. '-c' Symetric passphrase encryption, '--no-symkey-cache' disables caching of passphrase
			gpg -c --no-symkey-cache "$HOME/.passwords/"$sname
			# 'rm' remove unencrytped file
			rm "$HOME/.passwords/"$sname
			# Prints the confirmation to screen including the filename, formatting was used for colour
			echo -e "${lightgreen}Encrypted Password Saved as $sname.gpg${nocol}"
			break
		fi
	done
	fi
	read -p "ANY key to CONTINUE or q to QUIT: "
	if [[ "$REPLY" == "q" ]];then
		clear
		break
	fi           
	fi
	if [[ "$REPLY" == 3 ]]; then
		# Counter being set to zero to be used as a stop limit for the next series of commands
		counter=0
		echo -n "Please Enter a Password: "
		# Reads input from user and sets to variable 'pass1' '-s' is used for blank input (not visable to console)
		read -s pass1
		while true; do
			# Add 1 to variable counter
			counter=$((counter+1))
			echo -en "\nPlease ReEnter Password: "
			# Reads input from user and sets to variable 'pass1' '-s' is used for blank input (not visable to console)
			read -s pass2
			# Comparing two string to make sure they match
			if [[ $pass1 == $pass2 ]]; then
				echo -e "\n"
				echo -e "${lightgreen}Password Matched!${nocol}"
				sleep 1
				read -p "Please Enter Filename: "
				# Echo the password the user entered and output it to a file
				echo -e "$pass1\n" > "$HOME/.passwords/$REPLY"
				gpg -c --no-symkey-cache "$HOME/.passwords/"$REPLY
				rm "$HOME/.passwords/$REPLY"
				read -p "Process Complete. Press any key to Continue: "
				break
			elif [[ $counter = 2 ]]; then
				echo ""
				echo -e "${red}Password Mismatch! :(${nocol}"
				sleep 3
				break
			fi
		done
	fi
	if [[ "$REPLY" == 4 ]]; then
		# BACKUPPATH Setting variable of the location of the backup url (tail and -n1 is to selct the last item in log)
		bpath=$(tail $HOME/Documents/bak.log -n 1 2> /dev/null)
		echo -e "${lightcyan}Checking...${nocol}"
		# If statement using curl to check if file exists on server
		if curl --output /dev/null --silent --head --fail "$bpath"; then
			echo -e "${yellow}Backup Already Exists: $bpath${nocol}"
			read -p "Backup anyway? (y/N): "
			if [[ "$REPLY" != "y" ]] || [[ -z "$REPLY" ]];then
				echo -e "User Selected NO"
			else
				# Archieve -c 'create' -f 'file' *.* all files in folder send output/error to null
				tar -cf $HOME/Documents/backup.tar $HOME/.passwords/*.* &>/dev/null
				# INTERNETFILENAME string variable created randomly 
				ifname=$(</dev/urandom tr -dc '1-9A-Za-z' | head -c10)
				# Encrypt backup archive
				gpg -c --no-symkey-cache $HOME/Documents/backup.tar 2>/dev/null
				# INTERNETPATH Command that uploads the file and returns the path in a variable
				ipath=$(curl --upload-file $HOME/Documents/backup.tar.gpg https://transfer.sh/$ifname.tar.gpg)
				# Remove Encrypted Backup File send all errors to null
				rm $HOME/Documents/backup.tar.gpg 2>/dev/null
				# IF command did work work (error code other then 0)
				if [[ $? != 0 ]]; then
					echo -e "${red}\nNo File Was Uploaded. Please Enter a Password To Upload File${nocol}"
					read -p "Press any key to Continue: "
				else
					# Writing the INTERNETPATH variable to a file locally and amend the doc
					echo "$ipath" >> $HOME/Documents/bak.log
					# BACKUPPATH Setting variable of the location of the backup url (tail and -n1 is to selct the last item in log)
					bpath=$(tail $HOME/Documents/bak.log -n 1)
					echo -e "${lightgreen}\nUpload Complete, stored at: $bpath${nocol}"
					read -p "Press any key to Continue: "
				fi
			fi	
		else
			# Archieve -c 'create' -f 'file' *.* all files in folder send output/error to null
			tar -cf $HOME/Documents/backup.tar $HOME/.passwords/*.* &>/dev/null
			echo -e "${lightgreen}Local backup saved at: $HOME/Documents/backup.tar${nocol}"
			read -p "Upload To The Cloud? (y/N): "
			
			# IF input is NOT y or blank string
			if [[ "$REPLY" != "y" ]] || [[ -z "$REPLY" ]];then
				echo -e "User Selected NO"
			else
				# Netcat to attempt to connect/listen '-z' zero-I/O mode [used for scanning]
				nc -z 8.8.8.8 53
				# IF command didn't work (error code other then 0)
				if [[ $? != 0 ]]; then
					echo -e "${red}Not Connected To Internet${nocol}"
					sleep 3
					# Run Function to keep inside program
					PASS_MAN
				fi
				# INTERNETFILENAME string variable created randomly 
				ifname=$(</dev/urandom tr -dc '1-9A-Za-z' | head -c10)
				# Encrypt backup archive
				gpg -c --no-symkey-cache $HOME/Documents/backup.tar 2>/dev/null
				# INTERNETPATH Command that uploads the file and returns the path in a variable
				ipath=$(curl --upload-file $HOME/Documents/backup.tar.gpg https://transfer.sh/$ifname.tar.gpg)
				# Remove Encrypted Backup File
				rm $HOME/Documents/backup.tar.gpg 2>/dev/null
				if [[ $? != 0 ]]; then
					echo -e "${red}\nNo File Was Uploaded. Please Enter a Password To Upload File${nocol}"
					read -p "Press any key to Continue: "
				else
					# Writing the INTERNETPATH variable to a file locally and amend the doc
					echo "$ipath" >> $HOME/Documents/bak.log
					# BACKUPPATH Setting variable of the location of the backup url (tail and -n1 is to selct the last item in log)
					bpath=$(tail $HOME/Documents/bak.log -n 1)
					echo -e "${lightgreen}\nUpload Complete, stored at: $bpath${nocol}"
					read -p "Press any key to Continue: "
				fi
			fi
		fi
	fi
	if [[ "$REPLY" == 5 ]]; then
		bpath=$(tail $HOME/Documents/bak.log -n 1 2>/dev/null)
		echo -e "${lightcyan}Checking...${nocol}"
		nc -z 8.8.8.8 53
		if [[ $? != 0 ]]; then
			echo -e "${red}Not Connected To Internet${nocol}"
			sleep 3
			PASS_MAN
		fi
		# Used for checking if file resides on website/server (command was aquired from manual page)
		if curl --output /dev/null --silent --head --fail "$bpath"; then
			# DOWNLOADPATH inserting a custom string into variable. Original string from position 0 to 19 then insert custom string, continue with rest or original value
			dpath="${bpath:0:19}/get${bpath:19}"
			# Download the file using the DESTINATIONPATH decrypt and send to file
			curl $dpath | gpg --no-symkey-cache -o- 2>/dev/null > $HOME/Documents/backup.tar
			echo -e "${lightgreen}\nDownloaded to: $HOME/Documents/backup.tar${nocol}"
			read -p "Download Complete. Extract files? (y/N): "
			# IF reply is NOT equal to y or string is empty
			if [[ "$REPLY" != "y" ]] || [[ -z "$REPLY" ]];then
				echo "Done."
			else
				# Extracting Archive, I had to use --strip-components 3 to remove the folder, for some reason tar DID NOT like the hidden folder
				tar -xf $HOME/Documents/backup.tar --strip-components 3 -C $HOME/.passwords/
				read -p "Process complete... Press any key to Continue: "
			fi
		else
			read -p "No files in cloud. Press any key to continue: "
		fi
	fi
	if [[ "$REPLY" == 6 ]]; then 
		# BACKUPFILENAME
		bfname=$HOME/Documents/bak.log
		# Setting BACKUPPATH as the last line using 'tail -n' sending any errors to null
		bpath=$(tail $HOME/Documents/bak.log -n 1 2>/dev/null)
		echo -e "${lightcyan}Checking...${nocol}"
		nc -z 8.8.8.8 53
		if [[ $? != 0 ]]; then
			echo -e "${red}Not Connected To Internet${nocol}"
			sleep 3
		# IF file is found on website/server
		elif curl --output /dev/null --silent --head --fail "$bpath"; then
			echo -e "Backup File Located at: ${yellow}$bpath${nocol}"
			sleep 5
		else
			echo -e "${red}No Backup Available${nocol}"
			sleep 3
		fi
	fi
	done
}

ENCRYPT_FILE () {
read -r -d '' ENCRYPTBANNER << EOM
███████╗███╗   ██╗ ██████╗██████╗ ██╗   ██╗██████╗ ████████╗
██╔════╝████╗  ██║██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝
█████╗  ██╔██╗ ██║██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   
██╔══╝  ██║╚██╗██║██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   
███████╗██║ ╚████║╚██████╗██║  ██║   ██║   ██║        ██║   
╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝
------------------------------------------------------------
EOM
   
	while true; do
		clear
		echo "$ENCRYPTBANNER"
		echo -e "1. Encrypt File\n2. Decrypt File\n\n0. Back to Main Menu"
		read -p "-> "
		if [[ "$REPLY" == 0 ]]; then
			MENU
		fi
		if [[ "$REPLY" == 1 ]]; then
			while true; do
				echo -e "${yellow}\nFiles found in directory: $PWD${nocol}"
				# Using ls -p tells ls to append a slash to entries which are a directory, and using grep -v / tells grep to return only lines not containing a slash.
				ls -p | grep -v / 2>/dev/null
				echo ""
				read -p "Please enter Filename: " sname
				# IF variable string is emtpy OR if the file does NOT exist
				if [[ -z "$sname" ]] ||[[ ! -f "$sname" ]];then
					read -p "Invalid Filename, press ANY key to CONTINUE"
					break
				else
					gpg -c --no-symkey-cache $sname
					echo "Encrypted Password Saved as $sname.gpg"
					read -p "Would you like to DELETE original file? (y/N) "
				# IS NOT 'y'
				if [[ $REPLY != "y" ]]; then
					echo -e "${lightgreen}All done!${nocol}"
					sleep 2
					clear
					echo "$ENCRYPTBANNER"
				else
					rm $sname
					echo -e "${lightgreen}File Deleted! All done!${nocol}"
					sleep 2
				fi
				break
		fi
			done
		fi
		if [[ "$REPLY" == 2 ]]; then
			while true; do
				echo -e "${yellow}\nFiles found in directory: $PWD${nocol}"
				# LIST command but only the files that contain .gpg, modify the output using xargs, using 1 per line and only not the extension, send all errors to null
				ls *.gpg 2>/dev/null | xargs -n 1 basename 2>/dev/null
				echo ""
				read -p "Enter Filename (.gpg is assumed): " fname
				# FILENAME
				if [[ -z "$fname" ]] ||[[ ! -f "$fname.gpg" ]]; then
					read -p "Invalid Filename, press ANY key to CONTINUE"
					clear
					break
				fi
				# Decrypt File and output to file using variable as name
				gpg --no-symkey-cache -o $fname --decrypt $fname.gpg 
				echo -e "${lightgreen}Decryption Complete, file saved as: $fname${nocol}"
				read -p "ANY key to CONTINUE or q to QUIT: "
				break
				clear
				echo "$ENCRYPTBANNER"
				if [[ "$REPLY" == "q" ]];then
					clear
					MENU
				fi
			done
		else
			clear
			echo "$ENCRYPTBANNER"
			continue
		fi
	done
}

SHARE_FILE () {

read -r -d '' UPLOAD_BANNER << EOM
██╗   ██╗██████╗ ██╗      ██████╗  █████╗ ██████╗     ███████╗██╗██╗     ███████╗
██║   ██║██╔══██╗██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔════╝██║██║     ██╔════╝
██║   ██║██████╔╝██║     ██║   ██║███████║██║  ██║    █████╗  ██║██║     █████╗  
██║   ██║██╔═══╝ ██║     ██║   ██║██╔══██║██║  ██║    ██╔══╝  ██║██║     ██╔══╝  
╚██████╔╝██║     ███████╗╚██████╔╝██║  ██║██████╔╝    ██║     ██║███████╗███████╗
 ╚═════╝ ╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝     ╚═╝     ╚═╝╚══════╝╚══════╝
                                                                                 
EOM
while true; do
	clear
	echo "$UPLOAD_BANNER"
	# UPLOAD variable holds the url of the last url used. Here it is checking if it holds a string
	if [[ -z "$upload" ]]; then
		echo -e "${lightcyan}https://transfer.sh${nocol}"
	else
		echo -e "Last upload URL: ${green}$upload${nocol}"
	fi
	echo -e "${yellow}\nFiles found in directory: $PWD${nocol}"
	# List command '-p' indicator style equals slash, using grep '-v' to reverse match to show only files and no directories
	ls -p | grep -v / 2>/dev/null
	echo ""
	read -p "Enter Filename: " fname
	if [[ -z "$fname" ]] ||[[ ! -f "$fname" ]]; then
		read -p "Invalid Filename, press ANY key to CONTINUE"
		clear
		break
	fi
	read -p "Randomize File Name? (y/N): "
		if [[ "$REPLY" == "y" ]]; then
			# RANDOMFILENAME
			rfname=$(</dev/urandom tr -dc '1-9A-Za-z' | head -c10)
			# UPLOAD file using variable for file name, using formatting .${variable: -3} to select the last three characters to preserve extention 
			upload=$(curl --upload-file ./$fname https://transfer.sh/$rfname".${fname: -3}")
			if [[ $? -eq 0 ]]; then
				echo -e "${green}$upload${nocol}\n"
				read -p "Upload Complete..."
				break
		else
			read -p "Error"
			break
			fi
		fi
	upload=$(curl --upload-file ./$fname https://transfer.sh/$fname)
	if [[ $? -eq 0 ]]; then
		echo -e "${green}$upload${nocol}\n"
		read -p "Upload Complete..."
		break
	else
		read -p "Error with Upload..."
		break
	fi
done

}

TAR_FILE () {

read -r -d '' TAR_BANNER << EOM
████████╗ █████╗ ██████╗     ███╗   ███╗ █████╗ ███╗   ██╗
╚══██╔══╝██╔══██╗██╔══██╗    ████╗ ████║██╔══██╗████╗  ██║
   ██║   ███████║██████╔╝    ██╔████╔██║███████║██╔██╗ ██║
   ██║   ██╔══██║██╔══██╗    ██║╚██╔╝██║██╔══██║██║╚██╗██║
   ██║   ██║  ██║██║  ██║    ██║ ╚═╝ ██║██║  ██║██║ ╚████║
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
EOM
	
	
	clear
	echo "$TAR_BANNER"
	echo -e "1. Archive Folder\n2. Extract Archive \n\n0. Back to Main Menu"
	read -p "-> "
	
	if [[ "$REPLY" == 2 ]]; then
		echo -e "${yellow}\nFiles Found In Current Directory: $PWD${nocol}"
		ls -p | grep -v /
		echo ""
		read -p "Enter File Name: " finame
		if [[ -z "$finame" ]] || [[ ! -f "$finame" ]]; then
			read -p "Invalid Filename, press ANY key to CONTINUE"
		else
		# TAR '-x' extract 'v' verbose 'f' file
		tar=$(tar -xvf $finame)
			# :: removes string characters. positive number starts at the start, negative numbers start at the end
			epath=${finame::-4}
			echo -e "${lightgreen}$tar${nocol}\n"
			echo -e "Saved to: ${lightgreen}$PWD/$epath/${nocol}"
			read -p "Complete..."
		fi
	fi
	if [[ "$REPLY" == 0 ]]; then
		MENU
	fi
	if [[ "$REPLY" == 1 ]]; then
		
		echo -e "${yellow}\nFolder Found In Current Directory: $PWD${nocol}"
		# LIST command '-d' for directories '*/' everything with a /(dir)
		ls -d */
		echo ""
		read -p "Enter Folder Name: " fname
		# IF directory does NOT exist
		if [ ! -d "$fname" ]; then
			read -p "Invalid Filename, press ANY key to CONTINUE"
			TAR_FILE
		else
			# TAR '-c' create file 'z' extract 'v' verbose 'f' filename
			tar=$(tar -czvf $fname.tar $fname)
				echo -e "${lightgreen}$tar${nocol}\n"
				echo -e "Saved to: ${lightgreen}$PWD/$fname.tar${nocol}"
				read -p "Complete..."
		fi
	else
		TAR_FILE
	fi
}

MENU () {
read -r -d '' MENUBANNER << EOM
███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
--------------------------------------
EOM
	clear
	echo "$MENUBANNER"
echo -ne "1. Password Manager
2. Encrypt-o-Matic
3. File Share
4. TAR File

0. Exit
Choose an option: "
        read option
        case $option in
	        1) PASS_MAN; MENU ;;
	        2) ENCRYPT_FILE; MENU ;;
	        3) SHARE_FILE; MENU ;;
	        4) TAR_FILE; MENU ;;
	        0) exit 0 ;;
		*) MENU
        esac
}

MENU
