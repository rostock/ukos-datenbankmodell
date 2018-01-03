"""Datenbankmodell-Revision 0007m

Revision ID: 9294057a6aa4
Revises: c1902d23bef8
Create Date: 2018-01-03 10:21:48.399048

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '9294057a6aa4'
down_revision = 'c1902d23bef8'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0007m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
