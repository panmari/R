# Date: Thursday, August 9, 2012

#####################################
### Statistical Analysis of a     ###
### Categorical Variable (factor) ###
#####################################

# Consider one categorical variable X of a
# given data set, say, a dataframe named "ds".
# Possible values:
#    x[1], x[2], ..., x[L]
# Observed values in sample:
#    X[1], X[2], ..., X[n].
# 
# Example for X = "random digit"
# p_j = P(a "typical person would chouse x_j)
# x_j = j -1, j = 1:10
# Null hypothesis: p_j = 0.1 for all j (so random numbers are evenly distributed)

# Statistical model: For a generic observation X,
#    Prob(X = x[j]) = p[j]
# with unknown probabilities
#    p[1], p[2], ..., p[L]
# summing to one. Then the summaries
#    T[j] = number of observations (indices i)
#           with X[i] = x[j]
# are random variables with distribution
#    T[j] ~ binom(n, p[j]) .
# 
# These summaries are obtained via
#     T <- table(ds$X).
# To specify the potential values, one can change
# the variable X as follows:
#    ds$X <- factor(ds$X, levels=c(x)) .
# 
# Inference about the p[j] is possible
# by means of binom.test().


# Example: StatWiSo2003.txt

ds <- read.table(file="StatWiSo2003.txt",header=TRUE)
X <- factor(ds$ZufZiffer,levels=0:9)
X

TX <- table(X)
TX
# TX looks like a matrix with two rows.
# But it is a one-dimensional array with
# named components:
str(TX)

# The one "NA" is automatically removed
n <- sum(TX)
n

# Empirical probabilities of the 10 digits:
p.emp <- TX/n
p.emp
round(p.emp,digits=3)


# What binom.test() really achieves:
result <- binom.test(TX[1],n, p=0.1)
result
str(result)
# Hence binom.test returns a list,
# and the confidence interval is item
# result$conf.int, a vector of length 2.
result$conf.int


# Compute simultaneous confidence
# bounds for p[j] = Prob(someone chooses digit j-1),
# for j=1,2,...,10.

# Initialize vectors containing the
# confidence bounds:
a <- rep(0,10)  # lower bounds
b <- rep(1,10)  # upper bounds

for (j in 1:10)
{
	result <- binom.test(TX[j],n,
		conf.level=1-0.05/10) #overall 95% confidence (over all intervalls
	a[j] <- result$conf.int[1]
	b[j] <- result$conf.int[2]
}

cbind(TX,p.emp,a,b)
# Looking at this table we may conclude with confidence
# 95% that certain digits are under- or overrepresented.
# Which ones?


### Exercise ###
# 
# Write a program file "MultinomialCBs.R" with just
# one function for this procedure, applied to an
# arbitrary vector TX of (absolute) frequencies
# (which may but need not have been obtained via
#  table() from a data frame).
# In particular, the length L of the table
# may be arbitrary. Also arbitrary confidence
# levels (1-alpha) should be possible...
# 
# This program file / function will be needed for the
# third hand-in-exercise.


# Once you have written your program:
source("MultinomialCBs.R")
MultinomialCBs(TX)


# Back to our example of the "random digits":
# A classical procedure to test whether a given
# theoretical distribution on a finite set fits
# given data is Pearson's Chisquared Test.
help.search("Pearson")
? chisq.test

# so here use:
chisq.test(TX) # number of occurences

# Explanation:
# Chi-squared goodness-of-fit test (by pearson)
# test statistic = some complex sum
# Compare the value of this test statistic with its distribution under
# the null hypothesis. 
# - For "large" n*min(p_j) its like a chi-square(L-1)
# - Use monte-carlo sampling -> set "simulate.p.value=TRUE"
#   (B= is the number of repetitions), this is more reliable!

# result: df = degrees of freedom
# Doesn't give any hints in which direction the deviation is.

# Try to apply this procudure to our current example.

# Try to apply this procedure with "simulated p-values".
# This provides a Monte-Carlo-p-value which is more
# honest than the classical one based on an approximation
# via chi-squared distributions.



# Another example: In the 12 months of the year 1966,
# the numbers of deaths in the U.S.A. were:
#    January    166761
#    February   151296
#    March      164804
#    April      158973
#    May        156455
#    June       149251
#    July       159924
#    August     145184
#    September  141164
#    Oktober    154777
#    November   150678
#    December   163882
# 
# Here one can justify the model that, conditional
# on the total number n of deaths in 1966, the number
# TX[j] of deaths in month j is a random variable with
# distribution binom(n,p[j]).
# The question is whether the cases of death are
# uniformly distributed over the whole year.
# Think first what this means for the probabilities
# p[j]. Then use MultinomialCBs() to answer this question
# (if possible).
TX2 <- c(166761, 151296, 164804, 158973, 156455, 149251, 159924, 145184, 141164, 154777, 150678, 163882)
MultinomialCBs(TX2) -> resultTX2
p0 = c(31,28,31,30,31,30,31,31,30,31,30,31)/365 # expected values

cbind(resultTX2, p0)
# => in winter & july (sultry), more people than expected 
# (if they were evenly distributed) are dying. Oh noez!

# with chi square test:
chisq.test(TX2, p=p0)