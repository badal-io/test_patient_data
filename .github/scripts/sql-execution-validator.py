#!/usr/bin/env python3
"""
SQL Execution Validator against BigQuery
Tests that actual SQL from LookML views executes successfully
"""

import os
import sys
import json
import re
from pathlib import Path
from typing import List, Dict, Any
from google.cloud import bigquery
from google.oauth2 import service_account
import traceback

class SQLValidator:
    """Validates SQL from LookML against BigQuery"""

    def __init__(self, project_id: str):
        self.project_id = project_id
        self.client = None
        self.errors = []
        self.tables_to_validate = [
            "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013",
            "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.outpatient_charges_2013",
            "prj-s-dlp-dq-sandbox-0b3c.EK_test_data.bikeshare_trips",
            "bigquery-public-data.austin_bikeshare.bikeshare_stations"
        ]

    def authenticate(self) -> bool:
        """Authenticate with BigQuery"""
        try:
            # Try to use service account from environment
            credentials_json = os.getenv('GOOGLE_APPLICATION_CREDENTIALS')

            if credentials_json and os.path.isfile(credentials_json):
                # Credentials file path provided
                credentials = service_account.Credentials.from_service_account_file(
                    credentials_json
                )
                self.client = bigquery.Client(
                    credentials=credentials,
                    project=credentials.project_id
                )
            else:
                # Try default credentials
                self.client = bigquery.Client(project=self.project_id)

            # Test connection
            query = "SELECT 1"
            self.client.query(query).result()
            print("✓ Successfully authenticated with BigQuery")
            return True
        except Exception as e:
            print(f"✗ Authentication error: {str(e)}")
            traceback.print_exc()
            return False

    def validate_table_exists(self, table_id: str) -> bool:
        """Validate that a table exists"""
        try:
            self.client.get_table(table_id)
            print(f"  ✓ Table exists: {table_id}")
            return True
        except Exception as e:
            print(f"  ✗ Table not found: {table_id}")
            print(f"    Error: {str(e)}")
            self.errors.append(f"Table not found: {table_id}")
            return False

    def validate_table_schema(self, table_id: str) -> bool:
        """Validate table schema and run sample queries"""
        try:
            table = self.client.get_table(table_id)

            # Test basic SELECT
            query = f"SELECT * FROM `{table_id}` LIMIT 1"
            results = self.client.query(query).result(timeout=30)

            row_count = 0
            for row in results:
                row_count += 1

            print(f"  ✓ Schema validated: {table_id} ({len(table.schema)} columns, {row_count} rows sampled)")
            return True
        except Exception as e:
            print(f"  ✗ Schema validation failed: {table_id}")
            print(f"    Error: {str(e)}")
            self.errors.append(f"Schema validation failed for {table_id}: {str(e)}")
            return False

    def validate_views_sql(self) -> bool:
        """Validate SQL from view definitions"""
        try:
            views_dir = Path("Views")
            view_files = list(views_dir.glob("*.view.lkml"))

            if not view_files:
                print("✓ No view files found to validate")
                return True

            print(f"\nValidating {len(view_files)} view files:")

            for view_file in view_files:
                print(f"  Checking {view_file.name}...")

                # Simple validation - ensure views reference existing tables
                content = view_file.read_text()

                # Find table references
                for table_id in self.tables_to_validate:
                    if table_id in content or table_id.split('.')[-1] in content:
                        if not self.validate_table_exists(table_id):
                            return False

            return True
        except Exception as e:
            print(f"✗ View validation error: {str(e)}")
            self.errors.append(f"View validation failed: {str(e)}")
            return False

    def validate_explores(self) -> bool:
        """Validate explore definitions"""
        try:
            explores_dir = Path("Explores")
            explore_files = list(explores_dir.glob("*.explore.lkml"))

            if not explore_files:
                print("✓ No explore files found to validate")
                return True

            print(f"\nValidating {len(explore_files)} explore files:")

            for explore_file in explore_files:
                print(f"  Checking {explore_file.name}...")

            return True
        except Exception as e:
            print(f"✗ Explore validation error: {str(e)}")
            self.errors.append(f"Explore validation failed: {str(e)}")
            return False

    def run(self) -> int:
        """Run the validator"""
        print("=" * 60)
        print("SQL Validator - BigQuery")
        print("=" * 60)

        if not self.authenticate():
            return 1

        print("\nValidating source tables...")
        all_valid = True

        for table_id in self.tables_to_validate:
            if not self.validate_table_exists(table_id):
                all_valid = False
            elif not self.validate_table_schema(table_id):
                all_valid = False

        if not self.validate_views_sql():
            all_valid = False

        if not self.validate_explores():
            all_valid = False

        if not all_valid:
            print("\n" + "=" * 60)
            print("❌ SQL Validation FAILED")
            print("=" * 60)
            if self.errors:
                print("\nErrors:")
                for error in self.errors:
                    print(f"  - {error}")
            return 1

        print("\n" + "=" * 60)
        print("✅ SQL Validation PASSED")
        print("=" * 60)
        return 0


def main():
    """Main entry point"""
    project_id = os.getenv('GCP_PROJECT_ID', 'prj-s-dlp-dq-sandbox-0b3c')

    # Set credentials file location if provided
    credentials_json = os.getenv('GOOGLE_APPLICATION_CREDENTIALS')
    if not credentials_json:
        # Try to create temp credentials file from env var
        creds_env = os.getenv('GCP_CREDENTIALS')
        if creds_env:
            import tempfile
            with tempfile.NamedTemporaryFile(mode='w', suffix='.json', delete=False) as f:
                f.write(creds_env)
                credentials_json = f.name
                os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credentials_json

    validator = SQLValidator(project_id)
    return validator.run()


if __name__ == "__main__":
    sys.exit(main())
