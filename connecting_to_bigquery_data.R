install.packages("bigrquery")
# install.packages('devtools')
devtools::install_github("r-dbi/bigrquery")

#########################
#Using bigrquery package
#########################
library(bigrquery)
billing <- bq_test_project() # replace this with your project ID 
sql <- "SELECT year, month, day, weight_pounds FROM `publicdata.samples.natality`"

tb <- bq_project_query(billing, sql)
bq_table_download(tb, max_results = 10)

#########################
#Using DBI package
#########################
library(DBI)
con <- dbConnect(
  bigrquery::bigquery(),
  project = "publicdata",
  dataset = "samples",
  billing = billing
)
con 
dbListTables(con)
dbGetQuery(con, sql, n = 10)

#########################
#Using dplyr package
#########################
library(dplyr)

natality <- tbl(con, "natality")

natality %>%
  select(year, month, day, weight_pounds) %>% 
  head(10) %>%
  collect()