#!/bin/bash

./prep_backup.sh
if [ $? -eq 0 ]
then
  ./bak2git.sh
else
  echo "Error when preping Backup... 😢"
fi
