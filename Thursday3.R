Date: Thursday, August 9, 2012

####################################################
### Statistical Analysis of a Numerical Variable ###
### (continued)                                  ###
####################################################


### Inference about the mean ###
help.search("Mean")          # ???
help.search("student test")  # :-(
help.search("student")       # :-)
? t.test

ds <- read.table(file="StatWiSo2003.txt",
	header=TRUE,sep="\t")
X <- ds$MonMiete
X <- X[X > 0 & !is.na(X)]

t.test(X)
t.test(X,mu=500)

# Problems:
# - Distribution of X is strongly skewed
#   to the right, maybe the mean is not an
#   appropriate location parameter.
# - Sample mean is sensitive to outliers.
# - Student-confidence interval assumes
#   Gaussian distribution of X or "large
#   sample sizes.
# 
# Alternative: Focus on the median and other
# quantiles!


### Inference about quantiles ###

# To any distribution function F corresponds a
# quantile function Q: For 0 < p < 1, Q(p) is the
# unique point such that
#    F(q) <  p  for q < Q(p)  and
#    F(q) >= p  for q >= Q(p) .

# Illustration:
qq <- seq(0,2000,length.out=1001)
Fqq <- pgamma(qq,shape=4,scale=125)
plot(qq,Fqq,type="l",col="green",lwd=2,
	xlab="q",ylab="F(q)")
p <- c(0.25,0.5,0.75)
Qp <- qgamma(p,shape=4,scale=125)
Qp
abline(h=p,col="red")
abline(v=Qp,col="blue")

# Repeat this with different values of p ...
# Repeat this with a vector p ...


# Often the Median of F, defined as Q(0.5), is of
# particular interest.


# For a given p, one can compute confidence bounds for
# Q(p) as follows:

# Upper bound: Let Xs be the vector of the
# ordered observations X[i], i.e.
#    Xs[1] <= Xs[2] <= ... <= Xs[n] .
# If we fix an index k in {1,2,...,n},
#    Prob(Q(p) > Xs[k])
#     =  Prob(at least k observations are < Q(p)) .
# The number of observations less than Q(p) has a
# binomial distribution with parameters n and p',
# where p' <= p. Thus
#    Prob(Q(p) > Xs[k])
#     =  Prob(at least k observations are < Q(p)) .
#     =  binom(n,p')({k,k+1,...,n})
#     <=  binom(n,p)({k,k+1,...,n})
#     =  1 - pbinom(k-1,n,p) .
# Consequently, we should choose k = k(n,p,alpha) to be
# the minimal number k in {1,2,...,n+1} such that
#    1 - pbinom(k-1,n,p) <= alpha
# or, equivalently,
#    pbinom(k-1,n,p) >= 1 - alpha .
# With the built-in quantile function "qbinom" we may
# write
# 
#    k(n,p,alpha) = qbinom(1-alpha,n,p) + 1 .
# 
# Then our upper (1-alpha)-confidence bound for Q(p) is
# 
#    Xs[k(n,p,alpha)] .
# 
# In case of k(n,p,alpha) == n+1, this should be
# interpreted as
# 
#    Inf.

# Lower bound: Analogous considerations or a symmetry
# argument yield the lower (1-alpha)-confidence bound
#    Xs[l(n,p,alpha)]
# with
#    l(n,p,alpha) = n+1 - k(n,1-p,alpha) ,
# i.e.
# 
#    l(n,p,alpha) = n - qbinom(1-alpha,n,1-p) .
# 
# The our lower (1-alpha)-confidence bound for Q(p) is
# 
#    Xs[l(n,p,alpha)] .
#
# In case of l(n,p,alpha) == 0, this should be
# interpreted as
# 
#    - Inf.

# Confidence interval: A (1-alpha)-confidence interval
# for Q(p) is given by
# 
#    [ Xs[l(n,p,alpha/2)], Xs[k(n,p,alpha/2)] ]
# 
# with the same conventions in case of l==0 or k==n+1.

# Exercise: Complete the program
# QuantileCBs <- function(X,p=0.5,alpha=0.05)
# {
#    ...
# }
# in "QuantileCBs.R" for these tasks.

source("QuantileCBs.R")

ds <- read.table(file="StatWiSo2003.txt",
	header=TRUE,sep="\t")
X <- ds$MonMiete
X <- X[X > 0 & !is.na(X)]
QuantileCBs(X,p=0.5,alpha=0.01)
QuantileCBs(X,p=0.5,alpha=0.05)
QuantileCBs(X,p=0.5,alpha=0.10)
QuantileCBs(X,p=0.25,alpha=0.05)
QuantileCBs(X,p=0.75,alpha=0.05)
