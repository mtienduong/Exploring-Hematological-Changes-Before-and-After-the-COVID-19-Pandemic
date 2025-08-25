# Load packages
library(tidyverse)
library(effectsize)

# Load datasets
pre_covid <- read.csv("2021-2023.csv")
dur_covid <- read.csv("2017-2020.csv")

# Calculate total white blood cell (WBC) count
pre_covid$WBC <- pre_covid$LBDLYMNO + pre_covid$LBDMONO + pre_covid$LBDNENO + pre_covid$LBDEONO + pre_covid$LBDBANO
dur_covid$WBC <- dur_covid$LBDLYMNO + dur_covid$LBDMONO + dur_covid$LBDNENO + dur_covid$LBDEONO + dur_covid$LBDBANO

# Add time period labels
pre_covid <- pre_covid %>% mutate(period = "2017-2020")
dur_covid <- dur_covid %>% mutate(period = "2021-2023")

# Select relevant columns
pre_covid <- select(pre_covid, LBXRBCSI, LBXHGB, LBXPLTSI, WBC, period)
dur_covid <- select(dur_covid, LBXRBCSI, LBXHGB, LBXPLTSI, WBC, period)

# Combine and clean data
combine_data <- bind_rows(pre_covid, dur_covid)
combine_data <- na.omit(combine_data)

# -------------------------
# Hemoglobin Analysis
# -------------------------
# Boxplot
ggplot(combine_data, aes(x = period, y = LBXHGB)) +
  geom_boxplot(fill = "#87CEEB") +
  labs(title = "Hemoglobin Levels by Time Period", x = "Time Period", y = "Hemoglobin (g/dL)") +
  theme_minimal()

# Histogram
ggplot(combine_data, aes(x = LBXHGB)) +
  geom_histogram() +
  facet_wrap(~period, ncol = 1, scales = "free") +
  labs(title = "Distribution of Hemoglobin", y = "Frequency") +
  theme_minimal()

# Variance & Welch t-test
bartlett.test(LBXHGB ~ period, data = combine_data)
t.test(LBXHGB ~ period, data = combine_data, var.equal = FALSE)

# -------------------------
# Platelet Analysis
# -------------------------
# Boxplot
ggplot(combine_data, aes(x = period, y = LBXPLTSI)) +
  geom_boxplot(fill = "#F4A582") +
  labs(title = "Platelet Count by Time Period", x = "Time Period", y = "Platelet Count (1000 cells/uL)") +
  theme_minimal()

# Histogram
ggplot(combine_data, aes(x = LBXPLTSI)) +
  geom_histogram() +
  facet_wrap(~period, ncol = 1, scales = "free") +
  labs(title = "Distribution of Platelets", y = "Frequency") +
  theme_minimal()

# Variance & t-test
bartlett.test(LBXPLTSI ~ period, data = combine_data)
t.test(LBXPLTSI ~ period, data = combine_data, var.equal = TRUE)

# Effect size
cohen.d(LBXPLTSI ~ period, data = combine_data)

# -------------------------
# WBC Analysis
# -------------------------
# Boxplot
ggplot(combine_data, aes(x = period, y = WBC)) +
  geom_boxplot(fill = "#CBAACB") +
  labs(title = "White Blood Cell Count by Time Period", x = "Time Period", y = "WBC (1000 cells/uL)") +
  theme_minimal()

# Histogram
ggplot(combine_data, aes(x = WBC)) +
  geom_histogram() +
  facet_wrap(~period, ncol = 1, scales = "free") +
  labs(title = "Distribution of WBC", y = "Frequency") +
  theme_minimal()

# Non-parametric test & effect size
bartlett.test(WBC ~ period, data = combine_data)
wilcox.test(WBC ~ period, data = combine_data, conf.int = TRUE)

# Log transformation + effect size
combine_data <- combine_data %>% mutate(log10_WBC = log10(WBC))
cohen.d(log10_WBC ~ period, data = combine_data)

# -------------------------
# RBC Analysis
# -------------------------
# Boxplot
ggplot(combine_data, aes(x = period, y = LBXRBCSI)) +
  geom_boxplot(fill = "#CBAACB") +
  labs(title = "Red Blood Cell Count by Time Period", x = "Time Period", y = "RBC (million cells/uL)") +
  theme_minimal()

# Histogram
ggplot(combine_data, aes(x = LBXRBCSI)) +
  geom_histogram() +
  facet_wrap(~period, ncol = 1, scales = "free") +
  labs(title = "Distribution of RBC", y = "Frequency") +
  theme_minimal()

# t-test & effect size
bartlett.test(LBXRBCSI ~ period, data = combine_data)
t.test(LBXRBCSI ~ period, data = combine_data, var.equal = TRUE)
cohen.d(LBXRBCSI ~ period, data = combine_data)

# -------------------------
# RBC - Discrete Category Analysis
# -------------------------
# Categorize RBC values
combine_data$RBC_dis <- cut(combine_data$LBXRBCSI,
                            breaks = c(-Inf, 4.25, 4.5, 4.75, 5, 5.25, Inf),
                            labels = c("1", "2", "3", "4", "5", "6"),
                            right = FALSE)

# Chi-square test
chisq_table_RBC <- table(combine_data$RBC_dis, combine_data$period)
chisq.test(chisq_table_RBC)
