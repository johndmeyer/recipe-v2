from flask import Flask
from flask_restx import Api

from .routes.routes_difficulty import api as difficulty_api
from .routes.routes_duration import api as duration_api
from .routes.routes_recipe import api as recipe_api
from .routes.routes_tag import api as tag_api

def create_app():
    app = Flask(__name__)

    @app.after_request
    def add_header(response):
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response

    api = Api(
        title="Recipe API",
        version="1.0.0",
        description="Recipe API built with python, flask, flask-restx, and mysql-connector-python ",
    )

    api.add_namespace(difficulty_api)
    api.add_namespace(duration_api)
    api.add_namespace(recipe_api)
    api.add_namespace(tag_api)

    api.init_app(app)
    
    return app
