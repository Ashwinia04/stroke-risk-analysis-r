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
---

## 🔬 Analysis Workflow

The project was completed across four progressive stages:

### Week 1 — Data Cleaning & Preliminary Analysis
- Loaded and inspected the healthcare dataset
- Checked dataset structure and dimensions
- Identified and handled missing values
- Examined numerical and categorical variables
- Performed descriptive statistics
- Investigated stroke outcome distribution
- Conducted preliminary exploratory analysis

### Week 2 — Data Visualization & Insight Communication
- Created visualizations using `ggplot2`
- Examined stroke distribution
- Compared age, glucose level, BMI, hypertension, heart disease, and smoking status with stroke outcomes
- Created an age-group stroke-rate analysis
- Generated a correlation heatmap
- Interpreted visual patterns and relationships

### Week 3 — Statistical Analysis & Predictive Modeling
- Conducted distribution checks
- Performed Wilcoxon rank-sum tests
- Conducted Chi-square tests
- Built a logistic regression model
- Generated predicted stroke probabilities
- Evaluated model performance using confusion matrix metrics
- Performed classification threshold analysis
- Generated ROC curve and calculated AUC
- Conducted multicollinearity analysis using VIF
- Performed model diagnostics using Cook's Distance and deviance residuals

### Week 4 — Comprehensive Data Analysis Report
- Integrated findings from Weeks 1–3
- Consolidated statistical and visualization results
- Interpreted predictive modeling performance
- Discussed model limitations
- Presented practical analytical insights
- Documented recommendations and future improvements

  ---

## 📈 Key Statistical Findings

The dataset contained 5,110 observations.

The stroke outcome was highly imbalanced:

| Outcome | Count | Percentage |
|---|---:|---:|
| No Stroke | 4,861 | 95.13% |
| Stroke | 249 | 4.87% |

### Age

The mean age was:

- No Stroke: **41.97 years**
- Stroke: **67.73 years**

The median age was:

- No Stroke: **43 years**
- Stroke: **71 years**

A Wilcoxon rank-sum test showed a statistically significant difference in age between the two outcome groups (`p < 2.2e-16`).

### Average Glucose Level

Mean average glucose level:

- No Stroke: **104.80**
- Stroke: **132.54**

Median average glucose level:

- No Stroke: **91.47**
- Stroke: **105.22**

The Wilcoxon rank-sum test indicated a statistically significant difference between groups (`p = 3.64e-09`).

### BMI

Mean BMI:

- No Stroke: **28.80**
- Stroke: **30.09**

The Wilcoxon rank-sum test showed a statistically significant difference in BMI distributions (`p = 0.0002769`).

### Hypertension

A Chi-square test showed a statistically significant association between hypertension and stroke outcome (`p < 2.2e-16`).

### Heart Disease

A Chi-square test also showed a statistically significant association between heart disease and stroke outcome (`p < 2.2e-16`).

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
---

## 🤖 Predictive Modeling

A binary logistic regression model was developed to estimate the probability of stroke using demographic, clinical, and lifestyle variables.

### Predictors Used

The model included:

- Gender
- Age
- Hypertension
- Heart disease
- Ever married
- Work type
- Residence type
- Average glucose level
- BMI
- Smoking status

The dataset was divided into:

- **80% training data**
- **20% testing data**

The outcome variable was highly imbalanced, with stroke cases representing only approximately 4.87% of the complete dataset.

### Significant Predictors

Based on the logistic regression results:

- **Age** was statistically significant (`p < 2e-16`)
- **Average glucose level** was statistically significant (`p = 0.00161`)

The estimated odds ratio for age was approximately **1.077 per additional year**, indicating increasing predicted stroke odds with increasing age.

The estimated odds ratio for average glucose level was approximately **1.004 per unit increase**.

Other predictors did not reach statistical significance in the fitted model at the 0.05 level.

---

## 📊 Model Evaluation

Using the default classification threshold of 0.50, the model produced:

| Metric | Result |
|---|---:|
| Accuracy | 95.20% |
| Sensitivity | 0.00% |
| Specificity | 100.00% |
| Precision | Not defined |

The high accuracy was largely influenced by the strong class imbalance in the dataset. At the default 0.50 threshold, the model classified all test observations as No Stroke and therefore failed to identify stroke cases.

This demonstrates why accuracy alone is not an appropriate evaluation metric for highly imbalanced healthcare classification problems.

---

## 🎯 Classification Threshold Analysis

Different probability thresholds were evaluated to understand the trade-off between sensitivity, specificity, precision, and accuracy.

| Threshold | Accuracy | Sensitivity | Specificity | Precision |
|---:|---:|---:|---:|---:|
| 0.05 | 75.61% | 81.63% | 75.31% | 14.29% |
| 0.10 | 86.09% | 67.35% | 87.04% | 20.75% |
| 0.15 | 89.42% | 48.98% | 91.46% | 22.43% |
| 0.20 | 92.75% | 24.49% | 96.19% | 24.49% |
| 0.25 | 93.93% | 16.33% | 97.84% | 27.59% |
| 0.30 | 94.71% | 8.16% | 99.07% | 30.77% |
| 0.35 | 94.71% | 2.04% | 99.38% | 14.29% |
| 0.40 | 95.00% | 0.00% | 99.79% | 0.00% |

The threshold analysis demonstrated that reducing the classification threshold substantially increased sensitivity. At a threshold of 0.05, sensitivity increased to approximately 81.63%, compared with 0% at the default 0.50 threshold.

This illustrates the importance of selecting an appropriate decision threshold when working with imbalanced healthcare data.

---

## 📈 ROC-AUC Performance

The logistic regression model achieved:

**ROC-AUC = 0.8668**

The 95% confidence interval for the AUC was:

**0.8270 – 0.9067**

The ROC analysis indicated that the model had good overall discriminatory ability to distinguish between individuals with and without stroke based on predicted probabilities.

Using Youden's index, the best threshold identified was approximately:

**0.0364**

At this threshold:

- Sensitivity = **91.84%**
- Specificity = **69.14%**

The ROC analysis demonstrates that model evaluation should consider ranking ability and threshold selection rather than relying only on accuracy at a fixed threshold.

---

## 🔍 Model Diagnostics

Several diagnostic procedures were performed to assess the reliability of the logistic regression model.

### Multicollinearity

Variance Inflation Factor (VIF) analysis showed low levels of multicollinearity among the predictors.

The adjusted GVIF values were close to 1 for the categorical variables, while the highest value observed for age was approximately 1.23.

These results indicate that severe multicollinearity was not evident in the fitted model.

### Cook's Distance

Cook's Distance was used to identify potentially influential observations.

Using the threshold:

`4 / n`

203 observations were flagged for further investigation.

However, the maximum Cook's Distance was approximately **0.0317**, indicating that the flagged observations should be interpreted as potentially influential rather than automatically treated as problematic observations.

### Deviance Residuals

Deviance residuals were examined against fitted values to assess model behavior and identify potential patterns or unusual observations.

---

## 💡 Key Insights

The analysis identified several important patterns:

1. **Age showed the strongest statistical association with stroke outcome.** Individuals in the stroke group were substantially older on average than individuals in the no-stroke group.

2. **Average glucose level was higher among individuals with stroke**, and the difference was statistically significant.

3. **Hypertension and heart disease were significantly associated with stroke outcome** based on Chi-square tests.

4. **BMI showed a statistically significant difference between stroke groups**, although the difference in group medians was small.

5. **Class imbalance was a major modeling challenge**, with only 4.87% of observations representing stroke cases.

6. **Accuracy alone was misleading.** Although the default-threshold accuracy was 95.20%, sensitivity was 0%, meaning the model failed to identify stroke cases at the 0.50 threshold.

7. **Threshold optimization improved sensitivity.** Lowering the probability threshold allowed the model to identify substantially more positive cases.

8. **The ROC-AUC of 0.8668 indicated good discriminatory performance**, demonstrating that the model's predicted probabilities contained useful information despite the classification-threshold limitation.

   ---

## ⚠️ Limitations

- The dataset contains a strong class imbalance between stroke and non-stroke observations.
- The logistic regression model was evaluated using a single train-test split.
- The analysis does not establish causal relationships between predictors and stroke.
- Statistical significance does not necessarily imply clinical significance.
- The model should not be interpreted as a clinical diagnostic tool.
- Additional validation using external datasets would be required before considering real-world deployment.
- More advanced imbalance-handling approaches could be explored in future work.

  ---

## 🚀 Future Improvements

Future analysis could include:

- SMOTE or other class-imbalance techniques
- Stratified cross-validation
- Random Forest
- Gradient Boosting
- XGBoost
- ROC-AUC and PR-AUC comparison across models
- Hyperparameter tuning
- Calibration analysis
- Feature importance analysis
- External validation
- Interactive dashboards using Power BI or Tableau
- Model explainability using SHAP or similar techniques

  ---

## 🛠️ Technologies & Tools

- **R**
- **RStudio**
- **ggplot2**
- **pROC**
- **caret**
- **car**
- **corrplot**
- **Statistical hypothesis testing**
- **Logistic regression**
- **ROC-AUC analysis**
- **Model diagnostics**

  ## 🗂️ Project Structure

```text
stroke-risk-analysis-r/
│
├── 01_stroke_distribution.png
├── 02_age_distribution.png
├── 03_age_glucose_scatter.png
├── 04_bmi_stroke_boxplot.png
├── 05_hypertension_stroke.png
├── 07_smoking_stroke.png
├── 08_age_group_stroke_rate.png
├── 09_correlation_heatmap.png
├── 10_ROC_curve.png
├── 11_cooks_distance.png
├── 12_deviance_residuals.png
├── 13_predicted_probability_distribution.png
├── 14_threshold_performance.png
│
├── Data Cleaning
├── DATA VISUALIZATION Stroke Risk Analysis
├── stroke_cleaned.csv
│
├── Week_1_Data_Cleaning_and_Preliminary_Analysis_R.docx
├── Week_2_Data_Visualization_and_Insight_Communication_R.docx
├── Week_3_Statistical_Analysis_and_Predictive_Modeling_R.docx
├── Week_4_Comprehensive_Stroke_Risk_Analysis_R.docx
│
├── Week_3_Statistical_Analysis_and_Predictive_Modeling.R
│
└── README.md
- **Git & GitHub**

