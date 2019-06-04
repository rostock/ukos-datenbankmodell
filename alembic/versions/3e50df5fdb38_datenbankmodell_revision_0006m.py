"""Datenbankmodell-Revision 0006m

Revision ID: 3e50df5fdb38
Revises: 9e5a0c99d3b6
Create Date: 2019-06-04 11:35:19.269914

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '3e50df5fdb38'
down_revision = '9e5a0c99d3b6'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0006m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
