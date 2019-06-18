"""Datenbankmodell-Revision 0011d

Revision ID: 1a6390476666
Revises: d60f5c16b873
Create Date: 2019-06-18 16:00:06.508982

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = '1a6390476666'
down_revision = 'd60f5c16b873'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0011d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
