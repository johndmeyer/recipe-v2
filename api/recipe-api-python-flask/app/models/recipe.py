from flask_restx import fields

def recipe(api):
    return api.model('recipe', {
        'difficultyName': fields.String(description=''),
        'difficultyId': fields.Integer(description=''),
        'recipeCookTime': fields.Integer(description=''),
        'recipeDescription': fields.String(description=''),
        'recipeDirections': fields.String(description=''),
        'recipeName': fields.String(description=''),
        'recipePhotoUrl': fields.String(description=''),
        'recipeYield': fields.Integer(description='')
    })