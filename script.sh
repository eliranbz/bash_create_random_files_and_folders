#!/bin/bash
#mailer for event handling
mailer() {
echo $1 | mail -s "Script Error" eliranbz@gmail.com
}

#Check if the script is still running and if it does - exit with error
#The reason it's ge => 3 and not 1 is because for some reason when script runs he create more processes and the shows 2 instead of 0.
#if you run this command outside the script it shows 0

running=`ps aux | grep -i "script.sh" | grep -v "grep" | wc -l`
if [ $running -ge 3 ]
then
    echo "Script is already running"
    mailer "Error! Script is already running!"
    exit 2
fi

#Creating a folder to save the results
if [ ! -d results ]; then
	mkdir results
else
	mailer "Error! Folder Exists"
	echo "*** Folder exists, skipping"
fi

cd results

#Create 100 Random Folders using mktemp
echo "*** Starting To Create Random Folders"
for i in {1..100}
do
   mktemp -d XXXXXXX
done
echo "*** Random Folders has been Created Successfully"
#Set prefixes in Array and count them
prefixes=(a b c)
num_prefixes=${#prefixes[*]}

#Run for each folder
echo "*** Starting To Create Random Files"
for dir in *;
do
        cd $dir
		#Run for each file in each folder
        for i in {1..100}
        do
				
            #Creating Random File names
			FILENAME=`mktemp -u XXXXXXX."${prefixes[$((RANDOM%num_prefixes))]}"`
			#Creating Random File Size (50Kb to 200Kb)
			FILESIZE=`expr $(((RANDOM%154+51)*1000)) + $((RANDOM%999+1))`
			#Adding random content to files using allowed chars
            cat /dev/urandom |tr -dc A-Z-a-z-0-9-" " | head -c${1:-$FILESIZE} > $FILENAME
			echo $FILENAME

			#Removing Spaces
			sed -r 's/\s+//g' $FILENAME > tmpfile
			cat tmpfile > $FILENAME
			#Removing tmpfile for next use
			rm -f tmpfile
			
			#Create MD5 File
			md5sum $FILENAME > $FILENAME.md5
        done
		#Exit folder
		echo "*** Files Has Been Created For Current Folder, Changing Folder"
        cd ..
done
