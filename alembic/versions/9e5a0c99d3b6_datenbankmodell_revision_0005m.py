"""Datenbankmodell-Revision 0005m

Revision ID: 9e5a0c99d3b6
Revises: 56a48e49a73b
Create Date: 2019-06-04 09:11:56.744470

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '9e5a0c99d3b6'
down_revision = '56a48e49a73b'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0005m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
