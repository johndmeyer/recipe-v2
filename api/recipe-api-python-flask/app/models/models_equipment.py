from flask_restx import fields

def equipment(api):
    return api.model('equipment', {
        'equipmentDescription': fields.String(description=''),
        'equipmentId': fields.Integer(description=''),
        'equipmentName': fields.String(description='')
    })