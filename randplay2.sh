#!/bin/sh
cont="y"
c="y"
avidemux="/cygdrive/c/Program Files (x86)\Avidemux 2.5\avidemux2_qt4.exe"
#find . -size +48M > /tmp/files

find . -maxdepth 1 -iname \*wmv -o -iname \*avi -o -iname \*mpg -o -iname \*mkv -o -iname \*mpeg -o -iname \*iso -o -iname \*da0 -o -iname \*flv > /tmp/files
##find -maxdepth 1 -type f -size +10M > /tmp/files

#find -type f -size +10M > /tmp/files

#ls -1Sr |tail -n 50 > /tmp/files
arg1="-fs -idx"
#arg2="-volume 1 -brightness -80 -contrast 15 -autoq 100 -autosync 100 -af volume=1:6"
#arg2="-vo gl2"
arg2="-volume 1"
file="filename"

while [ "$cont" == "y" ]; do
  mv /tmp/files /tmp/files_tmp
  if [ "$c" = "d" ]; then
    rm -rf "$file"
  fi

  if [ "$c" = "c" ]; then
    mv "$file" c/
  fi

  if [ "$c" = "s" ]; then
    mv "$file" s/
  fi

  if [ "$c" = "a" ]; then
    "$avidemux" "$file"
    echo "delete?:"
    dlt="c"
    read -t 10 dlt
    if [ "$dlt" = "y" ]; then
        rm -rf "$file"
    fi
  fi

  if [ "$c" != "r" ]; then
    cat /tmp/files_tmp | grep -v "$file" >> /tmp/files
    file=`cat /tmp/files | randfile.pl`
  fi


  mplayer $arg1 $arg2 "$file"

  echo $file
  echo "d/r/a/q:"
  c="n"
  read -t 10 c

  if [ "$c" = "q" ]; then
    cont="n"
  fi

done;
rm -rf /tmp/files /tmp/files_tmp
