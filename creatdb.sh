#!/bin/bash

shopt -s extglob
export LC_COLLATE=C

echo "ENTER THE NAME OF DATABASE"
  read db


while [[ -d $projectpath/$db || $db != +([a-zA-Z])*([a-z1-9A-Z])  ]] 
do                           
	if [[ -d $projectpath/$db ]]
	then
		echo "DATABASE NAME IS TAKEN, PLEASE ENTER ANOTHER NAME"

	else
		echo "CONTAIN SPECIAL CHARACTER, TRY AGAIN"
	fi
	read db
done
               


export dbpath="$projectpath/$db" 
mkdir $dbpath
echo "DATABASE CREATED SUCCESSFULLY"

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