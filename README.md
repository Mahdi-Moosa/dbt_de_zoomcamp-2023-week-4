Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Notes on data ingestion
* Direct data ingestion from csv.gz file (google cloud to BigQuery) gave rise to errors (unicode issues/ column mismatch). 
    * Manual check shows that some files have PUlocation, others have PULocation in column header.
* Ingestion via parquet (see Week-3) seemed to work. After accounting for column header differences.
    * pickup_datetime and tropoff_datetime read as string.
    * created another table after casting casting pickup_datetime and dropoff_datetime as timestamp.