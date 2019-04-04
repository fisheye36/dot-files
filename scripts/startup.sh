_DOT_FILES_REPO_PATH=~/projects/dot-files
cp -r ~/.bashrc ~/.bash_aliases ~/.gitconfig ~/.vimrc ~/.ideavimrc ~/scripts/ ~/.tmux.conf ~/.tmux $_DOT_FILES_REPO_PATH

cd $_DOT_FILES_REPO_PATH
_MESSAGE_HEADER="repository `dirs`:"
if [[ "`git status`" == *"added to commit"* ]]; then
    echo "$_MESSAGE_HEADER dirty";
else
    echo "$_MESSAGE_HEADER clean";
fi
echo
cd $OLDPWD
