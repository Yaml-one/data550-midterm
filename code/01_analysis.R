# sara_analysis.R
# Sara Rozengarten
# Analysis: ANOVA and linear regressions for NBA player stats

library(here)
library(tidyverse)
library(broom)

# Load clean data
nba_data <- read_csv(here("data_clean", "nba_combined.csv"))

# Create output folder if needed
dir.create(here("output"), recursive = TRUE, showWarnings = FALSE)

# -----------------------------
# 1. ANOVA: Position vs Points
# -----------------------------
# Does position influence points scored per 36 minutes?

position_pts_aov <- aov(pts ~ position, data = nba_data)
position_pts_results <- tidy(position_pts_aov)

position_pts_summary <- nba_data %>%
  group_by(position) %>%
  summarise(
    n = n(),
    mean_pts = round(mean(pts, na.rm = TRUE), 2),
    sd_pts = round(sd(pts, na.rm = TRUE), 2),
    median_pts = round(median(pts, na.rm = TRUE), 2),
    .groups = "drop"
  )

# -----------------------------
# 2. Linear Regression: Age vs Minutes Played
# -----------------------------
# Does age influence time spent on the court?

age_mins_lm <- lm(mins_played ~ age, data = nba_data)
age_mins_results <- tidy(age_mins_lm, conf.int = TRUE)

# -----------------------------
# 3. Linear Regression: Games vs Defensive Rebounds
# -----------------------------
# Is there a relationship between games played and defensive rebounds?

games_dreb_lm <- lm(rebounds_defensive ~ games, data = nba_data)
games_dreb_results <- tidy(games_dreb_lm, conf.int = TRUE)

# Save outputs directly in output/
saveRDS(position_pts_results, here("output", "position_pts_anova_results.rds"))
saveRDS(position_pts_summary, here("output", "position_pts_summary.rds"))
saveRDS(age_mins_results, here("output", "age_mins_regression_results.rds"))
saveRDS(games_dreb_results, here("output", "games_dreb_regression_results.rds"))

cat("sara_analysis.R complete — outputs saved to output/\n")
