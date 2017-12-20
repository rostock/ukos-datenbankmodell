"""Datenbankmodell-Revision 0002d

Revision ID: b2efcb44b9a2
Revises: a3f6acc7ebde
Create Date: 2017-12-20 16:32:29.593944

"""
from alembic import op
import sqlalchemy as sa
import io
import os


# revision identifiers, used by Alembic.
revision = 'b2efcb44b9a2'
down_revision = 'a3f6acc7ebde'
branch_labels = None
depends_on = None


def upgrade():
    sql_file = os.path.abspath(os.path.join(os.path.dirname(os.path.realpath(__file__)), '../..', 'datenbankmodell/revision-0002d.sql'))
    sql = io.open(sql_file, mode = 'r', encoding = 'utf-8').read()
    connection = op.get_bind()
    connection.execute(sa.text(sql))


def downgrade():
    pass
