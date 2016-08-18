FROM java:8

ENV SYNTAXNETDIR=/opt/tensorflow PATH=$PATH:/root/bin

RUN mkdir -p $SYNTAXNETDIR \
    && cd $SYNTAXNETDIR \
    && apt-get update \
    && apt-get install git zlib1g-dev file swig python2.7 python-dev python-pip -y \
    && pip install --upgrade pip \
    && pip install -U protobuf==3.0.0b2 \
    && pip install asciitree \
    && pip install numpy \
    && wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel-0.2.2b-installer-linux-x86_64.sh \
    && chmod +x bazel-0.2.2b-installer-linux-x86_64.sh \
    && ./bazel-0.2.2b-installer-linux-x86_64.sh --user \
    && git clone --recursive https://github.com/tensorflow/models.git \
    && cd $SYNTAXNETDIR/models/syntaxnet/tensorflow \
    && echo "\n\n\n" | ./configure

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && bazel test --genrule_strategy=standalone syntaxnet/... util/utf8/... \
    && apt-get autoremove -y \
    && apt-get clean


RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && echo "cache bust" \
    && wget https://raw.githubusercontent.com/jiriker/parser/master/scripts/parse_czech.sh \
    && wget https://raw.githubusercontent.com/jiriker/parser/master/scripts/parse_english.sh \
    && cd $SYNTAXNETDIR/models/syntaxnet/syntaxnet/models \ 
    && git clone https://github.com/jiriker/czech_model.git

RUN cd $SYNTAXNETDIR/models/syntaxnet \
    && GIT_TRACE=1 git stash \
    && git config http.postBuffer 5000 \ 
    && git clone https://github.com/jiriker/parser.git -b master --progress --verbose

RUN cd $SYNTAXNETDIR/models/syntaxnet \
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
# mkdir build && cp Dockerfile build/ && cd build
# docker build -t syntaxnet .
# docker run syntaxnet

