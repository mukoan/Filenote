# Filenote

## Introduction

Back in the day, AmigaDOS supported a handy function called
"filenote" which added a note, or comment to a file. This feature
was supported by the filesystem plus variants such as PFS, SFS, etc.
The note would be displayed when you used the `list` command but would
not be shown when using the `dir` command.

Notes were handy for a variety of reasons. I remember finding where
I had downloaded a file from because the web browser had placed
the URL in the filenote.

Recently I found myself searching for a similar feature in modern
filesystems, such as ext4.

Filenote could have been written in more modern bash but I wanted it to work
on Mac as well as Linux.

## Usage

 - `./filenote.sh file "note"` adds/replaces a note for `file`
 - `./filenote.sh file` shows the note for `file`
 - `./filenote.sh -d file` deletes the note for `file`
 - `./lsnote.sh` lists files in the current directory and shows any notes that exist

## How it Works

A simple text file with the name `.filename.fn` is created/overwritten. In normal
usage this file is hidden because the name begins with a dot.

## Future Work (?)

Here are some ideas for future work:
 - Support for wildcards
 - Support for `lsnote` to pass additional parameters to `ls`
 - Add `cpnote` and `rmnote` variants to copy and remove notes when copying and removing files
 - Clean up: detect orphaned notes and remove them

