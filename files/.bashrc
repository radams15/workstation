# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export EDITOR=vim

export LD_LIBRARY_PATH=
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH=~/scripts/distrobox:$PATH:~/go/bin:~/binaryninja:~/idafree-8.3:~/.local/bin
export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(direnv hook bash)"
eval "$(starship init bash)"

alias l='ls'
alias ll='ls -lah'
alias cls='clear'
alias lvim='vim -u ~/.config/vim/vimrc.light'

function cpsl {
  cp `readlink $1` $2
}

function len {
    echo $1 | wc -c
}

