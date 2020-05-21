*replicated model - 2014

gen minwg2=minwg
replace minwg2=0 if minwg2==.
replace minwg2=7.25 if minwg2<7.25
*minwg2 replaces missing and low values with fed minwg
gen minwg3=minwg2
replace minwg3=. if minwg3==7.25
*minwg3 removes everything equal to fed minwg

correl unemp minwg2 minwg3 bene cpi hs ugrad adv

reg unemp minwg
estat hettest
*homoskedastic-only standard errors

label variable unemp "Unemp$^{1}$"
label variable minwg2 "Min Wage 2$^{2}$"
label variable minwg3 "Min Wage 3$^{3}$"
label variable bene "Benefit$^{4}$"
label variable cpi "CPI$^{5}$"
label variable hs "High School$^{6}$"
label variable ugrad "College$^{7}$"
label variable adv "Advanced$^{8}$"

regress unemp minwg2
estimates store m1

regress unemp minwg2 bene cpi hs ugrad adv
estimates store m2
test bene cpi hs ugrad adv
test minwg2 bene
test minwg2 cpi
test minwg2 hs
test minwg2 ugrad
test minwg2 adv

regress unemp minwg3 bene cpi hs ugrad adv
estimates store m3
test bene cpi hs ugrad adv
test minwg3 bene
test minwg3 cpi
test minwg3 hs
test minwg3 ugrad
test minwg3 adv

estout m1 m2 m3 using \Users\William\Desktop\school\senior_s1\econometrics\paper_data\beta_table_rep.tex, ///
replace style(tex) cells(b(star fmt(%6.3f)) se(par(\small{( )}))) lz wrap ///
stats(r2_a r2 N F, fmt(%9.3f %9.3f %9.0g %9.0f) labels( \$R^{2}-adjusted\$ \$R^{2}\$ Observations \$F$-stat)) ///
title(Results of Regressions of Unemployment on Minimum Wage, Education Level, Unemployment Benefit, and CPI - Replication) ///
label numbers mlabels(, depvar) collabels(" ") varlabels(_cons Constant) ///
prehead("\begin{table}" "\caption{@title}" "\begin{center}" "\label{tab3}" "\begin{tabular}{l*{@M}{c}}" "\hline \\" ) posthead( ///
"\vspace {1mm} \\ \hline \hline"\\ ) ///
postfoot("\vspace {1mm} \\ \hline \\" ///
"\multicolumn{@M}{l}{Robust standard errors in parentheses. *** p $<$ 0.01, ** p$<$ 0.05, * p$<$ 0.1} \\" ///
"\multicolumn{@M}{l}{1. Annual unemployment rate by state (NSA).} \\" ///
"\multicolumn{@M}{l}{2. Annual minimum wage rate by state - missing values set to fed wage.} \\" ///
"\multicolumn{@M}{l}{3. Annual minimum wage rate by state - values equal to fed rate removed.} \\" ///
"\multicolumn{@M}{l}{4. Maximum weekly unemployment benefit entitlement by state.} \\" ///
"\multicolumn{@M}{l}{5. Consumer price index by state.} \\" ///
"\multicolumn{@M}{l}{6. Percent of population with high school as highest education by state.} \\" ///
"\multicolumn{@M}{l}{7. Percent of population with college as highest education by state.} \\" ///
"\multicolumn{@M}{l}{8. Percent of population with post-graduate as highest education by state.} \\" ///
"\multicolumn{@M}{l}{} \\" ///
"\end{tabular}" "\end{center}" "\end{table}" )

***

ramsey unemp minwg2 bene cpi hs ugrad adv
*test for model misspecification

reg minwg2 bene cpi hs ugrad adv
predict uhat, residuals
reg unemp uhat minwg2
*test for simultaneous causality

 

