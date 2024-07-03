import os, logging, re
from datetime import timedelta
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.python_operator import PythonOperator
from airflow.providers.google.cloud.operators.cloud_run import (
    CloudRunExecuteJobOperator,
)

from google.cloud import logging as gcp_logging

dag_name = os.path.basename(__file__).split(".")[0]
gcp_project = os.environ.get("GCP_PROJECT")


def query_logs(**context):
    cloud_run_job_context = context["task_instance"].xcom_pull(task_ids="demo-job-task")
    cloud_run_job_execution = cloud_run_job_context["latest_created_execution"]
    execution_id = cloud_run_job_execution["name"]
    created = cloud_run_job_execution["create_time"]
    completed = cloud_run_job_execution["completion_time"]

    # Log filter:
    # severity="Default" - lines from Docker containers do not have a severity; ie: Default
    # labels."run.googleapis.com/execution_name" - Cloud Run Jobs execution id; eg: demo-job-fxslc
    # timestamp - use job created and completed returned from the Cloud Run Job operator
    log_filter = f'resource.type=cloud_run_job AND severity="Default" AND labels."run.googleapis.com/execution_name"={execution_id} AND timestamp>"{created}" AND timestamp<"{completed}"'
    logging.info("Querying logs with filter: %s", log_filter)
    client = gcp_logging.Client()
    client.logger(f"projects/{gcp_project}/logs/run.googleapis.com/stdout")
    entries = client.list_entries(filter_=log_filter)
    entry_count = 0

    for entry in entries:
        text_payload = entry.payload
        logging.info(text_payload)
        entry_count += 1
    
    logging.info(f"Cloud Run Job logs: {entry_count} entries")


default_args = {
    "owner": "demo",
    "provide_context": True,
}

with DAG(
    dag_id=dag_name,
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    catchup=False,
    max_active_runs=1,
    tags=["demo", "cloud-run-jobs"],
) as dag:
    demo_job_task = CloudRunExecuteJobOperator(
        task_id="demo-job-task",
        project_id=gcp_project,
        region="australia-southeast1",
        job_name="demo-job",
        deferrable=False,
    )

    query_logs_task = PythonOperator(
        task_id="query-logs-task",
        python_callable=query_logs,
        provide_context=True,
    )

    demo_job_task >> query_logs_task
