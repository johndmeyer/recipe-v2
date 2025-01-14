from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.tag import tag

api = Namespace('tag', description='Operations on the tag table')

model_tag = tag(api)

getTags_model = api.model('data', {
	'tags': fields.List(fields.Nested(model_tag))
})

@api.route('')
class Difficulties(Resource):
	@api.doc(description='Retrieves a heirarchal list of tags')
	@api.doc(model=getTags_model)
	def get(self):
		proc_name = 'retrieveTags'
		proc_args = []

		result = call_proc(proc_args, proc_name)

		data = {}

		data['tags'] = result[0]

		response = {}
		response['data'] = data

		return response
