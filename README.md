# Test Driven Development in Data Engineering using DBT on Postgres
## This repository contains all the related codebase for this article here: https://www.linkedin.com/pulse/test-driven-development-data-engineering-using-dbt-postgres-nabi-hfzbc


### Setup database and tables in docker desktop:

 1. First enable docker container runtime in your computer and then run the following command from the root directory of this project:
 ``` docker compose up -d```. This will spin up Postgresql db in docker and adminer client from which you can browse the table data.
 1. After that, login into Postgres using adminer client,using this credential 
    ```
        Username: postgres
        password: abc123
        host: db
        database: dev
    ```
 1. Copy all the content from `./ddl.txt` and run these command via adminer inside Postgres. All the relevant data table for this project will be created and you are good to go.

 ### Setup DBT project:

 #### There are actually two DBT project. One is under `./dbt_unit_testing` directory and the another one is under `./dbt_unit_testing_refactored`. The later one is the refactored version of the same project. Please read this article here: https://www.linkedin.com/pulse/test-driven-development-data-engineering-using-dbt-postgres-nabi-hfzbc 

 1. First setup python virtual environment by running:  ``` python3 -m venv venv```
 2. Activate python virtual environment and update PIP if needed using this:  ```python3 -m pip install --upgrade pip```. 
 3. Install all the required packages by running this command from the root directory of this project:  ```pip3 install -r requirements.txt```
 4. Get into the directory of the project and run `dbt debug` to make sure all the DB related connection is working fine.
 5. If everything setup, then you can run `dbt run` to execute all the models.
 


