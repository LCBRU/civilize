from flask import render_template

from lbrc_flask.database import db
from sqlalchemy import select
from sqlalchemy.orm import selectinload

from civilize.model import Case

from .. import blueprint


@blueprint.route("/participant")
def participant_index():
    q = select(Case).where(Case.is_deleted == False)
    q = q.options(selectinload(Case.case_type))

    return render_template(
        "ui/participant/index.html",
        cases=db.session.execute(q).scalars(),
    )
