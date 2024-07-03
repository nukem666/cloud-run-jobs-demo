GCP_PROJECT_ID=sacred-age-412000

AIRFLOW__CORE__DAGS_FOLDER=$(pwd)/dags GCP_PROJECT=$GCP_PROJECT_ID GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json" airflow standalone
