/* THIS SCRIPT READS FROM A KINESIS STREAM THEN TRANSFORMS 
THE FIELDS userName AND userId SUCH THAT THEIR ARE OF THE FORM xxxx@domain
ONLY FIELDS NEEDED ON TABLEAU REPORT ARE KEPT IN THIS STREAM
 *\


/* INITIALIZE OUTPUT STREAM TO BE PICKUP BY FIREHOSE *\

CREATE OR REPLACE STREAM "OUT_STREAM" (
    id VARCHAR(64),
    datetime TIMESTAMP,
    country VARCHAR(16),
    username VARCHAR(32),
    anonymous VARCHAR(4),
    userId VARCHAR(64),
    queryExpression VARCHAR(64),
    c_product VARCHAR(64));

/* INITIALIZE PUMP TO FEED OUTPUT STREAM. FIELDS ARE TRANSFORMED HERE *\

CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
  INSERT INTO "OUT_STREAM" 
    SELECT STREAM 
        "COL_id" as id,
    "datetime",
    "country",
    REGEX_REPLACE("username",'.*@','xxxx@',1,0),
    "anonymous",
    REGEX_REPLACE("userId",'.*@','xxxx@',1,0),
    "queryExpression",
    "c_product"
    FROM "SOURCE_SQL_STREAM_001";
