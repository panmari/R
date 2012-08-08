# Date: Wednesday, August 8, 2012

#####################################
### Capture-Recapture Experiments ###
### (continued)                   ###
#####################################

# The first goal today is to write a program
# providing confidence bounds and and a confidence
# interval for a population size N via
# capture-recapture experiments.
# 
# The underlying principle is illustrated now:


### Consideration 1: ###
 
# For a given error bound alpha in (0,1) and
# for any hypothetical value N0 of N we can
# identify points which are "too small" for
# N0, i.e. a critical value c(N0) such that
#    P(X <= c(N0)) <= alpha  if N = N0.
# 
# (c(N0) is chosen as large as possible.)

m <- 20
k <- 20
N0 <- c(40,50,60,70)
x <- 0:min(m,k)
alpha <- 0.1 		#fixed error bound, typically 5%

# Illustrate the critical values c(N0):

par(mfcol=c(2,length(N0)))
for (i in 1:length(N0))
{
	dx <- dhyper(x,m,N0[i]-m,k)
	Fx <- phyper(x,m,N0[i]-m,k)
	c <- min(x[Fx > alpha]) - 1
	barplot(dx,names.arg=x,col=c("blue","red")[1+(x <= c)],
		main=paste("N0 = ",
			as.character(N0[i]),
			", c(N0) = ",
			as.character(c),
			sep=""),
		xlab="x",ylab="P(X = x)")
	sf <- stepfun(x,c(0,Fx))
	plot.stepfun(sf,lw=2,pch="",
		main=paste("N0 = ",
			as.character(N0[i]),
			", c(N0) = ",
			as.character(c),
			sep=""),
		xlab="x",ylab="P(X <= x)")
	abline(h=alpha,col="red",lwd=2)
}

# Show for all values N0 = 20, 21, 22, ...
# which values x are "normal" (blue) and which
# are "too small" (red):

N0min <- 20
N0max <- 100
par(mfcol=c(1,1),mai=c(1,1,0,0))
plot(NULL,
	xlim=c(min(x),max(x)),ylim=c(N0min,N0max),
	xlab="x",ylab="N0")
for (N0 in N0min:N0max)
{
	Fx <- phyper(x,m,N0-m,k)
	points(x,rep(N0,length(x)),
		col=c("blue","red")[1 + (Fx <= alpha)],
		pch=16)
}

# Looking at the previous plot and coming back
# to our original problem, when performing a
# capture-recapture experiment, the point (X,N)
# will be a blue point with probability at least
# 1 - alpha, because by definition of the critical
# values c(N0),
#    P(X <= c(N)) <= alpha .
# 
# These considerations lead to a
# lower (1 - alpha)-confidence bound for N:
#    a(X,alpha) = minimal value N0 such that
#                 X > c(N0)
#               = minimal value N0 such that
#                 phyper(X,m,N0-m,k) > alpha !
# 
# Interpretation/Use:
# With confidence 1-alpha we may claim that
#    N >= a(X,alpha).
# 
# Note: A trivial lower bound for N is
#       m + k - X,
# because we have seen and marked m individuals
# in the first round, and in the second round we
# have seen k - X new (unmarked) individuals.


### Consideration 2: ###

# For a given error bound alpha in (0,1) and
# for any hypothetical value N0 of N we can
# identify points which are "too large" for
# N0, i.e. a critical value d(N0) such that
#    P(X > d(N0)) <= alpha  if N = N0.
# 
# Equivalently:
#    P(X <= d(N0)) >= 1-alpha  if N = N0.
# 
# (d(N0) is chosen as small as possible.)

m <- 20
k <- 20
N0 <- c(40,50,60,70)
x <- 0:min(m,k)
alpha <- 0.1

# Illustrate the critical values d(N0):

par(mfcol=c(2,length(N0)))
for (i in 1:length(N0))
{
	dx <- dhyper(x,m,N0[i]-m,k)
	Fx <- phyper(x,m,N0[i]-m,k)
	d <- min(x[Fx >= 1-alpha])
	# d = qhyper(1-alpha,m,N0[i]-m,k)
	barplot(dx,names.arg=x,col=c("blue","red")[1+(x > d)],
		main=paste("N0 = ",
			as.character(N0[i]),
			", d(N0) = ",
			as.character(d),
			sep=""),
		xlab="x",ylab="P(X = x)")
	sf <- stepfun(x,c(0,Fx))
	plot.stepfun(sf,lw=2,pch="",
		main=paste("N0 = ",
			as.character(N0[i]),
			", d(N0) = ",
			as.character(d),
			sep=""),
		xlab="x",ylab="P(X <= x)")
	abline(h=1-alpha,col="red",lwd=2)
}

# Show for all values N0 = 20, 21, ..., 100
# which values x are "normal" (blue) and which
# are "too large" (red):

N0min <- 20
N0max <- 100
par(mfcol=c(1,1),mai=c(1,1,0,0))
plot(NULL,
	xlim=c(min(x),max(x)),ylim=c(N0min,N0max),
	xlab="x",ylab="N0")
for (N0 in N0min:N0max)
{
	Fx <- phyper(x,m,N0-m,k)
	d <- min(x[Fx >= 1-alpha])
	points(x,rep(N0,length(x)),
		col=c("blue","red")[1 + (x > d)],
		pch=16)
}

# Looking at the previous plot and coming back
# to our original problem, when performing a
# capture-recapture experiment, the point (X,N)
# will be a blue point with probability at least
# 1 - alpha, because by definition of the critical
# values d(N0),
#    P(X <= d(N)) >= 1 - alpha .
# 
# These considerations lead to an
# upper (1 - alpha)-confidence bound for N:
#    b(X,alpha) = maximal value N0 such that
#                 X <= d(N0)
#               = maximal value N0 such that
#                 phyper(X-1,m,N0-m,k) < 1 - alpha !
# 
# Interpretation/Use:
# With confidence 1-alpha we may claim that
#    N <= b(X,alpha).
# 
# Note: In case of X = 0,
#    b(X,alpha) = Inf.


### Consideration 3: ###
# 
# If we want to have a lower and an upper bound
# for N simultaneously, we should compute the
# (1-alpha)-confidence interval
# 
#    [a(X,alpha/2), b(X,alpha/2)] .
# 
# With confidence 1-alpha we may claim that
# N lies within this interval.


### Summary and explicit procedure: ###
# 
# The starting point are the four numbers
#    m, k  (design of the capture-recapture experiment)
#    X     (observation in the experiment, random)
#    alpha (error bound).
# 
# We first compute the lower bound a2 of our
# (1-alpha)-confidence interval, i.e.
#    a2 = minimal number satisfying
#         phyper(X,m,a2-m,k) > alpha/2.
# To this end we start with a2 = m+k-X. As long as
# phyper(X,m,a2-m,k) <= alpha/2 we increase a2 by one...
# 
# Now we compute the lower (1-alpha)-confidence bound
#    a1 = minimal number satisfying
#         phyper(X,m,a1-m,k) > alpha.
# To this end we start with a1 = a2. As long as
# phyper(X,m,a1-m,k) <= alpha we increase a1 by one...
# 
# Next we want to compute the upper bound
#    b1 = maximal number satisfying
#         phyper(X-1,m,b1-m,k) < 1-alpha
# and the upper bound b2 of our (1-alpha)-confidence
# interval, i.e.
#    b2 = maximal number satisfying
#         phyper(X-1,m,b2-m,k) < 1-alpha/2
# 
# In case of X = 0, nothing has to be done because
#    b1 = b2 = Inf.
# 
# In case of X >= 1, we start with b1 = m+k-X. As long as
# phyper(X-1,m,b1+1-m,k) < 1-alpha we increase b1 by one...
# 
# Then we set b2 = b1. As long as
# phyper(X-1,m,b1+1-m,k) < 1-alpha/2 we increase b2 by one...


# The previous computations may be performed with
# while-loops:
# 
# while (condition)
# {
# 	... commands to be executed
#       as long as 'condition' is satisfied ...
# }
# 
# When implementing a while-loop one has to make
# sure that the condition will be violated eventually.
# Otherwise your program won't terminate!



### Hand-in-exercise 2: ###
# 
# Self-written program CaptureRecapture.R:
# Input:
# - m,k,X : see above;
# - alpha : parameter for confidence bounds
#           and confidence interval
#           (probability that a bound or the
#            interval is not correct is no
#            larger than alpha).
#
# Output:
# - point.estimator: point estimator for N
#         (assuming that m/N = X/k approximately
#          leads to point.estimator = round(m*k/X));
# - lower.bound: lower (1-alpha)-confidence bound
#                for N;
# - upper.bound: upper (1-alpha)-confidence bound
#                for N;
# - confidence.interval: (1-alpha)-confidence
#                        interval for N;
# - confidence.level: 1-alpha.


source("Exercise2.R")

CaptureRecapture(20,20,3)
CaptureRecapture(m=20,k=20,X=3,alpha=0.05)
# Interpretation of the confidence interval:
# If a capture-recapture experiment is performed with
# m = 20, k = 20 and observation X = 3, one may claim
# with confidence 1-alpha=95% that the unknown
# population size is between 59 and 601.
# 
# Interpretation of the lower bound:
# If a capture-recapture experiment is performed with
# m = 20, k = 20 and observation X = 3, one may claim
# with confidence 1-alpha=95% that the unknown
# population size is at least 64.
# 
# Interpretation of the upper bound:
# If a capture-recapture experiment is performed with
# m = 20, k = 20 and observation X = 3, one may claim
# with confidence 1-alpha=95% that the unknown
# population size is at most 459.
# 
# The user should know himself/herself a priori
# whether he/she needs an interval or just a lower
# bound or just an upper bound.

CaptureRecapture(20,20,3,alpha=0.05,illustrate=TRUE)

CaptureRecapture(20,20,1,alpha=0.01)
CaptureRecapture(20,20,1,alpha=0.05)
CaptureRecapture(20,20,1,alpha=0.10)