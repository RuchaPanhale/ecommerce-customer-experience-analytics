# load_raw.py
# Loads the 9 Olist CSV files from data/raw/ into the "raw" schema in Postgres.
# Data is loaded as-is; cleaning and type fixes happen later in sql/01_staging.sql.
# Password comes from the PGPASSWORD environment variable, never from this file.

import os
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine

# Connection to the Docker Postgres database (user analyst, port 5434, database ecommerce)
engine = create_engine(
    f"postgresql+psycopg://analyst:{os.environ['PGPASSWORD']}@localhost:5434/ecommerce"
)

# Loop over every CSV in data/raw/, in alphabetical order
for f in sorted(Path("data/raw").glob("*.csv")):
    # Turn the file name into a short table name, e.g. olist_orders_dataset -> orders
    table = f.stem.replace("olist_", "").replace("_dataset", "")

    df = pd.read_csv(f)  # read the CSV into a pandas table

    # Write it to Postgres as raw.<table>; replace it if it already exists
    df.to_sql(table, engine, schema="raw", if_exists="replace", index=False)

    print(f"raw.{table}: {len(df):,} rows")