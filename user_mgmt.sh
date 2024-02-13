#!/bin/bash

#The script should be able to add, delete, and modify user accounts on a Linux system.

home_page(){
	clear
echo ""
echo "Home Page"
echo ""
echo "u - User Management...!"
echo ""
echo "g - Group Manegament...!"
echo ""
echo "b - Backup Manegmanet...!"
echo ""
echo "e - Exit...!"
echo ""

read -p "Please select what you want(u/g/b) : " user
clear
#Case statement 
case $user in 
	"u" )
		echo "User Manegament...!"
		user_mgmt
		;;
	"g" )
		echo "Group Manegament...!"
		./group_mgmt.sh
		;;
	"b" )
		echo "Backup Manegament...!"
		./backup_mgmt.sh
		;;
	"e" )
		exit
		;;
esac
}

#User Manegment

user_mgmt(){
	#clear
	echo ""
	echo "c - Create User...!"
	echo ""
	echo "p - Set a password for created user...!"
	echo ""
	echo "m - Modify user "
	echo ""
	echo "del - Delete User...!"
	echo ""
	echo "s - Show Created Users"
	echo ""
	echo "h - Back To Home Page "
	echo ""
	echo "e - Exit"
	echo ""
	read -p "What do you want to do:  " choice

	case $choice in 
		"c" )
			echo "User creation...!"
			create_user
			;;
		"p" )
			echo "Set password for created user...!"
			user_pass
			;;
		"m" )
			echo "Modify user name...!"
			user_modify
			;;
		"del" )
			echo "Delete user"
			user_del
			;;
		"s" )
			clear
			show
			;;
		"h" )
			home_page
			;;
		"e" )
			exit
	esac
}

#User creation

create_user(){
	clear 
	echo "User Creation...!"
	echo ""
	read -p "Please enter user name: " user_name 
	echo ""

	if id "$user_name" &>/dev/null;
	then
		echo "User $user_name is exists...!"
		echo ""
	else
		sudo useradd $user_name 
		echo ""
		echo "User $user_name successfully created...!"
		echo ""
	fi

	echo "x - Back to User Manegament...!"
	echo ""
	echo "h - Back to Home"
	echo ""
	echo "e - Exit"
	echo ""
	read -p "Please enter your choice " choice 

	case $choice in 
		"x" )
			clear
			user_mgmt
			;;
		"h" )
			clear
			home_page
			;;
		"e" )
			clear 
			exit
	esac

}

#Set Password to user

user_pass(){
	clear 
	echo "Set password for created user...!"
	echo ""
	read -p "Please enter user name: " user_name
	echo ""

	password_field=$(grep "^$user_name:" /etc/shadow | cut -d: -f2)
	
	if [ -n "$password_field" ];
	then 
		echo "Already password is set for user $user_name"
	else
		sudo passwd $user_name
	fi

	echo ""
	echo "x - Back to User Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
	echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        user_mgmt
                        ;;
                "h" )
                        clear
                        home_page
                        ;;
		"e" )
			clear
			exit
        esac
}

#User modification 

user_modify(){
	clear
	echo "Modify User Name...!"
	echo ""

	read -p "Old user name: " old_user
	echo ""

	if id "$old_user" &>/dev/null;
        then
                read -p "New user name: " new_user
		echo ""
		sudo usermod -l "$new_user" -c "$old_user name changed as $new_user" "$old_user"
                echo ""
        else
                echo ""
                echo "User $user_name not found...!"
                echo ""
        fi

	echo ""
        echo "x - Back to User Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
	echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        user_mgmt
                        ;;
                "h" )
                        clear
                        home_page
                        ;;
		"e" )
			clear
			exit
        esac
}

user_del(){
	clear
	echo "User delete...!"
	echo ""
	read -p "Please enter user name: " user_name 

	if id "$user_name" &>/dev/null;
        then
                echo ""
                sudo userdel $user_name
		echo "User $user_name is deleted successfully...!"
                echo ""
        else
                echo ""
                echo "User $user_name not found...!"
                echo ""
        fi

        echo ""
        echo "x - Back to User Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
        echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        user_mgmt
                        ;;
                "h" )
                        clear
                        home_page
                        ;;
                "e" )
                        clear
                        exit

        esac
}

show(){
	user_deatils=$(awk -F: '{print $1}' /etc/passwd)
	echo"Below are the users....! "
	echo ""
	echo "$user_deatils"

	echo ""
        echo "x - Back to User Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        user_mgmt
                        ;;
                "h" )
                        clear
                        home_page
                        ;;
                "e" )
                        clear
                        exit

        esac
}


home_page
