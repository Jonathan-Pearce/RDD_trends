devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(ggplot2)
#read helper functions
source(file.path(getwd(),"get_gtrends_data.R"))
source(file.path(getwd(),"get_rdd_graph.R"))
#get Google Trends data
gtrends_data <- get_gtrends_data("GST tax", search_geo = "CA", search_time = "2024-10-15 2024-12-08")
#write data for future reference
write.csv(gtrends_data, "gst_tax_example.csv", row.names = FALSE)
#get regression discontinuity graph
rdd_graph <- get_rdd_graph(gtrends_data, "Tax break proposed", geo_label = "Canada",
                           disc_datetime = as.POSIXct("2024-11-21 GMT"))
plot(rdd_graph)
#save plot
ggsave("gst_tax_example.png")
