#!/bin/bash
# My first script

#echo "Hello World!"

## TODO: not use sudo here, add docker to virtual group maybe? 
sentence=$@
#docker run syntaxnet "sh" "-c" "echo $sentence | bash parse_english.sh"
cd /opt/tensorflow/models/syntaxnet
echo $sentence | bash parse_english.sh