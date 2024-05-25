from flask.blueprints import Blueprint
from lbrc_flask.database import db


blueprint = Blueprint("ui", __name__, template_folder="templates")


@blueprint.record
def record(state):
    if db is None:
        raise Exception(
            "This blueprint expects you to provide " "database access through database"
        )


from .views import *
