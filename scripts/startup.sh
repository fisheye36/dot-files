_DOT_FILES_REPO_PATH=~/projects/dot-files
cp -r ~/.bashrc ~/.bash_aliases ~/.gitconfig ~/.vimrc ~/.ideavimrc ~/scripts/ ~/.tmux.conf ~/.tmux "${_DOT_FILES_REPO_PATH}"

cd "${_DOT_FILES_REPO_PATH}"
_MESSAGE_HEADER="repository $(dirs):"
if [[ "$(git status)" == *"nothing to commit"* ]]; then
    echo -e "${_MESSAGE_HEADER} ${_GREEN_BG}${_BLACK}clean${_RESET_ALL}";
else
    echo -e "${_MESSAGE_HEADER} ${_LIGHT_RED_BG}${_BLACK}dirty${_RESET_ALL}";
fi
echo
cd "${OLDPWD}"
