#retrieve cleaned gtrends data
get_gtrends_data <- function(search_keyword, search_time = "now 7-d", search_geo = "CA", search_gprop = c("web")){
  #run gtrends query
  gtrends_query <- gtrends(
    keyword = search_keyword,
    geo = search_geo,
    time = search_time,
    gprop = search_gprop
  )
  
  #pull data
  gtrends_data <- gtrends_query[["interest_over_time"]]
  
  #standardize column names
  names(gtrends_data)[1] <- "datetime"
  #names(gtrends_data)[2] <- "search_volume"
  
  #impute 0.5
  gtrends_data[gtrends_data$hits == "<1", "hits"] <- "0.5"
  #convert to numeric
  gtrends_data$hits <- as.numeric(gtrends_data$hits)
  
  return(gtrends_data)
}
