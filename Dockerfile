FROM java:8

ENV SYNTAXNETDIR=/opt/tensorflow PATH=$PATH:/root/bin


RUN mkdir -p $SYNTAXNETDIR \
    && echo "Installing dependencies for Syntaxnet and Tensorflow" \
    && cd $SYNTAXNETDIR \
    && apt-get update \
    && apt-get install git zlib1g-dev file swig python2.7 python-dev python-pip -y \
    && pip install --upgrade pip \
    && pip install -U protobuf==3.0.0b2 \
    && pip install asciitree \
    && pip install numpy \
    && wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel-0.2.2b-installer-linux-x86_64.sh \
    && chmod +x bazel-0.2.2b-installer-linux-x86_64.sh \
    && ./bazel-0.2.2b-installer-linux-x86_64.sh --user 

RUN cd $SYNTAXNETDIR \ 
    && echo "Clone tensorflow with models  !cache!." \ 
    && git clone --recursive https://github.com/tensorflow/models.git  

RUN cd $SYNTAXNETDIR/models/syntaxnet/tensorflow \
    && echo "configure tensorflow before building." \
    && echo "\n\n\n" | ./configure

    

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "Test build with bazel" \
    && bazel test --genrule_strategy=standalone syntaxnet/... util/utf8/... \
    && apt-get autoremove -y \
    && apt-get clean

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "Donwload and unzip czech model trained by google." \
    && mkdir google_czech_model \
    && wget http://download.tensorflow.org/models/parsey_universal/Czech.zip \
    && unzip Czech.zip \
    && cd Czech 

ENV MODEL_DIRECTORY=/opt/tensorflow/models/syntaxnet/google_czech_model/Czech


RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "Copy scripts for model calling and download czech model trained in Metacentrum." \
    && wget https://raw.githubusercontent.com/jiriker/parser/master/scripts/parse_czech.sh \
    && wget https://raw.githubusercontent.com/jiriker/parser/master/scripts/parse_english.sh \
    && cd $SYNTAXNETDIR/models/syntaxnet/syntaxnet/models \ 
    && git clone https://github.com/jiriker/czech_model.git --progress --verbose

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "Download web app in Flask." \
    && GIT_TRACE=1 git stash \
    && git clone https://github.com/jiriker/parser.git -b master --progress --verbose

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "Install all dependecies for web app. " \
    && pip install cherrypy \
    && pip install flask \
    && pip install flask-login \
    && pip install flask-openid \
    && pip install flask-mail \
    && pip install flask-sqlalchemy \ 
    && pip install sqlalchemy-migrate \
    && pip install flask-whooshalchemy \
    && pip install flask-wtf \
    && pip install flask-babel \
    && pip install guess_language \
    && pip install flipflop \ 
    && pip install coverage 
   

EXPOSE 5000

WORKDIR $SYNTAXNETDIR/models/syntaxnet/parser

CMD python server.py 

# COMMANDS to build and run
# ===============================

# docker build -t syntaxnet .

#docker run -d -p 5000:5000 -i -t syntaxnet
