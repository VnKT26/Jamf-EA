#!/bin/bash


EA_Function(){

#List all Users
Users_homefolders="$(/bin/ls /Users/ | grep -v '.localized' | grep -v 'root' | grep -v 'adoa-administrator' | grep -v 'casperadmin' | grep -v 'Shared' | grep -v 'administrator'| grep -v 'parks-administrator' | grep -v 'Guest' | grep -v 'Library' | grep -v 'xahome')"



for user in $Users_homefolders; do
	uid="$(/usr/bin/id -u $user)"

		#Verify User Account Type
 		if [ "$uid" -lt 1000 ]; then
		Account_Type="Local"
		elif [ "$uid" -gt 1000 ]; then
		Account_Type="Network"
 		fi
 
 		#Find if Account is Mobile or Not 
		MobileAccount_Type=$(/usr/bin/dscl . list /Users | /usr/bin/grep "$user" )
		if [ "$MobileAccount_Type" == "" ]; then
		Status="Network-Only-Account"
		elif [ "$MobileAccount_Type" == "$user" ]; then
		Status="Mobile-Account"
 		fi
 
if [ "$Account_Type" == "Local" ]; then 	
echo "<result>$user
$Account_Type</result>"
else 
echo "<result>$user
$Account_Type
$Status</result>"
fi	
	
done
}

#########################################################
result="`EA_Function`"
echo "<result>$result</result>"
exit 0		## Success
