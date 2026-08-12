# Stroke Risk Analysis Using R

## 📌 Project Overview

This project presents an end-to-end healthcare data analysis of stroke risk factors using the **Stroke Prediction Dataset**. The analysis was completed as part of a four-week data analytics internship and covers data cleaning, exploratory analysis, visualization, statistical testing, predictive modeling, and model evaluation using **R**.

The objective was to investigate demographic, clinical, and lifestyle factors associated with stroke and develop a logistic regression model to estimate stroke probability.

---

## 🎯 Project Objectives

- Clean and preprocess healthcare data using R
- Identify and handle missing values
- Perform exploratory data analysis
- Analyze relationships between demographic and clinical variables
- Create informative visualizations
- Conduct statistical hypothesis tests
- Develop a logistic regression model
- Evaluate model performance using multiple metrics
- Analyze classification thresholds
- Assess ROC-AUC performance
- Perform model diagnostics and multicollinearity checks
- Communicate findings through a comprehensive analytical report

---

## 📊 Dataset

The project uses a publicly available **Stroke Prediction Dataset** containing **5,110 observations and 12 variables**.

### Key variables

- `age` – Age of the individual
- `gender` – Gender
- `hypertension` – Presence of hypertension
- `heart_disease` – Presence of heart disease
- `ever_married` – Marital status
- `work_type` – Type of employment
- `Residence_type` – Urban or rural residence
- `avg_glucose_level` – Average glucose level
- `bmi` – Body mass index
- `smoking_status` – Smoking category
- `stroke` – Stroke outcome

The dataset contains a highly imbalanced outcome, with:

- **4,861 No Stroke observations (95.13%)**
- **249 Stroke observations (4.87%)**

---

# 🗂️ Project Structure

```text
stroke-risk-analysis-r/
│
├── Plots/
│   ├── 01_stroke_distribution.png
│   ├── 02_age_distribution.png
│   ├── 03_age_glucose_scatter.png
│   ├── 04_bmi_stroke_boxplot.png
│   ├── 05_hypertension_stroke.png
│   ├── 07_smoking_stroke.png
│   ├── 08_age_group_stroke_rate.png
│   ├── 09_correlation_heatmap.png
│   ├── 10_ROC_curve.png
│   ├── 11_cooks_distance.png
│   ├── 12_deviance_residuals.png
│   ├── 13_predicted_probability_distribution.png
│   └── 14_threshold_performance.png
│
├── stroke_cleaned.csv
│
├── Week_1_Data_Cleaning_and_Preliminary_Analysis.docx
├── Week_2_Data_Visualization_and_Insight_Communication.docx
├── Week_3_Statistical_Analysis_and_Predictive_Modeling.docx
├── Week_4_Comprehensive_Data_Analysis_Report.docx
│
└── Week_3_Statistical_Analysis_and_Predictive_Modeling.R
