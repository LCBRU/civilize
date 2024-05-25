from lbrc_flask.database import db
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import Boolean, Integer, String


class CaseType(db.Model):
    __tablename__ = 'civicrm_case_type'

    id: Mapped[int] = mapped_column(Integer, nullable=False, primary_key=True)
    name: Mapped[str] = mapped_column(String(64), nullable=False)
    title: Mapped[str] = mapped_column(String(64), nullable=False)
    description: Mapped[str] = mapped_column(String(255), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, nullable=True)
