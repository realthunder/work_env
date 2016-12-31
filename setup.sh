#!/bin/sh

files='vimrc screenrc'
for f in $files; do
    src="$PWD/$f"
    dst=~/."$f"
    if [ "$dst" -ef "$f" ]; then
       echo skip $f
       continue
    fi
    if test -f "$dst"; then
        if test -f "$dst.bak"; then
            echo error: $dst backup already exist
            continue
        fi
        echo backup $dst
        mv "$dst" "$dst.bak"
    fi
    echo linking $f
    ln -s "$src" "$dst"
done
