all: report_config_${WHICH_CONFIG}.html

## This command runs Ana's cleaning script
data_clean/ana_clean.csv: code/Ana_clean_data.R \
  data_raw/nba_2026-02-27.csv
	Rscript code/Ana_clean_data.R
	
## This command runs Toni's cleaning script
data_clean/toni_clean.csv: code/Toni_clean_data.R \
  data_raw/nba_2026-02-27.csv
	Rscript code/Toni_clean_data.R

## This command creates the combined clean dataset
data_clean/nba_combined.csv: code/00_joined_clean_data.R \
  data_clean/ana_clean.csv \
  data_clean/toni_clean.csv
	Rscript code/00_joined_clean_data.R
	
## This command creates the final report
report_config_${WHICH_CONFIG}.html: report.Rmd \
  output/position_pts_anova_results.rds \
  output/position_pts_summary.rds \
  output/age_mins_regression_results.rds \
  output/games_dreb_regression_results.rds \
  output/box_plot_1.png \
  output/scatter_plot_2.png \
  output/scatter_plot_3.png
	Rscript code/03_render_report.R

## This command creates the ANOVA and regression results
output/position_pts_anova_results.rds \
output/position_pts_summary.rds \
output/age_mins_regression_results.rds \
output/games_dreb_regression_results.rds &: code/01_analysis.R data_clean/nba_combined.csv
	Rscript code/01_analysis.R

## This command creates graphs
output/box_plot_1.png \
output/scatter_plot_2.png \
output/scatter_plot_3.png &: code/Shravya_graphs.R data_clean/nba_combined.csv
	Rscript code/Shravya_graphs.R

## This clean: command removes outputs
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html && rm -f data_clean/*.csv
	
## This install: command restores R package environment to that of lockfile
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"