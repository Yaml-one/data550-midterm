all: report/report.html

output/position_pts_anova_results.rds \
output/position_pts_summary.rds \
output/age_mins_regression_results.rds \
output/games_dreb_regression_results.rds: code/01_analysis.R data_clean/nba_combined.csv
	Rscript code/01_analysis.R

report/report.html: report/report.Rmd \
output/position_pts_anova_results.rds \
output/position_pts_summary.rds \
output/age_mins_regression_results.rds \
output/games_dreb_regression_results.rds
	Rscript -e "rmarkdown::render('report/report.Rmd', output_file = 'report.html', output_dir = 'report')"

clean:
	rm -f output/*.rds
	rm -f report/report.html