#!//usr/bin/bash

echo "      Enter the name of the database you want to open     "
   read db

while [ ! -d $projectpath/$db ]
do
	read -p "Wrong name, try again: " db
done

export dbpath="$projectpath/$db"
echo "What do you want to do ?"
echo "*************************************************************"
select x in "Create Table" "List Tables" "Drop Table " " Insert into Table" " Select From Table" " Delete From Table " " Update Table" " Back to main menu"
	do
	case $x in
		"Create Table") source  ./createtable.sh;;

		"List Tables")
		echo "-----------------------------------------------------" 
		echo "                  YOUR TABLES ARE                    "  		
		echo "-----------------------------------------------------"
	        ls $dbpath  
		echo "-----------------------------------------------------"
		sleep 2
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
		;;

		"Drop Table ") source ./droptable.sh ;;

		" Insert into Table") source ./insertintotable.sh;;
		
		" Select From Table") source ./selectfromtable.sh;;
		
		" Delete From Table ") source ./deletefromtable.sh;;

		" Update Table") source ./updatetable.sh;;

		"main menu")source ./mainmenu.sh ;;
	esac
done


