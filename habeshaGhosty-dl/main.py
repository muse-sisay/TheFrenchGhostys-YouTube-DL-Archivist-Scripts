from __future__ import unicode_literals
import youtube_dl
import click
import json
import functools
from pathlib import Path
import OptionEatAll


def common_options(f):
    options = [
        click.option(
            '--mode', '-m', type=click.Choice(['video', 'channel', 'playlist'], case_sensitive=False, )),
        click.option('--link', '-l', type=str, help="YouTube link/s",
                     cls=OptionEatAll.OptionEatAll),
    ]
    return functools.reduce(lambda x, opt: opt(x), options, f)


@click.group()
@common_options
def cli(**kwargs):
    '''
    TheHabeshaGhosty-s-YouTube-DL-Archivist-Scripts

    \b
    Python implementation of TheFrenchGhostys-YouTube-DL-Archivist-Scripts, 
    The ultimate collection of scripts for YouTube-DL.
    '''
    pass


@cli.command(short_help='Download vidoes.')
@common_options
def download(mode, link):
    '''
    Download videos

    Downloads videos from text file specified in config.json depending on the mode passed.
    '''

    if not mode:
        print("Exiting")
        exit()

    script_path = Path(__file__).absolute()
    config_path = script_path.parent / "config.json"

    with open(config_path, 'r') as f:
        config = json.load(f)

    quality = config['default_quality']
    f_ormat = config['config']['quality'][quality]
    extra = config['config']['extra']

    ydl_opts = {"format": f_ormat}
    ydl_opts.update(extra)

    if mode == 'video':
        # If the video is part of a playlist download only the video
        ydl_opts['noplaylist'] = True

    # Template for output names.
    outtmpl = config['config']['output_format'][mode]
    ydl_opts['outtmpl'] = f"{config['output_path']}/" + outtmpl

    # File name of a file where all downloads are recorded.
    ydl_opts['download_archive'] = f"{config['output_path']}/{config['archive_log'][mode]}"

    if not link:
        with open(config['queue_file'][mode], 'r') as f:
            link = [x.strip() for x in f.readlines()]

    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.download(link)


@cli.command(short_help='Add links')
@common_options
@click.option('-f', 'file', type=click.Path(), help="file to read links from")
def add(mode, link, file):
    '''
    Add links

    Add links specfied in config.json depending on the mode "-m" specfied from STDIN or file -f.
    '''

    if not mode or (not link and not file):
        print("Exiting")
        exit()

    script_path = Path(__file__).absolute()
    config_path = script_path.parent / "config.json"
    with open(config_path, 'r') as f:
        config = json.load(f)

    if file:
        with open(file, 'r') as f:
            link = [l for l in f.readlines()]
    else:
        link = [l.split()[0] for l in link]

    queue_path = script_path.parent / config['queue_file'][mode]

    with open(queue_path, 'a') as fi:
        for l in link :
            fi.write(f'{l}\n')


cli()
