#!/bin/bash
# My first script

#echo "Hello World!"

## TODO remap to docker 
sentence=$@
#docker run syntaxnet "sh" "-c" "echo $sentence | bash parse_czech.sh"

echo $sentence | bash parse_czech.sh
