"""Datenbankmodell-Revision 0015d

Revision ID: a690da2870a9
Revises: 0a97dbd191b0
Create Date: 2019-07-19 10:53:04.822351

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'a690da2870a9'
down_revision = '0a97dbd191b0'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0015d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
