from flask import render_template

from lbrc_flask.database import db
from sqlalchemy import select

from civilize.model import CaseType

from .. import blueprint


@blueprint.route("/")
def index():
    q = select(CaseType).where(CaseType.is_active == 1)

    return render_template(
        "ui/home.html",
        case_types=db.session.execute(q).scalars(),
    )
