#!/bin/bash

PATH=$PATH:/usr/bin:/usr/bin/git
DATE=`date +%Y-%m-%d:%H:%M:%S`

# Check variables are set
 if [ -z "$BAK2GIT_BAK_DIR" ]; then 
 	echo "Backup directory set to: "$BAK2GIT_BAK_DIR; 
else 
	echo "Backup directory must be set in variable BAK2GIT_BAK_DIR - Cannot work without"; 
	exit 1;
fi

cd $BAK2GIT_BAK_DIR

# At a later stage we will send out emails 
# mail -s "Starting backup $DATE of gartnerprivat.de" till.gartner@gmail.com < /dev/null
echo "**** Backup on $DATE" 
echo "Path: $PATH" 

echo "git add"
git add -A  

echo "git commit"
git commit -m "Backup on $DATE" 

echo "git push"
git push

