#!/usr/bin/env python3

from dotenv import load_dotenv
from lbrc_flask.database import db
from lbrc_flask.security import init_roles, init_users

load_dotenv()

from new_way import create_app

application = create_app()
application.app_context().push()
db.create_all()
init_roles()
init_users()

from alembic.config import Config
from alembic import command
alembic_cfg = Config("alembic.ini")
command.stamp(alembic_cfg, "head")
