# 🏥 Healthcare Dataset — SQL & Excel Cleaning + Analysis

Cleaned and optimized a messy healthcare admissions dataset using SQL and Excel, resolving data quality issues and conducting exploratory analysis to uncover cost, diagnosis, and admission trends.

**Tools:** SQL (SQLite) · Microsoft Excel (formulas, pivot-style summaries, charts) · Python (data generation/pipeline orchestration)

---

## 📌 Overview

Starting from a raw, intentionally messy 1,245-row hospital admissions dataset (patient demographics, department, diagnosis, cost, insurance), I identified and resolved multiple real-world data quality issues, standardized the records, and ran exploratory analysis to surface cost and admission trends across departments, diagnoses, and patient demographics.

## 🧹 Data Quality Issues Found & Resolved

| Issue | Resolution |
|---|---|
| 44 exact duplicate admission records | Removed via de-duplication on patient + admission + discharge + cost |
| Inconsistent name formatting (ALL CAPS, lowercase, stray whitespace) | Standardized with `TRIM` + `PROPER` (Excel) |
| Inconsistent gender values (`M`, `Male`, `m`, `F`, `Female`, `f`) | Standardized to `M` / `F` / `Unknown` |
| 4 mixed date formats (`YYYY-MM-DD`, `DD/MM/YYYY`, `MM-DD-YYYY`, `DD Mon YYYY`) | Parsed and standardized to a single format |
| Invalid ages (`-1`, data entry errors) | Flagged, treated as missing, imputed with department median |
| Missing cost, diagnosis, and insurance values | Imputed (cost: department median) or labeled (`Not Recorded` / `Unknown`) |

**Result:** 1,245 raw rows → **1,201 clean, analysis-ready records**

## 🔍 Exploratory Data Analysis

Performed in SQL (see [`healthcare_cleaning_and_eda.sql`](./healthcare_cleaning_and_eda.sql)) and cross-validated with Excel `SUMIFS`/`COUNTIFS`/`AVERAGEIF` formulas in the workbook's Summary tab — both approaches independently returned matching numbers.

**Key findings:**
- **1,201 admissions** across 1,200 unique patients — **avg. cost: $7,777.08**, avg. length of stay: 5.9 days
- **Orthopedics** had the highest total cost ($1.47M), followed by Neurology ($1.40M)
- **Hypertension** was the most common diagnosis (88 cases), followed by Osteoarthritis (53)
- Cost was fairly consistent across insurance types ($7,600–$7,900 avg.) — no major coverage-based cost disparity
- Patients aged **41–65** had the highest average cost per admission ($8,188)

## 📁 Repo Contents

```
├── healthcare_raw.csv                       # Original messy dataset
├── healthcare_clean.csv                     # Cleaned, analysis-ready dataset
├── clean_pipeline.py                        # Full cleaning logic + audit log
├── cleaning_log.txt                         # Row-level cleaning summary
├── healthcare_cleaning_and_eda.sql           # SQL cleaning + EDA queries
├── run_eda.py                                # Runs the SQL queries, prints results
├── Healthcare_Dataset_Cleaning_Analysis.xlsx # Excel workbook: raw data, formula-driven
│                                              # cleaning sample, clean data, KPI summary + chart
└── README.md
```

## 🧠 What This Project Demonstrates

- Identifying and systematically resolving real-world data quality issues (duplicates, missing values, inconsistent formatting)
- Data transformation and standardization techniques in both SQL and Excel
- Cross-validating results between two tools to confirm analysis accuracy
- Exploratory data analysis to surface actionable healthcare cost and utilization insights
- Building formula-driven (non-hardcoded) Excel summaries that update if source data changes

---
*Author: Bamidele Yetunde — [LinkedIn](https://www.linkedin.com/in/bamidele-yetunde) · [GitHub](https://github.com/bamideleyetunde)*
