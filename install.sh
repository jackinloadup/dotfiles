#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"

if (($+1)); then
  DESTINATION=$1
else
  DESTINATION=$HOME
fi

for file in $(find $DIR -maxdepth 1); do
 file=${file#$DIR/}
 
 if [[ $file =~ '^[a-z]' ]] && [[ $file != 'install.sh' ]]
 then
   echo "ln -s \e[1;34m$DIR\e[00m/$file \e[0;35m$DESTINATION\e[00m/.$file"
 fi
done
echo ""

echo -n "Does this look correct? (\e[1;32my\e[00m/\e[00;31mn\e[00m) "
read REPLY
if [[ $REPLY != "y" ]]; then
  echo "\e[00;31mExiting. Won't install\e[00m"
  exit 1
fi

for file in $(find $DIR -maxdepth 1); do
 file=${file#$DIR/}
 
 if [[ $file =~ '^[a-z]' ]] && [[ $file != 'install.sh' ]]
 then
   ln -s $DIR/$file $DESTINATION/.$file
 fi
done
