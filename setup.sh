#!/bin/sh

set -e

name=suguni

printf "\033[0;32mSetup public repository...\033[0m\n"

git git@github.com:suguni/${name}.github.io.git ..

ln -s ../${name}.github.io public
