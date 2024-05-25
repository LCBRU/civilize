from flask import render_template

from lbrc_flask.database import db

from .. import blueprint


@blueprint.route("/")
def index():
    return render_template("ui/home.html")


@blueprint.route("/form")
def form():
    return render_template("ui/form.html")