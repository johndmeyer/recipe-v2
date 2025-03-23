from flask_restx import fields

def difficulty(api):
    return api.model('difficulty', {
        'difficultyId': fields.Integer(description=''),
        'difficultyName': fields.String(description=''),
    })