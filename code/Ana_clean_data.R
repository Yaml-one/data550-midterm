library(here)
library(dplyr)
here::i_am("code/Ana_clean_data.R")

# Load data
nba_raw <- read.csv(here("data_raw", "nba_2026-02-27.csv"))

# Rename columns to match codebook
nba_raw <- nba_raw %>%
  rename(
    rank               = Rk,
    player             = Player,
    age                = Age,
    team               = Team,
    position           = Pos,
    games              = G,
    games_started      = GS,
    mins_played        = MP,
    rebounds_defensive = DRB,
    pts                = PTS
  )

# Handle players listed multiple times (keep TOT row for traded players)
nba_clean <- nba_raw %>%
  group_by(player) %>%
  filter(team == "TOT" | n() == 1) %>%
  ungroup()

# Keep only relevant columns
nba_clean <- nba_clean %>%
  select(rank, player, age, position, team, games, mins_played, rebounds_defensive, pts)

# Remove rows with any missing values and keep more than 100 minutes played
nba_clean <- nba_clean %>%
  na.omit() %>%
  filter(mins_played >= 100)

# Dynamic split - Ana gets first half
midpoint <- floor(nrow(nba_clean) / 2)
ana_clean <- nba_clean %>% slice(1:midpoint)

# Save clean dataset to merge with Toni's
write.csv(ana_clean, here("data_clean", "ana_clean.csv"), row.names = FALSE)
