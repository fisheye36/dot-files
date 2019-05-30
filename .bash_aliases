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

alias cpp3="g++ -std=c++03 -Wall -Wextra -pedantic"
alias cpp11="g++ -std=c++11 -Wall -Wextra -pedantic"
alias cpp14="g++ -std=c++14 -Wall -Wextra -pedantic"
alias cpp17="g++ -std=c++17 -Wall -Wextra -pedantic"
alias val="valgrind --leak-check=full --show-leak-kinds=all"

################
# python aliases
################

alias p="python"
alias p3="python3"

function _activate_virtualenv {
    local ENV_SCRIPT=$(find -path "*env/bin/activate" | grep "^\.\/[^/]*env\/bin\/activate")
    if [ -f "${ENV_SCRIPT}" ]; then
        . "${ENV_SCRIPT}"
    else
        echo -e "${_LIGHT_RED}no virtual environment in $(dirs)${_RESET_ALL}"
    fi
}

alias activate=_activate_virtualenv

############
# ls aliases
############

alias ll="ls -lhF"
alias la="ls -AhF"
alias lla="ls -lAhF"

#############
# git aliases
#############

alias gol="git lga"
alias gol10="git lg -10"
alias gol20="git lg -20"
alias gadd="git add"
alias gcom="git commit"
alias gcomv="git commit -v"
alias gst="git status"
alias gmaster="git checkout master"
alias gorigin="git remote show origin"

function _notify_updated {
    [ ${#} -ge 1 ] && echo -e "${_BOLD}${1}${_RESET_ALL} ${_YELLOW}updated${_RESET_ALL}"
}

function _edit_gitignore {
    if [ -f .gitignore ]; then
        vim .gitignore
        _notify_updated .gitignore
    else
        echo -e "${_LIGHT_RED}no .gitignore in $(dirs)${_RESET_ALL}"
    fi
}

alias ignore=_edit_gitignore

#######################
# configuration aliases
#######################

alias edrc="vim ~/.bashrc; . ~/.bashrc; _notify_updated .bashrc"
alias edal="vim ~/.bash_aliases; . ~/.bash_aliases; _notify_updated .bash_aliases"
alias edgit="git config --global -e; _notify_updated .gitconfig"
alias todo="vim ~/.todo; _notify_updated .todo"
alias scr="vim ~/scripts/startup.sh; _notify_updated scripts/startup.sh"
alias rel=". ~/.bashrc"

##################
# packages aliases
##################

alias updt="sudo apt update"
alias upgr="sudo apt upgrade"
alias armv="sudo apt autoremove"
alias updtbl="apt list --upgradeable"
alias deb="sudo deborphan"

############
# cd aliases
############

_PROJECT_DIR=~/projects

alias root="cd /"
alias ..="cd .."
alias proj="cd ${_PROJECT_DIR}"
alias dot="cd ${_PROJECT_DIR}/dot-files"

function _go_to_latest_project {
    local LATEST_PROJ=$(ls -t ${_PROJECT_DIR} | head -1)
    cd "${_PROJECT_DIR}/${LATEST_PROJ}"
}

alias lpj=_go_to_latest_project
alias lproj=lpj
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"

################
# output aliases
################

alias igrep="grep -i"
alias proc="ps aux | head -1; echo; ps aux | grep -i" # <process name regex>

function _find_everywhere {
    if [ ${#} -ge 1 ]; then
        find / -name "*${1}" 2> /dev/null
    else
        echo -e "${_RED}No filename pattern specified${_RESET_ALL}"
    fi
}

alias fnd=_find_everywhere
alias hist="history | tail"
alias gui="nautilus . &"

#######################
# misc commands aliases
#######################

alias png="ping www.onet.pl"
alias aliases="less ~/.bash_aliases"
alias learn="evince ~/Documents/books/Mark\ Lutz\ -\ Learning\ Python.pdf &"
alias v="vim"
alias g="chromium &"
alias y="chromium www.youtube.com &"
