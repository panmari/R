# Date: Wednesday, August 8, 2012

##############################
### Binomial Distributions ###
##############################

# Examples for binomially distributed random
# variables:
# - Election polls: A random sample of n persons is
#   interviewed,
#      X = nr. of people supporting party ABC
#        ~ binom(n,p)
#   with p in [0,1]: unknown percentage of supporters
#   of ABC in the whole population.
# - cross-fertilization experiment: Two plants of
#   genotype Aa produce n children.
#      X = nr. of children of genotype aa
#        ~ binom(n,p),
#   presumably, p = 1/4 (Mendel's law), but maybe
#   some selection is going on.

help.search("binomial distribution")
? Binomial


# Illustrate binomial distributions
# with a multiple plot:

n <- 30
x <- 0:n

# Visualize binom(n,p) for 9 different values opf p:
par(mfcol=c(3,3))
pv <- seq(from=0.1,to=0.9,by=0.1)
for (j in 1:9)
{
	barplot(dbinom(x,n,pv[j]),names.arg=x,
		main=paste("p = ", as.character(pv[j])))
}

# There are many ways to modify plots.
? par
# One interesting parameter is "mai"
# ("ma(rgin sizes in) i(nches)").
# An example:
par(mfcol=c(3,3),mai=c(0.3,0.3,0.5,0))
pv <- seq(from=0.1,to=0.9,by=0.1)
for (j in 1:9)
{
	barplot(dbinom(x,n,pv[j]),names.arg=x,
		main=paste("p = ", as.character(pv[j])))
}
# Another group of useful parameters:
# All parameters cex, cex.... which control
# the font size of axis labels, numbers etc.


? binom.test

# Short explanation of the parameters:
# x : observation X
# n : sample size or number of trials
# p : a hypothetical value of the unknown p
#     to be tested (default: 0.5).
# alternative : optional parameter with
#     possible values
#     "two.sided" (default), "greater", "less".
# conf.level : confidence level for the
#     confidence interval or confidence bound
#     (default: 0.95).
#
# * alternative == "two.sided": The
#   null hypothesis that the unknown p equals
#   the specified value is tested, and a
#   confidence interval is computed.
# * alternative == "greater": The
#   null hypothesis that the unknown p is
#   less than or equal to the specified value
#   is tested, and a lower confidence bound
#   (confidence interval with upper limit 1)
#   is computed.
# * alternative == "less": The
#   null hypothesis that the unknown p is
#   greater than or equal to the specified value
#   is tested, and an upper confidence bound
#   (confidence interval with lower limit 0)
#   is computed.


# First examples for the use of binom.test:
# Interview n = 400 potential voters
# and determine number X of supporters of
# party ABC...

n <- 400
x <- 122

binom.test(x,n)
binom.test(x,n,conf.level=0.99)

# By default, binom.test() computes a
# confidence interval for the unknown p.
# If one is interested only in an upper bound
# or only in a lower bound, one has to use
# the optional input argument "alternative"

binom.test(x,n,alternative="less")
binom.test(x,n,alternative="greater")
binom.test(x,n,alternative="two.sided")

# Of the 48 attendees of this course,
# 6 people smoke regularly.
# We pretend that the 48 attendees are a
# random subsample of the population of
# all students in Bern, and p is the unknown
# proportion regular smokers within this
# population.
binom.test(8,60)
binom.test(8,60,conf.level=0.99)


# Second illustration of binom.test():
# Use "scan()" to generate and store a "random vector"
# containing about 70 entries in {1,2}:
data <- scan("")

# Question: Are you a reliable random generator?

# First test:
# We determine n = length(data) and
# X = number of entries equal to "1":
n <- length(data)
x <- sum(data == 1)
binom.test(x,n)

# Second test:
# We determine n2 = n-1 and
# x2 = number of indices i in {1,2,...,n-1}
#      such that data[i] != data[i+1]:
n2 <- n-1
x2 <- sum(data[1:(n-1)] != data[2:n])
binom.test(x2,n2)


# Exercise for binom.test:

# Help analyzing the following (fictitious) data:
# * Party ABC is hoping for > 10% voters in the
#   upcoming election.
#   In a poll with n = 1000 people, X = 127 claimed to
#   support ABC. Does this confirm the party's hope?
# * In a cross-fertilization trial (see above),
#   n = 52 plants with parents of genotype Aa have been
#   grown, and X = 9 plants turned out to be of
#   genotype aa. Is
#      p = Prob(child = aa | parents are both Aa)
#        = 1/4?


# Try to do this yourself, before reading on!

# For first example: working hypothesis (alternative)
# is that p > 0.1:

binom.test(127, 1000, p=0.1, alternative="greater")

# For second example: working hypothesis (alternative)
# is that p != 0.25, any deviation is possible.

binom.test(9, 52, p=0.25)
binom.test(9, 52, p=0.25, alternative="two.sided")

# Disappointed? Well, the variability of
# binom(52,0.25) is quite large:
barplot(dbinom(0:52,52,0.25),names.arg=0:52)

# If we would have had 5 times as many observations:

binom.test(45, 260, p=0.25, alternative="two.sided")
barplot(dbinom(0:260,260,0.25),names.arg=0:260)


# Final comment: Always try to work with
# confidence intervals or confidence bounds
# rather than tests!
