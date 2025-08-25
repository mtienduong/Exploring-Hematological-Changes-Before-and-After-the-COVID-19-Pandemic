# Exploring-Hematological-Changes-Before-and-After-the-COVID-19-Pandemic

This project analyzes potential shifts in hematologic markers in the U.S. population before and after the COVID-19 pandemic using public CDC Complete Blood Count datasets (2017–2023). The analysis was completed using R and includes exploratory data visualization, statistical testing, and effect size measurements.

---

## Method summary

### Data

- Data Source: Centers for Disease Control and Prevention (datasets are no longer available on the website)
- Time Periods:
  - **2017–2020** (pre-pandemic) — n = 8,727
  - **2021–2023** (during/post-pandemic) — n = 13,772

> Note: COVID-19 status was not included in the dataset, so analyses reflect population-level trends, not individual infection outcomes.

### Analysis Steps

1. **Data Cleaning & Preprocessing**
   - Combined CBC data for both time periods
   - Created derived variables (e.g., total White blood cells(WBC) by summing individual cell types)

2. **Visualizations**
   - Boxplots and histograms for each marker across time periods
   - QQ plots for normality check

3. **Statistical Tests**
   - Bartlett’s test for homogeneity of variance
   - T-tests (Welch or standard, based on variance)
   - Mann-Whitney U test (for WBC with unequal variance)
   - Chi-square test (for discrete RBC category comparison)

4. **Effect Size**
   - Cohen’s d used to assess the magnitude of differences

---

## Code and Files

- `hematology_analysis.Rmd`: Full R code for data loading, cleaning, visualization, and analysis.
- `2021-2023.csv` and `2017-2020.csv`: Raw datasets (not included in repo due to data availability).
- `README.md`: You’re here!

