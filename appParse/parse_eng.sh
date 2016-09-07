#!/bin/bash
# Call parsey mcparseface on sentence

sentence=$@

cd /opt/tensorflow/models/syntaxnet
echo $sentence | bash parse_english.sh