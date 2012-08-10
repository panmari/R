# Date: Friday, August 10, 2012

################################################
# Fisher's Exact Test and Related Procedures ###
################################################

# Goal: Detect true association between two binary
# "variables".


### Fisher's exact test for randomized trials ###

# Example:
# 48 bank managers participated in a randomized experiment without
# knowing this: They had to judge whether a fictitious person should
# be promoted or not, based on his/her file.
# The 48 files had been distributed at random and differed only in
# one aspect: 24 files belonged to Mr. Miller, 24 to Mrs. Miller.
#
# Possible working hypotheses:
# * "Men tend to be judged better than women"
# * "Women tend to be judged better than men"
# * "The decision is dependent on the candidate's
#    gender, but we don't know how."
# 
# (Before obtaining/analyzing the data, one should know
#  one's nworking hypothesis. In case of doubt, the
#  two-sided working hypothesis of some dependency is
#  recommended.)
# 
# Null hypothesis: The 48 managers judged objectively; the
# candidate's gender was irrelevant.
#
# Result:
#                    ||  promoted | not promoted ||
#       -----------------------------------------------
#        Mr. Miller  ||  21       |  3           || 24
#        Mrs. Miller ||  14       | 10           || 24
#       -----------------------------------------------
#                    ||  35       | 13           || 48
#
# Under null hypothesis, the resulting table has the form
# 
#                    ||  promoted | not promoted ||
#       -----------------------------------------------
#        Mr. Miller  ||   T       | 24-T         || 24
#        Mrs. Miller ||  35-T     | T-11         || 24
#       -----------------------------------------------
#                    ||  35       | 13           || 48
# with
#       T ~ hyper(35, 13, 24) .


x <- 11:24
dx <- dhyper(x,35,13,24)
barplot(dx,names.arg=x)

# P-values
# (probabilities are computed assuming the null hypothesis):
# * pv.rs = 1 - phyper(T-1,35,13,24)
#   Right-sided p-value: Is T "suspiciously large"?
# * pv.ls = phyper(T,35,13,24)
#   Left-sided p-value: Is T "suspiciously small"?
# * pv.ts = 2 * min(pv.ls, pv.rs)
#   Two-sided p-value: Is T "suspiciously extreme"?
# Which p-value is appropriate,
# depends on our working hypothesis.
# Let's be cautious and use the two-sided one:

pv.ls <- phyper(21, 35,13,24)
pv.ls
pv.rs <- 1 - phyper(20, 35,13,24)
pv.rs
pv.ts <- 2*min(pv.ls,pv.rs)
pv.ts

# Now the same thing with a built-in procedure:
help.search("Fisher's exact test")
? fisher.test

# There are two modes of using fisher.test():
# * We have a data frame 'ds' with two binary factors
#   "F1" and "F2"; then run
#   fisher.test(ds$F1,ds$F2)
# * We have a two-by-two table "x"; then run
#   fisher.test(x)

# To use fisher.test here, we have to generate
# a contingency table:

x <- matrix(c(21,14,3,10),nrow=2,ncol=2)
x

fisher.test(x=x)

# Note that the p-value provided here is the
# two-sided p-value we computed "by hand".
# To get the one-sided p-values, type
fisher.test(x=x,alternative="less")     # for pv.ls
fisher.test(x=x,alternative="greater")  # for pv.rs

# The output also contains an estimate and a
# confidence interval for an "odds ratio".
# This will be explained next...



### Odds ratios ###

# Goals:
# * Compare two different procedures (e.g. medical
#   treatments) with respect to success/failure.
# * Compare two (sub-)populations with respect to
#   a certain property of individuals.
#
# In the first example, let p1 and p2 be the success
# probabilities with procedure 1 and 2, respectively.
# Then the odds of success are
#    pj/(1-pj)  with procedure j,
# and the odds ratio of success with procedure 1 versus
# procedure 2 equals
#    OR = (p1/(1-p1)) / (p1/(1-p2))
#       = p1*(1-p2) / (p2*(1-p1)) .
# 
# Note that
#    p1 >< p2  if, and only if,  OR >< 1 .
# 
# A randomized study to compare the two procedures:
# A group of volunteers is divided randomly into two
# groups, where group j undergoes procedure j.
# The results may be summarized as a two-by-two table: 
# 
#                 || success   | failure   ||
#       -------------------------------------------------
#        Group 1  || S1        | F1        || n1 = S1+F1
#        Group 1  || S2        | F2        || n2 = S2+F2
#       -------------------------------------------------
#                 || S = S1+S2 | F = F1+F2 || n = n1+n2
# 
# Performing fisher.test(x) with this two-by-two table
# (x <- matrix(c(S1,S2,F1,F2),nrow=2,ncol=2))
# yields a p-value for the null hypothesis that the two
# two procedures have the same success probabilities
# (p1 == p2  <==>  OR == 1),
# a confidence interval for the odds ratio OR and
# an estimator for OR.


# In the second example, let pj be the proportion of
# individuals having the property within
# (sub-)population j. Thus, if we draw an indivudual
# from (sub-)population j randomly, the odds of picking
# an individual with the property are pj/(1-pj).
# Again the odds ratio is defined as
#    OR = (p1/(1-p1)) / (p1/(1-p2))
#       = p1*(1-p2) / (p2*(1-p1)) .


# Data example:
# Gender and Left-Handedness (see website of this course).
# 
#                | left-handed | right-handed |
#       ---------------------------------------
#        male    | 113         |  934         |
#        female  |  92         | 1070         |
#       ---------------------------------------

x <- matrix(c(113,92,934,1070),ncol=2,nrow=2)
x
fisher.test(x)

# Conclusion: With confidence 95% we may conclude
# that left-handedness is more frequent among men
# than among women (in the given population).
