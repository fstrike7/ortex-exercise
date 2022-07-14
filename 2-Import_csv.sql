-- Copy .csv values to a table named companies.
COPY companies
FROM 'C:\Users\Public\2017.csv'
DELIMITER ','
CSV HEADER;

-- Check that copy was successful
SELECT * FROM companies;