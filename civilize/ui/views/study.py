from flask import render_template

from lbrc_flask.database import db
from sqlalchemy import select
from sqlalchemy.orm import selectinload

from civilize.model import CaseType

from .. import blueprint


@blueprint.route("/")
def index():
    q = select(CaseType).where(CaseType.is_active == True)
    q = q.options(selectinload(CaseType.cases))


    return render_template(
        "ui/study/index.html",
        case_types=db.session.execute(q).scalars(),
    )
