#!/bin/bash
# My first script

#echo "Hello World you little man!"

## TODO: not use sudo here, add docker to virtual group maybe? 
sentence=$@
sudo docker run syntaxnet "sh" "-c" "echo $sentence | syntaxnet/demo.sh"
