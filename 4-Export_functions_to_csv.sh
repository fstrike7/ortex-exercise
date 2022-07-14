# Export function results using bash commands and relative route.
# In order to run it, type "bash 4-Export_functions_to_csv.sh"
scriptDir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
\cd $scriptDir
psql -c "\copy (SELECT * from most_transactions()) TO 'most_transactions.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER)"
psql -c "\copy (SELECT * from highest_value()) TO 'highest_value.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER)"
psql -c "\copy (SELECT * from percentage_per_month()) TO 'percentage_per_month.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER)"


