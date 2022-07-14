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
        company_name VARCHAR,
        value_in_eur FLOAT
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
CREATE OR REPLACE FUNCTION avg_by_given_date(start_date INTEGER, end_date INTEGER)
    returns FLOAT
AS $$
BEGIN
    RETURN (SELECT AVG(transaction_count) AS average_transactions FROM
    (   
        SELECT count(transactionID) as transaction_count
        FROM companies
        WHERE tradeDate BETWEEN start_date and end_date
        AND tradeSignificance = 3
    ) Z); -- Z as an alias for the subquery but doesn't affect the result.
END; $$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION percentage_per_month()    
    returns TABLE (
        jan FLOAT,
        feb FLOAT,
        mar FLOAT,
        apr FLOAT,
        may FLOAT,
        jun FLOAT,
        jul FLOAT,
        aug FLOAT,
        sep FLOAT,
        oct FLOAT,
        nov FLOAT,
        december FLOAT
    )
AS $$
BEGIN
    RETURN QUERY SELECT
    avg_by_given_date(20170101,20170131) as January,
    avg_by_given_date(20170201,20170229) as February,
    avg_by_given_date(20170301,20170331) as March,
    avg_by_given_date(20170401,20170430) as April,
    avg_by_given_date(20170501,20170531) as May,
    avg_by_given_date(20170601,20170630) as June,
    avg_by_given_date(20170701,20170731) as July,
    avg_by_given_date(20170801,20170831) as August,
    avg_by_given_date(20170901,20170930) as September,
    avg_by_given_date(20171001,20171031) as October,
    avg_by_given_date(20171101,20171130) as November,
    avg_by_given_date(20171201,20171231) as December;
END; $$ 
LANGUAGE 'plpgsql';


-- Testing functions
SELECT * from most_transactions();
SELECT * from highest_value();
SELECT * from percentage_per_month();