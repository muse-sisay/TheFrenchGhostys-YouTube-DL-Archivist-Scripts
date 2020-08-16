from __future__ import unicode_literals
import youtube_dl
import click
import json
import functools


def common_options(f):
    options = [
        click.option(
            '-download-mode', '-m', type=click.Choice(['video', 'channel', 'playlist'], case_sensitive=False, )),
        click.option('--link', '-l', type=str),
    ]
    return functools.reduce(lambda x, opt: opt(x), options, f)


@click.group()
@common_options
def cli(**kwargs):
    '''
    SHOW HELP MESSAGE
    END // WRITE SOMETHING
    '''
    pass


@cli.command()
@common_options
def download(download_mode, link):

    if not download_mode:
        print("Exiting")
        exit()

    with open('config.json', 'r') as f:
        config = json.load(f)

    quality = config['default_quality']
    f_ormat = config['config']['quality'][quality]
    extra = config['config']['extra']

    ydl_opts = {"format": f_ormat}
    ydl_opts.update(extra)

    if download_mode == 'unique':
        # If the video is part of a playlist download only the video
        ydl_opts['noplaylist'] = True

    # Template for output names.
    outtmpl = config['config']['output_format'][download_mode]
    ydl_opts['outtmpl'] = f"config['output_path']/" + outtmpl

    # File name of a file where all downloads are recorded.
    ydl_opts['download_archive'] = config['archive_log'][download_mode]

    if not link:
        with open(config['links'][download_mode], 'r') as f:
            link = [x.strip() for x in f.readlines()]
    else:
        link = [].append(link)

    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.download(link)


@cli.command()
@common_options
@click.option('-f', type=click.Path())
def add(download_mode, link, f):

    if not download_mode or (not link and not f):
        print("Exiting")
        exit()

    with open('config.json', 'r') as f:
        config = json.load(f)

    with open(config['links'][download_mode], 'a') as fi:
        [fi.write(l) for l in link.split()]


cli()
