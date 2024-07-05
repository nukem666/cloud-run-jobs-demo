# Cloud Run Jobs Demo

This repository contains a demo for running jobs on Google Cloud Run. The project demonstrates how to set up and deploy Dockerized applications, manage infrastructure with Terraform, and orchestrate workflows using either:
- Google Cloud Workflows for simple workloads
- Google Cloud Cloud Composer as a complete orchestration solution

## Repository Structure

- `app/`: Contains the main application code and Dockerfile for building the Docker image.
- `cloudbuild/`: Deployment configuration.
- `infra/`: Contains Terraform configurations for managing infrastructure.
  - `sandbox/`: Specific Terraform configurations for the sandbox environment.
- `airflow/`: Contains Airflow configurations and DAGs.
  - `dags/`: Directory for Airflow DAGs.
- `workflows/`: Contains Google Cloud Workflows configurations.
  - `cloud-run-job-workflow.yaml`: Workflow definition for orchestrating Cloud Run jobs.

## Getting Started

Assumed knowledge:
- GCP
- Terraform
- Docker
- Airflow

### Prerequisites

Pre-existing cloud infrastructure:
- GCP project
- Cloud Composer deployed
- GCS bucket for Terraform state
- Git repository

GCP APIs:
- Artifact Registry
- Cloud Build
- Secret Manager
- Cloud Run
- Workflows

Required locally:
- Google Cloud SDK

Optional local development tools:
- Docker Desktop
- Terraform
- Airflow Standalone

### Clone the Repository

```bash
git clone https://github.com/nukem666/cloud-run-jobs-demo.git
cd cloud-run-jobs-demo
```

### Configure

To set up deployment with Cloud Build:
1. Set up your own git repository.
2. Create Docker repository using `./create_docker_repo.sh` as an example--change to your own GCP Project ID.
3. Grant permissions to you Cloud Build service account, using `./grant.sh` as an example.

Update Cloud Build configuration *.yaml with:
- Git repository name
- Desired GCP region
- Existing Cloud Composer bucket
- Your Git repository URL
- Amend the Terraform init and apply steps with backend overrides  and project/region variables

Update Terraform settings:
- Set bucket config `backend.tf` for state storage
- Set your own project and region in `variables.tf` 

Make sure to commit and push those updates to your Git repositry.

### Deploy

To deploy your updated configuration using Cloud Build from your local Bash terminal:
```bash
cd cloudbuild
./submit.sh
```
