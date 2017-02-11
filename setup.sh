#!/bin/sh

if ! which git; then
    apt-get install -y git
fi
if test -z "$(git config --global user.name)"; then
    git config --global user.name 'Zheng, Lei'
    git config --global user.email 'realthunder.dev@gmail.com'
fi

git config --global core.editor "vim"

files='.ctags .vimrc .screenrc make.sh'
for f in $files; do
    src="$PWD/$f"
    dst=~/"$f"
    if [ "$dst" -ef "$f" ]; then
       echo skip $f
       continue
    fi
    if test -h "$dst"; then
	rm $dst
    elif test -f "$dst"; then
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
