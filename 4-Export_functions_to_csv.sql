-- Export results as .csv

COPY (SELECT * from most_transactions()) TO 'C:\Users\Public\most_transactions.csv'  WITH DELIMITER ',' CSV HEADER;
COPY (SELECT * from highest_value()) TO 'C:\Users\Public\highest_value.csv'  WITH DELIMITER ',' CSV HEADER;
COPY (SELECT * from percentage_per_month()) TO 'C:\Users\Public\percentage_per_month.csv'  WITH DELIMITER ',' CSV HEADER;
