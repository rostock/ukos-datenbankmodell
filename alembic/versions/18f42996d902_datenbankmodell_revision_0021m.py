"""Datenbankmodell-Revision 0021m

Revision ID: 18f42996d902
Revises: 82163dd50b37
Create Date: 2019-09-04 11:40:27.957126

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '18f42996d902'
down_revision = '82163dd50b37'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0021m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
