# termux-url-opener
 
 - First ask link type
 - Ask if it should be downloaded right now 
   or simply added to queue.

 - Establish ssh connection 
   - use identity file
 
 = On the machine with habeshaghosty installed 
   * Add to queue 
	- get file path from ENV ( script to export file path from 
	  config.json)
	  [OR]
   * Start a TMUX session
	- run the program 
	- Exit TMUX
   : another option is to start the program in backgroun with "nohup"
   this would be the best solution, because it doesnot require additional requirments
   
 
# setup script

 - Generate RSA keys for ssh 
    place them in   ~/.ssh/habeshaGhosty-dl.pub and
		    ~/.ssh/habeshaGhosty-dl
    add them to host machine, user is required to authenticate
 - download `termux-url-opener`
    if "habeshaGhosty-android" is downloaded, no need to download 
    just move `termux-url-opener` to ~/bin (best option)

