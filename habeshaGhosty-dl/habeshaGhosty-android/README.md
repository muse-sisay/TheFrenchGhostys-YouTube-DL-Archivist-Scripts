##	 termux-url-opener
 
 - First ask link type
 - Ask if it should be downloaded right now 
 <br>or simply added to queue.

 - Establish ssh connection 
 <br/>use identity file.
 
 **On the machine with habeshaghosty installed**
- Add to queue 
- get file path from ENV ( the script should export file path fromconfig.json )
<br>  [OR]
<br>call habeshaGhosty-dl add subcommand
- Start a TMUX session
- run the program 
- Exit TMUX
<br>: another option is to start the program in backgroun with "nohup"
<br>this would be the best solution, because it doesnot require additional requirments
   
 
## setup script

 - Generate RSA keys for ssh 
<br>place them in   ~/.ssh/habeshaGhosty-dl.pub and
<br>					~/.ssh/habeshaGhosty-dl
<br>add them to host machine, user is required to authenticate

- download `termux-url-opener`
<br>if "habeshaGhosty-android" is downloaded, no need to download 
<br>just move `termux-url-opener` to ~/bin (best option)

