library(ggplot2)

nba_stats <- read.csv("Data/nba_combined.csv")

# 100+ minute players
nba_stats <- nba_stats[nba_stats$mins_played >= 100, ]


#Element 1: Box plots per position
nba_stats$position <- factor(nba_stats$position, levels = c("PG", "SG", "SF", "PF", "C"))

ggplot(nba_stats, aes(x = position, y = pts, fill = position)) +
  geom_boxplot(outlier.shape = 21, outlier.fill = "white") +
  labs(
    title = "Points Scored per Game per 36 Minutes by Position",
    x = "Position (Pos)",
    y = "Points Scored (PTS)"
  ) +
  theme_bw() +
  theme(legend.position = "none")


#Element 2: Scattegtrplot
ggplot(nba_stats, aes(x = age, y = mins_played)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(
    title = "Age vs. Minutes Played per 36 Minutes",
    x = "Age (Age)",
    y = "Minutes Played (MP)"
  ) +
  theme_bw()


#Element 3: Scatterplot
ggplot(nba_stats, aes(x = games, y = rebounds_defensive)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(
    title = "Games vs. Defensive Rebounds per 36 Minutes",
    x = "Games Played (G)",
    y = "Defensive Rebounds (DRB)"
  ) +
  theme_bw()
