"""Datenbankmodell-Revision 0001m

Revision ID: a3f6acc7ebde
Revises: 89df46d6dc07
Create Date: 2017-12-20 16:27:01.108393

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'a3f6acc7ebde'
down_revision = '89df46d6dc07'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0001m.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
