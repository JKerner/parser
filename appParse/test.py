
import re


def parseToSentences(list_of_sentences):
	sentence = re.split("\\.",list_of_sentences)
	sentence.pop()
	print sentence
	print len(sentence)


	for i in range(0,len(sentence)):
		sentence[i]+="."
		print sentence[i]


parseToSentences("List. Day is all sunny.")
