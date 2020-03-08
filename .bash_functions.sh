function greet_user {
    echo -e "${_BOLD}${_YELLOW}Hello, have a nice and productive day!${_RESET_ALL}"
    todo
}

function todo {
    echo
    echo -e "${_UNDERLINE}${_LIGHT_BLUE}TODO${_RESET_ALL}:"
    [ -r ~/.todo ] && cat ~/.todo
    echo
}

function sync_to_repo {
    for BLOB in $(cat ~/.dotfile_list); do
        BLOB=~/"$BLOB"
        local CP='cp'
        [ -d "$BLOB" ] && CP+=' -r'
        $CP "$BLOB" "$_DOT_FILES_REPO_PATH"
    done
}

function echo_repo_status {
    cd "$_DOT_FILES_REPO_PATH"
    local MESSAGE_HEADER="repository $(dirs):"

    if [ -z "$(git status -s)" ]; then
        echo -e "$MESSAGE_HEADER ${_GREEN_BG}${_BLACK}clean${_RESET_ALL}\n";
    else
        echo -e "$MESSAGE_HEADER ${_LIGHT_RED_BG}${_BLACK}dirty${_RESET_ALL}\n";
    fi

    cd "$OLDPWD"
}

function notify_config_updated {
    [ $# -ge 1 ] && echo -e "${_BOLD}${1}${_RESET_ALL} ${_YELLOW}updated${_RESET_ALL}"
}

function edit_config_file {
    if [[ $# -ge 1 && -r "$1" ]]; then
        vim "$1"
        [ "$2" != "-n" ] && . "$1"
        notify_config_updated "$1"
        sync_to_repo
    fi
}
