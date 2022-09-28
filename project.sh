string="" # repesent the string of file
x=0  # a variable to check if exists or doesn't
select="" # represent the chosen number from the menu
selection="" #represent the selected field first name or last name in list
first="" # represent the string of first name
last="" # represent the string of last name
phone="" # represent the string of phone number
email="" # represent the string of email
printf "welcome\n"
read -p "please choose a file:"  string
echo $string
if [ -e $string ]
then 
echo "the file exists"
sed '1d' $string > names.txt
x=1
else
echo "the file doesn't exist"
fi
while [ $x==1 ] # if file exists
do
printf " ** welocme to Contact Management System ****\n"
printf "\n\n"
printf "           MAIN MENU\n"
printf "======================\n"
printf "[1] Add a new Contact\n"
printf "[2] List all Contacts\n"
printf "[3] Search for Contact\n"
printf "[4] Edit a Contact\n"
printf "[5] Delete a Contact\n"
printf "[0] Exit\n"
printf "=======================\n"
read -p  "Enter the choice:" select
if [ "$select" -eq 0 ]
then
exit 1
fi
case "$select" #case statment 
in
#add new contact
[1] ) echo "please enter First name:"  
	read first
	if [ $first = "" ] # checking if the first name empty
	then
		echo "please enter First name(it's a required field):"  
        	read first
       	 
	fi
	if  echo $first | grep '^[A-Za-z]*[A-Za-z]$' > /dev/null #valid
	then
	:
	else
	#if if the first name is not valid the user can write it or quit
        	echo "please enter First name again or print 1 to quit:"  
        	read first
        fi
        
        if echo $first | grep '^[A-Za-z]*[A-Za-z]$' > /dev/null #valid
	then
	:
	else # not valid for the second time
       	 continue
        fi
        
	echo "please enter last name:" 
	read last
	if  echo $last | grep '^[A-Za-z]*[A-Za-z]$' > /dev/null # valid
	then
	:
	else
	if [ "$last" = "" ] # checking if the last name empty
	then
		echo " it can be empty, it's an optional field"
	else
		echo "not valid, do you want to write it again?(yes or no)"
	read ans
	if [ $ans = "yes" ]
	then
		echo "enter your last name again: "
		read last
	else 
	:
	fi
	fi
	fi
	
	echo "please enter phone number:" 
	read phone
	
	if [ $phone = "" ] # checking if the phone number is empty
	then
		echo "please enter phone(it's a required field):" 
	read phone
	fi
	if  echo $phone | grep '^[0-9]\{9,10\}$' > /dev/null #valid
	then
	:
	else
		echo "please enter phone again:" #not valid
	read phone
	fi
	
	echo "please enter email:" 
	read email
	
	if echo $email | grep '^[A-Za-z].*@[A-Za-z]*\.[A-Za-z]*$' > /dev/null #valid
	then
	:
	else
		if [ "$email" = "" ] # checking if email is empty
		then
			echo " it can be empty, it's an optional field"
		else
        		echo "please enter email again:" # not valid  
        		read email
        	fi
        fi
        # adding the new contact to names.txt
        echo "$first ,$last , $phone , $email" >> names.txt 
        ;; 
        
[2] )	#list contact according to first or last name and selected fields 

	echo "please enter whether you want to list contacts based on first name or last name"
	
	read selection
	# if first name has been chosen
	
	if echo $selection | grep '\<[Ff]irst [Nn]ame\>' > /dev/null 
	then
	sort -k 1 names.txt > sort.txt
	
	# select fields to list with first name
	
	echo "please choose the fields you want to list (last,phone,email)(add ',' after each field)"  
	read choice
	
	if echo $choice | grep '^[Ll][A-Za-z]*,[Pp][A-Za-z]*$' > /dev/null
	then # to list last name and phone number with the first name
	cut -d ',' -f 1,2,3 sort.txt
	
	elif echo $choice | grep '^[Ll][A-Za-z]*,[Ee][A-Za-z]*$' > /dev/null
	then # to list last name and email with the first name
	cut -d ',' -f 1,2,4 sort.txt
	elif echo $choice | grep '^[Pp][A-Za-z]*,[Ee][A-Za-z]*$' > /dev/null
	then # to list phone number and email with the first name
	cut -d ',' -f 1,3,4 sort.txt
	
	elif echo $choice | grep '^[Pp]...e$' > /dev/null
	then # to list phone number  with the first name
	cut -d ',' -f 1,3 sort.txt
	
	elif echo $choice | grep '^[Ee]...l$' > /dev/null
	then # to list email with the first name
	cut -d ',' -f 1,4 sort.txt
	
	elif echo $choice | grep '^[Ll]..t$' > /dev/null
	then # to list last name with the first name
	cut -d ',' -f 1,2 sort.txt
	fi
	
 	# if last name has been chosen
 	
	elif echo $selection | grep '\<[Ll]ast [Nn]ame\>' > /dev/null 
	then
	sort -k 2 names.txt > sort.txt
	
	echo "please choose the fields you want to list (first,phone,email)(add ',' after each field)" # select fields to list with last name
	
	read choice
	
	if echo $choice | grep '^[Ff][A-Za-z]*,[Pp][A-Za-z]*$' > /dev/null
	then # to list first name and phone number with the last name
	cut -d ',' -f 1,2,3 sort.txt
	elif echo $choice | grep '^[Ff][A-Za-z]*,[Ee][A-Za-z]*$' > /dev/null
	then # to list first name and email with the last name
	cut -d ',' -f 1,2,4 sort.txt
	elif echo $choice | grep '^[Pp][A-Za-z]*,[Ee][A-Za-z]*$' > /dev/null
	then # to list phone number and email with the last name
	cut -d ',' -f 2,3,4 sort.txt
	
	elif echo $choice | grep '^[Pp]...e$' > /dev/null
	then # to list phone number with the last name
	cut -d ',' -f 2,3 sort.txt
	
	elif echo $choice | grep '^[Ee]...l$' > /dev/null
	then # to list email with the last name
	cut -d ',' -f 2,4 sort.txt
	
	elif echo $choice | grep '^[Ff]...t$' > /dev/null
	then # to list first name with the last name
	cut -d ',' -f 1,2 sort.txt
	
	fi

	fi
	;;
[3] ) 	#serach for a contact
	cat names.txt | tr -d ',' > search.txt
	cat search.txt | tr "[A-Z]" "[a-z]" > search1.txt
	
	echo "please enter what you want to search for:"
	read search 
	
	cat search1.txt | grep "$search" > search.txt
	cat search.txt
	;;
[4] ) 	# edit a contact
	cat names.txt | tr -d ',' > edit.txt
	cat edit.txt | tr "[A-Z]" "[a-z]" > names.txt
	
	echo "please write the first name or the last name or phone number or email of the contact that you want to edit" # choose which contact to edit
	read edit
	 
	cat names.txt | grep -v "$edit" > edit1.txt
	
	if cat names.txt | grep "$edit" > edit.txt
	then
		cat edit.txt 
		echo "which contact you want to edit from the above( write a unique field)" # choosing which field to edit
		read edit1
	
		cat edit.txt | grep -v "$edit1" > edit3.txt
	
		if cat edit.txt | grep "$edit1" > edit2.txt
		then
			cat edit2.txt
			echo "do you want to edit this contact? Are you sure?(write yes or no)"
			read edit2
			if [ $edit2 = "yes" ]
			then
				# menu to choose which field to edit
				printf "  Menu of fields\n"
				printf "======================\n"
				printf "[1] for the first name\n"
				printf "[2] for the last name\n"
				printf "[3] for the phone number\n"
				printf "[4] for the email\n"
				printf "======================\n"
				echo "please enter the number of field from the menu above"
				read field
				case "$field" 
				in
				[1] ) echo "please enter the new first name"
				read newfirst
				awk '{$1=newf}1' newf=$newfirst edit2.txt 
				;;
	
				[2] )	echo "please enter the new last name"
				read newlast
				awk '{$2=newl}1' newl=$newlast edit2.txt 
				;;
	
				[3] )	echo "please enter the new phone number"
				read newphone
				awk '{$3=newp}1' newp=$newphone edit2.txt 
				;;
	
				[4] )	echo "please enter the new email"
				read newemail
				awk '{$4=newe}1' newe=$newemail edit2.txt 
				;;
				esac
	
			elif [ $edit2 = "no" ]
			then
		        continue 
			fi
		else 
		echo "filed not found2"
		fi
	else
	echo "field not found"
	fi
	
	cat edit3.txt >> edit1.txt
	cat edit1.txt > names.txt
	
	;;
	
[5] ) 	# delete a contact
	cat names.txt | tr -d ',' > delete.txt
	cat delete.txt | tr "[A-Z]" "[a-z]" > names.txt
	
	#choose a contact to edit by seraching for it first
	echo "please write the first name,or last name or phone number or 		email of the contact that you want to delete" 
	
	read delete
	cat names.txt | grep -v "$delete" > delete1.txt 
	 
	cat names.txt | grep "$delete" > delete.txt  # contact to delete 
	
	cat delete.txt
	
	#if there is mpre than one contact
	echo "do you want to delete all contacts above(yes or no)"
	 
	read delete1
	if [ $delete1 = "yes" ]
	then
		sed '/'"$delete"'/d' names.txt  # delete all contacts
	else
		# if there is 2 contacts and we want to delete one of them
		echo "please enter anything unique related to this contact"
		read delete2 
	 
		cat delete.txt | sed '/'"$delete2"'/d' >> delete1.txt
		cat delete1.txt > names.txt
		cat names.txt
	fi
	;;
esac
done

