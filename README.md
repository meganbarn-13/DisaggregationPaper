# DisaggregationPaper
//Shortened Abstract -
We present a framework for spatially disaggregating regional tourism expenditures by leveraging discrete choice models of travel demand. We pass expenditure data through the demand model to estimate trip-related expenditures at destinations. Applications to recreational fishing in the US Great Lakes region.

# Description
This repository contains the Stata replication code and data for disaggregating regional tourism expenditures into local estimates using a behavioral model. This project is designed to be generalizable to several disciplines, with our chosen behavioral model as one example. 

# Repository Structure
* MAIN.do : master script. Run this to execute the whole analysis and obtain full results. Lines 14-15 set the root path.

* data/ : contains the post-processed dataset
* scripts/ : contains two .do files, one for near-home estimates and one for near-site
* results/ : generated in MAIN.do to house logs and the two results files

!!Note:
Code was written in STATA 18.5, replication of this project requires STATA 15 or higher
