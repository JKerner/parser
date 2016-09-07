#!/bin/bash
# Script for calling czech model od Syntaxnet

sentence=$@

# set directory where model is stored, add sentence to text file
MODEL_DIRECTORY=/opt/tensorflow/models/syntaxnet/google_czech_model/Czech
cd /opt/tensorflow/models/syntaxnet 
echo -e $sentence > sentences.txt

# call tokenizer on sentence
cat sentences.txt | syntaxnet/models/parsey_universal/tokenize.sh \
    $MODEL_DIRECTORY > tokenized_sentences.txt

# call parser on tokenized sentence
cat tokenized_sentences.txt | syntaxnet/models/parsey_universal/parse.sh \
    $MODEL_DIRECTORY > output.conll

# print output to stdout that is read with python
cat output.conll

# remove all the temporary files
rm output.conll
rm tokenized_sentences.txt
rm sentences.txt
