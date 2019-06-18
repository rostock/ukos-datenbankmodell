"""Datenbankmodell-Revision 0009m

Revision ID: a087b8dbadcf
Revises: a5ada6ed8306
Create Date: 2019-06-18 15:05:00.536125

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'a087b8dbadcf'
down_revision = 'a5ada6ed8306'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0009m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
