#!/bin/bash
# My first script

#echo "Hello World!"

## TODO remap to docker 
sentence=$@
cd /home/jiri/Documents/workspace/syntaxNet/models/syntaxnet/work
echo $sentence | bash test.sh

