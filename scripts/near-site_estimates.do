*********** 
//NEAR-SITE RESULTS// 
**********
*****************************************************************************
*import final dataset
clear
import excel "${data}/finaldataset" , firstrow case(lower) //
*****************************************************************************
*****************************************************************************
drop state creel_effort stayhome zoneother drive_dist year

*statewide near-site trip-related GL spending 2024
gen statespend_total = 1134394287

*STATUS QUO spending estimates
gen sq_spend = trip_s_pop_s*statespend_total

*parse out site visit probability for scenario 2
gen exputil_sq = exp(tccoefficient*tcost+meanutility)
by origin_zip, s: egen sum_exputil_sq = total(exputil_sq)
gen prob_sq = exputil_sq/sum_exputil_sq	
****************

****************
*HYPOTHETICAL 1: OIL SPILL
*gen spill probabilities
gen tcost_spil = 999999 if oiled == 1
	replace tcost_spil = tcost if oiled == 0
gen exputil = exp(tccoefficient*tcost_spil+meanutility)
by origin_zip, s: egen sum_exputil = total(exputil)
gen prob_spil = exputil/sum_exputil		

*gen norm population shares
bys origin_zip: egen zip_pop = mean(population)
	bys origin_zip: gen zip_first = (_n == 1)
egen statepop = total(zip_pop * zip_first)
gen pop_share = zip_pop / statepop
	drop zip_first
	
*gen spill (probability x population) measure
gen spill_trip_s_pop_s = prob_spil*pop_share

*SPILL spending estimates	
gen spil_spend = statespend_total*spill_trip_s_pop_s
****************
//clean-up
drop exputil exputil_sq sum_exputil_sq sum_exputil tcost_spil tcost tccoefficient meanutility
****************
*HYPOTHETICAL 2: DETROIT POPULATION INCREASE
*new populations
gen newstatepop = statepop + 100000
gen newzip_pop = zip_pop + (100000/36) if detroitzip == 1
	replace newzip_pop = zip_pop if detroitzip == 0
gen newpop_share = newzip_pop/newstatepop

*gen detroit (probability x population) measure
gen det_trip_s_pop_s = newpop_share*prob_sq
	
*get nsite $spent/person
gen spendper1person = (statespend_total)/statepop //=$560.55 per person in MI

*new spending
gen newstatespend_total = statespend_total + (100000 * 560.55)

*DETROIT spending estimates
gen det_spend = det_trip_s_pop_s*newstatespend_total

**final results
collapse oiled (sum) spil_spend det_spend sq_spend, by(creel_id site_name waterbody)
	*50% reduction for oil spill
	gen spill_reduc = (spil_spend+sq_spend)/2 
*****************************************************************************
*final export
export excel "${results}/nsite_results", firstrow(variables) replace
*****************************************************************************
