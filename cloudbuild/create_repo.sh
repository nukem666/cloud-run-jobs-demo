GCP_PROJECT_ID=sacred-age-412000

gcloud artifacts repositories create repo \
    --project=$GCP_PROJECT_ID \
    --repository-format=docker \
    --location=australia-southeast1 \
    --description="Docker repository"
