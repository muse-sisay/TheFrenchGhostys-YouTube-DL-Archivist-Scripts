# TheHabeshaGhosty's YouTube-DL Archivist Scripts

Python Implementaion of [TheFrenchGhosty’s YouTube-DL Archivist Scripts](https://github.com/TheFrenchGhosty/TheFrenchGhostys-YouTube-DL-Archivist-Scripts).

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
	"links": {
		"channel": "/path/queue/list-channel",
		"playlist": "/path/queue/list-playlist",
		"video": "/path/queue/list-video"
	}
}
```


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


# Details :

(Channels Scripts) `--output "%(uploader)s - [%(channel_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s"` : Tell youtube-dl to download the videos in folders and subfolders, using the naming scheme `Uploader [CHANNELID]/Title - Uploader - 20191231/Title - Uploader - 20191231 [VIDEOID].ext`.

(Playlists Scripts) `--output "%(uploader)s - [%(channel_id)s]/%(playlist)s - %(uploader)s - [%(playlist_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s"` : Tell youtube-dl to download the videos in folders and subfolders, using the naming scheme `Uploader [CHANNELID]/PlaylistName - Uploader [PLAYLISTID]/Title - Uploader 20191231 /Title - Uploader - 20191231 [VIDEOID].ext`.

(Video Scripts) `--output "%(uploader)s - [%(channel_id)s]/%(title)s - %(uploader)s - %(upload_date)s/%(title)s - %(uploader)s - %(upload_date)s [%(id)s].%(ext)s"` : Tell youtube-dl to download the videos in folders and subfolders, using the naming scheme `Uploader [CHANNELID]/Title - Uploader - 20191231/Title - Uploader - 20191231 [VIDEOID].ext`.



