from flask_restx import fields, Namespace, Resource
from ..models.duration import duration

api = Namespace('duration', description='Ref data for the cook time drop down')

model_duration = duration(api)

get_duration_model = api.model('data', {
	'durations': fields.List(fields.Nested(model_duration))
})

@api.route('')
class CookTimes(Resource):
	@api.doc(description='Retrieves a list of durations')
	@api.doc(model=get_duration_model)
	def get(self):
		durations = []
		durations.append({'durationId': 30, 'durationName': '30 minutes or less'})
		durations.append({'durationId': 60, 'durationName': '60 minutes or less'})
		durations.append({'durationId': 90, 'durationName': '90 minutes or less'})

		data = {}
		data['durations'] = durations

		response = {}
		response['data'] = data

		return response
