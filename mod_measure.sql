

drop table if exists mod_measure;
CREATE TABLE mod_measure (
  id STRING,
  name STRING,
  categoryId STRING,
  propertyId STRING,
  dimensionId STRING,
  score DECIMAL(10, 2),
  weight DECIMAL(10, 2)
) WITH (
 'connector' = 'kafka',
 'topic' = 'ilife_mod_measure',
 'properties.bootstrap.servers' = '42.96.153.179:9092',
 'properties.group.id' = 'flink',
 'scan.startup.mode' = 'earliest-offset',
 'format' = 'canal-json' 
);

drop table if exists sink_table;
CREATE TABLE sink_table (
  id STRING,
  name STRING,
  categoryId STRING,
  propertyId STRING,
  dimensionId STRING,
  score DECIMAL(10, 2),
  weight DECIMAL(10, 2)
) WITH (
    'connector' = 'print'
);

INSERT INTO sink_table SELECT id, name, categoryId, propertyId,dimensionId,score,weight FROM mod_measure;

