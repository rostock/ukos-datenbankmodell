"""Datenbankmodell-Revision 0006m

Revision ID: c1902d23bef8
Revises: 27bfc72137cf
Create Date: 2018-01-03 09:38:14.281699

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'c1902d23bef8'
down_revision = '27bfc72137cf'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0006m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
