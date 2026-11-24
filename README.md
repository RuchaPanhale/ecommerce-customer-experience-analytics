# E-commerce Customer Experience Analytics

**What makes online marketplace customers unhappy, and what is it costing the business?**

🔄 **Status: In progress** (started November 2026)

This project analyzes about 100,000 real orders (2016–2018) from an online marketplace to find what drives bad reviews and lost repeat customers, and to estimate the value of fixing it. It links three things most e-commerce analyses look at separately: **delivery performance → customer reviews → business impact**.

## Project status

| Step | Status |
|---|---|
| Load the raw data and profile all 9 tables | 🔄 In progress |
| Data quality report, data dictionary, metric definitions | 📋 Planned |
| Cleaning and star-schema data model (PostgreSQL) | 📋 Planned |
| Load the data model into Snowflake | 📋 Planned |
| Q1 Exploratory data analysis | 📋 Planned |
| Q2 Delivery reliability | 📋 Planned |
| Q3 Late delivery vs review scores (statistical testing) | 📋 Planned |
| Q4 Complaint reasons from review text (Claude, validated against hand labels) | 📋 Planned |
| Q5 Repeat purchases after a bad experience | 📋 Planned |
| Q6 Seller scorecard and revenue-at-risk model (Excel) | 📋 Planned |
| Power BI dashboard | 📋 Planned |
| Findings and recommendation memo | 📋 Planned |

Only items marked ✅ are finished and verified. Everything else is a plan, not a result.

## Questions this project answers

1. What does the business look like (orders, revenue, categories, regions, review scores)?
2. How reliable is delivery compared with the date promised to customers?
3. Is late delivery linked to bad reviews, and how strongly?
4. What do unhappy customers actually complain about?
5. Do customers with a bad first experience come back?
6. Which sellers and regions drive the problem, and what would fixing it be worth?

## Key findings

*Coming soon. Each finding will include a number and will be traceable to a query or notebook in this repo.*

## Tools

| Purpose | Tools |
|---|---|
| Database and SQL | PostgreSQL (Docker), DBeaver, Snowflake |
| Data cleaning and statistics | Python (pandas, SciPy, scikit-learn), Jupyter |
| Modeling and business analysis | Star schema, Excel |
| Dashboard | Power BI |
| Text classification | Claude (with human validation) |

## Repository structure

```text
scripts/      data loading
sql/          profiling, cleaning, data model, checks, analysis queries
notebooks/    profiling, statistics, review classification
claude/       complaint categories, prompt, validation results
excel/        revenue-at-risk model
docs/         data quality report, data dictionary, metric definitions, findings memo
results/      charts
```

## Data

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle: about 100,000 anonymized orders across 9 linked tables (orders, items, payments, reviews, customers, sellers, products, categories, geolocation).

The raw data is **not included** in this repo. To reproduce: download the dataset from Kaggle and place the 9 CSV files in `data/raw/`.

## How this is built

I define the questions, metrics and data decisions, and I run and verify every result. I use Claude as an AI assistant for guidance and code review, and as a tool to classify review text, with its accuracy checked against my own labels.

## Credits and license

Data © Olist, published on Kaggle under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) (non-commercial use, share-alike). This repository is a non-commercial portfolio project.

**Author:** Rucha Panhale · MS Computer Science, Binghamton University · [LinkedIn](https://www.linkedin.com/in/rucha-panhale/)
