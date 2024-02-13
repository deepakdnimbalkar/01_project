#!/bin/bash

group_mgmt(){
        clear
	echo "Gorup Manegament...!"
        echo ""
        echo "c - Create Group...!"
        echo ""
        echo "a - Add users in group...!"
        echo ""
        echo "r - Remove users from group...!"
	echo ""
	echo "del - Delete a group...!"
	echo ""
	echo "s - Show Groups...!"
        echo ""
        echo "h - Back To Home Page "
        echo ""
	echo "e - Exit"
        read -p "What do you want to do:  " choice

        case $choice in
                "c" )
                        echo "Group creation...!"
                        create_group
                        ;;
                "a" )
                        echo "Add users in group...!"
                        user_add
                        ;;
                "r" )
                        echo "Remove user from group...!"
                        user_remove
                        ;;
                "del" )
                        echo "Delete group"
                        group_del
                        ;;
		"s" )
			echo "Show Groups...!"
			show_group
			;;
                "h" )
                        ./user_mgmt.sh
                        ;;
		"e" )
			exit
			;;
        esac
}

#creating groups

create_group(){
	clear
        echo "Group Creation...!"
        echo ""
        read -p "Please enter group name: " group_name
        echo ""

        if getent group "$group_name" &>/dev/null;
        then
                echo "Group $group_name is exists...!"
                echo ""
        else
                sudo groupadd "$group_name"
                echo ""
                echo "Group $group_name successfully created...!"
                echo ""
        fi

        echo "x - Back to Group Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
	echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        group_mgmt
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
		"e" )
			exit
			;;
        esac

}

#User adding in the group 

user_add(){
	clear 
	echo "Add users in group"
	echo ""
	read -p "Please enter group name: " group_name

	if getent group "$group_name" &>/dev/null;
        then
		echo ""
		read -p "Please enter user name: " user_name
		echo ""

		if id "$user_name" &>/dev/null;
		then
			sudo usermod -aG "$group_name" "$user_name"
			echo ""
			echo "User $user_name successfully added in the group $group_name"
		else
			echo ""
			echo "User $user_name is not found...!"
			echo ""
		fi
			       
        else
                echo ""
                echo "Group $group_name is not abailable...!"
                echo ""
        fi

	echo "x - Back to Group Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
	echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        group_mgmt
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
		"e" )
			exit
			;;
        esac
}

user_remove(){
	clear
        echo "Removing users from group"
        echo ""
        read -p "Please enter group name: " group_name

        if getent group "$group_name" &>/dev/null;
        then
                echo ""
                read -p "Please enter user name: " user_name
                echo ""

                if id "$user_name" &>/dev/null;
                then
                        sudo gpasswd -d "$user_name" "$group_name"
                        echo ""
                        echo "User $user_name successfully removed from the group $group_name"
			echo ""
                else
                        echo ""
                        echo "User $user_name is not found...!"
                        echo ""
                fi

        else
                echo ""
                echo "Group $group_name is not abailable...!"
                echo ""
        fi

	echo "x - Back to Group Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        group_mgmt
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
                "e" )
                        exit
                        ;;
        esac
}

group_del(){
	clear
        echo "Group Delete...!"
        echo ""
        read -p "Please enter group name: " group_name

        if getent group "$group_name" &>/dev/null;
        then
                echo ""
		sudo groupdel $group_name
		echo ""
		echo "Group $group_name is deleted successfully...!"
		echo ""
        else
                echo ""
                echo "Group $group_name is not abailable...!"
                echo ""
        fi

        echo "x - Back to Group Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
        echo "e - Exit"
	echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        group_mgmt
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
                "e" )
                        exit
                        ;;
        esac
}

show_group(){
	clear
	all_groups=$(cat /etc/group)
	echo ""
	echo "$all_groups"
	echo ""

	echo "x - Back to Group Manegament...!"
        echo ""
        echo "h - Back to Home"
        echo ""
        echo "e - Exit"
        echo ""
        read -p "Please enter your choice " choice

        case $choice in
                "x" )
                        clear
                        group_mgmt
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
                "e" )
                        exit
                        ;;
        esac


}

group_mgmt
