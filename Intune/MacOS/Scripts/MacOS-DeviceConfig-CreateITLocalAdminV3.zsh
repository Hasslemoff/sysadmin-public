#!/bin/zsh
# Username and Password to create
username=ADMINACCOUNTUSERNAME
password="SuperSecurePassword3!"
# Create User and add to admins
dscl . -create /Users/$username
dscl . -create /Users/$username UserShell /bin/bash # Sets Default Shell could be sh or zsh
dscl . -create /Users/$username RealName $username # Sets Displayname for the account
dscl . -create /Users/$username UniqueID "666" #Unique Local ID
dscl . -create /Users/$username PrimaryGroupID 20 # 20 for admin accounts 80 for standard accounts
dscl . -create /Users/$username NFSHomeDirectory /Users/$username # Creates account home directory
dscl . -passwd /Users/$username $password # Sets PW
dscl . -append /Groups/admin GroupMembership $username # Adds to local admin group
dscl . -create /Users/$username IsHidden 1 #Hides the user from the login screen