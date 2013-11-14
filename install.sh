#!/bin/zsh
DIR="$(readlink -f "$( cd "$( dirname "$0" )" && pwd )")"

# allow the installation destination to be passed in as arg1
# else default to the current user's HOME
if (($+1)); then
  DESTINATION=$1
else
  DESTINATION=$HOME
fi

# get the absolute location of our destination
DESTINATION="$(readlink -f "$DESTINATION")"

# check if we are running the current script out of our desired location
if [ `readlink -f $DESTINATION/.dotfiles` != $DIR ]; then
  #debug
  #echo $DIR
  #echo `readlink -f $DESTINATION/.dotfiles`
  if [ -h $DESTINATION/.dotfiles ]; then # check if desired location is symlink
    # at this point we know the desired destination is a symlink but not the one we want
    echo "There seems to be a symlinked directory where i would like to put mine."
    echo "I would like to symlink $DESTINATION/.dotfiles to $DIR"
    echo "Currently it is symlinked to `readlink -f $DESTINATION/.dotfiles`"
    echo "I'm going to let you sort that out."
    echo "Abandon ship!"
    exit 1;
  else # desired location is not symlink
    if [ -e $DESTINATION/.dotfiles ]; then # check if file exists in the desired location
      echo "file exists"
    else # file does not exist in the desired location
      echo "I see you are using an alternate dotfiles directory location. I need to create a link to myself that I know of"
      echo "May I symlink $DIR to $DESTINATION "
      echo -n "Create? (\e[1;32my\e[00m/\e[00;31mn\e[00m) "
      read CREATE
      if [[ $CREATE == "y" ]]; then
        ln -s $DIR $DESTINATION/.dotfiles
      else
        echo "Sounds good boss. I'm going to let you sort that out then."
        echo "Abandon ship!"
        exit 1;
      fi
    fi
  fi
  echo "woot"
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

# install powerline if needed
echo "Checking if powerline is needing to be installed"
if type "yaourt" &> /dev/null; then
  echo "\e[1;32mInstalling powerline\e[00m"
  yaourt -Qq | grep -qw python-powerline-git || yaourt -S python-powerline-git
  yaourt -Qq | grep -qw gvim-python || yaourt -S gvim-python
else
  echo "Sorry I don't know how to install powerline without yaourt. It might be installed but i wouldn't know"
fi
