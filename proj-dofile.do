*Joshua Markwell & Devin Hayes

clear all
cd "U:\IND Study\Test Scores (XSL)"
capture log close
set logtype text
set more off


log using "ind_study", replace
***************************************************************************
use "2010"


drop if SchoolName=="DISTRICT RESULTS"
drop if S=="X"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(S)
collapse satisfy, by(SchoolName)
gen year="2010"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2010_coll", replace

***************************************************************************
use "2011"


drop if SchoolName=="DISTRICT RESULTS"
drop if ProfAdv=="X"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(ProfAdv)
collapse satisfy, by(SchoolName)
gen year="2011"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2011_coll", replace
*************************************************************************
use "2012"


drop if SchoolName=="DISTRICT RESULTS"
drop if ProficientandAdvanced=="--"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(ProficientandAdvanced)
collapse satisfy, by(SchoolName)
gen year="2012"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2012_coll", replace
************************************************************************
use "2013"


drop if SchoolName=="DISTRICT RESULTS"
drop if ProficientandAdvanced=="--"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(ProficientandAdvanced)
collapse satisfy, by(SchoolName)
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2013_coll", replace
************************************************************************
use "2014"


drop if SchoolName=="DISTRICT RESULTS"
drop if ProficientandAdvanced=="--"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(ProficientandAdvanced)
collapse satisfy, by(SchoolName)
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2014_coll", replace
***********************************************************************
use "2015"


drop if SCHOOLNAME=="ALL SCHOOLS"
rename SCHOOLNAME SchoolName
drop if METOREXCEEDEDEXPECTATI=="*"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(METOREXCEEDEDEXPECTATI)
collapse satisfy, by(SchoolName)
gen year="2015"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2015_coll", replace
**********************************************************************
use "2016"

drop if SchoolName=="All Schools"
drop if X=="*"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(X)
collapse satisfy, by(SchoolName)
gen year="2016"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2016_coll", replace
**********************************************************************
use "2017"


drop if SchoolName=="All Schools"
drop if X=="*"
*dropped schools with x's (indicates no usable test score results)
gen satisfy=real(X)
collapse satisfy, by(SchoolName)
gen year="2017"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Updated Scores\2017_coll", replace
**********************************************************************
*Appending Test Score Data
cd "U:\IND Study\Test Scores (XSL)\Updated Scores"

use "2010_coll", clear
append using "2011_coll"
append using "2012_coll"
append using "2013_coll"
append using "2014_coll"
append using "2015_coll"
append using "2016_coll"
append using "2017_coll"
save "U:\IND Study\Test Scores (XSL)\Updated Scores\appended_data", replace

****************************************************************************
*Finding total number of students

*Gifted Status--------------------------
cd "U:\IND Study\Test Scores (XSL)\Gifted Status"
use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
rename TotalN10 total
collapse (sum) total, by (SchoolName)
gen year="2010"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2010_coll", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalCount)
collapse (sum) total, by (SchoolName)
gen year="2011"
drop if missing(SchoolName)
*tab SchoolName
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2011_coll", replace


use "2012"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2012"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2012_coll", replace

use "2013"
drop if SchoolName=="DISTRICT RESULTS"
*dropped schools with x's (indicates no usable test score results)
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2013_coll", replace


use "2014"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2014_coll", replace

use "2015"
drop if SCHOOLNAME=="ALL SCHOOLS"
rename SCHOOLNAME SchoolName
gen total=real(OFVALIDSCORES)
collapse (sum) total, by(SchoolName)
gen year="2015"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2015_coll", replace

use "2016"
drop if SCHOOLNAME=="All Schools"
rename SCHOOLNAME SchoolName
gen total=real(OFVALIDSCORES)
collapse (sum) total, by(SchoolName)
gen year="2016"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2016_coll", replace


use "2017"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2017"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2017_coll", replace


use "2010_coll", clear
append using "2011_coll"
append using "2012_coll"
append using "2013_coll"
append using "2014_coll"
append using "2015_coll"
append using "2016_coll"
append using "2017_coll"
save "U:\IND Study\Test Scores (XSL)\Gifted Status\appended_gifted", replace

*Gifted Status_____________________________________
*cd "U:\IND Study\Test Scores (XSL)\Gifted Status"
*****************************************************************************
*****************************************************************************
*****************************************************************************
*Finding Percent gifted for each year

use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen gifted=1 if GiftedTalented=="Mathematics Gifted" 
replace gifted=1 if GiftedTalented=="Both Language Arts & Mathematics Gifted" 
replace gifted=1 if GiftedTalented=="Other Gifted" 
replace gifted=1 if GiftedTalented=="Language Arts Gifted"
replace gifted=0 if GiftedTalented=="No, Not Gifted"
sort SchoolName
by SchoolName: egen gifted_tot=sum(TotalN10) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(TotalN10) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2010"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2010_per_gifted", replace



use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen gifted=1 if GiftedTalented=="Mathematics Gifted" 
replace gifted=1 if GiftedTalented=="Both Language Arts & Mathematics Gifted" 
replace gifted=1 if GiftedTalented=="Other Gifted" 
replace gifted=1 if GiftedTalented=="Language Arts Gifted"
replace gifted=0 if GiftedTalented=="No, Not Gifted"
gen total=real(TotalCount)
sort SchoolName
by SchoolName: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2011"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2011_per_gifted", replace

use "2012.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen gifted=1 if Group=="Mathematics" 
replace gifted=1 if Group=="Language Arts and Mathematics" 
replace gifted=1 if Group=="Other " 
replace gifted=1 if Group=="Language Arts"
replace gifted=0 if Group=="Not Gifted"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2012"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2012_per_gifted", replace

use "2013.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen gifted=1 if Group=="Mathematics Gifted"
replace gifted=1 if Group=="Both Language Arts and Mathematics Gifted"
replace gifted=1 if Group=="Language Arts Gifted"
replace gifted=1 if Group=="Other Gifted"
replace gifted=0 if Group=="Not Gifted"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2013"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2013_per_gifted", replace


use "2014.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen gifted=1 if Group=="Mathematics Gifted"
replace gifted=1 if Group=="Both Language Arts and Mathematics Gifted"
replace gifted=1 if Group=="Language Arts Gifted"
replace gifted=1 if Group=="Other Gifted"
replace gifted=0 if Group=="Not Gifted"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2014"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2014_per_gifted", replace

use "2015.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen gifted=1 if GROUP=="Gifted    "
replace gifted=0 if GROUP=="Non-Gifted"
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SCHOOLNAME
by SCHOOLNAME: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SCHOOLNAME)
gen year="2015"
drop if missing(SCHOOLNAME)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
rename SCHOOLNAME SchoolName
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2015_per_gifted", replace

use "2016.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen gifted=1 if GROUP=="Gifted    "
replace gifted=0 if GROUP=="Non-Gifted"
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SCHOOLNAME
by SCHOOLNAME: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SCHOOLNAME)
gen year="2016"
drop if missing(SCHOOLNAME)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
rename SCHOOLNAME SchoolName
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2016_per_gifted", replace

use "2017.dta"
drop if SchoolName=="All Schools"
gen gifted=1 if GiftedandTalented=="Gifted and Telented"
replace gifted=0 if GiftedandTalented=="Not Gifted and Talented"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen gifted_tot=sum(total) if gifted==1
gen not_gifted=1 if gifted==0
sort SchoolName
by SchoolName: egen not_gifted_tot=sum(total) if not_gifted==1
collapse gifted_tot not_gifted_tot, by (SchoolName)
gen year="2017"
drop if missing(SchoolName)
gen total=gifted_tot + not_gifted_tot
gen percent_gifted=gifted_tot/total
save "U:\IND Study\Test Scores (XSL)\Gifted Status\2017_per_gifted", replace


use "2010_per_gifted", clear
append using "2011_per_gifted"
append using "2012_per_gifted"
append using "2013_per_gifted"
append using "2014_per_gifted"
append using "2015_per_gifted"
append using "2016_per_gifted"
append using "2017_per_gifted"
save "U:\IND Study\Test Scores (XSL)\Appended Demographics\gifted", replace



*sum gifted values are not specified below 16 within partcular group.
	*EX: Abraham lincoln HS has <16 'other gifted' students in 10th grade



*****************************************************************************

*Lunch Status--------------------------
cd "U:\IND Study\Test Scores (XSL)\Lunch"
use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
rename TotalN10 total
collapse (sum) total, by (SchoolName)
gen year="2010"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Lunch\2010_coll", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalCount)
collapse (sum) total, by (SchoolName)
gen year="2011"
drop if missing(SchoolName)
*tab SchoolName
save "U:\IND Study\Test Scores (XSL)\Lunch\2011_coll", replace


use "2012"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2012"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Lunch\2012_coll", replace

use "2013"
drop if SchoolName=="DISTRICT RESULTS"
*dropped schools with x's (indicates no usable test score results)
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Lunch\2013_coll", replace


use "2014"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Lunch\2014_coll", replace

use "2015"
drop if SCHOOLNAME=="ALL SCHOOLS"
rename SCHOOLNAME SchoolName
gen total=real(OFVALIDSCORES)
collapse (sum) total, by(SchoolName)
gen year="2015"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Lunch\2015_coll", replace

use "2016"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2016"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Lunch\2016_coll", replace


use "2017"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2017"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Lunch\2017_coll", replace


use "2010_coll", clear
append using "2011_coll"
append using "2012_coll"
append using "2013_coll"
append using "2014_coll"
append using "2015_coll"
append using "2016_coll"
append using "2017_coll"
save "U:\IND Study\Test Scores (XSL)\Lunch\appended_lunch", replace

*Finding Percent eligible for lunch program for each year
use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen lunchpro=1 if FreeorReducedLunch=="Free Lunch Eligible"
replace lunchpro=1 if FreeorReducedLunch=="Reduced Lunch Eligible"
replace lunchpro=0 if FreeorReducedLunch=="Not Eligible"
*gen total=real(TotalN10)
*TotalN10 is already destrung
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(TotalN10) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(TotalN10) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) TotalN10, by (SchoolName)

gen percent_lunchpro=lunchpro_tot/TotalN10
rename TotalN10 total
gen year="2010"
save "U:\IND Study\Test Scores (XSL)\Lunch\2010_per_lunch", replace

use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen lunchpro=1 if FreeorReducedLunch=="Free Lunch Eligible"
replace lunchpro=1 if FreeorReducedLunch=="Reduced Lunch Eligible"
replace lunchpro=0 if FreeorReducedLunch=="Not Eligible"
gen total=real(TotalCount)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2011"
save "U:\IND Study\Test Scores (XSL)\Lunch\2011_per_lunch", replace


use "2012.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen lunchpro=1 if Group=="Free Lunch Eligible"
replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if Group=="Not Eligible"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2012"
save "U:\IND Study\Test Scores (XSL)\Lunch\2012_per_lunch", replace
*has the <16 problem like gifted status

use "2013.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen lunchpro=1 if Group=="Free Lunch Eligible"
replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if Group=="Not Eligible"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Lunch\2013_per_lunch", replace

use "2014.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen lunchpro=1 if Group=="Free Lunch Eligible"
replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if Group=="Not Eligible"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Lunch\2014_per_lunch", replace

use "2015.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen lunchpro=1 if GROUP=="Free/Reduced Lunch Eligible   "
*replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if GROUP=="Non-Free/Reduced Lunch Eligible"
*gen total_count=real(TotalTested)
*gen unsat_count=real(nUnsatisfactory)
*replace unsat_count=0 if unsat_count==.
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SCHOOLNAME
by SCHOOLNAME: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SCHOOLNAME)
drop if missing(SCHOOLNAME)

gen percent_lunchpro=lunchpro_tot/total
rename SCHOOLNAME SchoolName
gen year="2015"
save "U:\IND Study\Test Scores (XSL)\Lunch\2015_per_lunch", replace

use "2016.dta"
drop if SchoolName=="All Schools"
gen lunchpro=1 if FreeandReducedLunch=="Free/Reduced Lunch Eligible"
*replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if FreeandReducedLunch=="Not Free/Reduced Lunch Eligible"
*gen total_count=real(TotalTested)
*gen unsat_count=real(nUnsatisfactory)
*replace unsat_count=0 if unsat_count==.
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2016"
save "U:\IND Study\Test Scores (XSL)\Lunch\2016_per_lunch", replace


use "2017.dta"
drop if SchoolName=="All Schools"
gen lunchpro=1 if FreeandReducedLunch=="Free/Reduced Lunch Eligible"
*replace lunchpro=1 if Group=="Reduced Lunch Eligible"
replace lunchpro=0 if FreeandReducedLunch=="Not Free/Reduced Lunch Eligible"
*gen total_count=real(TotalTested)
*gen unsat_count=real(nUnsatisfactory)
*replace unsat_count=0 if unsat_count==.
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen lunchpro_tot=sum(total) if lunchpro==1
gen no_lunch=1 if lunchpro==0
replace no_lunch=0 if lunchpro==1
sort SchoolName
by SchoolName: egen no_lunch_tot=sum(total) if no_lunch==1
collapse lunchpro_tot no_lunch_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_lunchpro=lunchpro_tot/total
gen year="2017"
save "U:\IND Study\Test Scores (XSL)\Lunch\2017_per_lunch", replace

use "2010_per_lunch", clear
append using "2011_per_lunch"
append using "2012_per_lunch"
append using "2013_per_lunch"
append using "2014_per_lunch"
append using "2015_per_lunch"
append using "2016_per_lunch"
append using "2017_per_lunch"
save "U:\IND Study\Test Scores (XSL)\Appended Demographics\lunch", replace

***************************************************************************
*Migrant Status--------------------------

cd "U:\IND Study\Test Scores (XSL)\Migrant"
use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
rename TotalN10 total
collapse (sum) total, by (SchoolName)
gen year="2010"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Migrant\2010_coll", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalCount)
collapse (sum) total, by (SchoolName)
gen year="2011"
drop if missing(SchoolName)
*tab SchoolName
save "U:\IND Study\Test Scores (XSL)\Migrant\2011_coll", replace


use "2012"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2012"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Migrant\2012_coll", replace

use "2013"
drop if SchoolName=="DISTRICT RESULTS"
*dropped schools with x's (indicates no usable test score results)
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Migrant\2013_coll", replace


use "2014"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Migrant\2014_coll", replace

use "2015"
drop if SCHOOLNAME=="ALL SCHOOLS"
rename SCHOOLNAME SchoolName
gen total=real(OFVALIDSCORES)
collapse (sum) total, by(SchoolName)
gen year="2015"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Migrant\2015_coll", replace

use "2016"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2016"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Migrant\2016_coll", replace


use "2017"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2017"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Migrant\2017_coll", replace


use "2010_coll", clear
append using "2011_coll"
append using "2012_coll"
append using "2013_coll"
append using "2014_coll"
append using "2015_coll"
append using "2016_coll"
append using "2017_coll"
save "U:\IND Study\Test Scores (XSL)\Migrant\appended_migrant", replace

*Finding Percent of migrant status for each year

use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen mig_im=1 if MigrantorImmigrant=="Migrant"
replace mig_im=1 if MigrantorImmigrant=="Immigrant"
replace mig_im=0 if MigrantorImmigrant=="Neither"
*gen total=real(TotalN10)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(TotalN10) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(TotalN10) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) TotalN10, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/TotalN10
rename TotalN10 total
gen year="2010"
save "U:\IND Study\Test Scores (XSL)\Migrant\2010_per_migrant", replace

use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen mig_im=1 if MigrantorImmigrant=="Migrant"
replace mig_im=1 if MigrantorImmigrant=="Immigrant"
replace mig_im=0 if MigrantorImmigrant=="Neither"
gen total=real(TotalCount)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2011"
save "U:\IND Study\Test Scores (XSL)\Migrant\2011_per_migrant", replace

use "2012.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen mig_im=1 if Group=="Migrant"
replace mig_im=1 if Group=="Immigrant"
replace mig_im=0 if Group=="Neither Immigrant nor Migrant"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2012"
save "U:\IND Study\Test Scores (XSL)\Migrant\2012_per_migrant", replace

use "2013.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen mig_im=1 if Group=="Migrant Only"
replace mig_im=1 if Group=="Immigrant Only"
replace mig_im=0 if Group=="Neither Migrant nor Immigrant"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Migrant\2013_per_migrant", replace

use "2014.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen mig_im=1 if Group=="Migrant Only"
replace mig_im=1 if Group=="Immigrant Only"
replace mig_im=0 if Group=="Neither Migrant nor Immigrant"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Migrant\2014_per_migrant", replace

use "2015.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen mig_im=1 if GROUP=="Migrant    "
*replace mig_im=1 if Group=="Immigrant Only"
replace mig_im=0 if GROUP=="Non-Migrant"
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SCHOOLNAME
by SCHOOLNAME: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SCHOOLNAME)
drop if missing(SCHOOLNAME)

gen percent_mig_im=mig_im_tot/total
rename SCHOOLNAME SchoolName
gen year="2015"
save "U:\IND Study\Test Scores (XSL)\Migrant\2015_per_migrant", replace
*All values for this year were 0


use "2016.dta"
drop if SchoolName=="All Schools"
gen mig_im=1 if Migrant=="Migrant"
*replace mig_im=1 if Group=="Immigrant Only"
replace mig_im=0 if Migrant=="Not Migrant"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2016"
save "U:\IND Study\Test Scores (XSL)\Migrant\2016_per_migrant", replace
*All values for this year were 0.

use "2017.dta"
drop if SchoolName=="All Schools"
gen mig_im=1 if Migrant=="Migrant"
*replace mig_im=1 if Group=="Immigrant Only"
replace mig_im=0 if Migrant=="Not Migrant"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen mig_im_tot=sum(total) if mig_im==1
gen no_mig_im=1 if mig_im==0
replace no_mig_im=0 if mig_im==1
sort SchoolName
by SchoolName: egen no_mig_im_tot=sum(total) if no_mig_im==1
collapse mig_im_tot no_mig_im_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_mig_im=mig_im_tot/total
gen year="2017"
save "U:\IND Study\Test Scores (XSL)\Migrant\2017_per_migrant", replace


use "2010_per_migrant", clear
append using "2011_per_migrant"
append using "2012_per_migrant"
append using "2013_per_migrant"
append using "2014_per_migrant"
append using "2015_per_migrant"
append using "2016_per_migrant"
append using "2017_per_migrant"
save "U:\IND Study\Test Scores (XSL)\Appended Demographics\migrant", replace



**************************************************************************
*Race--------------------------

cd "U:\IND Study\Test Scores (XSL)\Race"
use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
rename TotalN10 total
collapse (sum) total, by (SchoolName)
gen year="2010"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Race\2010_coll", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalCount)
collapse (sum) total, by (SchoolName)
gen year="2011"
drop if missing(SchoolName)
*tab SchoolName
save "U:\IND Study\Test Scores (XSL)\Race\2011_coll", replace


use "2012"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2012"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Race\2012_coll", replace

use "2013"
drop if SchoolName=="DISTRICT RESULTS"
*dropped schools with x's (indicates no usable test score results)
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Race\2013_coll", replace


use "2014"
drop if SchoolName=="DISTRICT RESULTS"
gen total=real(TotalTested)
collapse (sum) total, by(SchoolName)
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Race\2014_coll", replace

use "2015"
drop if SCHOOLNAME=="ALL SCHOOLS"
rename SCHOOLNAME SchoolName
gen total=real(OFVALIDSCORES)
collapse (sum) total, by(SchoolName)
gen year="2015"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Race\2015_coll", replace

use "2016"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2016"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Race\2016_coll", replace


use "2017"
drop if SchoolName=="All Schools"
gen total=real(ofTotalRecords)
collapse (sum) total, by(SchoolName)
gen year="2017"
drop if missing(SchoolName)
save "U:\IND Study\Test Scores (XSL)\Race\2017_coll", replace


use "2010_coll", clear
append using "2011_coll"
append using "2012_coll"
append using "2013_coll"
append using "2014_coll"
append using "2015_coll"
append using "2016_coll"
append using "2017_coll"
save "U:\IND Study\Test Scores (XSL)\Race\appended_race", replace

*Finding Percent of race each year

use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen other=1 if Ethnicity=="American Indian or Alaskan Native"
replace other=1 if Ethnicity=="Asian or Pacific Islander"
*replace other=0 if Ethnicity~="American Indian or Alaskan Native"
*replace other=0 if Ethnicity~="Asian or Pacific Islander"
*gen total=real(TotalN10)
*rename TotalN10 total
sort SchoolName
by SchoolName: egen other_tot=sum(TotalN10) if other==1

gen white=1 if Ethnicity=="White (not Hispanic)"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(TotalN10) if white==1

gen black=1 if Ethnicity=="Black (not Hispanic)"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(TotalN10) if black==1

gen hispanic=1 if Ethnicity=="Hispanic"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(TotalN10) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) TotalN10, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/TotalN10
gen percent_white=white_tot/TotalN10
gen percent_black=black_tot/TotalN10
gen percent_hispanic=hispanic_tot/TotalN10
rename TotalN10 total
gen year="2010"
save "U:\IND Study\Test Scores (XSL)\Race\2010_per_race", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen other=1 if RaceEthnicity=="American Indian or Alaskan Native"
replace other=1 if RaceEthnicity=="Asian"
replace other=1 if RaceEthnicity=="Hawaiian/Pacific Islander"
replace other=1 if RaceEthnicity=="Two or More Races"
gen total=real(TotalCount)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if RaceEthnicity=="White"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if RaceEthnicity=="Black"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if RaceEthnicity=="Hispanic"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2011"
save "U:\IND Study\Test Scores (XSL)\Race\2011_per_race", replace


use "2012.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen other=1 if Group=="American Indian"
replace other=1 if Group=="Asian"
replace other=1 if Group=="Pacific Islander"
replace other=1 if Group=="Two or More Races"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if Group=="White"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if Group=="Black"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if Group=="Hispanic"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2012"
save "U:\IND Study\Test Scores (XSL)\Race\2012_per_race", replace


use "2013.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen other=1 if Group=="American Indian or Alaska Native"
replace other=1 if Group=="Asian"
*replace other=1 if Group=="Pacific Islander"
replace other=1 if Group=="Two or More Races"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if Group=="White"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if Group=="Black or African American"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if Group=="Hispanic or Latino"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Race\2013_per_race", replace

use "2014.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen other=1 if Group=="American Indian or Alaska Native"
replace other=1 if Group=="Asian"
replace other=1 if Group=="Native Hawaiian or Other Pacific Islander"
replace other=1 if Group=="Two or More Races"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if Group=="White"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if Group=="Black or African American"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if Group=="Hispanic or Latino"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Race\2014_per_race", replace


use "2015.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen other=1 if GROUP=="American Indian "
replace other=1 if GROUP=="Asian           "
replace other=1 if GROUP=="Pacific Islander"
replace other=1 if GROUP=="Multiracial     "
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen other_tot=sum(total) if other==1

gen white=1 if GROUP=="White           "
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SCHOOLNAME
by SCHOOLNAME: egen white_tot=sum(total) if white==1

gen black=1 if GROUP=="Black           "
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SCHOOLNAME
by SCHOOLNAME: egen black_tot=sum(total) if black==1

gen hispanic=1 if GROUP=="Hispanic        "
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SCHOOLNAME
by SCHOOLNAME: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SCHOOLNAME)
drop if missing(SCHOOLNAME)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
rename SCHOOLNAME SchoolName
gen year="2015"
save "U:\IND Study\Test Scores (XSL)\Race\2015_per_race", replace


use "2016.dta"
drop if SchoolName=="All Schools                                       "
gen other=1 if Ethnicity=="American Indian or Alaska Native"
replace other=1 if Ethnicity=="Asian           "
replace other=1 if Ethnicity=="Hawaiian/Pacific Islander       "
replace other=1 if Ethnicity=="Two or More Races               "
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if Ethnicity=="White                           "
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if Ethnicity=="Black                           "
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if Ethnicity=="Hispanic                        "
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2016"
save "U:\IND Study\Test Scores (XSL)\Race\2016_per_race", replace


use "2017.dta"
drop if SchoolName=="All Schools"
gen other=1 if Ethnicity=="American Indian or Alaska Native"
replace other=1 if Ethnicity=="Asian"
replace other=1 if Ethnicity=="Hawaiian/Pacific Islander"
replace other=1 if Ethnicity=="Two or More Races"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen other_tot=sum(total) if other==1

gen white=1 if Ethnicity=="White"
*replace white=0 if Ethnicity~="White (not Hispanic)"
sort SchoolName
by SchoolName: egen white_tot=sum(total) if white==1

gen black=1 if Ethnicity=="Black"
*replace black=0 if Ethnicity~="Black (not Hispanic)"
sort SchoolName
by SchoolName: egen black_tot=sum(total) if black==1

gen hispanic=1 if Ethnicity=="Hispanic"
*replace hispanic=0 if Ethnicity~="Hispanic"
sort SchoolName
by SchoolName: egen hispanic_tot=sum(total) if hispanic==1

collapse other_tot white_tot black_tot hispanic_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_other=other_tot/total
gen percent_white=white_tot/total
gen percent_black=black_tot/total
gen percent_hispanic=hispanic_tot/total
gen year="2017"
save "U:\IND Study\Test Scores (XSL)\Race\2017_per_race", replace

use "2010_per_race", clear
append using "2011_per_race"
append using "2012_per_race"
append using "2013_per_race"
append using "2014_per_race"
append using "2015_per_race"
append using "2016_per_race"
append using "2017_per_race"
save "U:\IND Study\Test Scores (XSL)\Appended Demographics\race", replace


*************************************************************************
*Finding percent male and female for each year

cd "U:\IND Study\Test Scores (XSL)\Gender"

use "2010.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen female=1 if Gender=="FEMALE"
replace female=0 if Gender=="MALE"
*gen total=real(TotalN10)
sort SchoolName
by SchoolName: egen female_tot=sum(TotalN10) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(TotalN10) if male==1
collapse female_tot male_tot (sum) TotalN10, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/TotalN10
gen percent_male=male_tot/TotalN10
rename TotalN10 total
gen year="2010"
save "U:\IND Study\Test Scores (XSL)\Gender\2010_per_gender", replace


use "2011.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen female=1 if Gender=="FEMALE"
replace female=0 if Gender=="MALE"
gen total=real(TotalCount)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2011"
save "U:\IND Study\Test Scores (XSL)\Gender\2011_per_gender", replace

use "2012.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen female=1 if Group=="F"
replace female=0 if Group=="M"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2012"
save "U:\IND Study\Test Scores (XSL)\Gender\2012_per_gender", replace


use "2013.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen female=1 if Group=="F"
replace female=0 if Group=="M"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2013"
save "U:\IND Study\Test Scores (XSL)\Gender\2013_per_gender", replace


use "2014.dta"
drop if SchoolName=="DISTRICT RESULTS"
gen female=1 if Group=="F"
replace female=0 if Group=="M"
gen total=real(TotalTested)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2014"
save "U:\IND Study\Test Scores (XSL)\Gender\2014_per_gender", replace



use "2015.dta"
drop if SCHOOLNAME=="ALL SCHOOLS                                       "
gen female=1 if GROUP=="Female"
replace female=0 if GROUP=="Male  "
gen total=real(OFVALIDSCORES)
sort SCHOOLNAME
by SCHOOLNAME: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SCHOOLNAME
by SCHOOLNAME: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SCHOOLNAME)
drop if missing(SCHOOLNAME)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
rename SCHOOLNAME SchoolName
gen year="2015"
save "U:\IND Study\Test Scores (XSL)\Gender\2015_per_gender", replace


use "2016.dta"
drop if SchoolName=="All Schools"
gen female=1 if Gender=="Female"
replace female=0 if Gender=="Male"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2016"
save "U:\IND Study\Test Scores (XSL)\Gender\2016_per_gender", replace


use "2017.dta"
drop if SchoolName=="All Schools"
gen female=1 if Gender=="Female"
replace female=0 if Gender=="Male"
gen total=real(ofValidScores)
sort SchoolName
by SchoolName: egen female_tot=sum(total) if female==1
gen male=1 if female==0
replace male=0 if female==1
sort SchoolName
by SchoolName: egen male_tot=sum(total) if male==1
collapse female_tot male_tot (sum) total, by (SchoolName)
drop if missing(SchoolName)

gen percent_female=female_tot/total
gen percent_male=male_tot/total
gen year="2017"
save "U:\IND Study\Test Scores (XSL)\Gender\2017_per_gender", replace


use "2010_per_gender", clear
append using "2011_per_gender"
append using "2012_per_gender"
append using "2013_per_gender"
append using "2014_per_gender"
append using "2015_per_gender"
append using "2016_per_gender"
append using "2017_per_gender"
save "U:\IND Study\Test Scores (XSL)\Appended Demographics\gender", replace

*****************************************************************************

*Merging appended demographic data (no test scores)
cd "U:\IND Study\Test Scores (XSL)\Appended Demographics"

clear
use "gender"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
sort SchoolName year
save gender_temp.dta, replace

clear
use "gifted"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
sort SchoolName year
save gifted_temp.dta, replace


clear
use "lunch"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
sort SchoolName year
save lunch_temp.dta, replace

clear
use "migrant"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
sort SchoolName year
save migrant_temp.dta, replace

clear
use "race"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
sort SchoolName year
save race_temp.dta, replace


clear
use gifted_temp
sort SchoolName year
save gifted_temp.dta, replace


use race_temp.dta
sort SchoolName
merge 1:1 SchoolName year using gifted_temp
drop if _merge~=3
drop _merge
save merge_1.dta, replace

use "merge_1"
sort SchoolName
merge 1:1 SchoolName year using lunch_temp
drop if _merge~=3
drop _merge
save merge_2.dta, replace

use "merge_2.dta"
sort SchoolName
merge 1:1 SchoolName year using migrant_temp
drop if _merge~=3
drop _merge
save merge_3.dta, replace

use "merge_3.dta"
sort SchoolName
merge 1:1 SchoolName year using race_temp
drop if _merge~=3
*drop _merge
save merge_semifinal.dta, replace

gen Year=real(year)
drop year
save merge_semifinal.dta, replace

********************************************************************
/*Generating rankings for test scores*/
cd "U:\IND Study\Test Scores (XSL)\Updated Scores"
clear
use "appended_data"
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)

gsort year -satisfy

egen rank2010=group(satisfy) if year=="2010"
egen rank2011=group(satisfy) if year=="2011"
egen rank2012=group(satisfy) if year=="2012"
egen rank2013=group(satisfy) if year=="2013"
egen rank2014=group(satisfy) if year=="2014"
egen rank2015=group(satisfy) if year=="2015"
egen rank2016=group(satisfy) if year=="2016"
egen rank2017=group(satisfy) if year=="2017"
replace rank2010=0 if rank2010==.
replace rank2011=0 if rank2011==.
replace rank2012=0 if rank2012==.
replace rank2013=0 if rank2013==.
replace rank2014=0 if rank2014==.
replace rank2015=0 if rank2015==.
replace rank2016=0 if rank2016==.
replace rank2017=0 if rank2017==.
gen rank=rank2010+rank2011+rank2012+rank2013+rank2014+rank2015+rank2016+rank2017

gen Year=real(year)
drop year
save appended_data, replace
***************************************************************************
/*Merge test scores and demographic data*/
cd "U:\IND Study\Test Scores (XSL)\Appended Demographics"

clear
use merge_semifinal
replace SchoolName=strltrim(SchoolName)
replace SchoolName=strrtrim(SchoolName)
*gen Year=real(year)
*drop year
drop _merge
sort SchoolName Year


cd "U:\IND Study\Test Scores (XSL)\Updated Scores"
merge 1:1 SchoolName Year using appended_data
drop if _merge~=3
*drop _merge
save merge_final.dta, replace


use merge_final.dta



***********Correcting names for schools with BEST funding
*YEAR 2015

replace SchoolName = "LAS ANIMAS MIDDLE SCHOOL" in 5241/5244
replace SchoolName = "LAS ANIMAS HIGH SCHOOL" in 5236/5237
replace SchoolName = "ESTES PARK MIDDLE SCHOOL" in 3054/3055
replace SchoolName = "STRASBURG HIGH SCHOOL" in 8926/8927
replace SchoolName = "LAKE COUNTY MIDDLE SCHOOL" in 5161/5162
replace SchoolName = "OAK GROVE ELEMENTARY SCHOOL" in 6774/6775
replace SchoolName = "ORTEGA MIDDLE SCHOOL" in 6858/6859
replace SchoolName = "BRUSH MIDDLE SCHOOL" in 1059/1060
replace SchoolName = "BRUSH HIGH SCHOOL" in 1057/1058
replace SchoolName = "SALIDA MIDDLE SCHOOL" in 8086/8087
replace SchoolName = "MONTROSE HIGH SCHOOL" in 6312/6313
replace SchoolName = "CANON CITY MIDDLE SCHOOL" in 1211/1212
replace SchoolName = "SIERRA GRANDE K-12 SCHOOL" in 8349/8356
replace SchoolName = "GRAND MESA HIGH SCHOOL" in 3914
replace SchoolName = "PLATEAU VALLEY ELEMENTARY SCHOOL" in 7283/7284
replace SchoolName = "PLATEAU VALLEY MIDDLE SCHOOL" in 7285/7286
replace SchoolName = "LA JUNTA INTERMEDIATE SCHOOL" in 5125/5126
replace SchoolName = "LA JUNTA JR/SR HIGH SCHOOL" in 5124
replace SchoolName = "LA JUNTA JR/SR HIGH SCHOOL" in 5138/5139
replace SchoolName = "SHERIDAN HIGH SCHOOL" in 8317/8318
replace SchoolName = "AURORA CENTRAL HIGH SCHOOL" in 412/413
replace SchoolName = "PUEBLO COUNTY HIGH SCHOOL" in 7518/7519
replace SchoolName = "CROWLEY COUNTY ELEMENTARY SCHOOL" in 2226/2227
replace SchoolName = "CROWLEY COUNTY MIDDLE SCHOOL" in 2230/2231
replace SchoolName = "CROWLEY COUNTY ELEMENTARY SCHOOL" in 2222
replace SchoolName = "CROWLEY COUNTY MIDDLE SCHOOL" in 2223/2225
replace SchoolName = "CROWLEY COUNTY HIGH SCHOOL" in 2221
replace SchoolName = "CROWLEY COUNTY HIGH SCHOOL" in 2228/2229
replace SchoolName = "DARTMOUTH ELEMENTARY SCHOOL" in 2296/2297
replace SchoolName = "HIDDEN LAKE HIGH SCHOOL" in 4283/4284
replace SchoolName = "FAIRVIEW ELEMENTARY SCHOOL" in 3152/3153
replace SchoolName = "FAIRVIEW ELEMENTARY SCHOOL" in 3159/3160
replace SchoolName = "FORT MORGAN MIDDLE SCHOOL" in 3395/3396
replace SchoolName = "FAIRVIEW HIGH SCHOOL" in 3161/3162


*YEAR 2016
replace SchoolName = "BENNETT HIGH SCHOOL" in 722/723
replace SchoolName = "CLARA E. METZ ELEMENTARY SCHOOL" in 1705/1706
replace SchoolName = "BELLE CREEK CHARTER SCHOOL" in 668/669
replace SchoolName = "BRANTNER ELEMENTARY SCHOOL" in 935/936
replace SchoolName = "BRIGHTON HIGH SCHOOL" in 973/974
replace SchoolName = "EAGLE RIDGE ACADEMY" in 2683/2684
replace SchoolName = "FOUNDATIONS ACADEMY" in 3419/3420
replace SchoolName = "HENDERSON ELEMENTARY SCHOOL" in 4241/4242
replace SchoolName = "LANDMARK ACADEMY AT REUNION" in 5194/5195
replace SchoolName = "NORTH ELEMENTARY SCHOOL" in 6627/6628
replace SchoolName = "NORTHEST ELEMENTARY SCHOOL" in 6701/6702
replace SchoolName = "OVERLAND TRAIL MIDDLE SCHOOL" in 6888/6889
replace SchoolName = "OTHO E STUART MIDDLE SCHOOL" in 6872/6873
replace SchoolName = "PRAIRIE VIEW HIGH SCHOOL" in 7458/7459
replace SchoolName = "PRAIRIE VIEW MIDDLE SCHOOL" in 7456/7457
replace SchoolName = "SECOND CREEK ELEMENTARY SCHOOL" in 8204/8205
replace SchoolName = "JOHN W THIMMIG ELEMENTARY SCHOOL" in 4857/4858
replace SchoolName = "SOUTH ELEMENTARY SCHOOL" in 8614/8615
replace SchoolName = "SOUTHEAST ELEMENTARY SCHOOL" in 8690/8691
replace SchoolName = "TURNBERRY ELEMENTARY" in 9528/9529
replace SchoolName = "VIKAN MIDDLE SCHOOL" in 9748/9749
replace SchoolName = "WESTRIDGE ELEMENTARY" in 10095/10096
replace SchoolName = "CENTAURI MIDDLE SCHOOL" in 1385/1386
replace SchoolName = "CENTAURI HIGH SCHOOL" in 1378/1379
replace SchoolName = "LA JARA ELEMENTARY SCHOOL" in 5118/5119
replace SchoolName = "MANASSA ELEMENTARY SCHOOL" in 5733/5734
replace SchoolName = "CALHAN ELEMENTARY SCHOOL" in 1161/1162
replace SchoolName = "CALHAN MIDDLE SCHOOL" in 1172/1173
replace SchoolName = "CALHAN HIGH SCHOOL" in 1167/1168
replace SchoolName = "ATLAS PREPARATORY SCHOOL" in 388
replace SchoolName = "ATLAS PREPARATORY SCHOOL" in 394/395
replace SchoolName = "CARMEL MIDDLE SCHOOL" in 1259/1260
replace SchoolName = "FOX MEADOW MIDDLE SCHOOL" in 3487/3488
replace SchoolName = "JAMES IRWIN CHARTER MIDDLE SCHOOL" in 4759/4760
replace SchoolName = "PANORAMA MIDDLE SCHOOL" in 6962/6963
replace SchoolName = "RUNNING CREEK ELEMENTARY SCHOL" in 7972/7973
replace SchoolName = "SINGING HILLS ELEMENTARY SCHOOL" in 8426/8427
replace SchoolName = "BEA UNDERWOOD ELEMENTARY SCHOOL" in 586/587
replace SchoolName = "WEST GRAND HIGH SCHOOL" in 9979/9980
replace SchoolName = "BURLINGTON MIDDLE SCHOOL" in 1123/1124
replace SchoolName = "ANIMAS VALLEY ELEMENTARY SCHOOL" in 217/218
replace SchoolName = "FLORIDA MESA ELEMENTARY SCHOOL" in 3311/3312
replace SchoolName = "FORT LEWIS MESA ELEMENTARY SCHOOL" in 3365
replace SchoolName = "NEEDHAM ELEMENTARY SCHOOL" in 6522/6523
replace SchoolName = "PARK ELEMENTARY SCHOOL" in 6987/6988
replace SchoolName = "RIVERVIEW ELEMENTARY SCHOOL" in 7800/7801
replace SchoolName = "SUNNYSIDE ELEMENTARY SCHOOL" in 9071/9072
replace SchoolName = "BERTHUOD ELEMENTARY SCHOOL" in 753/754
replace SchoolName = "MOUNTAIN VIEW HIGH SCHOOL" in 6418/6419
replace SchoolName = "THOMPSON VALLEY HIGH SCHOOL" in 9341/9342
replace SchoolName = "FITZSIMMONS MIDDLE SCHOOL" in 3259/3260
replace SchoolName = "MOFFAT PREK-12 SCHOOL" in 6201/6206


*YEAR 2017


replace SchoolName = "KEARNEY MIDDLE SCHOOL" in 4935/4936
replace SchoolName = "HARRIS PARK ELEMENTARY SCHOOL" in 4144/4145
replace SchoolName = "MRACHEK MIDDLE SCHOOL" in 6458/6459
replace SchoolName = "PAGOSA SPRINGS MIDDLE SCHOOL" in 6904/6905
replace SchoolName = "EAGLE COUNTY CHARTER ACADEMY" in 2667/2668
replace SchoolName = "PALMER LAKE ELEMENTARY SCHOOL" in 6947/6948
replace SchoolName = "CANON CITY HIGH SCHOOL" in 1203/1204
replace SchoolName = "HARRISON SCHOOL" in 4160/4161
replace SchoolName = "LEGACY ACADEMY" in 5286/5287
replace SchoolName = "ELIZABETH HIGH SCHOOL" in 2909/2910
replace SchoolName = "GRAND VALLEY HIGH SCHOOL" in 3921/3922
replace SchoolName = "WAMSLEY ELEMENTARY SCHOOL" in 9841/9842
replace SchoolName = "CACTUS VALLEY ELEMENTARY SCHOOL" in 1153/1154
replace SchoolName = "KATHRYN SENOR ELEMENTARY SCHOOL" in 4923/4924
replace SchoolName = "GRAHAM MESA ELEMENTARY SCHOOL" in 3887/3888
replace SchoolName = "BURLINGTON HIGH SCHOOL" in 1118/1119
replace SchoolName = "BAYFIELD ELEMENTARY SCHOOL" in 564/565
replace SchoolName = "LIMON ELEMENTARY SCHOOL" in 5436/5437
replace SchoolName = "LIMON JUNIOR-SENIOR HIGH SCHOOL" in 5438/5439
replace SchoolName = "COLUMBINE MIDDLE SCHOOL" in 1944/1945
replace SchoolName = "OLATHE MIDDLE SCHOOL" in 6828/6829
replace SchoolName = "SWINK ELEMENTARY SCHOOL" in 9158/9159
replace SchoolName = "HOLYOKE SENIOR HIGH SCHOOL" in 4459/4460
replace SchoolName = "GOODNIGHT ELEMENTARY SCHOOL" in 3876/3877
replace SchoolName = "HERITAGE ELEMENTARY SCHOOL" in 4259/4260
replace SchoolName = "FRONTIER CHARTER ACADEMY" in 3603/3604
replace SchoolName = "WELD CENTRAL SENIOR HIGH SCHOOL" in 9924/9925
replace SchoolName = "LOCHBUIE ELEMENTARY SCHOOL" in 5527/5528
replace SchoolName = "HUDSON ACADEMY OF ARTS AND SCIENCES" in 4551
replace SchoolName = "HOFF ELEMENTARY SCHOOL" in 4423/4424
replace SchoolName = "WELD CENTRAL MIDDLE SCHOOL" in 9922/9923
replace SchoolName = "WELD CENTRAL MIDDLE SCHOOL" in 9926/9927



egen id=group(SchoolName)
/*save merge_final.dta, replace*/

save "U:\IND Study\Awarded Schools (XSL)\before_best_data", replace

cd "U:\IND Study\Awarded Schools (XSL)"
use "15funding"
sort id
save 15funding_sorted.dta, replace

use "16funding"
sort id
save 16funding_sorted.dta, replace

use "17funding"
sort id
save 17funding_sorted.dta, replace


use "before_best_data"
sort id
drop _merge
merge m:1 id using "15funding_sorted"
*drop if _merge~=3
gen best15=1 if _merge==3
replace best15=0 if _merge~=3
drop _merge
save before_best2.dta, replace

use "before_best2"
sort id
merge m:1 id using 16funding
*drop if _merge~=3
tab id if _merge==3
gen best16=1 if _merge==3
replace best16=0 if _merge~=3
drop _merge
save before_bestfinal.dta, replace

use "before_bestfinal"
sort id
merge m:1 id using 17funding
tab id if _merge==3
gen best17=1 if _merge==3
replace best17=0 if _merge~=3
*drop if _merge~=3
*drop _merge
save best_final.dta, replace

use "best_final"
gen best_yes=1 if best15==1
replace best_yes=1 if best16==1
replace best_yes=1 if best17==1
replace best_yes=0 if best15==0 & best16==0 & best17==0 


drop other_tot white_tot black_tot hispanic_tot gifted_tot not_gifted_tot lunchpro_tot no_lunch_tot mig_im_tot no_mig_im_tot rank2010 rank2011 rank2012 rank2013 rank2014 rank2015 rank2016 rank2017 best15 best16 _merge best17 Funding

/*drop in 3152 
drop in 3157
drop in 8346
drop in 8346
dropped manually and saved new data set*/

************************************************************************************
/*working with new data set*/

clear
cd "U:\IND Study\Awarded Schools (XSL)"
use "best_final_2"

replace best_yes=0 if Year==2010
replace best_yes=0 if Year==2011
replace best_yes=0 if Year==2012
replace best_yes=0 if Year==2013
replace best_yes=0 if Year==2014

xtset id Year

/*OLS Regressions*/

reg rank best_yes

/*gen y2010=1 if Year==2010
replace y2010=0 if Year~=2010

gen y2011=1 if Year==2011
replace y2011=0 if Year~=2011

gen y2012=1 if Year==2012
replace y2012=0 if Year~=2012

gen y2013=1 if Year==2013
replace y2013=0 if Year~=2013

gen y2014=1 if Year==2014
replace y2014=0 if Year~=2014

gen y2015=1 if Year==2015
replace y2015=0 if Year~=2015

gen y2016=1 if Year==2016
replace y2016=0 if Year~=2016

gen y2017=1 if Year==2017
replace y2017=0 if Year~=2017*/

reg rank best_yes y2011 y2012 y2013 y2014 y2015 y2016 y2017

reg rank best_yes y2011 y2012 y2013 y2014 y2015 y2016 y2017 percent_other percent_white percent_black percent_hispanic percent_gifted percent_lunchpro percent_mig_im

/*xtreg regressions and fixed effects*/

xtreg rank best_yes, fe vce(robust)

xtreg rank best_yes y2011 y2012 y2013 y2014 y2015 y2016 y2017, fe vce(robust)

xtreg rank best_yes y2011 y2012 y2013 y2014 y2015 y2016 y2017 percent_other percent_white percent_black percent_hispanic percent_gifted percent_lunchpro percent_mig_im, fe vce(robust)



ttest rank, by(best_yes)
ttest percent_black, by(best_yes)
ttest percent_white, by(best_yes)
ttest percent_hispanic, by(best_yes)
ttest percent_lunch, by(best_yes)
ttest percent_mig_im, by(best_yes)

egen newrank2010=rank(satisfy) if Year==2010, field 
egen newrank2011=rank(satisfy) if Year==2011, field 
egen newrank2012=rank(satisfy) if Year==2012, field 
egen newrank2013=rank(satisfy) if Year==2013, field 
egen newrank2014=rank(satisfy) if Year==2014, field 
egen newrank2015=rank(satisfy) if Year==2015, field 
egen newrank2016=rank(satisfy) if Year==2016, field 
egen newrank2017=rank(satisfy) if Year==2017, field 
replace newrank2010=0 if newrank2010==.
replace newrank2011=0 if newrank2011==.
replace newrank2012=0 if newrank2012==.
replace newrank2013=0 if newrank2013==.
replace newrank2014=0 if newrank2014==.
replace newrank2015=0 if newrank2015==.
replace newrank2016=0 if newrank2016==.
replace newrank2017=0 if newrank2017==.
gen newrank=newrank2010+newrank2011+newrank2012+newrank2013+newrank2014+newrank2015+newrank2016+newrank2017


/*
OLS regress y on Best
y on Best and time effects
Y on Best and time and controls
xtreg (school fixed effects) repeat

xtreg rank percent_other percent_white percent_black percent_hispanic percent_gifted percent_lunchpro percent_mig_im best_yes

xtreg y xxxx, fe


xtset id Year

xtreg rank percent_other percent_white percent_black percent_hispanic percent_gifted percent_lunchpro percent_mig_im best_yes

*/


log close





