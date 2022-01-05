#!/usr/bin/bash 

typeset record=""
typeset columnname=" "
typeset datatype=""
typeset data=""
typeset -i i=1
typeset -i cols=0
typeset -i  lastid=0
typeset -i check=1

echo "enter name of the table you want to insert into"
read tablen

#check the existance of file
while [ ! -f $dbpath/$tablen ] 
	do	 
	read -p "the table name is wrong, try again : " tablen
done

#number of columns
cols=` awk -F: '{ if ( NR==1 ) { print NF }  }' $dbpath/$tablen  `


#loop on columns	 	                

while [[ $i -le $cols ]]
do 
	#print column name and datatype			
	datatype=` awk -F: -v dt=$i '{ if ( NR==1 ) { print $dt } }' $dbpath/$tablen  `
	columnname=` awk -F: -v cn=$i '{ if ( NR==2 ) { print $cn } }' $dbpath/$tablen` 

	echo "datatype: " $datatype
	echo "columnname:" $columnname
	
	#read the data of table unless it is not the serial datatyp

	if [[ $datatype != 'serial'  ]]
	then
		read data
	fi

	#for the primary key
	if [[ $i -eq 1 ]]
	then
		if [[ $datatype == 'integer'  ]]
		then	
			check=`awk -F: -v pk=$data '{ if ( $1==pk  ) { print 5 } }'  $dbpath/$tablen `	

			while [[ $check == 5 ]]
			do
				read -p "this key exists try again" data
				check=`awk -F: -v pk=$data '{ if ( $1==pk  ) { print 5 } }'  $dbpath/$tablen  `
			done
			record="$data"	
		fi


		if [[ $datatype == 'serial' ]] 
		then
			#check that there is no previous pk
			sleep 1
			echo "**********************************************"
			echo " the serial primary key will auto-increment "
			echo "**********************************************"

			checknr=`awk -F: '{ print NR; }' $dbpath/$tablen `
		
			if [[ $checknr == 2   ]]	
			then	
				record="1"
			else
				lastid=` awk -F: 'END{ print $1 }' $dbpath/$tablen  `					
				typeset -i id=$lastid+1
				record="$id" 
			fi					
		fi
		
	#excute over other columns
	else
		## if integer and not pk
		if [[ $datatype == 'integer'  ]] 
		then
			##
			while [[ $data != +([ 0-9 ]) ]]	
			do					 
				read -p " try again with integer only :" data
			done
			record="$record:$data"	
		fi
		## if string
		if [[ $datatype == 'string'  ]] 
		then
			while [[ $data != +([ a-zA-Z_1@. ]) ]]
			do
				read -p " try again with alphabets only :" data
			done
			record="$record:$data"	
		fi
	fi
i=$i+1
done
echo " $record" >> $dbpath/$tablen		
echo "Your record was added successfully"

echo "Do you want to insert something else?"
		select choice in "yes" "no" "open database" "main menu" 
		do  
		case $choice 
		in
		 		"yes") source ./insertintotable.sh;;
				"no") source ./exit.sh ;;
				"open database") source ./opendb.sh ;;
				"main menu") source ./mainmenu.sh ;;
				esac
				done

