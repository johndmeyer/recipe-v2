from flask_restx import fields

def tag(api):
    return api.model('tag', {
        'tagDescription': fields.String(description=''),
        'tagId': fields.Integer(description=''),
        'tagName': fields.String(description=''),
    })