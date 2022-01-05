#!/usr/bin/bash

echo "ENTER NAME OF TABLE WANTO TO DELETE"
read table

while [[ ! -f $dbpath/$table ]]
do
	echo "NOT EXISTES, PLEASE ENTER THE NAME AGAIN"
	read table

done

rm $dbpath/$table
echo "TABLE REMOVED SUCCESSFULLY"

sleep 1
echo "Do you want to do something else?"
		select choice in "yes" "no" "main menu"
		do  
		case $choice 
		in
		 		"yes") source ./opendb.sh;;
				"no") source ./exit.sh ;;
				"main menu") source ./mainmenu.sh ;;
				esac
				done

				