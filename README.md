# ORTEX Exercise

Coding exercises for Data Engineer role.

## PART 1
Consists in PostgreSQL scripts and Bash scripts (to use relative paths).

- Tasks

1. Which are the top 3 exchange with the most transactions in the file?

2. In August 2017, which 2 companyNames had the highest combined valueEUR?

3. For 2017, only considering transactions with tradeSignificance 3, what is the percentage of transactions per month?

## PART 2
Python scripts to read, analyze and extract data from .csv

- Tasks

1. Which are the top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of shares per transaction?

2. Which are the top 3 currency by the total numerical value of trades in that currency?

3. What is the total number of transactions where inputdate was more than 2 weeks after tradedate?

Software used:
- PostgreSQL 13
- Python 3.8.0

In order to run the Python script:
- "cd" inside "PART 2" folder.
- Install required libraries using 
`pip install -r requirements.txt`
- Run `python main.py`
    - at the end, you'll be asked if you want to export function results as .csv files.