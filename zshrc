# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="lukerandall"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

HOSTNAME=`hostname -s`

if [[ $HOSTNAME =~ 'mac[0-9]{3}' || $HOSTNAME == 'k-lmriutzel' ]] {
  source $HOME/.bash_profile
  
  alias pub1='ssh pub1 -t su -c "tmux\ a" root'
  alias wi='ssh wi -t tmux a'
  alias toph='ssh toph -t su'
  alias nana='ssh nana -t tmux a'
  alias opus='ssh opus -t su -c "tmux\ a" root'
  
  alias freenode="ssh -NL 6667:irc.freenode.net:6667 pub1"
  alias tpirc="ssh -NL 6666:irc.esper.net:6667 pub1"
  
  alias mtr="mtr --curses"
  
  # proxy info
  export http_proxy=http://10.10.10.13:8080
  export https_proxy=http://10.10.10.13:8080
  export HTTP_PROXY=http://10.10.10.13:8080
  export HTTPS_PROXY=http://10.10.10.13:8080
  
  alias noproxy="unset http_proxy; unset https_proxy; unset HTTP_PROXY; unset HTTPS_PROXY; "
}

# if tmux make force get zsh to not be stupid and use 256 color mode
if [[ ${+TMUX} == 1 ]]
then
  export TERM=screen-256color
fi

unsetopt correct_all

setopt autopushd

# override oh-my-zsh function
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ $ref == refs* ]]; then
    git="${ref#refs/heads/}"
  elif [[ -n $(git describe --exact-match HEAD 2> /dev/null) ]]; then
    git=$(git describe --exact-match HEAD 2> /dev/null)
  elif [[ -n $(git describe HEAD 2> /dev/null) ]]; then
    git=$(git describe HEAD | sed "s/.\{9\}$//g" | sed "s/-/+/"  2> /dev/null)
  fi

  if [[ $git =~ .+ ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$git$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX";
  fi
}

# override lukerandall theme function
function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ $ref == refs* ]]; then
    git="${ref#refs/heads/}"
  elif [[ -n $(git describe --exact-match HEAD 2> /dev/null) ]]; then
    git=$(git describe --exact-match HEAD 2> /dev/null)
  elif [[ -n $(git describe HEAD 2> /dev/null) ]]; then
    git=$(git describe HEAD | sed "s/.\{9\}$//g" | sed "s/-/+/"  2> /dev/null)
  fi

  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"

  if [[ $git =~ .+ ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$git$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX";
  fi
}
