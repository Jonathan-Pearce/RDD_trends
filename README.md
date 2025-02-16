# RDD_trends
Enabling regression discontinuity experiments with Google Trends data

![image](https://github.com/user-attachments/assets/3a4d4162-0e0f-4c00-be77-d6f921e41e7d)

## Example -  'GST tax' search in Canada
Between November 2024 and February 2025 the federal government of Canada proposed, passed and executed legislation (Bill C-78, the Tax Break for All Canadians Act) making essentially all food and many holiday essentials tax-free (GST/HST) for two months from December 14, 2024 to February 15, 2025. In this example, we focus around the date this [legislation was originally proposed](https://www.canada.ca/en/department-finance/news/2024/11/more-money-in-your-pocket-a-tax-break-for-all-canadians.html) (November 21, 2024) to examine how this news impacted the search volume related to tax terms in Canada, specifically the search term 'GST tax'.

Data for replication:

Code for replication:

![image](https://github.com/user-attachments/assets/098c245b-f65c-43db-974c-10c9f0ad9843)


## Notes
### Limitations 



## References:
### Papers
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
- RDD, add local polynomial regression (bandwidths, kernels, etc.)
- RDD, regression kink design
- Implement difference in differences (will require >1 time series)
- Basic time series methods (e.g. seasonality)
  - example search term: 'flu shot' 
