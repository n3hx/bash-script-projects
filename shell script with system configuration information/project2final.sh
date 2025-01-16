#!/bin/bash

# Function to display the operating system type using whiptail utility
function OperatingSystem() {
    whiptail --msgbox "Type of Operating System:\n$(uname -s)" 10 40 
    #The uname -s command retrieves the operating system name
}

# Function to display the computer cpu information using whiptail utility
function CPUInformation() {
    whiptail --msgbox "CPU Information:\n$(lscpu)" 20 60
    #The lscpu command retrieves the CPU information.
}

# Function to display the memory information using whiptail utility
function MemoryInformation() {
    whiptail --msgbox "Memory Information:\n$(free -h)" 20 60
    #The free -h command retrieves the memory information and displays it in a human-readable format
}

# Function to display the hard disk information using whiptail utility
function HardDiskInformation() {
    whiptail --msgbox "Hard Disk Information:\n$(lsblk)" 20 60
    #The lsblk command retrieves the hard disk information.
}

# Function to display the file system information using whiptail utility
function FileSystemInformation() {
    whiptail --msgbox "File System Information (Mounted):\n$(df -h)" 20 60
    #The df -h command retrieves the mounted file system information and displays it in a human-readable format.
}

# Function to exit the script
function ExitProgram() {
    #whiptail --yesno "Do you want to exit the program?" 20 60
    #if [[$? -eq 0]]; then
    	whiptail --msgbox "Exiting the program..." 20 60
    	exit 0
    #elif [[$? -eq 1]]; then
    # whiptail --msgbox "Returning to main menu..." 20 60
    #fi
}

#Function to prompt user to enter a password
function Password(){
	password="1234"
	attempts=3
	for (( i=1; i<=$attempts; i++ )); do
        input=$(whiptail --passwordbox "Enter a password" 20 60 3>&1 1>&2 2>&3)

        # check password
        if [ "$input" == "$password" ]; then
            # password is correct procced to main menu
            #whiptail --ok-button Done --msgbox "Correct password." 20 60
            count=0 
            while [[ ${count} -le 100 ]]; do 
            	sleep 1
            	count=$(($count+10))
            	echo ${count}
            done | whiptail --title "Processing data..." --gauge "Please wait while data is loading" 6 50 ${count}
         
         	# Loop to display the main menu using whiptail utility
		while true
		do
    			# Display the main menu
    			choice=$(whiptail --title "System Configuration Menu" --menu "Choose an option:" 20 60 5 \
        		"1" "Type of Operating System " \
        		"2" "Computer CPU Information" \
        		"3" "Memory Information" \
        		"4" "Hard Disk Information" \
        		"5" "File System Information (Mounted)" \
        		"6" "Exit" \
        		3>&1 1>&2 2>&3) #This means that any output written to file descriptor will be written to the same location as standard output.

    			# Call the appropriate function based on the user's choice
    			case $choice in
        			1) OperatingSystem;;
        
        			2) CPUInformation;;
        
        			3) MemoryInformation;;
        
        			4) HardDiskInformation;;
        
        			5) FileSystemInformation;;
        
        			6) ExitProgram;;
        
        			*)
            			whiptail --msgbox "Invalid selection. Please try again." 10 40 ;;
    			esac
		done   
        else
            # password is incorrect
            whiptail --ok-button Done --msgbox "Incorrect password.\nYou have $(($attempts-$i)) attempts remaining." 20 60
        fi            
    done
    # if attempts exhausted, exit program
    whiptail --ok-button Done --msgbox "Incorrect password.\nAttempts exhausted.\nProgram terminated." 20 60
    exit 0
}

#call function Password
Password

