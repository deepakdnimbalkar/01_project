#!/bin/bash 

backup(){

	clear
	echo "Backup Manegament...!"
	echo ""
	echo "b - Backup...!"
        echo ""
        echo "h - Back To Home Page "
        echo ""
        echo "e - Exit"
	echo ""
        read -p "What do you want to do:  " choice

        case $choice in
                "b" )
                        echo "Backup...!"
                        user_backup
                        ;;
                "h" )
                        clear
                        ./user_mgmt.sh
                        ;;
                "r" )
                        exit
                        ;;
	esac
}

user_backup(){
	clear
	echo "which directory backup you want...!"
	echo ""
	read -p "Please enter target  path followed by / : " src_dir
	echo ""
	read -p "Please enter source path followed by / : " tgt_dir

#	cd /home/deepak/06_batch_devops/01_project/backup

#	src_dir="/home/deepak/06_batch_devops/01_project/backup"
#	tgt_dir="/home/deepak/06_batch_devops/01_project/backup"
	backup_filename="backups_$(date +%Y-%m-%d-%H-%M-%S).tar.gz"
	
	echo "Backup Started...!"
	
	echo "Backup up to $backup_filename"

	tar -czvf "${tgt_dir}/${backup_filename}" "$src_dir"

	echo "Backup Completed...!"

}

backup 
