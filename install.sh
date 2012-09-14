#!/bin/zsh
DIR="$( cd "$( dirname "$0" )" && pwd )"

# allow the installation destionation to be passed in as arg1
# else default to the current user's HOME
if (($+1)); then
  DESTINATION=$1
else
  DESTINATION=$HOME
fi

for file in $(find $DIR/HOME -maxdepth 1); do
 file=${file#$DIR/HOME/}
 
 if [[ $file =~ '^[a-z]' ]]
 then
   echo "ln -s \e[1;34m$DIR/HOME\e[00m/$file \e[0;35m$DESTINATION\e[00m/.$file"
 fi
done
echo ""

echo -n "Does this look correct? (\e[1;32my\e[00m/\e[00;31mn\e[00m) "
read REPLY
if [[ $REPLY != "y" ]]; then
  echo "\e[00;31mExiting. Won't install\e[00m"
  exit 1
fi

for file in $(find $DIR/HOME -maxdepth 1); do
 file=${file#$DIR/HOME/}
 
 if [[ $file =~ '^[a-z]' ]]
 then
   
   # does file already exist?
   if [ -e "$DESTINATION/.$file" ] || [ -h "$DESTINATION/.$file" ]
   then
    echo -n ".$file exists. Overwrite? (\e[1;32my\e[00m/\e[00;31mn\e[00m) "
    read OVERWRITE
    if [[ $OVERWRITE == 'y' ]]
    then
      if [[ -f "$DESTINATION/.$file" ]] || [[ -h "$DESTINATION/.$file" ]] 
      then
        rm "$DESTINATION/.$file"
      fi

      if [[ -d "$DESTINATION/.$file" ]]
      then
        rm -r "$DESTINATION/.$file":
      fi
      echo "\e[1;32mLinking $file\e[00m"
      ln -s $DIR/HOME/$file $DESTINATION/.$file
    else
      echo "\e[1;31mSkipping file\e[00m"
      continue
    fi
   else
     echo "\e[1;32mLinking $file\e[00m"
     ln -s $DIR/HOME/$file $DESTINATION/.$file
   fi
   
 fi
done
