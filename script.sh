#!/bin/bash
#Check if the script is still running and if it does - exit with error
if pidof -x "script.sh" >/dev/null; then
    echo "Script is already running"
        exit 2
fi

#Creating a folder to save the results
mkdir results
cd results

#Create 100 Random Folders using mktemp
for i in {1..100}
do
   mktemp -d XXXXXXX
done

#Set prefixes in Array and count them
prefixes=(a b c)
num_prefixes=${#prefixes[*]}

#Run for each folder
for dir in *;
do
        cd $dir
		#Run for each file in each folder
        for i in {1..100}
        do
				
            #Creating Random Filenames
			FILENAME=`mktemp -u XXXXXXX."${prefixes[$((RANDOM%num_prefixes))]}"`
			#Creating Random File Size (50Kb to 200Kb)
			FILESIZE=`expr $(((RANDOM%154+51)*1000)) + $((RANDOM%999+1))`
			#Adding random content to files using allowed chars
                        cat /dev/urandom |tr -dc A-Z-a-z-0-9-" " | head -c${1:-$FILESIZE} > $FILENAME
			echo $FILENAME

			#Removing Spaces From file content using a tmp file manipulation
			sed -r 's/\s+//g' $FILENAME > tmpfile
			cat tmpfile > $FILENAME
			
			#Removing tmpfile for next use
			rm -f tmpfile
			
			#Create MD5 File
			md5sum $FILENAME > $FILENAME.md5
        done
		#Exit folder
        cd ..
done

mailer {
sendmail eliranbz@gmail.com <<EOF
subject: test
from: Script@scriptland.com

Something went wrong!
EOF
}
