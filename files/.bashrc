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
export PATH=$PATH:~/binaryninja:~/idafree-8.3

source /home/rhys/.local/bin/watcom/owsetenv.sh

export PATH="/home/rhys/perl5/bin${PATH:+:${PATH}}"; export PATH;
export PERL5LIB="/home/rhys/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
export PERL_LOCAL_LIB_ROOT="/home/rhys/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
export PERL_MB_OPT="--install_base \"/home/rhys/perl5\""; export PERL_MB_OPT;
export PERL_MM_OPT="INSTALL_BASE=/home/rhys/perl5"; export PERL_MM_OPT;

alias l='ls'
alias ll='ls -lah'
alias cls='clear'

function len {
    echo $1 | wc -c
}
