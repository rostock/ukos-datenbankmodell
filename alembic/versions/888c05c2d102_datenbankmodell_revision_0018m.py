"""Datenbankmodell-Revision 0018m

Revision ID: 888c05c2d102
Revises: 78b27ef133cf
Create Date: 2019-09-04 11:40:21.797218

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '888c05c2d102'
down_revision = '78b27ef133cf'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0018m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
