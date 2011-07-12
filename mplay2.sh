#!/bin/bash

cont="y"
#find . -iname \*wmv -o -iname \*avi -o -iname \*mpg -o -iname \*mkv -o -iname \*mpeg -o -iname \*iso -o -iname \*da0 -o -iname \*flv > /tmp/files
find . -type f >/tmp/files
##find -maxdepth 1 -type f -size +10M > /tmp/files
#find . -size +48M > /tmp/files
#arg1="-idx -volume 1"
arg1="-idx -noborder"

dx=700
dy=364
lx=700
ly=364
geometry="$dx"x"$dy"

#geometry="-x 640 -y 512"
#geometry="-x 533 -y 400"
file=none

process=0

for position in 0+0 0+$ly $lx+$ly $lx+0; do
#for i in 0%:0% 0%:50% 0%:100% 50%:0% 50%:50% 50%:100% 100%:0% 100%:50% 100%:100%; do
  while [ "$?" == 0 ]; do
    echo "$file" > /tmp/files_active_$process
    while [[ `cat /tmp/files_active_* |grep "$file"` ]]; do
        file=`cat /tmp/files | sort -uR |head -n1`
        if [ "$file" == "" ]; then
            echo "sorry, no files found :(" &&
            exit
        fi
    done
    echo "$process :: $file" | tee /tmp/files_active_$process

    sleep 0.5
    cat /tmp/files | grep -v "$file" > /tmp/files_$process
    cp /tmp/files_$process /tmp/files
    sleep 0.5

    filetype=`file -bi "$file" | cut -d/ -f1`

    if [ "$filetype" == "image" ]; then
#        feh -B black -x -g $geometry+$position -ZD 10 --cycle-once "$file"
        sleep 0.1
    elif [ "$filetype" == "video" ]; then
        mplayer.expect $arg1 -geometry $geometry+$position "$file" >/dev/null 2>&1
    elif [ "$filetype" == "audio" ]; then
        mplayer "$file" >/dev/null 2>&1 &
    fi
  done &
  let process=$process+1
done;
