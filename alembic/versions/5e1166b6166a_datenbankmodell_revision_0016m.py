"""Datenbankmodell-Revision 0016m

Revision ID: 5e1166b6166a
Revises: a690da2870a9
Create Date: 2019-07-23 09:12:54.222114

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '5e1166b6166a'
down_revision = 'a690da2870a9'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0016m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
