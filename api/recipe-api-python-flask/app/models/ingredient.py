from flask_restx import fields

def ingredient(api):
    return api.model('ingredient', {
        'quantity': fields.Integer(description=''),
        'unitName': fields.String(description=''),
        'unitId': fields.Integer(description=''),
        'unitAbbreviation': fields.String(description=''),
        'ingredientId': fields.Integer(description=''),
        'ingredientName': fields.String(description=''),
        'ingredientDescription': fields.String(description='')
    })