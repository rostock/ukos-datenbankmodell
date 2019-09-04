"""Datenbankmodell-Revision 0020m

Revision ID: 82163dd50b37
Revises: 5ce1d45a9647
Create Date: 2019-09-04 11:40:26.379150

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '82163dd50b37'
down_revision = '5ce1d45a9647'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0020m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
