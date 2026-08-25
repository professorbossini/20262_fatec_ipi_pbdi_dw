SELECT * FROM raw.sales;

-- DROP TABLE IF EXISTS raw.sales CASCADE;
-- CREATE TABLE raw.sales(
-- 	invoice_id TEXT,
-- 	branch TEXT,
-- 	city TEXT,
-- 	customer_type TEXT,
-- 	gender TEXT,
-- 	product_line TEXT,
-- 	unit_price TEXT,
-- 	quantity TEXT,
-- 	tax_5pct TEXT,
-- 	total TEXT,
-- 	sale_date TEXT,
-- 	sale_time TEXT,
-- 	payment TEXT,
-- 	cogs TEXT,
-- 	gross_margin_percentage TEXT,
-- 	gross_income TEXT,
-- 	rating TEXT
-- );


-- CREATE SCHEMA IF NOT EXISTS raw;
-- CREATE SCHEMA IF NOT EXISTS staging;
-- CREATE SCHEMA IF NOT EXISTS dw;

-- SELECT schema_name
-- FROM information_schema.schemata;