here::i_am("code/03_render_report.R")

# Call config env variable
WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config = WHICH_CONFIG
)

# Create report file name with config env variable
library(rmarkdown)
report_filename <- paste0(
  "report_config_",
  WHICH_CONFIG,
  ".html"
)

# rendering a report in production mode
render(
  "report.Rmd",
  output_file = report_filename)

