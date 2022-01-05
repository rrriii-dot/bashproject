#!/usr/bin/bash

typeset -i exists
typeset record""

echo "enter the table name you will delete from"
read tablen


while [ !-f $dbpath/$tablen ]
do
  read -p "the table name is wrong, try again : " tablen 
done

echo "here is the table with the last updated records"
cat $dbpath/$tablen

echo "enter the value of the primary key you want to delete it's record"
read pk

exists=`awk -F: -v a=$pk '{ if  ( $1==a ) { print 1; }  }' $dbpath/$tablen ` 

while [[ $exists -eq 0 ]]
do
	read -p "enter the correct value" pk
	exists=`awk -F: -v a=$pk '{ if  ( $1==a ) { print 1; }  }' $dbpath/$tablen ` 
done

record=`awk -F: -v b=$pk  '{ if ( $1==b  ) { print $0;  }  }' $dbpath/$tablen  `
echo $record
sed -i " /$record/d  " $dbpath/$tablen	

cat $dbpath/$tablen

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

