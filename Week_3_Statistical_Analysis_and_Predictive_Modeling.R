# WEEK 3: STATISTICAL ANALYSIS & PREDICTIVE MODELING
# Stroke Risk Analysis
# ============================================

# Load cleaned dataset
stroke_clean <- read.csv("Data/stroke_cleaned.csv")

# Check structure
str(stroke_clean)

# Check dimensions
dim(stroke_clean)

# Check missing values
colSums(is.na(stroke_clean))

# Summary statistics
summary(stroke_clean)

# Stroke outcome distribution
table(stroke_clean$stroke)

# Stroke percentage
prop.table(table(stroke_clean$stroke)) * 100

# ============================================
# DESCRIPTIVE STATISTICS
# ============================================

# Mean age by stroke status
aggregate(
  age ~ stroke,
  data = stroke_clean,
  FUN = mean
)

# Median age by stroke status
aggregate(
  age ~ stroke,
  data = stroke_clean,
  FUN = median
)

# Mean glucose by stroke status
aggregate(
  avg_glucose_level ~ stroke,
  data = stroke_clean,
  FUN = mean
)

# Median glucose by stroke status
aggregate(
  avg_glucose_level ~ stroke,
  data = stroke_clean,
  FUN = median
)

# Mean BMI by stroke status
aggregate(
  bmi ~ stroke,
  data = stroke_clean,
  FUN = mean
)

# Median BMI by stroke status
aggregate(
  bmi ~ stroke,
  data = stroke_clean,
  FUN = median
)

# ============================================
# DISTRIBUTION CHECKS
# ============================================

# Age distribution
hist(
  stroke_clean$age,
  main = "Distribution of Age",
  xlab = "Age"
)

# Average glucose distribution
hist(
  stroke_clean$avg_glucose_level,
  main = "Distribution of Average Glucose Level",
  xlab = "Average Glucose Level"
)

# BMI distribution
hist(
  stroke_clean$bmi,
  main = "Distribution of BMI",
  xlab = "BMI"
)

# QQ plot for age
qqnorm(stroke_clean$age)
qqline(stroke_clean$age)

# QQ plot for glucose
qqnorm(stroke_clean$avg_glucose_level)
qqline(stroke_clean$avg_glucose_level)

# QQ plot for BMI
qqnorm(stroke_clean$bmi)
qqline(stroke_clean$bmi)

# ============================================
# HYPOTHESIS TEST 1: AGE
# ============================================

age_test <- wilcox.test(
  age ~ stroke,
  data = stroke_clean
)

age_test

# ============================================
# HYPOTHESIS TEST 2: GLUCOSE
# ============================================

glucose_test <- wilcox.test(
  avg_glucose_level ~ stroke,
  data = stroke_clean
)

glucose_test

# ============================================
# HYPOTHESIS TEST 3: BMI
# ============================================

bmi_test <- wilcox.test(
  bmi ~ stroke,
  data = stroke_clean
)

bmi_test

# ============================================
# HYPOTHESIS TEST 4: HYPERTENSION
# ============================================

hypertension_table <- table(
  stroke_clean$hypertension,
  stroke_clean$stroke
)

hypertension_table

hypertension_chisq <- chisq.test(
  hypertension_table
)

hypertension_chisq

# ============================================
# HYPOTHESIS TEST 5: HEART DISEASE
# ============================================

heart_disease_table <- table(
  stroke_clean$heart_disease,
  stroke_clean$stroke
)

heart_disease_table

heart_disease_chisq <- chisq.test(
  heart_disease_table
)

heart_disease_chisq

# ============================================
# STEP 9: PREPARE DATA FOR PREDICTIVE MODELING
# ============================================

# Create a copy for modeling
stroke_model <- stroke_clean

# Convert binary categorical variables to factors
stroke_model$gender <- as.factor(stroke_model$gender)
stroke_model$hypertension <- as.factor(stroke_model$hypertension)
stroke_model$heart_disease <- as.factor(stroke_model$heart_disease)
stroke_model$ever_married <- as.factor(stroke_model$ever_married)
stroke_model$work_type <- as.factor(stroke_model$work_type)
stroke_model$Residence_type <- as.factor(stroke_model$Residence_type)
stroke_model$smoking_status <- as.factor(stroke_model$smoking_status)

# Convert stroke outcome to factor
stroke_model$stroke <- factor(
  stroke_model$stroke,
  levels = c(0, 1),
  labels = c("No_Stroke", "Stroke")
)

# Remove ID because it is an identifier, not a meaningful predictor
stroke_model$id <- NULL

# Check structure
str(stroke_model)

# Check outcome distribution
table(stroke_model$stroke)

# Check proportions
prop.table(table(stroke_model$stroke)) * 100

# ============================================
# WEEK 3: PREDICTIVE MODELING
# STEP 1: MODEL DATA CHECK
# ============================================

# Check structure
str(stroke_model)

# Check dimensions
dim(stroke_model)

# Check missing values
colSums(is.na(stroke_model))

# Check outcome distribution
table(stroke_model$stroke)

# Check outcome proportions
prop.table(table(stroke_model$stroke)) * 100

install.packages("caret")
library(caret)
set.seed(123)

train_index <- createDataPartition(
  stroke_model$stroke,
  p = 0.80,
  list = FALSE
)

stroke_train <- stroke_model[train_index, ]

stroke_test <- stroke_model[-train_index, ]

dim(stroke_train)

prop.table(table(stroke_train$stroke)) * 100
prop.table(table(stroke_test$stroke)) * 100


# ============================================
# LOGISTIC REGRESSION MODEL
# ============================================

logistic_model <- glm(
  stroke ~ gender +
    age +
    hypertension +
    heart_disease +
    ever_married +
    work_type +
    Residence_type +
    avg_glucose_level +
    bmi +
    smoking_status,
  data = stroke_train,
  family = binomial
)

summary(logistic_model)
summary(logistic_model)

summary(logistic_model)$coefficients

exp(coef(logistic_model))


exp(confint(logistic_model))

summary(logistic_model)$coefficients

# Convert logistic regression coefficients to odds ratios

odds_ratios <- exp(coef(logistic_model))

odds_ratios

# 95% confidence intervals for odds ratios

odds_ratio_ci <- exp(confint(logistic_model))

odds_ratio_ci

# Generate predicted probabilities on the test dataset

stroke_test$predicted_probability <- predict(
  logistic_model,
  newdata = stroke_test,
  type = "response"
)

head(stroke_test$predicted_probability)

summary(stroke_test$predicted_probability)

# ============================================
# MODEL EVALUATION
# ============================================

# Classify predicted probabilities using 0.5 threshold

stroke_test$predicted_class <- ifelse(
  stroke_test$predicted_probability >= 0.5,
  "Stroke",
  "No_Stroke"
)

stroke_test$predicted_class <- factor(
  stroke_test$predicted_class,
  levels = c("No_Stroke", "Stroke")
)

# Check predictions

table(stroke_test$predicted_class)

# Confusion matrix

confusion_matrix <- table(
  Actual = stroke_test$stroke,
  Predicted = stroke_test$predicted_class
)

confusion_matrix

# Extract confusion matrix values

TN <- confusion_matrix["No_Stroke", "No_Stroke"]
FP <- confusion_matrix["No_Stroke", "Stroke"]
FN <- confusion_matrix["Stroke", "No_Stroke"]
TP <- confusion_matrix["Stroke", "Stroke"]

# Calculate performance metrics

accuracy <- (TP + TN) / sum(confusion_matrix)

sensitivity <- TP / (TP + FN)

specificity <- TN / (TN + FP)

precision <- TP / (TP + FP)

accuracy
sensitivity
specificity
precision

# ============================================
# THRESHOLD ANALYSIS
# ============================================

thresholds <- c(0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40)

threshold_results <- data.frame()

for (threshold in thresholds) {
  
  predicted <- ifelse(
    stroke_test$predicted_probability >= threshold,
    "Stroke",
    "No_Stroke"
  )
  
  predicted <- factor(
    predicted,
    levels = c("No_Stroke", "Stroke")
  )
  
  cm <- table(
    Actual = stroke_test$stroke,
    Predicted = predicted
  )
  
  TN <- cm["No_Stroke", "No_Stroke"]
  FP <- cm["No_Stroke", "Stroke"]
  FN <- cm["Stroke", "No_Stroke"]
  TP <- cm["Stroke", "Stroke"]
  
  sensitivity <- ifelse(
    (TP + FN) > 0,
    TP / (TP + FN),
    0
  )
  
  specificity <- ifelse(
    (TN + FP) > 0,
    TN / (TN + FP),
    0
  )
  
  precision <- ifelse(
    (TP + FP) > 0,
    TP / (TP + FP),
    0
  )
  
  accuracy <- (TP + TN) / sum(cm)
  
  threshold_results <- rbind(
    threshold_results,
    data.frame(
      Threshold = threshold,
      Accuracy = accuracy,
      Sensitivity = sensitivity,
      Specificity = specificity,
      Precision = precision
    )
  )
}

threshold_results

# ============================================
# ROC CURVE AND AUC
# ============================================

install.packages("pROC")
library(pROC)

# Generate ROC curve

roc_curve <- roc(
  response = stroke_test$stroke,
  predictor = stroke_test$predicted_probability,
  levels = c("No_Stroke", "Stroke"),
  direction = "<"
)

# Display AUC

auc_value <- auc(roc_curve)

auc_value

# Plot ROC curve

plot(
  roc_curve,
  main = "ROC Curve - Logistic Regression Stroke Model",
  legacy.axes = TRUE
)

abline(
  a = 0,
  b = 1,
  lty = 2
)

png(
  "Plots/10_ROC_curve.png",
  width = 1000,
  height = 800
)

plot(
  roc_curve,
  main = "ROC Curve - Logistic Regression Stroke Model",
  legacy.axes = TRUE
)

abline(
  a = 0,
  b = 1,
  lty = 2
)

dev.off()

auc(roc_curve)
ci.auc(roc_curve)

coords(
  roc_curve,
  "best",
  ret = c(
    "threshold",
    "sensitivity",
    "specificity",
    "precision"
  ),
  best.method = "youden"
)

coords(
  roc_curve,
  "best",
  ret = c(
    "threshold",
    "sensitivity",
    "specificity"
  ),
  best.method = "youden"
)

install.packages("car")
library(car)

vif(logistic_model)

par(mfrow = c(1, 1))

# Cook's distance

cooks_distance <- cooks.distance(logistic_model)

summary(cooks_distance)

# Identify potentially influential observations

influential_points <- which(
  cooks_distance > 4 / nrow(stroke_train)
)

length(influential_points)

head(influential_points)

# ============================================
# MODEL DIAGNOSTICS
# Cook's Distance
# ============================================

png(
  "Plots/11_cooks_distance.png",
  width = 1000,
  height = 800
)

plot(
  cooks_distance,
  type = "h",
  main = "Cook's Distance for Logistic Regression Model",
  xlab = "Observation",
  ylab = "Cook's Distance"
)

abline(
  h = 4 / nrow(stroke_train),
  lty = 2
)

dev.off()

# ============================================
# Deviance Residuals
# ============================================

deviance_residuals <- residuals(
  logistic_model,
  type = "deviance"
)

png(
  "Plots/12_deviance_residuals.png",
  width = 1000,
  height = 800
)

plot(
  fitted(logistic_model),
  deviance_residuals,
  main = "Deviance Residuals vs Fitted Values",
  xlab = "Fitted Values",
  ylab = "Deviance Residuals"
)

abline(
  h = 0,
  lty = 2
)

dev.off()

# ============================================
# Predicted Probability Distribution
# ============================================

png(
  "Plots/13_predicted_probability_distribution.png",
  width = 1000,
  height = 800
)

hist(
  stroke_test$predicted_probability,
  breaks = 30,
  main = "Distribution of Predicted Stroke Probabilities",
  xlab = "Predicted Probability of Stroke"
)

abline(
  v = 0.5,
  lty = 2
)

dev.off()

# ============================================
# Threshold Performance Analysis
# ============================================

png(
  "Plots/14_threshold_performance.png",
  width = 1000,
  height = 800
)

plot(
  threshold_results$Threshold,
  threshold_results$Sensitivity,
  type = "b",
  ylim = c(0, 1),
  xlab = "Classification Threshold",
  ylab = "Metric Value",
  main = "Model Performance Across Classification Thresholds"
)

lines(
  threshold_results$Threshold,
  threshold_results$Specificity,
  type = "b"
)

lines(
  threshold_results$Threshold,
  threshold_results$Accuracy,
  type = "b"
)

legend(
  "bottomright",
  legend = c(
    "Sensitivity",
    "Specificity",
    "Accuracy"
  ),
  lty = 1,
  pch = 1
)

dev.off()

# ============================================
# WEEK 3: FINAL RESULTS SUMMARY
# ============================================

cat("============================================\n")
cat("WEEK 3 FINAL MODEL RESULTS\n")
cat("============================================\n\n")

cat("Dataset size:\n")
print(dim(stroke_model))

cat("\nOutcome distribution:\n")
print(table(stroke_model$stroke))

cat("\nOutcome percentage:\n")
print(prop.table(table(stroke_model$stroke)) * 100)

cat("\n--------------------------------------------\n")
cat("HYPOTHESIS TESTS\n")
cat("--------------------------------------------\n")

cat("\nAge Wilcoxon test:\n")
print(age_test)

cat("\nGlucose Wilcoxon test:\n")
print(glucose_test)

cat("\nBMI Wilcoxon test:\n")
print(bmi_test)

cat("\nHypertension Chi-square test:\n")
print(hypertension_chisq)

cat("\nHeart Disease Chi-square test:\n")
print(heart_disease_chisq)

cat("\n--------------------------------------------\n")
cat("LOGISTIC REGRESSION\n")
cat("--------------------------------------------\n")

print(summary(logistic_model))

cat("\nOdds Ratios:\n")
print(odds_ratios)

cat("\n95% Confidence Intervals:\n")
print(odds_ratio_ci)

cat("\n--------------------------------------------\n")
cat("MODEL PERFORMANCE - THRESHOLD 0.5\n")
cat("--------------------------------------------\n")

cat("Accuracy:", accuracy, "\n")
cat("Sensitivity:", sensitivity, "\n")
cat("Specificity:", specificity, "\n")
cat("Precision:", precision, "\n")

cat("\n--------------------------------------------\n")
cat("THRESHOLD ANALYSIS\n")
cat("--------------------------------------------\n")

print(threshold_results)

cat("\n--------------------------------------------\n")
cat("ROC / AUC\n")
cat("--------------------------------------------\n")

cat("AUC:\n")
print(auc_value)

cat("\n95% CI for AUC:\n")
print(ci.auc(roc_curve))

cat("\nOptimal Youden threshold:\n")
print(
  coords(
    roc_curve,
    "best",
    ret = c(
      "threshold",
      "sensitivity",
      "specificity",
      "precision"
    ),
    best.method = "youden"
  )
)

cat("\n--------------------------------------------\n")
cat("VIF\n")
cat("--------------------------------------------\n")

print(vif(logistic_model))

cat("\n--------------------------------------------\n")
cat("COOK'S DISTANCE\n")
cat("--------------------------------------------\n")

print(summary(cooks_distance))

cat("\nNumber of potentially influential observations:\n")
print(length(influential_points))

cat("\n============================================\n")
cat("END OF RESULTS\n")
cat("============================================\n")
