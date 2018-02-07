"""Datenbankmodell-Revision 0011m

Revision ID: 1c080b64f223
Revises: 72ff8fd67ad2
Create Date: 2018-02-06 16:00:11.356728

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '1c080b64f223'
down_revision = '72ff8fd67ad2'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0011m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
