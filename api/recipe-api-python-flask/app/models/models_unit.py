from flask_restx import fields

def unit(api):
    return api.model('unit', {
        'unitAbbreviation': fields.String(description=''),
        'unitId': fields.Integer(description=''),
        'unitName': fields.String(description=''),
        'unitType': fields.String(description=''),
    })