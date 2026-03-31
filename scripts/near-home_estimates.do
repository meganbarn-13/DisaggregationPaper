*********** 
//NEAR-HOME RESULTS// 
**********
*****************************************************************************
*import final dataset
clear 
import excel "${data}/finaldataset.xlsx", firstrow case(lower) //
*****************************************************************************
*****************************************************************************
*obtain population #s by zipcode
by origin_zip, s: egen zip_pop = mean(population)
	bys origin_zip: gen zip_first = (_n == 1)
egen statepop = total(zip_pop * zip_first)
gen pop_share = zip_pop / statepop
	drop zip_first

*get ns $spent/person
gen nh_sq_totspend = 786908478 //statewide near-home trip-related GL spending 2024
gen nh_spendper1person = nh_sq_totspend/statepop //=$388.84 per person in MI

*add 100,000 in population to Detroit
by origin_zip, s: gen det_zip_pop = zip_pop+(100000/36) if detroitzip == 1	
	replace det_zip_pop = zip_pop if detroitzip == 0
		**divide 100,000 by the 36 detroit zip codes
		gen det_pop_share = det_zip_pop/(statepop+100000)

*gen new statewide spending number	
gen nh_det_totspend = nh_sq_totspend + (100000*nh_spendper1person)

***ESTIMATES***
*status quo 
gen h_spentperzip = nh_sq_totspend*pop_share
*immigration result
gen h_spentperzip_det = nh_det_totspend*det_pop_share
	
*final results
collapse detroit h_spentperzip h_spentperzip_det, by(origin_zip county)
*****************************************************************************
*final export
export excel "${results}/nhome_results", firstrow(variables) replace 
*****************************************************************************
