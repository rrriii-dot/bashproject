#!/usr/bin/bash
shopt -s extglob
export LC_COLLATE=C

echo "-----------------------------------------------------"
echo "      Enter the name of the database                 "
echo "-----------------------------------------------------"
read db

while [[ ! -d $projectpath/$db ]]
do                                      
	echo "Doesn't exists, please enter another name"
	read db
      
done

rm -r  $projectpath/$db
echo
echo
echo "Database removed successfuly"

sleep 1
echo "Do you want to do something else?"
		select choice in "no" "main menu"
		do  
		case $choice 
		in
		 		"main menu") source ./mainmenu.sh ;;
				"no") source ./exit.sh ;;
			
				esac
				done
