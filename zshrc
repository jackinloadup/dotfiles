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
source $HOME/.bash_profile

# Customize to your needs...

alias pub1='ssh pub1.kanakuk.com -t su -c "tmux\ a" root'
alias lr='ssh -L 10000:localhost:10000 lucasr.com -t su -c "tmux\ a" root'
alias wi='ssh root@wiledesign.wiledesign.com -t tmux a'
alias toph='ssh sean@toph.tac0bell.com -t su'
alias nana='ssh root@nana.wikiwhore.com -t tmux a'
alias opus='ssh rcs@opus.robisoncreative.com -t su'

alias freenode="ssh -NL 6667:irc.freenode.net:6667 lucasr.com"
alias tpirc="ssh -NL 6666:irc.esper.net:6667 lucasr.com"

alias mtr="mtr --curses"

# proxy info
export http_proxy=http://10.10.10.13:8080
export https_proxy=http://10.10.10.13:8080
export HTTP_PROXY=http://10.10.10.13:8080
export HTTPS_PROXY=http://10.10.10.13:8080

alias noproxy="unset http_proxy; unset https_proxy; unset HTTP_PROXY; unset HTTPS_PROXY; "
#
# if tmux make force get zsh to not be stupid and use 256 color mode
if [[ ${+TMUX} == 1 ]]
then
  export TERM=screen-256color
fi

unsetopt correct_all

export PATH=$PATH:/usr/local/sbin:/Developer/android-sdk/platform-tools:$HOME/bin

setopt autopushd
