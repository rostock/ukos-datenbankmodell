"""Datenbankmodell-Revision 0008m

Revision ID: c63c941c4262
Revises: 9294057a6aa4
Create Date: 2018-01-30 11:06:24.937975

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'c63c941c4262'
down_revision = '9294057a6aa4'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0008m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
