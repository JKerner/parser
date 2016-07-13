from wtforms import StringField, Form, validators



class SubmitForm(Form):
	submit = StringField('submit',[validators.DataRequired()])
