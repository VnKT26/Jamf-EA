#!/bin/bash
#Checks for if Client is running  Microsoft Office 2016 or Microsoft Office 2019 based on the presence of Excel
Check2016(){

wordversion=$(defaults read /Applications/Microsoft\ Word.app/Contents/Info.plist CFBundleVersion)

if [[ $wordversion = 15.* || $wordversion = 16.[0-9].* || $wordversion = 16.1[0-6]* ]];
then 
Office2016=$(echo "<result>Office2016Installed</result>")
else echo "Office2016 NotInstalled, no xml output"
fi
}

Check2019() {

#script to determine if MS Office 2019 is installed

excelversion=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleVersion)
onenoteversion=$(defaults read /Applications/Microsoft\ OneNote.app/Contents/Info.plist CFBundleVersion)
outlookversion=$(defaults read /Applications/Microsoft\ Outlook.app/Contents/Info.plist CFBundleVersion)
powerpointversion=$(defaults read /Applications/Microsoft\ PowerPoint.app/Contents/Info.plist CFBundleVersion)
wordversion=$(defaults read /Applications/Microsoft\ Word.app/Contents/Info.plist CFBundleVersion)


#Remove the period from the output

excelversionNP=$(defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleVersion | cut -c1-5 | tr -d .)
onenoteversionNP=$(defaults read /Applications/Microsoft\ OneNote.app/Contents/Info.plist CFBundleVersion | cut -c1-5 | tr -d .)
outlookversionNP=$(defaults read /Applications/Microsoft\ Outlook.app/Contents/Info.plist CFBundleVersion | cut -c1-5 | tr -d .)
powerpointversionNP=$(defaults read /Applications/Microsoft\ PowerPoint.app/Contents/Info.plist CFBundleVersion | cut -c1-5 | tr -d .)
wordversionNP=$(defaults read /Applications/Microsoft\ Word.app/Contents/Info.plist CFBundleVersion | cut -c1-5 | tr -d .)




#below will identify presence of any Office app version 16.17 through 16.29:
if [[ $excelversion = 16.2?* || $excelversion = 16.1[7-9]* || \
$onenoteversion = 16.2?* || $onenoteversion = 16.1[7-9]* || \
$outlookversion = 16.2?* || $outlookversion = 16.1[7-9]* || \
$powerpointversion = 16.2?* || $powerpointversion = 16.1[7-9]* || \
$wordversion = 16.2?* || $wordversion = 16.1[7-9]* ]] ;

#For JAMF EA:
then Office2019=$(echo "<result>Office2019Installed<result/>")
elif [[ "$excelversionNP" -ge '1640' ]];
then
 Office2019=$(echo "<result>Office2019Installed<result/>")
else echo  "Office2019 NotInstalled, no xml output"
fi

}

Check2016
Check2019
echo "$Office2016"
echo "$Office2019"
exit 0

