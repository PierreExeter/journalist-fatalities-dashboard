# Journalist Fatalities Dashboard


This project presents a dashboard of the journalist fatalities in the world. The [data](https://data.unesco.org/explore/dataset/fej001/information/?disjunctive_nationality=&disjunctive_gender=&disjunctive_local=&disjunctive_media=&disjunctive_country_title_en=&disjunctive_staff=&disjunctive_enquiry_status=&disjunctive_date_resolution=&disjunctive.nationality&disjunctive.gender&disjunctive.local&disjunctive.media&disjunctive.country_title_en&disjunctive.staff&disjunctive.enquiry_status&disjunctive.date_resolution) is from the Unesco datahub. Their dashboard can be found [here](https://www.unesco.org/en/safety-journalists/observatory/statistics?hub=72609).


![Dashboard Overview](img/1.png)

![Fatalities by Country](img/2.png)

![Trends Over Time](img/3.png)

![Media Type Analysis](img/4.png)

![Enquiry Status Breakdown](img/5.png)


Tools:
- Dashboard : Metabase
- Database : PostgreSQL
- Container : Docker


## Install

1. Pull Metabase container

```bash
docker pull metabase/metabase:latest
```

2. Run container and connect to localhost network
```bash
docker run -d -p 3000:3000 --network host --name metabase metabase/metabase
```

3. Open in browser : [http://localhost:3000/](http://localhost:3000/)

4. Create a Metabase account.

## Import data to postgreSQL database

1. Connect to postgres with user postgres
```bash
sudo -u postgres psql
```

2. Create database
```sql
CREATE DATABASE unesco_db;
```

CTRL + D to exit postgres.

3. Create personal user
```sql
CREATE USER my-user WITH PASSWORD 'my-password';
```
4. Grant all permissions
```sql
GRANT ALL PRIVILEGES ON DATABASE unesco_db to my-user;
```

CTRL + D to exit postgres.

5. Create schema and table and import CSV data

```bash
# clone repo
git clone https://github.com/PierreExeter/journalist-fatalities-dashboard

cd journalist-fatalities-dashboard

psql -U my-user -d unesco_db -f create_journalists_table.sql
```

6. Check that the table was created properly

```bash
# Connect to database with my user name
psql -U my-user -d unesco_db
```

```sql
Set search path to schema 
SET search_path TO journalists_schema, public;

-- list tables
\dt

-- Display table
SELECT ID, "Title En", Countries, "Date", "Enquiry status" FROM journalists_schema.killed_journalists LIMIT 5;
```
CTRL + D to exit postgres.

# Connect to the postgreSQL database with Metabase

1. Check if I can connect to the database locally
```bash
psql -U my-user -d unesco_db -h localhost -p 5432
```

2. In the Metabase portal ([http://localhost:3000/](http://localhost:3000/))

- Click Add your data > Add a database : postgreSQL
- Fill in the connection details:
  - Display name : Unesco Killed Journalists
  - host : host.docker.internal (not localhost)
  - port : 5432
  - database name : unesco_db
  - username : my-user
  - password : my-password

Click Save.

## Create the questions (visualisation) and dashboard in Metabase


## Deployment on Render

See the guide at https://render.com/docs/deploy-metabase.
