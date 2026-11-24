# Quick check of the prepared order-level analysis data.
# Full regression workflow is in notebooks/olist_delivery_analysis.ipynb.
import pandas as pd
from pathlib import Path
file = Path('data/processed/delivered_orders_analysis.csv')
df = pd.read_csv(file)
print('Rows:', len(df))
print(df[['delivery_delay_days','approval_hours','item_count','total_price','total_freight']].describe())
