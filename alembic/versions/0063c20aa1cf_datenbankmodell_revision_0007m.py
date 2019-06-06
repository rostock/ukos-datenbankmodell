"""Datenbankmodell-Revision 0007m

Revision ID: 0063c20aa1cf
Revises: 3e50df5fdb38
Create Date: 2019-06-06 08:54:06.414930

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '0063c20aa1cf'
down_revision = '3e50df5fdb38'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0007m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
