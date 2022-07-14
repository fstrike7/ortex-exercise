-- Copy .csv values to a table named companies.
COPY companies
FROM 'C:\Users\Public\2017.csv' -- Using an absolute public path to avoid permission problems with PgAdmin.
DELIMITER ','
CSV HEADER;

-- Check that copy was successful
SELECT * FROM companies;