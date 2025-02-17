# RDD_trends
Enabling regression discontinuity experiments with [Google Trends](https://trends.google.com/trends/) data

![image](https://github.com/user-attachments/assets/17c72c2e-91c2-47b3-8769-0e567a3824b6)


## Example -  'GST tax' search in Canada
Between November 2024 and February 2025 the federal government of Canada proposed, passed and executed legislation ([Bill C-78, the Tax Break for All Canadians Act](https://www.canada.ca/en/services/taxes/child-and-family-benefits/gst-hst-holiday-tax-break.html)) making essentially all food and many holiday essentials tax-free (GST/HST) for two months from December 14, 2024 to February 15, 2025. In this example, we focus around the date this [legislation was originally proposed](https://www.canada.ca/en/department-finance/news/2024/11/more-money-in-your-pocket-a-tax-break-for-all-canadians.html) (November 21, 2024) to examine how this news impacted the search volume related to tax terms in Canada, specifically the search term 'GST tax'.

Code for replication:
```R
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(ggplot2)
#read helper functions
source(file.path(getwd(),"rdd_helpers.R"))
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
```
![image](https://github.com/user-attachments/assets/97c3ef29-b027-414b-bb6d-4400eece03c8)



## Implementation Notes
- Google trends reports search volume on a relative scale (interest over time) defined as follows; Numbers represent search interest relative to the highest point on the chart for the given region and time. A value of 100 is the peak popularity for the term. A value of 50 means that the term is half as popular. A score of 0 means there was not enough data for this term.
- Depending on the start and end points of your Google Trends query the time scale of data returned can vary (hour, day, week, etc.)
- Some queries return values of "<1" for certain times, currently we impute a value of 0.5 for these times.

## References:
### Google Trends
#### Papers
- Brodeur, Clark, Fleche and Powdthavee (2021): [COVID-19, lockdowns and well-being: Evidence from Google Trends](https://www.sciencedirect.com/science/article/pii/S0047272720302103)
- Holzl, Keusch and Sajons (2024): [The (mis)use of Google Trends data in the social sciences - A systematic review, critique, and recommendations](https://www.sciencedirect.com/science/article/pii/S0049089X24001212?via%3Dihub)
- Carneiro and Mylonakis (2009): [Google trends: a web-based tool for real-time surveillance of disease outbreaks](https://pubmed.ncbi.nlm.nih.gov/19845471/)

### RDD
#### Papers
- Cattaneo, Idrobo and Titiunik (2020): [A Practical Introduction to Regression Discontinuity Designs: Foundations](https://arxiv.org/abs/1911.09511)
- Cattaneo, Idrobo and Titiunik (2024): [A Practical Introduction to Regression Discontinuity Designs: Extensions](https://arxiv.org/abs/2301.08958)
- Hausman and Rapson (2018): [Regression Discontinuity in Time: Considerations for Empirical Applications](https://www.annualreviews.org/content/journals/10.1146/annurev-resource-121517-033306)
- Gelman and Imbens (2014): [Why High-order Polynomials Should not be Used in Regression Discontinuity Designs](https://www.nber.org/papers/w20405)

### Chapters
- Cunningham (2021): [The Mixtape, Chapter 6 - Regression Discontinuity](https://mixtape.scunning.com/06-regression_discontinuity)
- Huntington-Klein (2022): [The Effect, Chapter 20 - Regression Discontinuity](https://theeffectbook.net/ch-RegressionDiscontinuity.html)

### Code
- [RD Packages](https://rdpackages.github.io/)

## Upcoming Features:
- [x] RDD, allow user to specify discontinuity date
- [ ] RDD, Automatically calculate optimal polynomial order
- [ ] RDD, calculate CIs for discontinuity estimate
- [ ] RDD, add fuzzy RDD
- [ ] RDD, add local polynomial regression (bandwidths, kernels, etc.)
- [ ] RDD, regression kink design ([Tools of the Trade: The Regression Kink Design](https://blogs.worldbank.org/en/impactevaluations/tools-trade-regression-kink-design))
- [ ] Implement difference in differences (will require >1 time series)
- [ ] Basic time series methods (e.g. seasonality)
  - example search term: 'flu shot' 
