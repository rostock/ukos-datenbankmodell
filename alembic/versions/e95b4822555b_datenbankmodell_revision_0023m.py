"""Datenbankmodell-Revision 0023m

Revision ID: e95b4822555b
Revises: d3cf94dac10f
Create Date: 2019-09-04 11:42:52.680538

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'e95b4822555b'
down_revision = 'd3cf94dac10f'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0023m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
