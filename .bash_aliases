unalias -a

########################
# system shutdown/reboot
########################

_GOODBYE_MSG="${_BOLD}${_YELLOW}Goodbye!${_RESET_ALL}"
_DELAY=1

alias off="echo -e \"${_GOODBYE_MSG}\"; sleep ${_DELAY}; shutdown now"
alias res="echo -e \"${_GOODBYE_MSG}\"; sleep ${_DELAY}; reboot"

#############
# ssh aliases
#############

_USER=6warchol
_TAURUS=taurus.fis.agh.edu.pl
_PASCAL=pascal.fis.agh.edu.pl

alias taurus="ssh ${_USER}\@${_TAURUS}"
alias xtaurus="ssh -X ${_USER}\@${_TAURUS}"
alias ptaurus="ssh -D8527 ${_USER}\@_${TAURUS}"
alias pascal="ssh ${_USER}\@${_PASCAL}"
alias ppascal="ssh -D8527 ${_USER}\@${_PASCAL}"

#############
# cpp aliases
#############

alias cpp3='g++ -std=c++03 -Wall -Wextra -pedantic'
alias cpp11='g++ -std=c++11 -Wall -Wextra -pedantic'
alias cpp14='g++ -std=c++14 -Wall -Wextra -pedantic'
alias cpp17='g++ -std=c++17 -Wall -Wextra -pedantic'
alias val='valgrind --leak-check=full --show-leak-kinds=all'

################
# python aliases
################

alias p='python'
alias p3='python3'

function activate_venv {
    local ENV_SCRIPT=$(find . -name 'activate' | egrep '^\./[^/]*env/(?:bin|Scripts)/activate')
    if [ -r "$ENV_SCRIPT" ]; then
        . "$ENV_SCRIPT"
    else
        echo -e "${_LIGHT_RED}no virtual environment in $(dirs)${_RESET_ALL}"
    fi
}

############
# ls aliases
############

alias ll='ls -lhF'
alias la='ls -AhF'
alias lla='ls -lAhF'

#############
# git aliases
#############

alias gol='git lga'
alias gol10='git lg -10'
alias gol20='git lg -20'
alias gadd='git add'
alias gcom='git commit'
alias gcomv='git commit -v'
alias gst='git status'
alias gmaster='git checkout master'
alias gorigin='git remote show origin'

function ignore {
    if [ -r .gitignore ]; then
        edit_config_file .gitignore
    else
        echo -e "${_LIGHT_RED}no .gitignore in $(dirs)${_RESET_ALL}"
    fi
}

##############
# tmux aliases
##############

alias newdev="tmux new -s dev \; source-file ~/.tmux/dev"
alias newsplit="tmux new -s split \; source-file ~/.tmux/split"
alias dev="tmux attach -t dev"
alias split="tmux attach -t split"

#######################
# configuration aliases
#######################

alias edlist='edit_config_file ~/.dotfile_list -n'
alias edrc='edit_config_file ~/.bashrc'
alias edcol='edit_config_file ~/.bash_colors.sh'
alias edcon='edit_config_file ~/.bash_constants.sh'
alias edfun='edit_config_file ~/.bash_functions.sh'
alias edal='edit_config_file  ~/.bash_aliases'
alias edgit='edit_config_file ~/.gitconfig -n'
alias todo='edit_config_file ~/.todo -n'

alias rel='. ~/.bashrc'

#################
# package aliases
#################

alias updt='sudo apt update'
alias upgr='sudo apt upgrade'
alias armv='sudo apt autoremove'
alias updtbl='apt list --upgradeable'
alias deb='sudo deborphan'

############
# cd aliases
############

alias root='cd /'
alias ..='cd ..'
alias proj="cd $_PROJECT_DIR"
alias dot="cd $_DOT_FILES_REPO_PATH"

function go_to_latest_project {
    local LATEST_PROJ=$(ls -t "$_PROJECT_DIR" | head -1)
    cd "${_PROJECT_DIR}/${LATEST_PROJ}"
}

alias lpj=go_to_latest_project
alias lproj=go_to_latest_project
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'

################
# output aliases
################

alias igrep='grep -i'

function find_process_by_name {
    if [ $# -ge 1 ]; then
        local PROCESSES=$(ps aux)
        echo "$PROCESSES" | head -1
        echo "$PROCESSES" | grep -i "$1"
    else
        echo -e "${_RED}No process name specified${_RESET_ALL}"
    fi
}

alias proc=find_process_by_name

function find_everywhere {
    if [ $# -ge 1 ]; then
        find / -name "*$1" 2> /dev/null
    else
        echo -e "${_RED}No filename pattern specified${_RESET_ALL}"
    fi
}

alias fnd=find_everywhere
alias hist="history | tail"
alias gui="nautilus . &"

######################
# misc command aliases
######################

alias png='ping www.onet.pl'
alias aliases='less ~/.bash_aliases'
alias learn='evince ~/Documents/books/Mark Lutz - Learning Python.pdf &'
alias v='vim'
alias g='chromium &'
alias y='chromium www.youtube.com &'
