from lbrc_flask.database import db
from sqlalchemy.orm import Mapped, mapped_column, relationship, backref
from sqlalchemy import Boolean, Integer, String, Date
from datetime import date


class CaseType(db.Model):
    __tablename__ = 'civicrm_case_type'

    id: Mapped[int] = mapped_column(Integer, nullable=False, primary_key=True)
    name: Mapped[str] = mapped_column(String(64), nullable=False)
    title: Mapped[str] = mapped_column(String(64), nullable=False)
    description: Mapped[str] = mapped_column(String(255), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, nullable=False)


class Case(db.Model):
    __tablename__ = 'civicrm_case'

    id: Mapped[int] = mapped_column(Integer, nullable=False, primary_key=True)
    case_type_id: Mapped[int] = mapped_column(Integer, nullable=False)
    subject: Mapped[str] = mapped_column(String(128), nullable=False)
    start_date: Mapped[date] = mapped_column(Date, nullable=False)
    end_date: Mapped[date] = mapped_column(Date, nullable=False)
    status_id: Mapped[int] = mapped_column(Integer, nullable=False)
    is_deleted: Mapped[bool] = mapped_column(Boolean, nullable=False)

    case_type: Mapped[CaseType] = relationship(
        CaseType,
        foreign_keys=[case_type_id],
        primaryjoin='CaseType.id == Case.case_type_id',
        backref=backref("cases", cascade="delete, delete-orphan")
    )
