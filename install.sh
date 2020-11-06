#!/usr/bin/env bash
#
# This script copies dotfiles from this repository to users's HOME directory. When a file or directory already exists in
# HOME, user is being asked whether to override it. Additionally, environment variables that may vary per system are
# created interactively for the dot files to work properly.
#
# Usage: ./install.sh

# include color definitions to enhance script visuals
[ -r .bash_colors.sh ] && . .bash_colors.sh

# check that working directory is inside the repository
if [ ! -r $(basename "$0") ]; then
    echo -e "${_RED}You must call the script from within the directory containing the repository!${_RESET_ALL}"
    exit 1
fi

FILE_LIST=.dotfile_list
TOTAL_FILES=$(wc -l $FILE_LIST | awk '{ print $1 }')

CONSTANTS_FILE=~/.bash_constants.sh
CONSTANTS_CONTENT=$(cat $CONSTANTS_FILE 2> /dev/null)
CONSTANTS_TEMPLATE=$(cat << EoF
# path to dot-files repository
export _DOT_FILES_REPO_PATH=$(dirs)

# path to directory containing various projects
export _PROJECT_DIR=~/projects
EoF
)

# interactively copies all files or directories listed in .dotfile_list
function copy_dotfiles_from_repo {
    # count copied files / directories
    local COPIED_FILES=0

    for BLOB in $(cat .dotfile_list); do
        local FILE_TYPE='File'
        local CP='cp'
        local SKIP=false

        if [ -d "$BLOB" ]; then
            FILE_TYPE='Directory'
            CP+=' -r'
        fi

        if [ -e ~/"$BLOB" ]; then
            if diff ~/"$BLOB" "$BLOB" > /dev/null; then
                echo -e "$FILE_TYPE ${_YELLOW}~/${BLOB}${_RESET_ALL} exists and is identical, skipping"
                SKIP=true
            else
                # blob already exists in HOME and is different, so ask the user what to do
                echo -en "$FILE_TYPE ${_YELLOW}~/${BLOB}${_RESET_ALL} exists and differs. Overwrite (y/n)? "
                read ANS
                case "$ANS" in
                    y|Y)
                        SKIP=false
                        ;;
                    *)
                        SKIP=true
                esac
            fi
        fi

        if $SKIP; then
            echo -e "Skipping ${_RED}${BLOB}${_RESET_ALL}"
        else
            $CP "$BLOB" ~
            echo -e "Copied ${_GREEN}${BLOB}${_RESET_ALL}"
            COPIED_FILES=$((COPIED_FILES + 1))
        fi
    done

    echo
    echo "Successfully copied $COPIED_FILES out of $TOTAL_FILES files"
}

# edits ~/.bash_constants.sh, allowing the user the option to delete previous file and start anew
function initialize_constants {
    if [ -n "$CONSTANTS_CONTENT" ]; then
        echo -e "${_YELLOW}${CONSTANTS_FILE}${_RESET_ALL} exists. Here are the contents:\n"
        cat "$CONSTANTS_FILE"
        echo
        read -p 'Do you want to edit the file from scratch (y/n)? ' ANS
        case "$ANS" in
            y|Y) echo "$CONSTANTS_TEMPLATE" > "$CONSTANTS_FILE"
        esac
    else
        echo "$CONSTANTS_TEMPLATE" > "$CONSTANTS_FILE"
    fi

    vim "$CONSTANTS_FILE"
    echo "Environment variables set"
}

echo -e "${_BOLD}${_CYAN}[ Attempting to copy all dot files to your HOME directory ]${_RESET_ALL}"
echo
copy_dotfiles_from_repo

echo
echo -e "${_BOLD}${_CYAN}[ Attempting to initialize environment variables ]${_RESET_ALL}"
echo
initialize_constants

echo
echo -e "${_BOLD}${_CYAN}[ Installation finished ]${_RESET_ALL}"
