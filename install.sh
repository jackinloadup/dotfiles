#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
echo "Installing files from $DIR"

if (($+1)); then
  DESTINATION=$1
else
  DESTINATION=$HOME
fi

echo "to $DESTINATION"
echo "----Below is an example---"

for file in $(find $DIR -maxdepth 1); do
 file=${file#$DIR/}
 
 if [[ $file =~ '^[a-z]' ]] && [[ $file != 'install.sh' ]]
 then
   echo "ln -s $DIR/$file $DESTINATION/.$file"
 fi
done
echo "------------------------"

echo "Does this look correct? (y/n) "
read  REPLY
if [[ $REPLY != "y" ]]; then
  echo "Exiting. Won't install"
  exit 1
fi

echo "Installing"

for file in $(find $DIR -maxdepth 1); do
 file=${file#$DIR/}
 
 if [[ $file =~ '^[a-z]' ]] && [[ $file != 'install.sh' ]]
 then
   ln -s $DIR/$file $DESTINATION/.$file
 fi
done
