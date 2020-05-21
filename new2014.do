*new model - 2014

gen mwemp=(mwlab/labfc)*100
*min wage employment variable
gen low_edu=0
replace low_edu=1 if hs>(ugrad+adv)
*low education variable

corr mwemp minwg bene cpi hs ugrad lcc bene low_edu med

reg minwg pce prod pinc cpi
estat hettest
predict p
replace minwg=p if minwg==.
*new predicted wage values

reg mwemp minwg
estat hettest
*heteroskedastic-robust standard errors

label variable mwemp "Min Wage Emp$^{1}$"
label variable minwg "Min Wage 2$^{2}$"
label variable bene "Benefit$^{3}$"
label variable cpi "CPI$^{4}$"
label variable hs "High School$^{5$"
label variable ugrad "College$^{6}$"
label variable adv "Advanced$^{7}$"
label variable low_edu "Low Edu$^{8}$"
label variable lcc "Compen Cost$^{9}$"
label variable med "Median Age$^{10}$"

reg mwemp minwg bene cpi hs ugrad adv, r
estimates store m1
test bene cpi hs ugrad adv
test minwg bene
test minwg cpi
test minwg hs
test minwg ugrad 
test minwg adv

reg mwemp minwg bene cpi low_edu, r
estimates store m2
test bene cpi low_edu
test minwg bene
test minwg cpi
test minwg low_edu

reg mwemp minwg bene cpi low_edu lcc, r
estimates store m3
test bene cpi low_edu lcc
test minwg bene
test minwg cpi
test minwg low_edu
test minwg lcc

reg mwemp minwg bene cpi low_edu med, r
estimates store m4
test bene cpi low_edu med
test minwg bene
test minwg cpi
test minwg low_edu
test minwg med

estout m1 m2 m3 m4 using \Users\William\Desktop\school\senior_s1\econometrics\paper_data\beta_table_imp.tex, ///
replace style(tex) cells(b(star fmt(%6.3f)) se(par(\small{( )}))) lz wrap ///
stats(r2_a r2 N F, fmt(%9.3f %9.3f %9.0g %9.0f) labels( \$R^{2}-adjusted\$ \$R^{2}\$ Observations \$F$-stat)) ///
title(Results of Regressions of Min-Wage-Employment on Minimum Wage, Education Level, Unemployment Benefit, CPI, and GDP in 2014) ///
label numbers mlabels(, depvar) collabels(" ") varlabels(_cons Constant) ///
prehead("\begin{table}" "\caption{@title}" "\begin{center}" "\label{tab3}" "\begin{tabular}{l*{@M}{c}}" "\hline \\" ) posthead( ///
"\vspace {1mm} \\ \hline \hline"\\ ) ///
postfoot("\vspace {1mm} \\ \hline \\" ///
"\multicolumn{@M}{l}{Robust standard errors in parentheses. *** p $<$ 0.01, ** p$<$ 0.05, * p$<$ 0.1} \\" ///
"\multicolumn{@M}{l}{1. Percent of labor force earning min wage or less (NSA).} \\" ///
"\multicolumn{@M}{l}{2. Annual minimum wage rate by state - missing values set to estimates.} \\" ///
"\multicolumn{@M}{l}{3. Maximum weekly unemployment benefit entitlement by state.} \\" ///
"\multicolumn{@M}{l}{4. Consumer Price Index by state.} \\" ///
"\multicolumn{@M}{l}{5. Percent of population with high school as highest education by state.} \\" ///
"\multicolumn{@M}{l}{6. Percent of population with college as highest education by state.} \\" ///
"\multicolumn{@M}{l}{7. Percent of population with post-graduate as highest education by state.} \\" ///
"\multicolumn{@M}{l}{8. Binary set to 1 if High School attainment is greater than college and advanced.} \\" ///
"\multicolumn{@M}{l}{9. Avergage cost of labor compensation to employer.} \\" ///
"\multicolumn{@M}{l}{10. Median age by state.} \\" ///
"\multicolumn{@M}{l}{} \\" ///
"\end{tabular}" "\end{center}" "\end{table}" )


*estimates table, star(.1 .05 .01) b(%9.3f)
