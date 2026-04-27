# Load packages
library(tidyverse)
library(here)

# Step 1 - Load data
data <- read.csv(here("data_raw", "nba_2026-02-27.csv"))

# Step 2 - Rename columns
toni_data <- data %>%
  rename(
    rank               = Rk,
    player             = Player,
    position           = Pos,
    age                = Age,
    team               = Team,
    games              = G,
    mins_played        = MP,
    pts                = PTS,
    rebounds_defensive = DRB
  )

# Step 3 - Handle duplicates (keep only TOT row for players on multiple teams)
toni_data <- toni_data %>%
  group_by(player) %>%
  filter(n() == 1 | team == "TOT") %>%
  ungroup()

# Step 4 - Keep only relevant columns
toni_data <- toni_data %>%
  select(rank, player, age, position, team, games, mins_played, rebounds_defensive, pts)

# Step 5 - Fix position column (keep only first position listed)
toni_data <- toni_data %>%
  mutate(position = str_extract(position, "^[A-Z]+"))

# Step 6 - Remove rows with any missing values
toni_data <- toni_data %>% drop_na()

# Step 7 - Keep only players with at least 100 minutes played
toni_data <- toni_data %>% filter(mins_played >= 100)

# Dynamic split - Toni gets second half
midpoint <- floor(nrow(toni_data) / 2)
toni_clean <- toni_data %>% slice((midpoint + 1):nrow(toni_data))

# Step 8 - Save clean file
write.csv(toni_clean, here("data_clean", "toni_clean.csv"), row.names = FALSE)

