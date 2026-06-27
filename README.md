# 🛒 E-Commerce Analytics Data Pipeline & Dashboard

> An end-to-end ELT pipeline transforming raw e-commerce transactions into analytics-ready datasets, powered by dbt, PostgreSQL, Neon Cloud, GitHub Actions, and Power BI.

![GitHub last commit](https://img.shields.io/github/last-commit/AtharvaKesare/E-Commerce-Analytics-Pipeline-Dashboard)
![dbt](https://img.shields.io/badge/dbt-Core-orange?logo=dbt)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)
![Neon](https://img.shields.io/badge/Neon-Cloud_DB-00e599?logo=postgresql)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=github-actions)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi)

---

##  Architecture

```mermaid
flowchart LR
    A[ Python\nData Generator\nsource/generate-data.py] -->|Raw CSVs| B

    subgraph GitHub[" GitHub Actions (CI/CD)"]
        direction TB
        TEST[Automated Testing\nSpins up test DB\nRuns dbt test]
    end

    subgraph Docker[" Local Dev (Docker)"]
        direction TB
        B[ Bronze Layer\ndbt seed\nRaw Ingestion]
        B -->|Deduplication\nNull Handling| C[ Silver Layer\ndbt models\nData Quality]
        C -->|Star Schema| D[ Gold Layer\ndbt models\nAnalytics-Ready]
    end
    
    Docker -->|Pushes Code| GitHub
    GitHub -->|On Success| E

    E[( Neon Cloud\nProduction DB)]
    E -->|Live Data| F[ Power BI\nDashboard]

    style Docker fill:#1a1a2e,stroke:#2496ED,color:#fff
    style GitHub fill:#24292e,stroke:#2088FF,color:#fff
    style A fill:#306998,stroke:#FFD43B,color:#fff
    style B fill:#cd7f32,stroke:#fff,color:#fff
    style C fill:#C0C0C0,stroke:#fff,color:#000
    style D fill:#FFD700,stroke:#fff,color:#000
    style E fill:#00e599,stroke:#000,color:#000
    style F fill:#F2C811,stroke:#fff,color:#000
```

---

##  Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Data Generation** | Python | Simulates raw e-commerce data with intentional defects |
| **Ingestion (Bronze)** | dbt Seeds | Loads raw CSVs into the warehouse as-is |
| **Transformation (Silver)** | dbt + SQL | Deduplication, null-handling, type-mismatch resolution |
| **Analytics (Gold)** | dbt + SQL | Star Schema — Fact & Dimension tables for reporting |
| **Local Dev DB** | PostgreSQL 15 | Local database container for safe development |
| **Production DB** | Neon (Cloud DB) | Serverless PostgreSQL for live dashboard connectivity |
| **CI/CD Pipeline** | GitHub Actions | Automated testing of SQL transformations on every push |
| **Visualization** | Power BI | Interactive business intelligence dashboard |

---

##  Medallion Architecture

This project follows a **Bronze → Silver → Gold** Medallion Architecture to ensure data quality at every stage of the pipeline.

```
 Raw Data (CSV)
    │
    ▼
 BRONZE  →  Raw ingestion via dbt seeds. No transformations. Data stored as-is.
    │
    ▼
 SILVER  →  Data quality enforcement: deduplication, null-handling,
              type-mismatch resolution using SQL window functions.
    │
    ▼
 GOLD    →  Analytics-ready Star Schema: dim_customer, dim_product, fct_order.
              Optimized for Power BI reporting.
```

---

##  Dashboard Preview

*(Add link to published Power BI web report here)*

The Power BI dashboard surfaces:
-  **Revenue Trends** over time
-  **Product Category Performance**
-  **Country-Level Sales Distribution**
-  **Order Volume & Customer Metrics**

---

##  CI/CD Pipeline (Automated Data Engineering)

To ensure high data quality and prevent bad code from breaking the production dashboard, a **CI/CD pipeline** was built using GitHub Actions.

Every time code is pushed to the repository:
1. GitHub Actions automatically spins up an ephemeral PostgreSQL database container.
2. It installs the exact versions of `dbt-core` and `dbt-postgres` used in the project.
3. It runs the entire dbt pipeline (`dbt seed`, `dbt run`, `dbt test`) against the test database.
4. Only if all transformations succeed without errors is the code considered safe.

---

##  Key Highlights

-  **Cloud-Native Production:** Transitioned from a local-only database to a Serverless Neon PostgreSQL database, enabling live dashboard access from anywhere.
-  **Automated CI/CD:** Implemented a GitHub Actions workflow to automatically test SQL transformations on a fresh, containerized database upon every commit.
-  **Real-World Data Cleaning:** Injected intentional defects (nulls, duplicates, type mismatches) into raw CSV data using Python, then resolved them in the Silver layer using window functions.
-  **Medallion Architecture:** Cleanly separated Bronze, Silver, and Gold layers for transparency, reusability, and testability.
-  **Star Schema Design:** Modelled Gold layer data into a Star Schema (Fact + Dimension tables) for optimized analytical query performance.
-  **Live BI Integration:** Power BI dashboard directly connected to the Neon cloud database, pulling live updates dynamically.
