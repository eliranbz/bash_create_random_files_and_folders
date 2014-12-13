Bash-RandomFilesAndFolders-MD5-ContentManipulation
==================================================
1. checks if this script is already running, if it's running write an error and exit
2. creates `100` random folders
3. creates `100` files in each folder with the following rules:
   - random size of `50K` to `200K`
   - random file-name prefix of `a`, `b` or `c`
   - random content of `a-z`, `A-Z`, `0-9`, `' '` (space)
4. for each file in each folder, remove all spaces in a file
5. for each file in each folder, create `.md5` file
6. if any of the steps above fails, exit and write an email
