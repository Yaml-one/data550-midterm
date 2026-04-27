library(ggplot2)

nba_stats <- read.csv("data_clean/nba_combined.csv")

# 100+ minute players
nba_stats <- nba_stats[nba_stats$mins_played >= 100, ]


## COLOR SET 1

#Element 1: Box plots per position
nba_stats$position <- factor(nba_stats$position, levels = c("PG", "SG", "SF", "PF", "C"))

e1 <- ggplot(nba_stats, aes(x = position, y = pts, fill = position)) +
  geom_boxplot(outlier.shape = 21, outlier.fill = "white") +
  labs(
    title = "Points Scored per Game per 36 Minutes by Position",
    x = "Position (Pos)",
    y = "Points Scored (PTS)"
  ) +
  theme_bw() +
  theme(legend.position = "none")

ggsave("output/box_plot_1.png", plot = e1, width = 8, height = 6, dpi = 150) 


#Element 2: Scatterplot 
e2 <- ggplot(nba_stats, aes(x = age, y = mins_played)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(
    title = "Age vs. Minutes Played per 36 Minutes",
    x = "Age (Age)",
    y = "Minutes Played (MP)"
  ) +
  theme_bw()

ggsave("output/scatter_plot_2.png", plot = e2, width = 8, height = 6, dpi = 150)



#Element 3: Scatterplot
e3 <- ggplot(nba_stats, aes(x = games, y = rebounds_defensive)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "darkred") +
  labs(
    title = "Games vs. Defensive Rebounds per 36 Minutes",
    x = "Games Played (G)",
    y = "Defensive Rebounds (DRB)"
  ) +
  theme_bw()

ggsave("output/scatter_plot_3.png", plot = e3, width = 8, height = 6, dpi = 150)





## COLOR CUSTOMIZATION

# Element 2: Scatterplot (customizable color, Move color inside aes so we can
# change it later)
e2 <- ggplot(nba_stats, aes(x = age, y = mins_played, color = "trend")) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Age vs. Minutes Played per 36 Minutes",
       x = "Age (Age)",
       y = "Minutes Played (MP)") +
  theme_bw()


# Element 3: Scatterplot (Same adjustment for customizable color)
e3 <- ggplot(nba_stats, aes(x = games, y = rebounds_defensive, color = "trend")) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Games vs. Defensive Rebounds per 36 Minutes",
       x = "Games Played (G)",
       y = "Defensive Rebounds (DRB)") +
  theme_bw()


# Save as RDS objects to customize in report.Rmd
saveRDS(e1, "output/box_plot_1.rds")
saveRDS(e2, "output/scatter_plot_2.rds")
saveRDS(e3, "output/scatter_plot_3.rds")