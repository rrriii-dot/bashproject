#!/usr/bin/bash
typeset -i exists=0
echo "Enter The name of table want to select data from"
read tablen

#table exists validation
while  [ ! -f $dbpath/$tablen ] 
do 
	read -p "the table name is wrong, try again : " tablen
done

echo "enter the value of the primary key you want to delete it's record"
read pk

#record exists validation
exists=`awk -F: -v a=$pk '{ if  ( $1==a ) { print 1; }  }' $dbpath/$tablen ` 

while [[ $exists -eq 0 ]]
do
	read -p "enter the correct value" pk
	exists=`awk -F: -v a=$pk '{ if  ( $1==a ) { print 1; }  }' $dbpath/$tablen ` 
done


#select record 

data=`awk -F: -v a=$pk '{ if( $1 == a ) print $0 }'  $dbpath/$tablen`




#display record 
NF=`  awk -F: ' END{ print NF  }'  $dbpath/$tablen `

typeset -i field=1


while [[ $field -le $NF ]]
do
datatype[$field]=`awk -F: -v i=$field '{ if( NR == 1 ) print $i }' $dbpath/$tablen`
cloumnlables[$field]=`awk -F: -v i=$field  '{ if( NR == 2 ) print $i }' $dbpath/$tablen`
data[$field]=`awk -F: -v a=$pk -v i=$field '{ if( $1 == a ) print $i }' $dbpath/$tablen`
field=$field+1
done

echo "Data of record: "
echo
echo "DataType : Column Name : Data "
echo
field=1
while [[ $field -le $NF ]]
do
echo "${datatype[$field]} : ${cloumnlables[$field]} : ${data[$field]}"
echo
field=$field+1
done

sleep 1
echo "Do you want to do select something else?"
		select choice in "yes" "no" "main menu"
		do  
		case $choice 
		in
		 		"yes") source ./selectfromtable.sh;;
				"no") source ./exit.sh ;;
				"main menu") source ./mainmenu.sh ;;
				esac
				done




