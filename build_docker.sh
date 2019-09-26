#!/usr/bin/env bash

say() {
 echo "$@" | sed \
         -e "s/\(\(@\(red\|green\|yellow\|blue\|magenta\|cyan\|white\|reset\|b\|u\)\)\+\)[[]\{2\}\(.*\)[]]\{2\}/\1\4@reset/g" \
         -e "s/@red/$(tput setaf 1)/g" \
         -e "s/@green/$(tput setaf 2)/g" \
         -e "s/@yellow/$(tput setaf 3)/g" \
         -e "s/@blue/$(tput setaf 4)/g" \
         -e "s/@magenta/$(tput setaf 5)/g" \
         -e "s/@cyan/$(tput setaf 6)/g" \
         -e "s/@white/$(tput setaf 7)/g" \
         -e "s/@reset/$(tput sgr0)/g" \
         -e "s/@b/$(tput bold)/g" \
         -e "s/@u/$(tput sgr 0 1)/g"
}

if [ -z "$KEY_PATH" ]
  then
    say @red[["Please set the env. variable KEY_PATH before running this script"]]
    say @red[["KEY_PATH should be set to the path to the private key " \
              "you want use for repo read access"]]
    exit 1;
fi

# read the SSHkey from the host
key_content=$(cat $KEY_PATH)

# build docker file:
docker build --rm -t testimage \
    --build-arg SSH_PRIVATE_KEY="${key_content}" \
    -f test.Dockerfile .
