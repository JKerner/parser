from wtforms import StringField, Form, validators, TextAreaField, TextField



class SubmitForm(Form):
	#submit = StringField('submit',[validators.DataRequired()])
	submit = TextAreaField('submit',[validators.DataRequired()])