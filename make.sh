#/bin/sh

if test -f ./build.sh; then
    ./build.sh "$@"
elif test -f ./make.sh; then
    ./make.sh "$@"
else
    make "$@"
fi

