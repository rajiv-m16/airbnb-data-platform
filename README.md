# Airbnb Data Engineering Pipeline (dbt + Snowflake)

Welcome to the **Airbnb Snowflake Analytics** project. This repository contains a production-grade End-to-End ELT (Extract, Load, Transform) pipeline. We leverage the power of **dbt** (data build tool) and **Snowflake** to transform raw Airbnb data into clean, actionable insights using the Medallion (Bronze/Silver/Gold) architecture.

---

## 📖 Table of Contents
1. [Project Overview](#1-project-overview)
2. [The Architecture](#2-the-architecture)
3. [Tech Stack](#3-tech-stack)
4. [Project Structure](#4-project-structure)
5. [Getting Started](#5-getting-started)
6. [Key Features](#6-key-features)
7. [Running the Pipeline](#7-running-the-pipeline)

---

## 1. Project Overview
The goal of this project is to simulate a modern data warehouse environment. We ingest raw CSV data, apply rigorous cleaning and business logic, and finally model the data for BI tools or data science workflows. By using dbt, we ensure our data transformations are version-controlled, testable, and documented.

## 2. The Architecture
We follow the **Medallion Architecture** to ensure data quality and lineage:

* **🥉 Bronze (Raw Layer):** Direct ingestion from sources. Data is kept in its original form but structured into Snowflake tables.
* **🥈 Silver (Cleansed Layer):** Data is standardized. We handle nulls, cast data types, and apply initial business rules (e.g., filtering out invalid prices).
* **🥇 Gold (Curated Layer):** The "Business Layer." Here, we create **One Big Table (OBT)** and Dimensional models designed for high-performance querying and reporting.

## 3. Tech Stack
* **Data Warehouse:** [Snowflake](https://www.snowflake.com/)
* **Transformation Tool:** [dbt-core](https://www.getdbt.com/)
* **Package Manager:** [uv](https://github.com/astral-sh/uv) (for lightning-fast Python dependency management)
* **Language:** SQL & Jinja

## 4. Project Structure
```
├── macros/              # Custom Jinja macros (e.g., custom tagging, math functions)
├── models/
│   ├── bronze/          # Raw landing zone
│   ├── silver/          # Cleaned & standardized models
│   └── gold/            # Analytical & OBT models
├── snapshots/           # SCD Type 2 tracking for hosts and listings
├── tests/               # Custom data quality assertions
├── pyproject.toml       # Python environment config (uv)
└── dbt_project.yml      # Main dbt configuration




```
## 5. Getting Started
Prerequisites
A Snowflake account (Trial version works great).

Python 3.9+ installed.

uv installed (pip install uv).

Setup Instructions
Clone the Repo:

Bash

git clone [repo-url]
cd airbnb-snowflake
Install Dependencies:
We use uv to manage the environment. Run:

Bash

uv sync
Configure dbt Profile:
Create or edit your ~/.dbt/profiles.yml to include your Snowflake credentials:

YAML
airbnb_project:
  outputs:
    dev:
      type: snowflake
      account: [your_account_id]
      user: [your_user]
      password: [your_password]
      role: [your_role]
      database: AIRBNB
      warehouse: COMPUTE_WH
      schema: dev
  target: dev
## 6. Key Features
✨ Custom Macros
We use macros to keep our SQL DRY (Don't Repeat Yourself).

trimmer: Automatically cleans whitespace from string columns.

tag: Adds metadata tags to columns for easier governance.

Example: {{ multiply('price', 1.1) }} to apply a standard 10% markup across models.

🕰️ Data Snapshots
To track how Airbnb listings change over time (e.g., price changes or status updates), we use dbt Snapshots. This implements Slowly Changing Dimensions (SCD Type 2), allowing us to see the history of any record.

## 7. Running the Pipeline
Check your connection:

Bash

dbt debug

Run the entire pipeline:

Bash

dbt run

Run data quality tests:

Bash

dbt test

Generate and view documentation:

Bash

dbt docs generate

dbt docs serve
