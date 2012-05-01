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
   
   # does file already exist?
   if [ -e "$DESTINATION/.$file" ]
   then
    echo -n ".$file exists. Overwrite? (\e[1;32my\e[00m/\e[00;31mn\e[00m) "
    read OVERWRITE
    if [[ $OVERWRITE == 'y' ]]
    then
      if [[ -f "$DESTINATION/.$file" ]]
      then
        rm "$DESTINATION/.$file"
      fi

      if [[ -d "$DESTINATION/.$file" ]]
      then
        rm -r "$DESTINATION/.$file"
      fi
    else
      echo "\e[1;31mSkipping file\e[00m"
      continue
    fi
   fi
   
   echo "\e[1;32mLinking $file\e[00m"
   ln -s $DIR/$file $DESTINATION/.$file
 fi
done
