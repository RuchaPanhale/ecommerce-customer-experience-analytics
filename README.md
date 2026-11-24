# mortgage-analysis
# Mortgage Credit Risk Analytics (SQL + Power BI)

🔄 **Status: In progress**

An analysis of real US mortgage performance data from the Freddie Mac
Single-Family Loan-Level Dataset. It tracks which loans become seriously
delinquent, and when, using vintage (cohort) analysis.

## Questions this project will answer

- What share of loans in each origination year become 60+ days delinquent,
  and how quickly?
- How does delinquency vary by credit score band, loan-to-value ratio and state?
- Which borrower and loan characteristics carry the highest risk?
- What would expected losses look like under different stress scenarios?

## Planned approach

- **Data:** Freddie Mac sample files (raw data is not redistributed here;
  download it from Freddie Mac after free registration)
- **Data quality:** documented cleaning rules, missing-value handling and checks
- **SQL (PostgreSQL):** vintage curves, window functions, CTEs
- **Statistics:** significance tests across risk segments
- **Excel:** expected-loss scenario model
- **Power BI:** credit risk dashboard
- **Findings memo:** key results, recommendations and limitations

## Author

Rucha Panhale · MS Computer Science, Binghamton University
