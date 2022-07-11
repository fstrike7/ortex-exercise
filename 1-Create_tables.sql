CREATE TABLE IF NOT EXISTS companies(
    transactionID INTEGER PRIMARY KEY,
    gvkey INTEGER,
    companyName VARCHAR,
    companyISIN VARCHAR,
    companySEDOL VARCHAR,
    insiderID INTEGER,
    insiderName VARCHAR,
    insiderRelation VARCHAR,
    insiderLevel CHAR,
    connectionType VARCHAR,
    connectedInsiderName VARCHAR,
    connectedInsiderPosition VARCHAR,
    transactionType VARCHAR,
    transactionLabel VARCHAR,
    iid VARCHAR,
    securityISIN VARCHAR,
    securitySEDOL VARCHAR,
    securityDisplay VARCHAR,
    assetClass VARCHAR,
    shares BIGINT,
    inputdate INTEGER,
    tradedate INTEGER,
    maxTradedate INTEGER,
    price FLOAT,
    maxPrice FLOAT,
    value FLOAT,
    currency VARCHAR(3),
    valueEUR FLOAT,
    unit VARCHAR(3),
    correctedTransactionID INTEGER,
    source VARCHAR,
    tradeSignificance INTEGER,
    holdings BIGINT,
    filingURL VARCHAR,
    exchange VARCHAR
);

-- Copy .csv values to a table named companies.
COPY companies
FROM 'E:\Documentos\Codigo\ORTEX-exercise\2017.csv'
DELIMITER ','
CSV HEADER;

-- Check that copy was successful
SELECT * FROM companies;

-- Define functions

-- 1. Which are the top 3 exchange with the most transactions in the file?
CREATE OR REPLACE FUNCTION most_transactions() 
    returns TABLE (
        exchange_name VARCHAR,
        qty_transactions BIGINT
    )
AS $$
BEGIN
    RETURN QUERY SELECT exchange, count(transactionID) 
    FROM companies 
    GROUP BY exchange
    ORDER BY count(transactionID) DESC
    LIMIT 3;
END; $$
LANGUAGE 'plpgsql';

-- 2. In August 2017, which 2 companyNames had the highest combined valueEUR?
CREATE OR REPLACE FUNCTION highest_value()
    returns TABLE (
        pct_january FLOAT,
        pct_
    )
AS $$
BEGIN
    RETURN QUERY SELECT companyName, sum(valueEUR)
    FROM companies
    WHERE tradedate BETWEEN 20170801 and 20170831
    GROUP BY companyName
    ORDER BY sum(valueEUR) DESC
    LIMIT 2;
END; $$
LANGUAGE 'plpgsql';

-- 3. For 2017, only considering transactions with tradeSignificance 3, what is the percentage of transactions per month


-- Testing functions
SELECT * from most_transactions()
SELECT * from highest_value()