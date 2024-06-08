# Terraform - Multiple AWS Accounts

This repository contains a GitHub Actions workflow for managing Terraform deployments across multiple AWS accounts. The workflow allows for planning, manual approval, and applying or destroying Terraform configurations.

## Workflow: Terraform Plan, Approval, and Deploy

### Workflow Dispatch Inputs

- **action**: Specifies the action to perform (`apply` or `destroy`). Default is `apply`.
- **aws_account**: Specifies the AWS account to deploy to (`shared`, `network`, `production`, `stage`, `develop`).
- **terraform_version**: Specifies the version of Terraform to use. Default is `1.8.0`.

### Workflow Jobs

#### 1. Plan

- **Runs on**: `ubuntu-latest`
- **Permissions**: 
  - `actions: read`
  - `issues: write`
  - `id-token: write`
  - `contents: write`
- **Timeout**: 5 minutes
- **Steps**:
  - Checkout the code.
  - Configure AWS credentials based on the selected AWS account.
  - Install and run `tflint` for linting Terraform files.
  - Setup Terraform with the specified version.
  - Initialize Terraform.
  - Plan Terraform changes and save the plan.
  - Cache Terraform files.
  - Upload the Terraform plan as an artifact.

#### 2. Approval

- **Needs**: `plan`
- **Runs on**: `ubuntu-latest`
- **Permissions**: 
  - `actions: read`
  - `issues: write`
  - `id-token: write`
  - `contents: write`
- **Steps**:
  - Request manual approval from the specified approvers.

#### 3. Deploy

- **Needs**: `approval`
- **Runs on**: `ubuntu-latest`
- **Permissions**:
  - `id-token: write`
  - `contents: write`
- **Timeout**: 20 minutes
- **Steps**:
  - Checkout the code.
  - Configure AWS credentials based on the selected AWS account.
  - Setup Terraform with the specified version.
  - Download the Terraform plan artifact.
  - Move the Terraform plan.
  - Initialize Terraform.
  - Apply or destroy the Terraform plan based on the specified action.

## Usage

To trigger the workflow, go to the Actions tab in your GitHub repository, select the `Terraform - Multiple AWS Accounts` workflow, and click on `Run workflow`. Fill in the required inputs and run the workflow.

## Secrets

The following secrets need to be configured in your GitHub repository:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_ROLE_ARN_NETWORK`
- `AWS_ROLE_ARN_PROD`
- `AWS_ROLE_ARN_DEVELOP`
- `AWS_ROLE_ARN_STAGE`
- `GITHUB_TOKEN` (automatically provided by GitHub)

## Notes

- Ensure the roles specified in the AWS credentials have the necessary permissions to perform the Terraform actions.
- Modify the role ARNs and other configurations as per your AWS setup.

For more information on GitHub Actions and Terraform, refer to the [GitHub Actions documentation](https://docs.github.com/en/actions) and [Terraform documentation](https://www.terraform.io/docs).
