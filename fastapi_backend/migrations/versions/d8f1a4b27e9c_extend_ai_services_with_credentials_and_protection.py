"""Extend ai_services with credentials, protection flag, and audit timestamps.

Revision ID: d8f1a4b27e9c
Revises: c7e8f9012abc
Create Date: 2026-05-25

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


revision: str = "d8f1a4b27e9c"
down_revision: Union[str, Sequence[str], None] = "c7e8f9012abc"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "ai_services",
        sa.Column("api_key", sa.Text(), nullable=True),
    )
    op.add_column(
        "ai_services",
        sa.Column(
            "auth_header",
            sa.String(length=64),
            nullable=True,
            server_default="Authorization",
        ),
    )
    op.add_column(
        "ai_services",
        sa.Column(
            "auth_scheme",
            sa.String(length=32),
            nullable=True,
            server_default="Bearer",
        ),
    )
    op.add_column(
        "ai_services",
        sa.Column(
            "is_protected",
            sa.Boolean(),
            nullable=False,
            server_default=sa.text("FALSE"),
        ),
    )
    op.add_column(
        "ai_services",
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=True,
            server_default=sa.text("NOW()"),
        ),
    )
    op.add_column(
        "ai_services",
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            nullable=True,
            server_default=sa.text("NOW()"),
        ),
    )

    # Lock the built-in gemini-cloud row so admins can't delete or mutate it
    # from the new CRUD endpoints. The Bard exploit path requires this exact
    # provider_url/headers combo and ships without an api_key.
    op.execute(
        """
        UPDATE ai_services
           SET is_protected = TRUE
         WHERE service_id = 'gemini-cloud';
        """
    )


def downgrade() -> None:
    op.drop_column("ai_services", "updated_at")
    op.drop_column("ai_services", "created_at")
    op.drop_column("ai_services", "is_protected")
    op.drop_column("ai_services", "auth_scheme")
    op.drop_column("ai_services", "auth_header")
    op.drop_column("ai_services", "api_key")
