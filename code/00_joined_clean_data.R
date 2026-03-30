library(here)
library(dplyr)

here::i_am("code/00_joined_clean_data.R")

# Load both clean datasets
ana_clean <- read.csv(here("data", "derived_data", "ana_clean.csv"))
toni_clean <- read.csv(here("data", "derived_data", "toni_clean.csv"))

# Check column names match
colnames(ana_clean)
colnames(toni_clean)

# Combine into one dataset
nba_combined <- bind_rows(ana_clean, toni_clean)

# Save combined dataset for TEAM :)
write.csv(nba_combined, here("data", "derived_data", "nba_combined.csv"), row.names = FALSE)
