#!/bin/bash
MIT License

Copyright (c) 2021 Ventura Torres

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

EA_Function(){

#List all Users
Users_homefolders="$(/bin/ls /Users/ | grep -v '.localized' | grep -v 'root' | grep -v '<IT_ACCOUNT_NAME>' | grep -v 'Shared' | grep -v 'Guest')"



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
exit 0		
