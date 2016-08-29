#!/bin/bash
# My first script

#echo "Hello World!"

## TODO remap to docker 
sentence=$@
echo sentence > sentences.txt
#docker run syntaxnet "sh" "-c" "echo $sentence | bash parse_czech.sh"
MODEL_DIRECTORY=/opt/tensorflow/models/syntaxnet/google_czech_model/Czech
cat sentences.txt | syntaxnet/models/parsey_universal/parse.sh \
    $MODEL_DIRECTORY > output.conll

cat output.conll
rm output.conll
rm sentences.txt


cd /opt/tensorflow/models/syntaxnet
echo $sentence | bash parse_czech.sh
