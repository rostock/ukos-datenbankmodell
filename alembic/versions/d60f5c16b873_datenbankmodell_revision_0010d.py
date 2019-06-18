"""Datenbankmodell-Revision 0010d

Revision ID: d60f5c16b873
Revises: a087b8dbadcf
Create Date: 2019-06-18 15:55:28.491874

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'd60f5c16b873'
down_revision = 'a087b8dbadcf'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0010d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
