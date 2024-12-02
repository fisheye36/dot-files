########################
# system shutdown/reboot
########################

_GOODBYE_MSG="${_BOLD}${_YELLOW}Goodbye!${_RESET_ALL}"
_DELAY=1

alias off="echo -e \"${_GOODBYE_MSG}\"; sleep ${_DELAY}; shutdown now"
alias res="echo -e \"${_GOODBYE_MSG}\"; sleep ${_DELAY}; reboot"

function restart_to_windows {
    local PREFIX=
    [ $(id -u) -ne 0 ] && PREFIX='sudo '
    ${PREFIX}grub-reboot 'Windows 11'
    res
}

alias win=restart_to_windows

################
# python aliases
################

alias p='python'
alias p3='python3'
alias pv='pyenv version'
alias pvs='pyenv versions'
alias psh='poetry shell'

function source_venv {
    if [ -n "$1" ]; then
        echo -e "${_GREEN}Activating${_RESET_ALL} '$1'"
        . "$1" 2> /dev/null || echo -e "${_RED}Error when trying to activate${_RESET_ALL} '$1'"
    else
        echo -e "${_RED}No activation script specified${_RESET_ALL}"
    fi
}

function venv {
    local VENV_SCRIPT_PATHS_FILE="$(mktemp)"
    find -path '*/activate' -exec file {} \; > "$VENV_SCRIPT_PATHS_FILE"
    local NUM_ENTRIES=$(wc -l "$VENV_SCRIPT_PATHS_FILE" | cut -f 1 -d ' ')

    if [ $NUM_ENTRIES -eq 0 ]; then
        echo -e "${_LIGHT_RED}No virtual environment in${_RESET_ALL} '$(dirs)'"
    elif [ $NUM_ENTRIES -eq 1 ]; then
        local VENV_NAME=$(cat "$VENV_SCRIPT_PATHS_FILE" | cut -f 1 -d ':')
        source_venv "$VENV_NAME"
    else
        echo -e "Available virtual environments in ${_YELLOW}$(dirs)${_RESET_ALL}:"
        nl "$VENV_SCRIPT_PATHS_FILE"
        read -p "Which one to source [1-${NUM_ENTRIES}]? " VENV_INDEX
        local VENV_NAME=$(nl "$VENV_SCRIPT_PATHS_FILE" | grep "\s${VENV_INDEX}\s" | cut -f 2 | cut -f 1 -d ':')
        [ -r "$VENV_NAME" ] && source_venv "$VENV_NAME" || echo -e "${_RED}Not an activation script${_RESET_ALL}"
    fi

    [ -w "$VENV_SCRIPT_PATHS_FILE" ] && rm "$VENV_SCRIPT_PATHS_FILE"
}

############
# ls aliases
############

alias ll='ls -lhF'
alias la='ls -AhF'
alias lla='ls -lAhF'

function list_dirs {
    lla | grep ^d | nl
}

function cdn {
    if [ -z "$1" ]; then
        echo -e "Contents of ${_YELLOW}$(dirs)${_RESET_ALL}:"
        list_dirs
        return
    fi

    local ENTRY_TO_CD_INTO=$(list_dirs | grep "^\s*$1" | awk '{ print $NF }')
    [ -d "$ENTRY_TO_CD_INTO" ] && cd "$ENTRY_TO_CD_INTO" || echo -e "${_RED}Not a directory${_RESET_ALL}"
}

################
# docker aliases
################

alias d='docker'; complete -F _docker d
alias dc='docker compose'; complete -F _docker dc
alias doco='docker-compose'; complete -F _docker doco
alias dps='docker ps'
alias dup='docker compose up'
alias ddown='docker compose down'

function enter {
    local CONTAINER_NAME="$1"
    local CMD="${2:-bash}"

    if [ -z "${CONTAINER_NAME}" ]; then
        echo "Container name missing" >&2
        return
    else
        docker exec -it "${CONTAINER_NAME}" "${CMD}"
    fi
}

function compose-enter {
    local SERVICE_NAME="$1"
    local CMD="${2:-bash}"

    if [ -z "${SERVICE_NAME}" ]; then
        echo "Service name missing" >&2
        return
    else
        docker compose exec "${SERVICE_NAME}" "${CMD}"
    fi
}

################
# terraform aliases
################

alias tf='terraform'

#############
# git aliases
#############

alias gs='git status'
alias gol='git lga'
alias gol10='git lg -10'
alias gol20='git lg -20'
alias gadd='git add'
alias gcom='git commit'
alias gcomv='git commit -v'
alias gamend='git commit -v --amend'
alias gst='git status'
alias gmaster='git checkout master'
alias gorigin='git remote show origin'
alias gprune='git remote prune origin'

function ignore {
    if [ -r .gitignore ]; then
        edit_config_file .gitignore -n
    else
        echo -e "${_LIGHT_RED}no .gitignore in $(dirs)${_RESET_ALL}"
    fi
}

function gtag {
    local version="$1"
    if [ -z "$version" ]; then
        echo -e "${_LIGHT_RED}version missing${_RESET_ALL}" >&2
        return 1
    fi

    git tag -a "$version" -m "$version"
}

##############
# tmux aliases
##############

alias newdev="tmux new -s dev \; source-file ~/.tmux/dev"
alias newquad="tmux new -s quad \; source-file ~/.tmux/quad"
alias newh="tmux new -s hsplit \; source-file ~/.tmux/hsplit"
alias newv="tmux new -s vsplit \; source-file ~/.tmux/vsplit"
alias dev="tmux attach -t dev"
alias quad="tmux attach -t quad"

#######################
# configuration aliases
#######################

alias edlist='edit_config_file ~/.dotfile_list -n'
alias edrc='edit_config_file ~/.bashrc'
alias edcol='edit_config_file ~/.bash_colors.sh'
alias edcon='edit_config_file ~/.bash_constants.sh'
alias edfun='edit_config_file ~/.bash_functions.sh'
alias edal='edit_config_file  ~/.bash_aliases'
alias edloc='edit_config_file  ~/.local_configuration.sh'
alias edlocl='edit_config_file  ~/.local_configuration_login.sh'
alias edgit='edit_config_file ~/.gitconfig -n'
alias edtodo='edit_config_file ~/.todo -n && todo'

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
alias b='cd -'
alias proj="cd $_PROJECT_DIR"
alias dot="cd $_DOT_FILES_REPO_PATH"
alias md=". ${HOME}/scripts/mkdir-and-cd.sh"

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
alias usage='grep -r -C 4'

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
        find / -name "*$1*" 2> /dev/null
    else
        echo -e "${_RED}No filename pattern specified${_RESET_ALL}"
    fi
}

alias fnd=find_everywhere
alias hist="history | tail"
alias gui="nautilus . &"
alias ccat="highlight --out-format=xterm256 --line-numbers"

######################
# misc command aliases
######################

alias png='ping www.onet.pl'
alias aliases='less ~/.bash_aliases'
alias l='less'
alias v='vim'
alias o='xdg-open'
alias g='chromium &'
alias y='chromium www.youtube.com &'
alias wl='wc -l'
alias level="echo Current shell level: ${SHLVL}"
alias t='mkdir test 2> /dev/null; cd test'
alias et='cd ..; rm -rfI test'
alias tp='type -a'
