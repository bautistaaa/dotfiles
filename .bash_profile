confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}


#########################################
# DOCKER
#########################################
alias dlist="docker ps -a"
docker_ids() { docker ps -aq; }
docker_stop_all() { docker stop $(docker_ids); }
docker_remove_all() { docker rm $(docker_ids); }

# Shortcuts

alias g="git"

alias gs="git status"

alias gsl="git stash list"

alias gc="git checkout"

alias gcp="git cherry-pick"

alias gb="git branch"

alias guc="git reset HEAD~"

alias h="history"

alias ch='history | grep "git commit"'

alias home='cd ~/'

alias gp="git fetch origin --prune"

alias startpost="pg_ctl -D ~/.asdf/installs/postgres/9.6.8/data -l logfile start"

alias stoppost="pg_ctl -D ~/.asdf/installs/postgres/9.6.8/data stop -s -m fast"

alias profile="open ~/.bash_profile"

alias containers="docker ps -a"

alias pgreload="pg_ctl reload"

alias reload="source ~/.bash_profile"

scon() {
  docker stop `docker ps -aq`
}

rmcon() {
  docker rm `docker ps -aq`
}

sig () {
  declare -f "$1"
}

# Git branch in prompt.
parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
export PS1="\u@\h \W\[\033[01;33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Project helpers

alias ..='cd ../'                      # Go back 1 directory level

alias ...='cd ../../'                  # Go back 2 directory levels

alias .3='cd ../../../'                # Go back 3 directory levels

alias .4='cd ../../../../'             # Go back 4 directory levels

alias .5='cd ../../../../../'          # Go back 5 directory levels

alias .6='cd ../../../../../../'       # Go back 6 directory levels

alias c='clear'                        # Clear terminal display

alias path='echo -e ${PATH//:\\\n}'    # Echo all executable Paths

alias edit='open -a TextEdit'   # open using TextEdit

alias l='ls -altr'                      # list all in order

# List all files colorized in long format, including dot files

alias la="ls -lahF ${colorflag}"

# Show/hide hidden files in Finder

alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"

alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

searchAndDestroy() {

  lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9

  echo "Port" $1 "found and killed."

}

searchProfile() {
  cat ~/.bash_profile | grep $1
}

#Delete remote branch and local branch

gd() {
  confirm "Force delete $(curbranch) on both your local machine AND origin?" && git push origin --delete $1 && gb -D $1
}

gsp() {
  git stash push -u -m $1;
  echo "Stash created with name" $1
}

#Delete local branch

gdl() {

  gb -D $1

}

export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/go/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#   ---------------------------
#   FZF config for use with vim
#   ---------------------------
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

