
drop table if exists pending_items;
CREATE TABLE pending_items (
    itemKey STRING,
    categoryId STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'stuff',
    'properties.bootstrap.servers' = '42.96.153.179:9092',
    'properties.group.id' = 'flink-info',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json' 
);
drop table if exists sink_table_pending_item;
CREATE TABLE sink_table_pending_item (
    itemKey STRING,
    categoryId STRING
) WITH (
    'connector' = 'print'
);
INSERT INTO sink_table_pending_item SELECT itemKey, categoryId FROM pending_items;
