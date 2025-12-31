Student Performance Data Analysis

Project Overview

This repository presents a structured end-to-end data analysis of student performance, focusing on cleaning, exploration, and statistical validation of insights.

The objective is not just to analyze data, but to identify which factors genuinely matter for improving academic performance and which do not, while avoiding common analytical pitfalls such as overinterpreting averages or confusing correlation with causation.

Repository Structure

The analysis is organized into three clear stages:

1. Data Cleaning

This stage ensures the dataset is reliable and analysis-ready.

Key activities include:

Data overview and schema validation

Handling missing values

Consistency and outlier checks

Creation of a clean, final dataset

2. Exploratory Data Analysis (EDA)

This stage focuses on understanding patterns, variability, and relationships in the data.

Key analyses include:

Univariate analysis of numeric variables

Bivariate analysis (numeric vs categorical)

Categorical vs categorical structural analysis

Integrated interpretation and decision-focused insights

3. Hypothesis Testing

This stage statistically validates observations from EDA.

Key activities include:

Hypothesis formulation and test selection logic

Parametric and non-parametric tests

Categorical association tests

Effect size calculation and interpretation

The emphasis is on practical significance, not just statistical significance.

Dataset Description

The dataset includes information on:

Academic performance (overall and subject-wise scores)

Behavioral factors (study hours, attendance, study methods)

Demographic and contextual variables

All analysis respects the limitations of observational data.

Key Insights

Demographic variables show minimal influence on performance.

Behavioral factors such as attendance and study consistency align strongly with outcomes.

Structured study methods perform modestly better than unstructured approaches.

Most performance variation occurs at the individual level.

Group-based targeting is not supported by the data.

Tools & Technologies

Python

Pandas, NumPy

Matplotlib, Seaborn

SciPy, Statsmodels

Jupyter Notebook

How to Use This Repository

Start with the data_cleaning folder to understand dataset preparation.

Move to the eda folder for exploratory analysis and insights.

Review the hypothesis_testing folder for statistical validation and effect sizes.

Author

Kushagra Goyal
