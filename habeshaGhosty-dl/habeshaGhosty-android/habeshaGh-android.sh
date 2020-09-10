#!/data/data/com.termux/files/usr/bin/bash

S_KEY=~/.ssh/habeshaGhosty-dl
USER=user
HOST=host

function save_to_queue (){

	mode=$1
	URL=$2

	if [[ $mode == "v" ]]
	then
	    # Write to sourceVideo
	    echo $URL >> ~/.habeshaGhosty-dl/sourceVideo

	elif  [[ $mode == "c" ]]
	then
	    # Write to sourceChannel
	    echo $URL >>  ~/.habeshaGhosty-dl/sourceChannel

	elif [[ $mode == "p" ]]
	then
	    # Write to sourcePlaylist
	    echo $URL >>  ~/.habeshaGhosty-dl/sourcePlaylist
	fi 
}

function empty_to_queue (){

	mode=$1

	if [[ $mode == "v" ]]
	then
	    # Write to sourceVideo
	    echo /dev/null > ~/.habeshaGhosty-dl/sourceVideo

	elif  [[ $mode == "c" ]]
	then
	    # Write to sourceChannel
	    echo /dev/null > ~/.habeshaGhosty-dl/sourceChannel

	elif [[ $mode == "p" ]]
	then
	    # Write to sourcePlaylist
	    echo /dev/null > ~/.habeshaGhosty-dl/sourcePlaylist
	fi 
}

function add_to_queue_r (){
	# Add to queue on remote machine
	local mode=$1
	local URL=$2

	ssh -i $S_KEY ${USER}@$HOST habeshaGhosty-dl download add --mode $mode -l $URL

	if [ $? -eq 0 ] 
	then 
		echo "Sent sucessfully"
		# Remove the contents
		empty_to_queue $mode
	fi 
	sleep 1
}	

function read_queue (){

	local mode=$1
	local list=""

	if [[ $mode == "v" ]]
	then
	   q_file=~/.habeshaGhosty-dl/sourceVideo

	elif  [[ $mode == "c" ]]
	then
	   q_file=~/.habeshaGhosty-dl/sourceChannel

	elif [[ $mode == "p" ]]
	then
	   q_file=~/.habeshaGhosty-dl/sourcePlaylist
	fi 


	while read line 
	do
		# Concatenate the strings
		list="$list $line"

	done < $q_file

	echo $list
}

function termux_url_opener (){

   	URL=$1

    until [[ $option =~ ^[dal][vcp] ]]
	do

		# ask operation type
		echo "
		$(tput setaf 3)- OPERATION
		$(tput setaf 2)    [d] download    [a] add to queue  [l] add to local queue

		$(tput setaf 3)- MODE
		$(tput setaf 2)    [v] video       [c] channel       [p] playlist
		$(tput sgr0) ++++++++++++++++++++++++++++++++++++++++++++++++++++ "
		read -p ":> " option

		case $option in 
		    dv|dc|dp|Dv|Dc|Dp) 
				mode=${option:1:1}
				
				ssh -i $S_KEY $USER@$HOST "nohup habeshaGhosty-dl download --download --mode $mode -l $URL" 
				add_to_queue_r $mode $URL

				echo "$(tput setaf 2)Download started" ;;
		    
		    av|ac|ap|Av|Ac|Ap) 
				mode=${option:1:1}
				
				add_to_queue_r $mode $URL
				echo "$(tput setaf 2)Added to queue successfully" ;;
		   
		   lv|lc|lp|Lv|Lc|Lp)
				mode=${option:1:1}

				save_to_queue $mode
				
				echo "$(tput setaf 2)Added to local queue successfully" ;;
		  
		    * ) 

echo "$(tput setaf 1)Unrecognized option \"$option\""
echo "Usage: operation + mode 
	eg. [ dv | dc | dp | av | ac | ap | lv | lc | lp]" ;;

		esac

	done 

	sleep 1
}

while getopts :t:m:s opt
do
    case "$opt" in 
	t) 
	    # termux operator
	    termux_url_opener $OPTARG
	    exit ;;
	s) 
		s_flag=true ;;
	m) 
		mode=$OPTARG ;;
	*) 
	    echo "Unrecognized option, $opt" ;;
    esac
done

if [[ "$s_flag" == "true" ]] 
then
	if [[ $mode == "v" || $mode == "p" || $mode == "c" ]]
	then 
		# send 
		# Read queue 
		list=$(read_queue $mode)

		echo "The LIST IS $list"
		add_to_queue_r $mode "$list"

	else 
		echo "Unrecognized mode: $mode"
		exit 
	fi
fi

