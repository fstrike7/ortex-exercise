# Alternative to 2-Import_csv.sql to copy .csv using bash script and relative route.
# In order to run it, type "bash 2-Import_csv.sh"
scriptDir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
\cd $scriptDir
psql -c "\copy companies FROM '2017.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER)"