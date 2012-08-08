# Date: Tuesday, August 7, 2012

#####################################
### Capture-Recapture Experiments ###
#####################################

# Consider a population of unknown size N.
# To get information about N, perform a
# capture-recapture experiment:
# 1st round: catch, mark and release again m individuals,
# 2nd round: catch anew k individuals and determine
#    X = number of marked individuals in second catch.
# We consider X as a random variable with hypergeometric
# distribution
#    Hyp(N, m, k)      (textbook convention)
#    hyper(m, N-m, k)  (R's convention)
# 
# A simple point estimator for N would be
#    N.est = m*k/X   (or m*k/(X+0.5)).
# Reason: After 1st round, the population contains
# m marked individuals out of N. If the sample in the
# 2nd round is "representative" of the population, we
# expect X/k to be similar to m/N. This leads to the
# equation X/k = m/N.est...

# General observation: The larger N is, the smaller X
# tends to be.


# Exercise: Visualize the distribution of X
# for various choices of m, k, N.
# Illustrate the previous observation.


m <- 20
k <- 20
N <- c(40,50,100,200,500,2000)
x <- 0:min(m,k)
x

par(mfrow=c(2,3))
# Show probability weights P(X = x):
for (i in 1:6)
{
	dx <- dhyper(x,m,N[i]-m,k)
	barplot(dx,names.arg=x,col="blue",
		main=paste("N = ", as.character(N[i]),sep=""),
		xlab="x",ylab="P(X = x)")
}
# Show distribution functions P(X <= x):
for (i in 1:6)
{
	Fx <- phyper(x,m,N[i]-m,k)
	sf <- stepfun(x,c(0,Fx))
	plot.stepfun(sf,lw=2,pch="",
		main=paste("N = ", as.character(N[i]),sep=""),
		xlab="x",ylab="P(X <= x)")
}