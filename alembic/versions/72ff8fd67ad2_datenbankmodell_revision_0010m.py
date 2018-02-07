"""Datenbankmodell-Revision 0010m

Revision ID: 72ff8fd67ad2
Revises: 5c6c87a0d85e
Create Date: 2018-02-06 15:50:10.830536

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '72ff8fd67ad2'
down_revision = '5c6c87a0d85e'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0010m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
