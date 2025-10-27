#!/usr/bin/env python3
"""
LookML Syntax Validator using Looker API
Validates LookML files for syntax errors
"""

import os
import sys
import json
import requests
from urllib.parse import urljoin
from typing import Optional, Dict, Any
import base64

class LookerValidator:
    """Validates LookML using Looker API"""

    def __init__(self, base_url: str, client_id: str, client_secret: str):
        self.base_url = base_url.rstrip('/')
        self.client_id = client_id
        self.client_secret = client_secret
        self.access_token = None
        self.project_name = "test_patient_data"
        self.errors = []
        self.warnings = []

    def authenticate(self) -> bool:
        """Authenticate with Looker API"""
        try:
            auth_url = urljoin(self.base_url, "/api/4.0/login")
            auth = (self.client_id, self.client_secret)

            response = requests.post(auth_url, auth=auth, timeout=10)

            if response.status_code == 200:
                data = response.json()
                self.access_token = data.get('access_token')
                print("✓ Successfully authenticated with Looker API")
                return True
            else:
                print(f"✗ Authentication failed: {response.status_code}")
                print(f"  Response: {response.text}")
                return False
        except Exception as e:
            print(f"✗ Authentication error: {str(e)}")
            return False

    def get_headers(self) -> Dict[str, str]:
        """Get request headers with authentication"""
        return {
            'Authorization': f'Bearer {self.access_token}',
            'Content-Type': 'application/json'
        }

    def validate_project(self) -> bool:
        """Validate the project using Looker API"""
        if not self.access_token:
            print("✗ Not authenticated. Cannot validate project.")
            return False

        try:
            # Get project details
            url = urljoin(self.base_url, f"/api/4.0/projects/{self.project_name}")
            response = requests.get(url, headers=self.get_headers(), timeout=10)

            if response.status_code != 200:
                print(f"✗ Failed to get project: {response.status_code}")
                print(f"  Response: {response.text}")
                return False

            project = response.json()
            print(f"✓ Project '{self.project_name}' found")

            # Validate project files
            validation_url = urljoin(
                self.base_url,
                f"/api/4.0/projects/{self.project_name}/validate"
            )

            val_response = requests.get(
                validation_url,
                headers=self.get_headers(),
                timeout=30
            )

            if val_response.status_code == 200:
                validation_result = val_response.json()

                # Check for errors
                if 'errors' in validation_result and validation_result['errors']:
                    print(f"\n✗ LookML Validation Errors Found:")
                    for error in validation_result['errors']:
                        error_msg = f"  - {error.get('message', 'Unknown error')}"
                        if 'file' in error:
                            error_msg = f"  [{error['file']}] {error.get('message', 'Unknown error')}"
                        print(error_msg)
                        self.errors.append(error_msg)
                    return False
                else:
                    print("✓ No LookML syntax errors found")

                    # Check for warnings
                    if 'warnings' in validation_result and validation_result['warnings']:
                        print(f"\n⚠ LookML Warnings:")
                        for warning in validation_result['warnings']:
                            warning_msg = f"  - {warning.get('message', 'Unknown warning')}"
                            if 'file' in warning:
                                warning_msg = f"  [{warning['file']}] {warning.get('message', 'Unknown warning')}"
                            print(warning_msg)
                            self.warnings.append(warning_msg)

                    return True
            else:
                print(f"✗ Validation request failed: {val_response.status_code}")
                print(f"  Response: {val_response.text}")
                return False

        except Exception as e:
            print(f"✗ Validation error: {str(e)}")
            return False

    def run(self) -> int:
        """Run the validator"""
        print("=" * 60)
        print("LookML Validator - Looker API")
        print("=" * 60)

        if not self.authenticate():
            return 1

        print("\nValidating LookML syntax...")
        if not self.validate_project():
            print("\n" + "=" * 60)
            print("❌ Validation FAILED")
            print("=" * 60)
            return 1

        print("\n" + "=" * 60)
        print("✅ Validation PASSED")
        print("=" * 60)
        return 0


def main():
    """Main entry point"""
    base_url = os.getenv('LOOKER_BASE_URL')
    client_id = os.getenv('LOOKER_CLIENT_ID')
    client_secret = os.getenv('LOOKER_CLIENT_SECRET')

    if not all([base_url, client_id, client_secret]):
        print("❌ Missing required environment variables:")
        if not base_url:
            print("  - LOOKER_BASE_URL")
        if not client_id:
            print("  - LOOKER_CLIENT_ID")
        if not client_secret:
            print("  - LOOKER_CLIENT_SECRET")
        return 1

    validator = LookerValidator(base_url, client_id, client_secret)
    return validator.run()


if __name__ == "__main__":
    sys.exit(main())
