# Date: Tuesday, August 7, 2012

######################################
### Probability Distributions in R ###
######################################

# Case 1 Discrete distributions
# X random quantity with integer values
# Distr. of X depends on certain parameters ...
# Tasks: - Simulation of X
# 	 - Compute P(X=x)
# 	 - Compute P(X <= x)
#
# Example: Hypergeometric distributions
# Urn containing N balls, m balls are marked, n = N-m balls are unmarked.
# Draw randomly k balls without replacement.
# X = number of marked balls in the sample.
# 
# Ex. Swisslotto
# N = 45
# m = 6    (winning numbers are marked)
# n = 39   (losing numbers)

# General remarks:
#
# For each family of distributions ("Family") there
# are four basic procedures:
# For a random variable X with distribution
# Family(par1, par2, ...),
# 
# - dFamily(x, par1, par2, ...) = Prob(X = x)
#      in case of discrete distributions
#      (hypergeometric, binomial, ...);
#   dFamily(x, par1, par2, ...) = density at x
#      in case of continuous distributions
#      (normal, gamma, ...);
# 
# - pFamily(q, par1, par2, ...) = Prob(X <= q);
# 
# - qFamily(p, par1, par2, ...) : the p-quantile of
#      that distribution, i.e. the smallest point q
#      such that pFamily(q, par1, par2, ...) >= p.
# 
# - rFamily(nn, par1, par2, ...) :
#      simulate nn independent random variables with
#      distribution Family(par1, par2, ...).


# Example: Hypergeometric distributions
#          Family = hyper.

help.search("hypergeometric")
? Hypergeometric

# An urn containing N balls, m of which are marked and
# n = N - m are unmarked. Then one draws k balls at
# random without replacement and determines
#    X = number of marked balls in that sample.
# This random variable X has a hypergeometric
# distribution with parameters
# - N, m, k  (convention of most textbooks),
# - m, n, k  (convention used by R, unfortunately).

# Example: Swisslotto
# Urn with 45 balls.
# m = 6 balls "marked", i.e. chosen by player!
# k = 6 balls drawn officially.
# X = number of correct choices.

m <- 6
k <- 6
N <- 45

# Possible values of X ~ hyper(m,N-m,k):
# Obviously, X cannot be smaller than 0 or
# larger than min(m,k). If m > N-k, X has
# to be at least m - (N-k) = m+k-N.
x <- max(0,m+k-N):min(m,k)
x

# Probabilities P(X = x[i]), 1 <= i <= length(x):
dhyper(6,m,N-m,k)
dhyper(3,m,N-m,k)
dx <- dhyper(x,m,N-m,k)
dx
cbind(x,dx)

# Bar plot of these probabilities:
barplot(dx,names.arg=x)

sim <- 100 # number of random simulations.
Y <- rhyper(sim,m,N-m,k)
Y
max(Y)
str(Y)
# Teach R that Y has possible values
# specified by x:
#declare possible values for Y, IS A NEW DATATYPE
Y <- factor(Y, levels=x)
Y
str(Y)

# Table of absolute frequencies in the sample:
# not-observed values have a zero! that's why we introduced levels!
table(Y)
# Table of relative frequencies in the sample:
dx.emp <- table(Y)/sim
dx.emp
barplot(dx.emp,names.arg=x)

# Plotting theoretical (left) and empirical (right)
# probabilities in one window:
par(mfrow=c(1,2))
barplot(dx,names.arg=x,col="red")
barplot(dx.emp,names.arg=x,col="blue")

# Several simulations (to be repeated):
sim <- 100 # Try different values of sim!
Y <- rhyper(sim,m,N-m,k)
Y <- factor(Y, levels=x)
dx.emp <- table(Y)/sim
par(mfrow=c(1,2))
barplot(dx,names.arg=x,col="green")
barplot(dx.emp,names.arg=x,col="blue")

# Alternative: theoretical and empirical
# probabilities in one plot:
sim <- 100
Y <- rhyper(sim,m,N-m,k)
Y <- factor(Y, levels=x)
dx.emp <- table(Y)/sim
par(mfrow=c(1,1))
barplot(rbind(dx,dx.emp),
	names.arg=x,
	beside=TRUE,
	col=c("green","blue"))


# Exercise (non-graded):

# Write a program doing the previous
# calculations, simulations and plots:
# 
# Function name: HyperDemo()
# Input:
# - N,m,k : parameters of hypergeometric
#           distribution (textbook convention).
# - sim : number of simulations
# Task: plot theoretical and empirical weights
# Output: List of
# - all input parameters,
# - x: potential values,
# - dx: vector of theoretical probabilites,
# - dx.emp: vector of empirical probabilities.

# Continuing the Swisslotto example:
# Illustration of distribution function phyper()
# and quantile function qhyper():


# distribution function:
Fx <- phyper(x,m,N-m,k)
Fx
cbind(x,dx,Fx)

help.search("step function")
sf <- stepfun(x,c(0,Fx))
plot.stepfun(sf)
plot.stepfun(sf,verticals=FALSE)
plot.stepfun(sf,lw=2,pch="")
plot.stepfun(sf,lw=2,pch=16)

# Read off various quantiles from the
# latter graph:
abline(h=0.01,col="red")
abline(h=0.05,col="red")
abline(h=0.25,col="red")
abline(h=0.50,col="red")
abline(h=0.75,col="red")
abline(h=0.95,col="red")
abline(h=0.99,col="red")
# Thus
# -  1%-quantile = 0
# -  5%-quantile = 0
# - 25%-quantile = 0
# - 50%-quantile = 1
# - 75%-quantile = 1
# - 95%-quantile = 2
# - 99%-quantile = 3

# Comparison with qhyper():
pv <- c(0.01,0.05,0.25,0.50,0.75,0.95,0.99)
qhyper(pv,m,N-m,k)
cbind(pv,qhyper(pv,m,N-m,k))


# Capture-Recapture Experiments
# Population of unknown size N.
# To gain information about N, perform a two-step experiment:
# Catch 1: Catch and mark and release m individuals
# Catch 2: Catch anew k individuals and determine X = number of marked individuals in 2nd Catch
# Assumption: First Catch doesn't influence second catch