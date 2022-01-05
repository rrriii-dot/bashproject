#!/usr/bin/bas
typeset  columns=""
typeset datatype=""
typeset -i c=1
#declare -A column_names=[0]
let column_names[0]

echo "-----------------------------------------------------" 
echo "                 ENTER TABLE NAME                      "
echo "-----------------------------------------------------" 
read table

#column name validation      
while  [[ -f $dbpath/$table  || $table != +([a-zA-Z])  ]] 
do               
	if [[ -f $dbpath/$table  ]]
	then
		echo "TABLE NAME IS TAKEN, PLEASE ENTER ANOTHER NAME"
	else
		echo "THIS NAME CONTAIN SPECIAL CHARACTER,PLEASE ENTER ANOTHER NAME"
	fi
	read table 
done

#read number of coulmn
echo "ENTER NUMBER OF COLOUMNS"
read col

#cloumn number validation
while [[ $col != +([1-9]) ]]
do
	read -p "try again using numbers only!!" col
done


#read the structure of table, column name and datatype of each cloumn
while [[ $c -le $col ]]
do


### for the primary key

	if [[ $c == 1  ]]
		then
                echo "-----------------------------------------------------" 
		echo " Enter the information of the primary key"
		echo "-----------------------------------------------------" 		
		echo "choose the datatype of the primary key"

		select x in "integer" "serial"
		do

			case $REPLY in

			1) datatype="integer"
				echo "enter the name of the primary key column"
				read pkname
				#validation of pk name
				while [[ $pkname != +([a-zA-Z])  ]]
				do
					read -p "try again using alphabets only!!" pkname
				done
				columns="$pkname"
column_names[$col]=$pkname
				break
				;;
			2)  datatype="serial"
				sleep 1
				echo "******NOTE: The first column will be an ID and set as a priamry key*******"
				echo "******************The ID will be auto-incremented.************************"
				sleep 1
				columns="ID"
				break
				;;
			*) echo "THERE IS NO OPTION MATCH YOUR NUMBER"
				;;
			esac
		done

	else
		##other columns info
		while true 
		do 
		echo "enter the name of the $c column"
		read colname
	

		if [[ $colname != +([a-zA-Z])   ]]   
		then

			echo "try again using alphabets only" 
			continue
		fi
#loop on array to check on repeating values		
	for i in ${column_names[@]}
	do 
	if [ "$i" == "$colname" ]
	then
	echo "column name already exists" 
	continue 2
	fi
	done
break
done
column_names[$col]=$colname
		columns="$columns:$colname"
	
   		echo "enter the datatype of the column number $c "
		
		select x in "integer" "string" 
		do
			case $REPLY in 

			1) datatype="$datatype:integer"
			break ;;
			2)  datatype="$datatype:string"
			break ;; 		         
			esac
		done
	fi
c=$c+1
done

sleep 1
#create table 
touch $dbpath/$table
echo "-----------------------------------------------------"  
echo "            TABLE CREATED SUCCESSFULLY"
echo "-----------------------------------------------------" 

echo  $datatype >> $dbpath/$table
echo $columns >> $dbpath/$table
sleep 1
echo " -----------------------------------------------------" 
echo "|           The structure of your table is            |   " 
echo " -----------------------------------------------------" 
echo $datatype
echo "-----------------------------------------------------" 
echo $columns
echo "-----------------------------------------------------" 
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


