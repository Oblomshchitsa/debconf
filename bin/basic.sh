#!/bin/bash

SPATH=`dirname "$(readlink -f "$0")"`

echo "Basic system install launched."
echo -n "Continue ? (y/N) "
read CHOICE

if [[ $CHOICE == "y" ]]; then

    apt-get update
    apt-get autoremove --purge -y exim4-.\* portmap rpcbind
    apt-get install -y git subversion curl irb rsync emacs emacs-goodies-el php-elisp nmap fail2ban httperf tree unzip build-essential python task ruby libruby ruby-dev rubygems libmysql-ruby libactiverecord-ruby

    echo
    echo "Install bash and emacs basic config ? (y/N) "
    read -n SUBCHOICE

    if [[ $SUBCHOICE == "y" ]]; then

        echo "And who is the main user ? "
        read -n MAINUSER

        if ! [ -z $MAINUSER ]; then
            for file in emacs emacs.d bashrc; do
                cp -R $SPATH/../src/dot/$file ~/.$file;
                cp -R $SPATH/../src/dot/$file /home/$MAINUSER/.$file;
            done
            chown -R $MAINUSER:$MAINUSER /home/$MAINUSER/.*
            source ~/.bashrc
        else
            echo "Failed! No user has been given. Retry !";
        fi
    fi

fi
