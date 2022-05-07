#!/bin/bash
#https://github.com/lshannon/bash-reference


echo 'Please supply a non-blank value?'
  read VALUE
  if [ -z "$VALUE" ]; then
    echo "I said 'non-blank'"
  else
    echo "You said: $VALUE"
  fi
echo 'Done!'  
