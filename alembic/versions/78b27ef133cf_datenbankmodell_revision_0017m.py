"""Datenbankmodell-Revision 0017m

Revision ID: 78b27ef133cf
Revises: 5e1166b6166a
Create Date: 2019-09-04 11:40:19.944973

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '78b27ef133cf'
down_revision = '5e1166b6166a'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0017m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
