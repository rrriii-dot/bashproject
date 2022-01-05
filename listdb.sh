#!/bin/bash
export dbpath=~/project/database

echo "-----------------------------------------------------"
		echo "                  YOUR DATABASE IS                      "  		
		echo "-----------------------------------------------------"
		ls $projectpath    
		echo "-----------------------------------------------------"
		sleep 2
		echo "Do you want to open a database?"
		select choice in "yes" "no" "exit"
		do  
		case $choice 
		in
		 		"yes") source ./opendb.sh ;;
				"no") source ./mainmenu.sh ;;
				"exit") source ./exit.sh ;;
				esac
				done
