library(here)
library(dplyr)

here::i_am("code/00_joined_clean_data.R")

# Load both clean datasets
ana_clean <- read.csv(here("data_clean", "ana_clean.csv"))
toni_clean <- read.csv(here("data_clean", "toni_clean.csv"))

# Check column names match
colnames(ana_clean)
colnames(toni_clean)

# Combine into one dataset
nba_combined <- bind_rows(ana_clean, toni_clean)

# Sanity checks for number of rows included
cat("Ana rows:", nrow(ana_clean), "\n")
cat("Toni 2 rows:", nrow(toni_clean), "\n")
cat("Combined rows:", nrow(nba_combined), "\n")
cat("Duplicate players:", sum(duplicated(nba_combined$player)), "\n")

# Save combined dataset for TEAM :)
write.csv(nba_combined, here("data_clean", "nba_combined.csv"), row.names = FALSE)
