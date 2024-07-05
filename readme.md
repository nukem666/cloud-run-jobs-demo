# Cloud Run Jobs Demo

This repository contains a demo for running jobs on Google Cloud Run. The project demonstrates how to set up and deploy Dockerized applications, manage infrastructure with Terraform, and orchestrate workflows using either:
- Google Cloud Workflows for simple workloads
- Google Cloud Cloud Composer as a complete orchestration solution

## Repository Structure

- `app/`: Contains a batch Python application, which logs environment variables and secrets set externally.
- `cloudbuild/`: Configuration and scripts for deploying the demo components using Google Cloud Build.
- `docker/`: Contains the Dockerfile for building the Docker image of the demo application.
- `infra/`: Contains Terraform configurations for managing infrastructure.
  - `sandbox/`: Specific Terraform configurations for the sandbox environment.
- `airflow/`: Contains Airflow configurations and DAGs.
  - `dags/`: Directory for Airflow DAGs, with an example for orchestrating a Cloud Run Job.
- `workflows/`: Contains Example Workflow definition for a Google Cloud Workflows service.

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
