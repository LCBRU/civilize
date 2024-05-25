#!/usr/bin/env python3

from random import randint
from dotenv import load_dotenv
from lbrc_flask.database import db
from lbrc_flask.security import init_roles, init_users
from lbrc_flask.security.model import Role, User, roles_users
from sqlalchemy import text
from faker import Faker
fake = Faker()

from civilize.model import Case, CaseType

load_dotenv()

from civilize import create_app

application = create_app()
application.app_context().push()

User.__table__.create(bind=db.session.get_bind())
Role.__table__.create(bind=db.session.get_bind())
roles_users.create(bind=db.session.get_bind())

init_roles()
init_users()

with open('civi_tables.sql', 'r') as f:
    for s in f.read().split(';'):
        if s.strip():
            db.session.execute(text(f'{s};'))

case_types = [
    CaseType(name='GENVASC', title='GENVASC', is_active=True),
    CaseType(name='BioResource', title='BioResource', is_active=True),
    CaseType(name='Dinosaur', title='Dinosaur', is_active=False),
    CaseType(name='BRICCS', title='BRICCS', is_active=True),
    CaseType(name='GUITAR', title='GUITAR', is_active=True),
    CaseType(name='BREAK', title='BREAK', is_active=True),
    CaseType(name='STEAM', title='STEAM', is_active=True),
    CaseType(name='GOAT', title='GOAT', is_active=True),
    CaseType(name='RIFF', title='RIFF', is_active=True),
    CaseType(name='SMOKE', title='SMOKE', is_active=True),
    CaseType(name='LOOSE', title='LOOSE', is_active=True),
    CaseType(name='BRIGHTEN', title='BRIGHTEN', is_active=True),
    CaseType(name='TOAST', title='TOAST', is_active=True),
    CaseType(name='LAKER', title='LAKER', is_active=True),
]

db.session.add_all(case_types)
db.session.flush()

cases = []

for ct in case_types:
    for _ in range(randint(50,100)):
        cases.append(
            Case(case_type_id=ct.id, subject=fake.sentence(), start_date=fake.date(), end_date=fake.date(), status_id=1, is_deleted=False)
        )

db.session.add_all(cases)
db.session.flush()

db.session.commit()