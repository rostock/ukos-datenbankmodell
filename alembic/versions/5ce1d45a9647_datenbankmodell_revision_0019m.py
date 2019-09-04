"""Datenbankmodell-Revision 0019m

Revision ID: 5ce1d45a9647
Revises: 888c05c2d102
Create Date: 2019-09-04 11:40:24.200892

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '5ce1d45a9647'
down_revision = '888c05c2d102'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0019m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
