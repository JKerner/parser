#!/bin/bash
# My first script

#echo "Hello World!"

## TODO remap to docker 
sentence=$@
#docker run syntaxnet "sh" "-c" "echo $sentence | bash parse_czech.sh"
cd /opt/tensorflow/models/syntaxnet
echo $sentence | bash parse_czech.sh
