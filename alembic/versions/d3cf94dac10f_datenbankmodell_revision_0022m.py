"""Datenbankmodell-Revision 0022m

Revision ID: d3cf94dac10f
Revises: 18f42996d902
Create Date: 2019-09-04 11:40:29.473162

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'd3cf94dac10f'
down_revision = '18f42996d902'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0022m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
