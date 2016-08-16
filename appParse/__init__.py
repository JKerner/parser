
#This is init script for python server application that is used as API for Parser McParseface model


from flask import Flask
import os

app = Flask(__name__)
app.config.from_object('config')

from appParse import views
