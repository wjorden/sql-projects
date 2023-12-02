# SQL Projects

A collection of SQL code used in my portfolio. Some of these are guided, some are assessments and some are curiosity driven.
SQL versions used include PostgreSQL and T-SQL. It will be some time until I come back around for MySQL which I haven't used since college.

## Notes for TSQL

To use the data, SSIS was used to import all of the CSV files into a database for use with SSMS.  

Steps included:  
    - Add databse connection  
    - Add Flat File Source loading  
    - Make new tables within SSIS  
    - Using a Foreach loop set to *Foreach File*  
    - Add function to parse file path and file extension for all files in the directory  
    - Proceed to SSMS

Within SSMS:  
    - Clean data (reformat lexicon issues using UPDATE)  
    - Create pseudo-tables using ;with CTE  
    - Perform aggregate calculations

## Notes for PostgreSQL

PgAdmin was used to create all of the tables.

### Notes for SBA

Due to the sie of the data, here is the [link](https://data.sba.gov/dataset/ppp-foia) for it. The Table of Size Standards (NAICS) CSV can be pulled from this repo or downloaded from [here](https://www.sba.gov/document/support-table-size-standards).
