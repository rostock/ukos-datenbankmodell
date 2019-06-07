"""Datenbankmodell-Revision 0008d

Revision ID: a5ada6ed8306
Revises: 0063c20aa1cf
Create Date: 2019-06-07 13:17:31.669819

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'a5ada6ed8306'
down_revision = '0063c20aa1cf'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0008d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
