"""Datenbankmodell-Revision 0004d

Revision ID: 7759d2f72914
Revises: d612d01889cb
Create Date: 2017-12-20 16:46:23.947546

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '7759d2f72914'
down_revision = 'd612d01889cb'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0004d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
