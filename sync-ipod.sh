#!/bin/bash

mount -o rw,uid=1000,gid=1000,iocharset=utf8,shortname=mixed /dev/sdc2 /mnt/ipod
rsync --modify-window=1 -rtv --delete /home/jas/mp3/old/ipod/ /mnt/ipod/Music
umount /mnt/ipod
