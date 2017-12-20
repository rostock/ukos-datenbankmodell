"""Datenbankmodell-Revision 0003m

Revision ID: d612d01889cb
Revises: b2efcb44b9a2
Create Date: 2017-12-20 16:34:23.163952

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'd612d01889cb'
down_revision = 'b2efcb44b9a2'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0003m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
