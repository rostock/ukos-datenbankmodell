"""Datenbankmodell-Revision 0001d

Revision ID: 76eea60bd612
Revises: 58db9411272a
Create Date: 2019-04-30 08:46:31.997916

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '76eea60bd612'
down_revision = '58db9411272a'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0001d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
