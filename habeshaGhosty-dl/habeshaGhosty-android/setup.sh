#!/bin/bash

# Script to setup habeshaGhosty-dl on android

read -p "USER :> " user
read -p "Host :> " host_u


# Setup RSA keys (is that what they are called,correct me if I am wrong)
echo "Creating RSA keys : ~/.ssh/habeshaGhosty-dl"
ssh-keygen -f ~/.ssh/habeshaGhosty-dl -q -N ""

# replace default usear and host by values provide by user
sed -i "s/user/$user/g; s/host/$host_u/g" termux-url-pener

echo "Coping termux-url-opener to ~/bin"
cp termux-url-opener ~/bin

# Add them to host machine
echo "Adding public key to $host_u, (you will be asked for password to copy)"
ssh-copy-id -i ~/.ssh/habeshaGhosty-dl $user@$host_u

echo
echo "Setup Finished, echo"
