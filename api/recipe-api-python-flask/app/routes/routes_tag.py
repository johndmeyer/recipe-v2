from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_tag import tag

api = Namespace('tag', description='Operations on the tag table')

model_tag = tag(api)

getTag_model = api.model('data', {
	'tags': fields.List(fields.Nested(model_tag))
})

@api.route('')
class Tag(Resource):
	@api.doc(description='Retrieves a heirarchal list of tags')
	@api.doc(model=getTag_model)
	def get(self):
		proc_name = 'retrieveTags'
		proc_args = []

		result = call_proc(proc_args, proc_name)

		data = {}

		data['tags'] = result[0]

		response = {}
		response['data'] = data

		return response

	@api.doc(description='Creates a new tag')
	@api.doc(model=getTag_model)
	def put(self):
		pass

	@api.doc(description='Updates an existing tag')
	@api.doc(model=getTag_model)
	def post(self):
		pass

@api.route('/<id>')
class EquipmentId(Resource):
	@api.doc(description='Deletes a specific tag by id')
	@api.doc(model=getTag_model)
	def delete(self, id):
		pass