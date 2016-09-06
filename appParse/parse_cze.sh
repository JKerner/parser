#!/bin/bash
# My first script

#echo "Hello World!"

## TODO remap to docker 
sentence=$@

#docker run syntaxnet "sh" "-c" "echo $sentence | bash parse_czech.sh"
MODEL_DIRECTORY=/opt/tensorflow/models/syntaxnet/google_czech_model/Czech
cd /opt/tensorflow/models/syntaxnet 
echo $sentence > sentences.txt

cat sentences.txt | syntaxnet/models/parsey_universal/parse.sh \
    $MODEL_DIRECTORY > output.conll

cat output.conll
rm output.conll

# tokenizer currently not working
#cat sentences.txt | syntaxnet/models/parsey_universal/tokenize.sh \
#    $MODEL_DIRECTORY > output.conll

#cat output.conll

#rm output.conll

rm sentences.txt

# google model works better and has more tags, replacing.
#echo "Metacentrum Model"
#cd /opt/tensorflow/models/syntaxnet
#echo $sentence | bash parse_czech.sh
