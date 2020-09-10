#!/bin/bash

# Script to setup habeshaGhosty-dl on android

read -p "USER :> " user
read -p "Host :> " host_u


# Setup RSA keys (is that what they are called,correct me if I am wrong)
echo "$(tput setaf 3) Creating RSA keys : ~/.ssh/habeshaGhosty-dl $(tput sgr0)"
if [[ -f ~/.ssh/habeshaGhosty-dl ]]
then 
    rm -f ~/.ssh/habeshaGhosty-dl
fi
ssh-keygen -f ~/.ssh/habeshaGhosty-dl -q -N ""

echo "$(tput setaf 3) Copying habeshaGh-android.sh to ~/.habeshaGhosty-dl $(tput sgr0)"
# replace default usear and host by values provide by user
sed  "s/user/$user/g; s/hostu/$host_u/1 " habeshaGh-android.sh > ~/.habeshaGhosty-dl/habeshaGh-android.sh

if [[  ! -f ~/bin/termux-url-opener ]]
then 
    rm ~/bin/termux-url-opener
else 
    touch ~/bin/termux-url-opener
    echo "~/.habeshaGhosty-dl/habeshaGh-android.sh -t \$1" > ~/bin/termux-url-opener
    chmod +x termux-url-opener
fi

# Add them to host machine
echo "$(tput setaf 3) Adding public key to $host_u, (you will be asked for password to copy) $(tput sgr0)"
ssh-copy-id -i ~/.ssh/habeshaGhosty-dl $user@$host_u

# Create directory where queue-list are saved
if [[ ! -d ~/.habeshaGhosty-dl ]]
then 
    mkdir ~/.habeshaGhosty-dl
fi

echo
echo "$(tput setaf 3)Setup Finished!!"
