"""Datenbankmodell-Revision 0012m

Revision ID: cbb32be93732
Revises: 1c080b64f223
Create Date: 2018-08-10 15:23:55.744966

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'cbb32be93732'
down_revision = '1c080b64f223'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0012m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
