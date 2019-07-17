"""Datenbankmodell-Revision 0014m

Revision ID: 0a97dbd191b0
Revises: c90d41748ac2
Create Date: 2019-07-17 09:03:56.844300

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '0a97dbd191b0'
down_revision = 'c90d41748ac2'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0014m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
