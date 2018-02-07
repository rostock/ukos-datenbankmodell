"""Datenbankmodell-Revision 0009m

Revision ID: 5c6c87a0d85e
Revises: c63c941c4262
Create Date: 2018-02-06 15:32:11.081980

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '5c6c87a0d85e'
down_revision = 'c63c941c4262'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0009m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
