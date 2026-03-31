********************************************************************************
* PROJECT: Disaggregating Regional Tourism Expenditures into Local Estimates Using Behavioral Models
* AUTHOR : Megan Barnhart, Loyola University Chicago
* PURPOSE: Master script to run near-home and near-site analysis
********************************************************************************

clear all
macro drop _all
set more off

*-------------------------------------------------------------------------------
* 1. SET PROJECT ROOT
*-------------------------------------------------------------------------------
global proj_root "/Users/home/Desktop/FISH/mi_dnr_report/test"

*-------------------------------------------------------------------------------
* 2. SUB-FOLDERS
*-------------------------------------------------------------------------------
global data    "${proj_root}/data"
global code    "${proj_root}/code"
global results "${proj_root}/results"

*-------------------------------------------------------------------------------
* 3. RUN ANALYSIS
*-------------------------------------------------------------------------------
do "${code}/near-home_estimates.do"
do "${code}/near-site_estimates.do"

display "All files run. Results are in ${results}"
