# Getting Started - test_patient_data Looker Project

## Quick Setup Guide

### Prerequisites
- Looker instance with API access
- Google Cloud Project with BigQuery access
- GitHub repository with GitHub Actions enabled
- Looker CLI installed (optional but recommended)

### Step 1: Set Up GitHub Secrets

Navigate to your GitHub repository settings and add these secrets:

| Secret Name | Description | Example |
|---|---|---|
| `LOOKER_BASE_URL` | Your Looker instance URL | `https://looker.company.com` |
| `LOOKER_CLIENT_ID` | API key ID from Looker admin settings | `abcdef123456` |
| `LOOKER_CLIENT_SECRET` | API key secret from Looker | `xyz789...` |
| `GCP_PROJECT_ID` | Google Cloud project ID | `prj-s-dlp-dq-sandbox-0b3c` |
| `GCP_CREDENTIALS` | GCP service account JSON (entire file contents) | `{...}` |

#### How to create Looker API credentials:
1. Go to Looker Admin → Users
2. Find your user account
3. Click "Edit API Credentials"
4. Create a new API key
5. Copy the Client ID and Client Secret

#### How to create GCP service account credentials:
1. Go to Google Cloud Console
2. Navigate to "Service Accounts"
3. Create a new service account with BigQuery access
4. Create a JSON key
5. Copy the entire JSON contents into the `GCP_CREDENTIALS` secret

### Step 2: Verify Files Are Created

```bash
# Check project structure
ls -la

# Verify all views
ls -la Views/

# Verify all explores
ls -la Explores/

# Verify dashboards
ls -la LookML_Dashboards/

# Verify data tests
ls -la data_tests/

# Verify CI/CD pipeline
ls -la .github/
```

### Step 3: Push to Repository

```bash
# Add all files
git add .

# Commit changes
git commit -m "Initial LookML project setup for test_patient_data"

# Push to your branch
git push origin vs_test_branch
```

The CI/CD pipeline will automatically run and validate:
- ✅ LookML syntax validation (via Looker API)
- ✅ SQL execution validation (via BigQuery)

### Step 4: Deploy to Looker

#### Option A: Using Looker IDE
1. Open Looker
2. Navigate to the project
3. Use the "Git" menu to pull latest changes
4. Deploy when ready

#### Option B: Using Looker CLI
```bash
# Install Looker CLI (if not already installed)
npm install -g @looker/cli

# Initialize CLI with your Looker instance
looker auth login

# Deploy the project
looker project import test_patient_data
```

#### Option C: Via Git Integration
1. Set up Git integration in Looker admin settings
2. Connect your GitHub repository
3. Pull and deploy from Looker IDE

## Project Structure Quick Reference

### Views (4 Data Views)
- **inpatient_charges_2013** - Inpatient hospital charges
- **outpatient_charges_2013** - Outpatient hospital charges (with APC code extraction)
- **bikeshare_trips** - Austin bikeshare trip data
- **bikeshare_stations** - Austin bikeshare station locations

### Explores (2 Analysis Tools)
- **inpatient_outpatient** - Compare inpatient vs outpatient charges by provider
- **bikeshare_info** - Analyze bikeshare usage with station details

### Dashboards (2 Business Dashboards)
- **provider_metrics** - Healthcare provider performance dashboard
- **bikeshare_overview** - Bikeshare usage and station overview

### Data Tests (4 Quality Checks)
- Inpatient zipcode not null validation
- Outpatient services > 1000 per city validation
- Bikeshare trip station IDs not null validation (2 tests)

## Common Tasks

### Run LookML Validation Locally

```bash
# Using Looker CLI
looker project validate

# This checks for syntax errors and structure issues
```

### Test Data Access

```bash
# Using BigQuery CLI
bq ls prj-s-dlp-dq-sandbox-0b3c:EK_test_data

# View table schemas
bq show --schema prj-s-dlp-dq-sandbox-0b3c.EK_test_data.inpatient_charges_2013
```

### Create a Test Dashboard

1. Open Looker
2. Click "Create" → "Dashboard"
3. Select "inpatient_outpatient" explore
4. Build your tiles
5. Save and add to project

### Add a New Field

1. Open a view file (e.g., `Views/inpatient_charges_2013.view.lkml`)
2. Add a new dimension or measure
3. Include label and description
4. Push changes to Git
5. CI/CD pipeline validates automatically

### Modify a Join

1. Open explore file (e.g., `Explores/inpatient_outpatient.explore.lkml`)
2. Edit the join block
3. Adjust join conditions, type, or relationship
4. Test in Looker IDE
5. Push changes

## Troubleshooting

### CI/CD Pipeline Fails

1. **Check GitHub Actions logs**
   - Go to GitHub → Actions tab
   - Click the failed workflow
   - Review error messages

2. **LookML Validation Errors**
   - Check syntax in view/explore files
   - Verify field names match table columns
   - Ensure all required fields have labels

3. **SQL Validation Errors**
   - Verify BigQuery tables exist
   - Check service account has BigQuery access
   - Verify table and schema names in constants

4. **Authentication Issues**
   - Verify GitHub secrets are set correctly
   - Check Looker API credentials are active
   - Verify GCP service account has correct permissions

### Data Not Showing in Explore

1. Check the table exists in BigQuery: `bq ls prj-s-dlp-dq-sandbox-0b3c:EK_test_data`
2. Verify field names match table columns: `bq show --schema [table_name]`
3. Check join conditions in explore files
4. Run data tests to verify data quality

### Dashboard Tiles Not Working

1. Verify the explore exists and is valid
2. Check field names in dashboard query definitions
3. Ensure joins are returning data
4. Review Looker logs for SQL errors

## Best Practices

1. **Always test changes locally** before pushing
2. **Write descriptive commit messages**
3. **Keep data tests updated** as schema changes
4. **Document custom dimensions** with clear descriptions
5. **Use version control** for all changes
6. **Review CI/CD logs** regularly
7. **Monitor data test results** in Looker

## Documentation Files

- **README.md** - Comprehensive project documentation
- **IMPLEMENTATION_SUMMARY.md** - What was built and why
- **GETTING_STARTED.md** - This file
- **CLAUDE.md** - Original task specification

## Next Steps

1. ✅ Set up GitHub secrets
2. ✅ Push to repository
3. ✅ Verify CI/CD passes
4. ✅ Deploy to Looker
5. ✅ Test dashboards
6. ✅ Run data tests
7. 📋 Iterate and improve based on feedback

## Support Resources

- [Looker Documentation](https://docs.looker.com/)
- [LookML Reference](https://docs.looker.com/reference/lookml)
- [Looker API Documentation](https://docs.looker.com/api)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Questions?

Review the comprehensive documentation in README.md or check the implementation details in specific view, explore, and dashboard files.
