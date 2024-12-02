# ~/.profile: executed by the command interpreter for login shells
# this file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask for ssh logins, install and configure the
# libpam-umask package
#umask 022

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# set PATH so it includes user's private scripts if it exists
[ -d "$HOME/scripts" ] && PATH="$HOME/scripts:$PATH"

# include .local_configuration_login.sh if it exists (login shell initial setup)
[ -r "$HOME/.local_configuration_login.sh" ] && . "$HOME/.local_configuration_login.sh"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# SSH agent setup
if test "$PS1"; then
    eval $(ssh-agent)
    find "$HOME/.ssh" -name "*rsa" -exec ssh-add '{}' \;
fi
