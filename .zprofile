export PATH=~/bin:$PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias dir='ls -l'
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls-l='ls -l'
alias md='mkdir -p'
alias rd='rmdir'
alias r=rails
alias o=open
alias gog='pushd `gem environment | grep -C1 "GEM PATHS" | tail -1 | cut -b8-`/gems'
alias start=open

export EDITOR=vim
alias ekh='$EDITOR /Users/phurley/.ssh/known_hosts'
alias odiff=opendiff

alias -s jpg="open "
alias -s png="open "
alias -s pdf="open "
alias -s log="tail -f "

shell-battery() {
    ioreg -c "AppleDeviceManagementHIDEventService" -a | xpath -q -e "//key[normalize-space(text()) = 'BatteryPercent']/../*[self::key[normalize-space(text()) = 'Product'] or self::key[normalize-space(text()) = 'BatteryPercent']]/following-sibling::*[position()=1]/text()"|awk '{getline x;printf "%s: ", x;}1' 
}

alias batt=battery

gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

gclonecd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

ov() { cd ../$1 }
calc() { echo $* | /usr/bin/bc -l ; }
fff() { (find . -iname "*$1*" -and -not -path "*.svn*" -and -not -path "*/.git*") 2> /dev/null; }
alias ff='noglob fff'
lf() { less `ff $1 | head -n1`; }
ccss() { hxnormalize -x -e $1 | hxselect -s '\n' -c $2; }

export HOMEBREW_GITHUB_API_TOKEN=3b14866115a3b6faafb5b45b148b7d96c50ed703

setopt NO_CASE_GLOB
setopt AUTO_CD
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

export PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

autoload -Uz compinit && compinit
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi

if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# load bashcompinit for some old bash completions 
autoload bashcompinit && bashcompinit
[[ -r ~/Projects/autopkg_complete/autopkg ]] && source ~/Projects/autopkg_complete/autopkg 

function enc {
  openssl enc -aes-256-cbc -salt -in "$1" -out "$2"
}

function dec {
  openssl enc -d -aes-256-cbc -in "$1" -out "$2"
}

function clip { 
  [ -t 0 ] && pbpaste || pbcopy 
}

function title {
  echo -e "\033];$1\007"
}

function e {
if [ `pwd` == /Users/phurley ] 
then 
  $EDITOR .zprofile
else 
  if [ -f CMakeLists.txt ]
  then
    $EDITOR CMakeLists.txt
  else
    if [ -f config/routes.rb ]
    then
      $EDITOR config/routes.rb
    else
      if [ -f Gemfile ]
      then
        $EDITOR Gemfile
      else
        if [ -f ${PWD##*/}.rb ]
        then
          $EDITOR ${PWD##*/}.rb
        else
          FNAME=(*.rb)
          if [ -f $FNAME ]
          then
            $EDITOR $FNAME
          else
            $EDITOR
          fi
        fi
      fi
    fi
  fi
fi
}

# move up the directory tree to the root of the project
# or my home directory
function vcs_type {
  pushd . > /dev/null
    until [[ -e ".git" || -e ".svn" || ("$HOME" == "$(pwd)") ]] ; do
      cd ..
    done

    is_git="0"
    is_svn="0"
    if [[ -e ".git" ]]
      then is_git="1"
    fi

    if [[ -e ".svn" ]]
      then is_svn="1"
    fi

  popd > /dev/null
}

#alias c='git commit -am "\"$@\""'
function c {
  vcs_type()

  if [[ "$is_git" == "1" ]]
  then (git commit -m "\"$@\"")
  elif [[ "$is_svn" == "1" ]]
  then (svn commit -m "\"$@\"")
  fi    
}

function st {
  vcs_type

  if [[ "$is_git" == "1" ]]
  then (git st)
  elif [[ "$is_svn" == "1" ]]
  then (svnst)
  fi    
}

# move up the directory tree to the root of the project
# or my home directory
function gup {
  until [[ -e ".git" || -e ".svn" || -e "Gemfile" || ("$HOME" == "$(pwd)") ]] ; do
    cd ..
  done
}

alias we="ansiweather;ansiweather -f 3"
alias weather=ansiweather
alias sb='git checkout $(git branch | fzf)'
alias mb='git checkout $(git branch | fzf)'

function fv {
  AGCMD="ag -l $@"
  VIEWME=$($AGCMD | fzf)
  if [ "$VIEWME" == "" ]
  then echo "Exited"
  else view "$VIEWME"
  fi
}

# [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
[[ -s "$HOME/bin/shellmarks.sh" ]] && source "$HOME/bin/shellmarks.sh"

function command_not_found_handler() {
  # do not run when inside Midnight Commander or within a Pipe
  if test -n "$MC_SID" -o ! -t 1 ; then
    echo $"$1: command not found"
    return 127
  fi

  # check if command was a directory, if so go there
  if [ "$1" = "pull" ]; then
    shift
    /usr/local/bin/git pull "$@"
    return 0
  fi

  if [ "$1" = "fetch" ] ; then
    shift
    /usr/local/bin/git fetch "$@"
    return $?
  fi

  if [ "$1" = "commit" ] ; then
    shift
    /usr/local/bin/git commit "$@"
    return $?
  fi

  echo $"$1: command not found"
  return 127
}
	
export TOKEN=a1082786d707d8ab695f0b7acc18a0b499a533e2

. /opt/homebrew/opt/asdf/libexec/asdf.sh

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

cache --dump
