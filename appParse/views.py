# coding=utf-8
# -*- coding: utf-8 -*-

#The views are the handlers that respond to requests from web browsers or other clients.
#In Flask handlers are written as Python functions. 
#Each view function is mapped to one or more request URLs.

from appParse import app
from flask import render_template
from flask import request
from flask import redirect
from flask import url_for
from flask import send_from_directory



from appParse.forms import SubmitForm
import commands
import re

@app.route("/", methods=['GET','POST'])
@app.route("/index", methods=['GET','POST'])



def index():
	
	print("Parsing english sentence")
	# create submit form in index 
	form = SubmitForm(request.form)

	# if there are data in POST request, then reply with parsed sentence
	if request.data.strip():
		return parseEngSentence(request.data)

	# if there are data in submit form then save the sentence
	if form.submit.data is not None  and form.validate():
		sentence = form.submit.data
		sentence = parseToSentences(sentence)
		
	else:
		# else add this default sentence
		sentence = 'Hello World.'
	

	parsedSentence = parseEngSentence(sentence)
	return render_template('index.html',
							parsedSentence=parsedSentence,
							sentence = sentence,
							form = form )




@app.route("/czech_parser", methods=['GET','POST'])

def czech_parser():

	print("Parsing czech sentence")
	form = SubmitForm(request.form)

	# if there are data in POST request, then reply with parsed sentence
	if request.data.strip():
		return parseCzeSentence(request.data)

	# if there are data in submit form then save the sentence
	if form.submit.data is not None  and form.validate():
		sentence = form.submit.data
		#take only first sentence if there are more in input
		sentence = parseToSentences(sentence)
		
	else:
		# else add thie default sentence
		#sentence = 'Ema má mísu.'
		sentence = u'Ahoj světe.'

	
	
	parsedSentence = parseCzeSentence(sentence)
	# result is a tuple, first is return code value, second is parsed string 
	return render_template('czech_parser.html',
							parsedSentence=parsedSentence,
							sentence = sentence.encode('utf-8'),
							form = form )








def parseEngSentence(sentence):
	""" parses english sentence and returns parsed output in CoNLL format"""
	bashCommand = "bash ./appParse/parse_eng.sh "+sentence
	print(bashCommand)

	import subprocess
	process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
	result = process.communicate()[0]
	
	print(result)
	return result

	

def parseCzeSentence(sentence):
	""" parses czech sentence and returns parsed output CoNLL format"""
	bashCommand = "bash ./appParse/parse_cze.sh "+sentence
	print(bashCommand)

	import subprocess
	process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
	result = process.communicate()[0]
	
	print(result)
	return result



def parseToSentences(input_string):
	""" Split at the end of the line"""
	sentence = re.split("\\.",input_string)
	

	""""sentence = input_string.split('\n')
	for s in sentence:
		print s
	return sentence"""

	return (sentence[0]+" .")

	