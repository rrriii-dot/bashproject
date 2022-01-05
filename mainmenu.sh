#!/bin/bash 
export projectpath=~/project/database 

echo "choose one of the options"
 
	select x in " Create database" " List database" " Drop database" " Open database"
	do
		case $x in 
	        " Create database") source ./creatdb.sh ;;
		" List database") source ./listdb.sh ;;
		" Drop database" ) source  ./deletedb.sh;;
		" Open database") source ./opendb.sh ;;	
		esac
	done
