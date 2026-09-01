SELECT
  d.year,
  d.month_name,
  b.branch_code AS filial,
  b.city,
  COUNT(*) AS vendas,
  SUM(f.total)::NUMERIC(12, 2) AS receita,
  ROUND(AVG(f.total), 2) AS ticket_medio
FROM dw.fact_sales f
JOIN dw.dim_date d ON d.date_sk = f.date_sk
JOIN dw.dim_branch b ON b.branch_sk = f.branch_sk
GROUP BY d.year, d.month, d.month_name, b.branch_code, b.city
ORDER BY d.month, filial;

-- SELECT * FROM dw.fact_sales;
-- INSERT INTO dw.fact_sales(
--   invoice_nk, date_sk,
--   branch_sk, product_sk, customer_sk, payment_sk,
--   unit_price, quantity, total, tax, cogs, gross_income, rating
-- )
-- SELECT
--   s.invoice_id,
--   CAST(TO_CHAR(s.sale_ts, 'YYYYMMDD') AS INTEGER),
--   db.branch_sk,
--   dp.product_sk,
--   dc.customer_sk,
--   dpa.payment_sk,
--   s.unit_price, s.quantity, s.total,
--   s.tax_5pct, s.cogs, s.gross_income, s.rating
-- FROM staging.sales s
-- JOIN dw.dim_branch db ON db.branch_code = s.branch
-- JOIN dw.dim_product dp ON dp.product_line = s.product_line
-- JOIN dw.dim_customer dc 
-- ON dc.customer_type = s.customer_type AND dc.gender = s.gender
-- JOIN dw.dim_payment dpa ON dpa.payment_type = s.payment;

-- DROP TABLE IF EXISTS dw.fact_sales CASCADE;
-- CREATE TABLE dw.fact_sales(
--   invoice_nk VARCHAR(20) PRIMARY KEY,
--   date_sk INTEGER NOT NULL REFERENCES dw.dim_date(date_sk),
--   branch_sk INTEGER NOT NULL REFERENCES dw.dim_branch(branch_sk),
--   product_sk INTEGER NOT NULL REFERENCES dw.dim_product(product_sk),
--   customer_sk INTEGER NOT NULL REFERENCES dw.dim_customer(customer_sk),
--   payment_sk INTEGER NOT NULL REFERENCES dw.dim_payment(payment_sk),
--   unit_price NUMERIC(10, 2) NOT NULL,
--   quantity INTEGER NOT NULL,
--   total NUMERIC(10, 2) NOT NULL,
--   tax NUMERIC(10, 4) NOT NULL,
--   cogs NUMERIC(12, 2) NOT NULL,
--   gross_income NUMERIC(10, 4) NOT NULL,
--   rating NUMERIC(4, 1) NOT NULL
-- );
-- SELECT 'branch' AS dimensao, COUNT(*) AS linhas FROM dw.dim_branch
-- UNION ALL
-- SELECT 'product', COUNT(*) FROM dw.dim_product
-- UNION ALL
-- SELECT 'customer', COUNT(*) FROM dw.dim_customer
-- UNION ALL
-- SELECT 'payment', COUNT(*) FROM dw.dim_payment;
-- SELECT * FROM dw.dim_payment;
-- INSERT INTO dw.dim_payment (payment_type)
-- SELECT DISTINCT payment FROM staging.sales;
-- SELECT * FROM dw.dim_customer;
-- INSERT INTO dw.dim_customer(customer_type, gender)
-- SELECT DISTINCT customer_type, gender FROM staging.sales;

-- SELECT * FROM dw.dim_product;
-- INSERT INTO dw.dim_product(product_line)
-- SELECT DISTINCT product_line FROM staging.sales;
-- SELECT * FROM dw.dim_branch;
-- INSERT INTO dw.dim_branch(branch_code, city)
-- SELECT DISTINCT branch, city FROM staging.sales;
-- DROP TABLE IF EXISTS dw.dim_payment CASCADE;
-- CREATE TABLE dw.dim_payment(
--   payment_sk SERIAL PRIMARY KEY,
--   payment_type VARCHAR(20) NOT NULL UNIQUE
-- );

-- DROP TABLE IF EXISTS dw.dim_customer CASCADE;
-- CREATE TABLE dw.dim_customer(
--   customer_sk SERIAL PRIMARY KEY,
--   customer_type VARCHAR(10) NOT NULL,
--   gender VARCHAR(10) NOT NULL,
--   UNIQUE(customer_type, gender)
-- );

-- DROP TABLE IF EXISTS dw.dim_product CASCADE;
-- CREATE TABLE dw.dim_product(
--   product_sk SERIAL PRIMARY KEY,
--   product_line VARCHAR(40) NOT NULL UNIQUE
-- );

--; DROP TABLE IF EXISTS dw.dim_branch CASCADE;
-- CREATE TABLE dw.dim_branch(
--   branch_sk SERIAL PRIMARY KEY,
--   branch_code VARCHAR(200) NOT NULL UNIQUE,
--   city VARCHAR(40) NOT NULL
-- );

-- SELECT * FROM dw.dim_date;

-- INSERT INTO dw.dim_date
-- SELECT
--   CAST(TO_CHAR(d, 'YYYYMMDD') AS INTEGER),
--   d::DATE,
--   EXTRACT(DAY FROM d)::SMALLINT,
--   EXTRACT(MONTH FROM d)::SMALLINT,
--   TO_CHAR(d, 'TMMonth'),
--   EXTRACT(QUARTER FROM d)::SMALLINT,
--   EXTRACT(YEAR FROM d)::SMALLINT,
--   TO_CHAR(d, 'TMDay'),
--   EXTRACT(DOW FROM d) IN(0, 6) 
-- FROM generate_series(
--   DATE '2019-01-01', DATE '2019-12-31', INTERVAL '1 day'
-- )g(d);

-- DROP TABLE IF EXISTS dw.dim_date CASCADE;
-- CREATE TABLE dw.dim_date(
--   date_sk INTEGER PRIMARY KEY,
--   full_date DATE NOT NULL UNIQUE,
--   day SMALLINT NOT NULL,
--   month SMALLINT NOT NULL,
--   month_name VARCHAR(15) NOT NULL,
--   quarter SMALLINT NOT NULL,
--   year SMALLINT NOT NULL,
--   day_of_week VARCHAR(15) NOT NULL,
--   is_weekend BOOLEAN NOT NULL
-- );

-- SELECT d
--   FROM generate_series(
--     DATE '2019-01-01',
--     DATE '2019-01-05',
--     INTERVAL '1 day'
--   ) g(d);
-- SELECT * FROM generate_series(0, 100, 25);
-- SELECT * FROM generate_series(1, 5);