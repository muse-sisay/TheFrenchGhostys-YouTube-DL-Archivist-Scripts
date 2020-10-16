# TheHabeshaGhosty's YouTube-DL Archivist Scripts
Python Implementaion of [TheFrenchGhosty’s YouTube-DL Archivist Scripts](https://github.com/TheFrenchGhosty/TheFrenchGhostys-YouTube-DL-Archivist-Scripts).

**simple and customizable**

Required modules **click** and **youtube-dl**.


**NOTE :** Modify `config.json` before using.

```json
{
	...
	"output_path": "/path/download-folder",				
	"default_quality": "1080p",
	"archive_log": {
		"channel": "/path/log-channel",
		"playlist": "/path/log-playlist",
		"video": "/path/log-video"
	},
	"queue_file": {
		"channel": "/path/queue/list-channel",
		"playlist": "/path/queue/list-playlist",
		"video": "/path/queue/list-video"
	}
}
```

## Installation :
Add to `~/.bashrc`, this is required for termux-open-url to work
```bash
alias habeshaGhosty-dl="python3 /path/to/script/habeshaGhosty-dl/main.py"
```
if `habeshaGhosty-dl` is to long, add another alias.

## Usage :
### To download videos


``` bash
$ python3 main.py download --mode video
```
or specify link using `-l` option.

```bash
$ python3 main.py download --mode [channel|playlsit|video] -l [LINK]
```

### To add link to queue list

```bash
$ python3 main.py add --mode video -l [LINK]
```
or `-f` option to specify file to add from

```bash
$ python3 main.py add --mode channel -f [FILE]
```


If you have added to `~/.bashrc`, you can call the command as follows

```bash 
$ habeshaGhosty-dl download --mode [channel|playlsit|video] -l [LINK]
$ habeshaGhosty-dl add --mode channel -f [FILE]
```

## Customization :
### Custom quality
To use a custom quality, add your quality to config.json under `config -> quality` and change `default_quality`.
eg.
```JSON
  {
	"config": {
		"quality": {
			    ...
			    "custom_quality" : "value"
			    ...
	"default_quality" : "custom_quality",
	...
```

### You don't like how the script saves the file(filename)?
Modify `config -> output_format`. The default output for

- **videos** is
	
```
Uploader [CHANNELID]/Title - Uploader - 20111306/Title - Uploader - 20111306 [VIDEOID].ext
``` 

```
--output "%(uploader)s - [%(channel_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s"
```	

- **channels** is 

```
Uploader [CHANNELID]/Title - Uploader - 20111306/Title - Uploader - 20111306 [VIDEOID].ext
```

```
--output "%(uploader)s - [%(channel_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s" 
```
	
- **playlists** is

```
Uploader [CHANNELID]/PlaylistName - Uploader [PLAYLISTID]/Title - Uploader 20111306/Title - Uploader - 20111306 [VIDEOID].ext
```
	
```
--output "%(uploader)s - [%(channel_id)s]/%(playlist)s - %(uploader)s - [%(playlist_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s"
```


## Setup on Android
You will need termux, a terminal emulato r for android. [[Google Play](https://play.google.com/store/apps/details?id=com.termux), [F-Droid](https://f-droid.org/repository/browse/?fdid=com.termux)]

Copy `/habeshaGhosty-dl/habeshaGhosty-android` and run `setup.sh`. It will prompt you for  username and host address.  
<br>Then share LINK from `YoutTube` TO `TERMUX`.


# THINGS TO DO
- [ ] Remove links after it finishes from queue
- [ ] Package it (pip)
- [ ] Write metadata that can be used by PLEX
- [ ] Date parameter (when archiving Channels)
- How does greg store podcast info, sync data. Where does it store it?



---
***I apologize for the bad commit messages and grammar.***

