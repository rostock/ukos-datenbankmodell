"""Datenbankmodell-Revision 0005m

Revision ID: 27bfc72137cf
Revises: 7759d2f72914
Create Date: 2018-01-03 09:11:01.031337

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '27bfc72137cf'
down_revision = '7759d2f72914'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0005m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
