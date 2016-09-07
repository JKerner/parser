# Web service for parser of Czech sentences
Web service is available at http://cloud.ailao.eu:4570/index
All information about Syntaxnet and Czech model from Google can be found here https://github.com/tensorflow/models/tree/master/syntaxnet

Simple web interface is build with python framework Flask. Cherrypy server is used. Only one request is services at the time. 
# How to use
The server is started by running server.py. All source files for service are placed in folder appParse. 

CSS styles are placed in static folder.

Templates for HTML pages are in folder templates.

All logic is placed in file views.py. 


# Output description
For description of CoNLL-U see http://universaldependencies.org/format.html

Output of Parsey McParseface
```
1	Hello	_	X	UH	_	0	ROOT	_	_
2	World	_	NOUN	NNP	_	1	dep	_	_
3	.	_	.	.	_	1	punct	_	_
```
Output of Czech parser 
```
1	Ahoj	_	NOUN	NNIS4-----A----	Animacy=Inan|Case=Nom|Gender=Masc|Negative=Pos|Number=Sing|fPOS=NOUN++NNIS1-----A----	2	dobj	_	_
2	světe	_	VERB	Vi-P---2--A----	Animacy=Inan|Case=Gen|Gender=Masc|Negative=Pos|Number=Sing|fPOS=NOUN++NNIS2-----A----	0	ROOT	_	_
3	.	_	PUNCT	Z:-------------	fPOS=PUNCT++Z:-------------	2	punct	_	_
```

