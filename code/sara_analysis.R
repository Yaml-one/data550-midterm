#sara_analysis.R
#Sara Rozengarten
#Analysis: Table 1- ANOVA and linear regressions for NBA player stats

library(here)
library(tidyverse)
library(gtsummary)
library(broom)
library(knitr)

#Load clean data
data <- read_csv(here("data_clean", "nba_combined.csv"))

dir.create(here("output", "tables"), recursive = TRUE)

#Element 1: ANOVA - Position vs Points (pts)
#Does position influence points scored per 36 minutes?
anova_model   <- aov(pts ~ position, data = data)
anova_table   <- tidy(anova_model)
anova_summary <- data |>
  group_by(position) |>
  summarise(
    n             = n(),
    mean_pts      = round(mean(pts, na.rm = TRUE), 2),
    sd_pts        = round(sd(pts,   na.rm = TRUE), 2),
    median_pts    = round(median(pts, na.rm = TRUE), 2)
  )

#Element 2: Linear regression - Age vs Minutes Played (mins_played)
#Does age influence tme spent on the court?
lm_age_mp       <- lm(mins_played ~ age, data = data)
lm_age_mp_table <- tidy(lm_age_mp, conf.int = TRUE)

#Element 3: Linear regression - Games (games) vs Defensive Rebounds
# Is there a correlation between games played and defensive rebounds?
lm_g_drb       <- lm(rebounds_defensive ~ games, data = data)
lm_g_drb_table <- tidy(lm_g_drb, conf.int = TRUE)

#Save outputs
saveRDS(anova_table,      here("output", "tables", "anova_position_pts.rds"))
saveRDS(anova_summary,    here("output", "tables", "anova_position_pts_summary.rds"))
saveRDS(lm_age_mp_table,  here("output", "tables", "lm_age_minsplayed.rds"))
saveRDS(lm_g_drb_table,   here("output", "tables", "lm_games_drb.rds"))

cat("sara_analysis.R complete — outputs saved to output/tables/\n")