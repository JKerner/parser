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
	# create submit form in index 
	form = SubmitForm(request.form, class_="submit_form")

	# if there are data in POST request, then reply with parsed sentence
	if request.data.strip():
		return parseSentence(request.data)

	# if there are data in submit form then save the sentence
	if form.submit.data is not None  and form.validate():
		sentence = form.submit.data
		## TODO: add redirect here in order to get the page again with results
	else:
		# else add thie default sentence
		sentence = 'Hello World'
	

	parsedSentence = parseSentence(sentence)
	# result is a tuple, first is return code value, second is parsed string 
	return render_template('index.html',
							parsedSentence=parsedSentence,
							form = form )


def parseSentence(sentence):
	""" parses sentence and return input and parset output"""

	result = commands.getstatusoutput('bash ./appParse/parse.sh '+sentence)

	# split result from parser to only include input sentence and parsed sentence 
	parsedSentence = result[1].split("Input:",1)[1]
	parsedSentence = 'Input: ' + parsedSentence
	print parsedSentence
	return parsedSentence

