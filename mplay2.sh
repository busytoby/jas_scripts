#!/bin/sh

cont="y"
find . -iname \*wmv -o -iname \*avi -o -iname \*mpg -o -iname \*mkv -o -iname \*mpeg -o -iname \*iso -o -iname \*da0 -o -iname \*flv > /tmp/files
##find -maxdepth 1 -type f -size +10M > /tmp/files
#find . -size +48M > /tmp/files
ls -1Sr >> /tmp/files
arg1="-idx -volume 1"
arg2="-x 640 -y 512"
#arg2="-x 533 -y 400"
file="filename"

for i in 0%:0% 0%:100% 100%:100% 100%:0%; do 
#for i in 0%:0% 0%:50% 0%:100% 50%:0% 50%:50% 50%:100% 100%:0% 100%:50% 100%:100%; do 
  while [ "$cont" == "y" ]; do
#    cp /tmp/files /tmp/files_tmp
    file=`cat /tmp/files | randfile.pl`
#    cat /tmp/files_tmp | grep -v "$file" > /tmp/files

    echo $file
    mplayer $arg1 $arg2 -geometry $i "$file" >/dev/null 
2>&1

  done &
  echo $i
  sleep 3
done;
