#!/bin/bash

# Script to setup habeshaGhosty-dl on android

read -p "USER :> " user
read -p "Host :> " host_u


# Setup RSA keys (is that what they are called,correct me if I am wrong)
echo "Creating RSA keys : ~/.ssh/habeshaGhosty-dl"
if [[ -f ~/.ssh/habeshaGhosty-dl ]]
then 
    rm -f ~/.ssh/habeshaGhosty-dl
fi
ssh-keygen -f ~/.ssh/habeshaGhosty-dl -q -N ""

# replace default usear and host by values provide by user
sed -i "s/user/$user/g; s/host/$host_u/g" habeshaGh-android.sh

echo "Coping habeshaGh-android.sh to ~/.habeshaGhosty-dl"
cp habeshaGh-android.sh ~/.habeshaGhosty-dl/

if [[  ! -f ~/bin/termux-url-opener ]]
then 
    rm ~/bin/termux-url-opener
else 
    touch ~/bin/termux-url-opener
    echo "~/.habeshaGhosty-dl/habeshaGh-android.sh" > ~/bin/termux-url-opener
    chmod +x termux-url-opener
fi

# Add them to host machine
echo "Adding public key to $host_u, (you will be asked for password to copy)"
ssh-copy-id -i ~/.ssh/habeshaGhosty-dl $user@$host_u

# Create directory where queue-list are saved
if [[ ! -d ~/.habeshaGhosty-dl ]]
then 
    mkdir ~/.habeshaGhosty-dl
fi

echo
echo "Setup Finished, echo"
