# coding=utf-8
# -*- coding: utf-8 -*-


# pip install requests
import requests


def call_parser(url, sentence,lang='eng'):
	""" url - base URL of server, can be hardcoded when it will be set
	    lang - eng or cze, default is eng 
	    sentence - sentence to be parsed"""

	if lang=='cze':
	  url+='czech_parser'

	r = requests.post(url, data=sentence)
	#print r.status_code
	#print r.encoding
	print r.text
	return r.text


# current production server URL
url='http://cloud.ailao.eu:13880/' 

sentence_eng = "New York is city in America."
sentence_cze = "Praha je město v České republice."

# call for english parser
call_parser(url,sentence_eng)

# call for czech parser
call_parser(url,sentence_cze,'cze')