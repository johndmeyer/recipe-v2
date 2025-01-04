'''
type python app.py to run
'''

from flask import Flask, request
from flask_restful import Resource, Api

from logic.recipe import Recipe
from logic.recipe import Recipes

app = Flask(__name__)
api = Api(app)
        
# routes

api.add_resource(Recipe, '/recipe/<int:id>')
api.add_resource(Recipes, '/recipe')


if __name__ == '__main__':
    app.run(debug=True)

