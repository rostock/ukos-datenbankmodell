"""Datenbankmodell-Revision 0012d

Revision ID: 6c3aac09d544
Revises: 1a6390476666
Create Date: 2019-06-28 09:58:07.256676

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '6c3aac09d544'
down_revision = '1a6390476666'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0012d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
