#!bin/bash

typeset -i pkey=0
typeset -i checkpr=1
typeset datatype=""
typeset cloumnlables=""
typeset -i field=1
typeset -i checkcolumn=0

echo "enter name of the table you want to update"
read tablenname



function update()
{

	

	oldline=$(awk -F: -v pk=$pkey '{if( $1==pk ) { print $0 } }' $dbpath/$tablenname)

	newline=$(awk -F: -v pk=$pkey -v updatedCol=$checkcolumn -v newVal="$newdata" 'BEGIN{OFS=":";}gsub($updatedCol, newVal, $updatedCol){if( $1== pk) {print $0}}' $dbpath/$tablenname)

	sed -i 's/'"$oldline"'/'"$newline"'/g' $dbpath/$tablenname
	echo "***********************************"
	echo $newline
	echo "***********************************"
	echo DONE
}



#check the existance of file
	while [ ! -f $dbpath/$tablenname ] 
	do	 
		read -p "the table name is wrong, try again : " tablenname
	done
#get pk amd check existance
echo "enter the primary key of the record you want to update"
read pkey
checkpr=`awk -F: -v prk=$pkey '{ if ( $1==prk  ) { print 2 } }'  $dbpath/$tablenname `	
		while [[ $checkpr != 2 ]]
			do
		read -p "This key doesn't exists"  pkey
		    checkpr=`awk -F: -v prk=$pkey '{ if ( $1==prk  ) { print 2 } }'  $dbpath/$tablenname `	
            done  

    #get record info  
NF=`  awk -F: ' END{ print NF  }'  $dbpath/$tablenname `


while [[ $field -le $NF ]]
do
datatype[$field]=`awk -F: -v i=$field '{ if( NR == 1 ) print $i }' $dbpath/$tablenname`
cloumnlables[$field]=`awk -F: -v i=$field  '{ if( NR == 2 ) print $i }' $dbpath/$tablenname`
data[$field]=`awk -F: -v recordud=$pkey -v i=$field '{ if( $1 == recordud ) print $i }' $dbpath/$tablenname`
field=$field+1
done
###display the record
echo
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


echo "enter the column name you want to update" 
read columnupdate

checkcolumn=$(awk -F: -v cnu=$columnupdate '{ if ( NR==2 ) {for ( i=1; i<=NF; i++ ) { if ( $i==cnu ) {print i } } } }' $dbpath/$tablenname)
#echo $checkcolumn

while [[ $checkcolumn == 0 ]]
do
	read -p "your entry doesn't match any fields, try again", columnupdate
	checkcolumn=`awk -F: -v cnu=$columnupdate '{ if ( NR==2 ) {for ( i=1; i<=NF; i++) { if ( $i==cnu ) { print i } } }   }' $dbpath/$tablenname `
done

while [[ $checkcolumn == 1 ]]
do
	read -p "you can't update a primary key, try again", columnupdate
	checkcolumn=`awk -F: -v cnu=$columnupdate '{ if ( NR==2 ) {for ( i=1; i<=NF; i++) { if ( $i==cnu ) { print i } } }   }' $dbpath/$tablenname `
done

datatype=$(awk -F: -v ckv=$checkcolumn '{ if ( NR==1 ) { print $ckv } }' $dbpath/$tablenname)
echo $datatype
echo "enter your new entry"
	read newdata


if [[ $datatype == 'integer'  ]] 
		then
			##
			while [[ $newdata != +([ 0-9 ]) ]]	
			do					 
				read -p " try again with integer only :" newdata
			done
					fi
		## if string
		if [[ $datatype == 'string'  ]] 
		then
			while [[ $newdata != +([ a-zA-Z_1@. ]) ]]
			do
				read -p " try again with alphabets only :" newdata
			done
			
		fi

	

update

sleep 1
echo "Do you want to update something else?"
		select choice in "yes" "no" "main menu"
		do  
		case $choice 
		in
		 		"yes") source ./updatetable.sh;;
				"no") source ./exit.sh ;;
				"main menu") source ./mainmenu.sh ;;
				esac
				done
