# E-commerce Customer Experience Analytics: Do Late Deliveries Lead to Bad Reviews?

**Do late deliveries lead to bad reviews, and what is that costing the business?**

🔄 **Status: In progress** (started November 2026)

This project analyzes about 100,000 real orders (2016–2018) from an online marketplace to measure how reliable delivery is, whether late deliveries are associated with worse review scores, and what that may cost the business. It links three things: delivery performance → customer reviews → business impact.

## Project status

| Step | Status |
|---|---|
| Load raw data and profile tables | ✅ |
| Data quality report | 🔄 In progress |
| Star schema data model (PostgreSQL to Snowflake) | 📋 Planned |
| Exploratory data analysis | 📋 Planned |
| Delivery reliability analysis | 📋 Planned |
| Late delivery vs review scores (statistical testing) | 📋 Planned |
| Excel impact model | 📋 Planned |
| Power BI dashboard | 📋 Planned |
| Findings and recommendation | 📋 Planned |

Only items marked ✅ are finished and verified. Everything else is a plan, not a result.

## Questions this project answers

1. What does the business look like (orders, order value, regions, review scores)?
2. How reliable is delivery compared with the date promised to customers?
3. Are late deliveries associated with worse review scores, and how strongly?
4. If late deliveries fell, how many bad reviews might be avoided, and how much order value is affected?

## Key findings

*Coming soon. Each finding will include a number and will be traceable to a query or notebook in this repo.*

## Tools

| Purpose | Tools |
|---|---|
| Database and SQL | PostgreSQL (Docker), DBeaver, Snowflake |
| Data analysis and statistics | Python (pandas, SciPy), Jupyter |
| Data modeling | Star schema with keys, constraints and checks |
| Business analysis | Excel |
| Dashboard | Power BI |
| Version control | Git, GitHub |

## Repository structure

```text
scripts/      data loading
sql/          profiling, staging, star schema, checks, analysis queries
notebooks/    EDA and statistics
excel/        late-delivery impact model
docs/         data quality report, metric definitions, findings memo, images
results/      charts
```

## Data

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle: about 100,000 anonymized orders. This project uses 4 of its 9 tables: orders, order items, order reviews and customers. Money values are in Brazilian reais (R$).

The raw data is **not included** in this repo. To reproduce: download the dataset from Kaggle and place the CSV files in `data/raw/`.

## How this is built

I define the questions, metrics and data decisions, and I run and verify every result. I use Claude as an AI assistant for guidance and code review.

## Credits and license

Data © Olist, published on Kaggle under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) (non-commercial use, share-alike). This repository is a non-commercial portfolio project.

**Author:** Rucha Panhale · MS Computer Science, Binghamton University · [LinkedIn](https://www.linkedin.com/in/rucha-panhale/)
