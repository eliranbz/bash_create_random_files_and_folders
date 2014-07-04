Bash-RandomFilesAndFolders-MD5-ContentManipulation
==================================================

Checks if this script is already running, if it's running write an error and exit creates 100 random folders. 
creates 100 files in each folder with the following rules: 
random size of 50K to 200K 
random file-name prefix of a, b or c 
random content of a-z, A-Z, 0-9, ' ' (space) 
for each file in each folder, remove all spaces in a file 
for each file in each folder, create .md5 file 
if any of the steps above fails, exit and write an email
