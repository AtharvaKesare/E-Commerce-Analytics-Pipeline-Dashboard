# E-Commerce Analytics Data Pipeline & Dashboard

This project is an end-to-end data engineering and analytics solution for an E-Commerce business. It uses **PostgreSQL** as the data warehouse, **dbt (Data Build Tool)** for data transformation, **Docker** for containerization, and **Power BI** for the final interactive dashboard.

## 🚀 Architecture & Tech Stack

* **Database:** PostgreSQL (Containerized)
* **Data Transformation:** dbt (Data Build Tool)
* **Containerization:** Docker & Docker Compose
* **Visualization:** Power BI

## 📂 Project Structure

* `source/`: Contains the raw source data for the E-Commerce platform.
* `dbt_project/`: Contains the dbt models, configurations, and transformations to model the raw data into analytics-ready tables.
* `E-Comm Dashboard/`: Contains the Power BI dashboard (`.pbix` file) and screenshots of the final reports.
* `docker-compose.yml`: Orchestrates the PostgreSQL database and dbt container environments.

## 📊 Dashboard Preview

![Dashboard Screenshot](E-Comm%20Dashboard/Screenshot%202026-06-17%20085853.png)

## 🛠️ Setup & Installation

1. **Clone the repository:**
   ```bash
   git clone <your-github-repo-url>
   cd E-Comm
   ```

2. **Start the environment using Docker:**
   This will spin up the PostgreSQL database and build the dbt container.
   ```bash
   docker-compose up -d
   ```

3. **Run dbt models:**
   Execute the transformations to clean and aggregate the data.
   ```bash
   docker exec -it dbt_core dbt run --project-dir /usr/app/dbt_ecomm
   ```

4. **View the Dashboard:**
   Open `E-Comm Dashboard/E-Commerce Analytics Dashboard.pbix` using Power BI Desktop and connect it to your local PostgreSQL instance (`localhost:5432`, DB: `E-Commerce`).

## 💡 Key Highlights

* Built a robust data pipeline that transforms raw e-commerce data into structured, star-schema (or analytical) models.
* Enforced data quality and consistency using dbt.
* Created a self-contained, reproducible environment using Docker.
* Designed an interactive Power BI dashboard to track key business metrics such as revenue, order volume, and customer trends.
