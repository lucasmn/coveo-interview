/* THIS SCRIPT SETS UP SNOWPIPE TO LISTEN FOR NOTIFICATIONS FROM AN S3 BUCKET AND INGEST RECORDS WHENEVER NEW IBJECTS ARE DROPPED INTO THE BUCKET */

create or replace stage cov_interview.public.searches_staging
url='s3://int-coveo' -- REPLACE THIS WITH A DIFFERENT BUCKET AS NEEDED
credentials = (AWS_KEY_ID = 'XXXXXXX' AWS_SECRET_KEY = 'XXXXXXXXXX'); -- REPLACE WITH ANOTHER AWS KEY AS NEEDED

create or replace table cov_interview.public.searches(
jsontext variant
);

create or replace pipe cov_interview.public.snowpipe auto_ingest=true as -- AUTO_INGEST=TRUE ACTIVATES NOTFICATION LISTENER 
    copy into cov_interview.public.searches 
    from @cov_interview.public.searches_staging 
    file_format = (type = 'JSON');

show stages;
show pipes;
