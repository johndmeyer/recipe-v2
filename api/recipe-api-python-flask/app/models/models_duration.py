from flask_restx import fields

def duration(api):
    return api.model('duration', {
        'durationId': fields.Integer(description=''),
        'durationName': fields.String(description=''),
    })