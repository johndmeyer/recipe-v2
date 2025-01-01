'''
type python app.py to run
'''

from flask import Flask
from flask_restful import Resource, Api

from logic.recipe import Recipe

app = Flask(__name__)
api = Api(app)
        
# routes
api.add_resource(Recipe, '/recipe/<int:id>')


if __name__ == '__main__':
    app.run(debug=True)

