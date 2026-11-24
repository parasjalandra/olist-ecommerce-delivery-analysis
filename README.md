# Olist E-commerce Delivery Performance Analysis

## Business question
Which order and fulfilment factors are associated with delivery delay compared with the estimated delivery date?

## Dataset
Original Kaggle source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce  
The SQLite database contains the nine original source tables from the uploaded Kaggle ZIP. The source dataset covers Brazilian marketplace transactions from 2016-2018.

## Main results
- Delivered orders with usable actual and estimated dates: 96,470
- Late orders: 7,826 (8.11%)
- Delivered on or before estimate: 88,644 (91.89%)
- Mean delivery delay: -11.18 days (negative means early)
- Median delivery delay: -11.95 days
- Review score and delay correlation: -0.267
- Interaction model test R-squared: 0.0377

## Contents
- `data/olist_sqlite_database.zip`: compressed SQLite database containing all nine source tables; extract it to get `olist.sqlite` for local SQL work
- `data/processed/`: order-level analysis dataset and data dictionary
- `notebooks/`: analysis notebook
- `src/`: supporting Python script
- `sql/`: schema notes and 14 SQL queries
- `outputs/figures/`: 12 charts
- `outputs/tables/`: data quality, regression results, SQL query outputs and summaries
- `docs/`: completed report and GitHub step-by-step guide

## Reproducing the analysis
1. Install Python 3.10+ and pandas, numpy, matplotlib, scikit-learn, statsmodels and Jupyter.
2. Open `notebooks/olist_delivery_analysis.ipynb` from the project root.
3. Run cells from top to bottom. The notebook reads the prepared file in `data/processed/`.
4. Open `data/olist.sqlite` in DB Browser for SQLite or use Python sqlite3.
5. If you received only the compressed database, extract `data/olist_sqlite_database.zip` first. Then run the statements in `sql/queries.sql` against `data/olist.sqlite`.

## Limitations
The regression has low explanatory power and should not be treated as a precise delivery-time forecasting tool. The analysis is observational and shows associations, not causes. The dataset is historical (2016-2018).
