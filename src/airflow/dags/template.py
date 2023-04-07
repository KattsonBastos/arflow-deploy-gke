# importing libraries

## general libraries
from datetime import datetime, timedelta

## airflow libraries
from airflow.decorators import dag, task
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator


# declaring dag
default_args = {
	"owner": "Kattson Bastos",
	"retries": 1,
	"retries_delay": 0
}

@dag(
    start_date=datetime(2023,4,6),
    schedule=None,
    default_args=default_args,
    catchup=False,
    tags=['template']
)
def template_dag():
    init = DummyOperator(task_id="init")

    end = DummyOperator(task_id="end")

    init >> end


dag = template_dag()