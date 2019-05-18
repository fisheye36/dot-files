########################
# system shutdown/reboot
########################

_GOODBYE_MSG=Goodbye!
_DELAY=1

alias off="echo $_GOODBYE_MSG; sleep $_DELAY; shutdown now"
alias res="echo $_GOODBYE_MSG; sleep $_DELAY; reboot"

#############
# ssh aliases
#############

_T_USER=6warchol
_T_HOST=taurus.fis.agh.edu.pl
_T_PASCAL=pascal.fis.agh.edu.pl

alias taurus="ssh $_T_USER\@$_T_HOST"
alias xtaurus="ssh -X $_T_USER\@$_T_HOST"
alias ptaurus="ssh -D8527 $_T_USER\@_$T_HOST"
alias pascal="ssh $_T_USER\@$_T_PASCAL"
alias ppascal="ssh -D8527 $_T_USER\@$_T_PASCAL"

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

alias p3="python3"

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

function _edit_gitignore {
    if [ -f .gitignore ]; then
        vim .gitignore;
        echo ".gitignore updated";
    else
        echo "no .gitignore in `dirs`"
    fi
}

alias ignore=_edit_gitignore

#######################
# configuration aliases
#######################

alias edrc="vim ~/.bashrc; . ~/.bashrc; echo .bashrc updated"
alias edal="vim ~/.bash_aliases; . ~/.bash_aliases; echo .bash_aliases updated"
alias edgit="git config --global -e; echo .gitconfig updated"
alias todo="vim ~/.todo; echo TODO list updated"
alias scr="vim ~/scripts/startup.sh; echo startup.sh script updated"
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
alias proj="cd $_PROJECT_DIR"
alias dot="cd $_PROJECT_DIR/dot-files"

function _go_to_latest_project {
    local LATEST_PROJ=`ls -t $_PROJECT_DIR | head -1`
    cd $_PROJECT_DIR/$LATEST_PROJ
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
    if [ $# -ge 1 ]; then
        find / -name "*$1" 2> /dev/null
    else
        echo "No filename pattern specified"
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
