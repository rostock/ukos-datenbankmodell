"""Datenbankmodell-Revision 0013m

Revision ID: c90d41748ac2
Revises: 6c3aac09d544
Create Date: 2019-07-05 15:15:37.207937

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'c90d41748ac2'
down_revision = '6c3aac09d544'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0013m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
