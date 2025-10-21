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

# eval "$(starship init bash)" 

export PATH="/home/rhys/perl5/bin${PATH:+:${PATH}}"; export PATH;
export PERL5LIB="/home/rhys/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
export PERL_LOCAL_LIB_ROOT="/home/rhys/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
export PERL_MB_OPT="--install_base \"/home/rhys/perl5\""; export PERL_MB_OPT;
export PERL_MM_OPT="INSTALL_BASE=/home/rhys/perl5"; export PERL_MM_OPT;

alias l='ls'
alias ll='ls -lah'
alias cls='clear'
alias lvim='vim -u ~/.vim/vimrc.light'

function cpsl {
  cp `readlink $1` $2
}

function len {
    echo $1 | wc -c
}

function asteroidsdk {
    source /usr/local/oecore-x86_64/environment-setup-armv7vehf-neon-oe-linux-gnueabi
}

export LD_LIBRARY_PATH=/usr/local/lib

_cdcs_completions()
{
    dirs=`ls /home/rhys/Documents/Cyber_Security/`
    COMPREPLY=($(compgen -W "$dirs" -- "${COMP_WORDS[1]}"))
}

function cdcs {
    cd /home/rhys/Documents/Cyber_Security/$1
}

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

complete -F _cdcs_completions cdcs

alias macroute='sudo iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j MASQUERADE ; sudo ip addr add 192.168.1.114 dev enp0s31f6 ; sudo sysctl net.ipv4.ip_forward=1'

export PATH=$PATH:/opt/flutter/bin/
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
