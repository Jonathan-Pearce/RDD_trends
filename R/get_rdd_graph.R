#retrieve cleaned gtrends data
get_rdd_graph <- function(data, rdd_label, polynomial_order = 1,
                          label_y_pos = 40, geo_label = NULL, disc_datetime = NULL){
  # data should have columns labeled "datetime", "hits", "group"

  search_keyword <- data$keyword[1]
  if(is.null(geo_label)){
    search_geo <- data$geo[1]      
  }else{
    search_geo <- geo_label
  }

  #calculate ID variable
  data$ID <- seq.int(nrow(data))
  
  #if available use user specified discontinuity date
  if(!is.null(disc_datetime)){
    rdd_threshold <- data[data$datetime==disc_datetime,]$ID
  }
  #if no discontinuity date is specified, auto select
  else{
    rdd_threshold <- data[data$hits=="100",]$ID
  }
  
  data$ID <- (data$ID - rdd_threshold)
  start_ID <- min(data$ID)
  treatment_cutoff_ID <- 0
  end_ID <- max(data$ID)
  ID_x_ticks <- c(start_ID, treatment_cutoff_ID, end_ID)
  
  #extract key dates
  start_datetime <- min(data$datetime)
  #if available use user specified discontinuity date
  if(!is.null(disc_datetime)){
    treatment_cutoff_datetime <- data[data$datetime==disc_datetime,]$datetime
  }
  #if no discontinuity date is specified, auto select
  else{
    treatment_cutoff_datetime <- data[data$hits=="100",]$datetime
  }
  
  end_datetime <- max(data$datetime)
  #build date seq for graph
  datetime_x_ticks <- c(start_datetime, treatment_cutoff_datetime, end_datetime)
  #remove seconds from datetime is present
  #if(is.POSIXct(datetime_x_ticks)){
  #  datetime_x_ticks <- as.POSIXct(format(datetime_x_ticks,format='%Y-%m-%d %H:%M'))
  #}
  
  #create group variable
  data$group <- "Treated"
  data[data$datetime < treatment_cutoff_datetime, "group"] <- "Untreated"
  cols <- c("Treated" = "red", "Untreated" = "blue")
  
  #will need logic for time_scale?
  
  #fit regression
  tx_lm <- lm(hits ~ poly(ID, polynomial_order, raw=TRUE), data = data[data$group == "Treated",])
  untx_lm <- lm(hits ~ poly(ID, polynomial_order, raw=TRUE), data = data[data$group == "Untreated",])

  #get lm predictions
  #first day of treated period
  tx_est <- head(tx_lm[["fitted.values"]], n=1)
  #last day of untreated period
  untx_est <- tail(untx_lm[["fitted.values"]], n=1)
  #calculate summary stats
  regression_discontinuity = tx_est - untx_est
  regression_discontinuity_scale = tx_est/untx_est

    
  rdd_plot <- data |>
    ggplot(aes(x = ID, y = hits, color = group)) +
    geom_point() +
    geom_smooth(method = "lm", formula = y ~ poly(x, polynomial_order, raw=TRUE)) +
    geom_vline(xintercept=c(treatment_cutoff_ID), linetype="dotted", colour="grey") +
    scale_color_manual(values=alpha(cols,0.5)) +
    scale_x_continuous(breaks = ID_x_ticks, label = datetime_x_ticks) +
    guides(color=guide_legend(override.aes=list(fill=NA))) +
    theme_classic() +
    labs(
      title = paste0("'", search_keyword, "' web search volume in ", search_geo),
      subtitle = paste0(start_datetime," to ", end_datetime),
      caption = "Data from Google Trends",
      x = "Date",
      y = "Search Volume",
      colour = "Group") +
    annotate("text", x = treatment_cutoff_ID-1, y = label_y_pos,
             label = paste0(rdd_label,"\nestimated discontinuity = ",
                            format(round(regression_discontinuity, 2), nsmall = 2)),
             hjust = 1)
  
  return(rdd_plot)

}
