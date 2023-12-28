#!/bin/zsh
# Username and Password to create
username=ADMINACCOUNTUSERNAME
password=“SuperSecurePassword”
# Create User and add to admins
dscl . -create /Users/$username
dscl . -create /Users/$username UserShell /bin/bash # Sets Default Shell could be sh or zsh
dscl . -create /Users/$username RealName $username # Sets Displayname for the account
dscl . -create /Users/$username UniqueID "666" #Unique Local ID
dscl . -create /Users/$username PrimaryGroupID 20 # 20 for admin accounts 80 for standard accounts
dscl . -create /Users/$username NFSHomeDirectory /Users/$username # Creates account home directory
dscl . -passwd /Users/$username $password # Sets PW
dscl . -append /Groups/admin GroupMembership $username # Adds to local admin group
# Get list of regular users
users=$(dscl . -list /Users | grep -v -e '_' -e root -e nobody -e daemon -e $username)
# Loop through them and remove them from Admins group
for i in $users
do
dseditgroup -o edit -d $i -t user admin
done