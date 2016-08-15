
#This is init script for python server application that is used as API for Parser McParseface model


from flask import Flask
import os

app = Flask(__name__)
app._static_folder = os.path.abspath("appParse/")
print(app._static_folder)
app.config.from_object('config')

from appParse import views
