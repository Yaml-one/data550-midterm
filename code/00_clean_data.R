library(here)
library(dplyr)

here::i_am("data550-midterm/code/00_clean_data.R")

# Load data
nba_raw <- read.csv(here("data550-midterm", "data_raw", "nba_2026-02-27_test_extra.csv"))

# Rename columns to match codebook
nba_clean <- nba_raw %>%
  rename(
    rank = Rk,
    player = Player,
    age = Age,
    team = Team,
    position = Pos,
    games = G,
    games_started = GS,
    mins_played = MP,
    rebounds_defensive = DRB,
    pts = PTS
  ) %>%
  
  # Keep first listed position only, e.g. SG-PG -> SG
  mutate(position = sub("-.*", "", position)) %>%
  
  # Keep TOT row for traded players; if no TOT, keep the row with highest minutes
  group_by(player) %>%
  filter(team == "TOT" | mins_played == max(mins_played, na.rm = TRUE)) %>%
  slice(1) %>%
  ungroup() %>%
  
  # Keep only relevant columns
  select(rank,player, age, position, team, games, mins_played, rebounds_defensive, pts) %>%
  
  # Remove missing values and low-minute players
  filter(
    !is.na(player),
    !is.na(age),
    !is.na(position),
    !is.na(team),
    !is.na(games),
    !is.na(mins_played),
    !is.na(rebounds_defensive),
    !is.na(pts),
    mins_played >= 100
  )

# Save clean dataset
write.csv(
  nba_clean,
  here("data550-midterm", "data_clean", "tryout_clean.csv"),
  row.names = FALSE
)
