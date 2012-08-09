Date: Thursday, August 9, 2012

####################################################
### Statistical Analysis of a Numerical Variable ###
####################################################


### Inference about an unknown ###
### distribution function      ###

# We consider a dataset with a numerical variable X and
# observations X[1], X[2], ..., X[n]

# Data example: Positive monthly rents of students
# in StatWiSo2003.txt:
ds <- read.table(file="StatWiSo2003.txt",
	header=TRUE,sep="\t")
str(ds)

# Extract rents:
X <- ds$MonMiete
X
# Get rid of zeros and NAs:
# Oh, you could put a condition there!
X <- X[X > 0 & !is.na(X)]
X
# Sort the values:
X <- sort(X)
X

# Simple summaries:
mean(X)
median(X)

# Popular graphical display: Histogram
hist(X)
hist(X,col="blue")
hist(X,col="blue", breaks=seq(0,2100, by=50))

# Graphical display: Instead of the popular but
# problematic histograms we use the empirical
# distribution function of the observations:
#    Fhat(q) = (number of i with X_i <= q)/n .
# is a stepfunction!

plot.ecdf(X)
plot.ecdf(X,pch="")
plot.ecdf(X,pch="",lwd=2)
plot.ecdf(X,pch="",lwd=2,verticals=TRUE)
plot.ecdf(X,pch="",lwd=2,verticals=TRUE,
	xlab="q",ylab="Fhat(q)",
	main="empirical c.d.f. of monthly rents")
grid()
grid(col="red")
rug(X)


# Statistical model: The X[i] are independent copies
# of a random variable X_o with (unknown) distribution
# function F, i.e.
#    Prob(X_o <= q)  =  F(q)   for any q .
# In our explicit example: F(q) = relative proportion
# of all students in Bern (in 2003) paying rent <= q
# among all students paying rent > 0. Here X_o stands
# for the monthly rent of a randomly chosen student
# from that population.

# Illustration of the concept of empirical and
# true distribution function:
# Use a so-called gamma distribution with parameters
# shape > 0, scale > 0. The mean of such a distribution
# is shape*scale, the standard deviation equals
# sqrt(shape)*scale. With the
# monthly rent in mind, we want to achieve
# mean = 500 (CHF) and standard deviation = 250,
# so ... shape = 4, scale = 250.

# Simulate random sample from gamma(shape=4,scale=125):
n <- 100
X <- rgamma(n,shape=4,scale=125)
# Plot Fhat:
plot.ecdf(X,verticals=TRUE,pch="",lwd=2,
	xlab="q",ylab="Fhat(q)",main="")
grid()
rug(X)
# Plot F:
qq <- seq(0,2000,length.out=1001)
Fqq <- pgamma(qq,shape=4,scale=125)
lines(qq,Fqq,col="green",lwd=2)

# Repeat this with different values of n ...

# Now we are a little more ambitious and want to
# first plot F and then superimpose Fhat:
plot(qq,Fqq,type="l",col="green",lwd=2,
	xlab="q",ylab="F(q), Fhat(q)")
# Generate new sample:
n <- 100
X <- rgamma(n,shape=4,scale=125)
# Plot Fhat "by hand":
xx <- c(0,rep(sort(X),each=2),max(2000,max(X)))
Fhatxx <- rep((0:n)/n,each=2)
lines(xx,Fhatxx,lwd=2)
grid()
rug(X)

# Again repeat this with different values of n ...

# A little more theory:
# One can show that for any t > 0,
#  Prob(|Fhat(q) - F(q)| > t for some q)
#   <= 2 * exp(- 2*n*t^2) ,
# regardless of the unknown F.
# Hence with probability at least 1 - alpha,
# the maximum of |Fhat(q) - F(q)| is no larger
# than
#    c(n,alpha) = sqrt(log(2/alpha) / (2*n)).
# In other words, with probability at least
# 1 - alpha, for each q, the unknown value of
# F(q) lies between
#    max(Fhat(q) - c(n,alpha), 0)
# and
#    min(Fhat(q) + c(n,alpha), 1)
# (Kolmogorov-Smirnov confidence band for F).


source("KSBand.R")


# Example to test your function on:
# (source("KSBand.R"))
ds <- read.table(file="StatWiSo2003.txt",
	header=TRUE,sep="\t")
X <- ds$MonMiete
X <- X[X > 0 & !is.na(X)]
KSBand(X,alpha=0.05,qmin=0)
KSBand(X,alpha=0.01,qmin=0)
KSBand(X,alpha=0.1,qmin=0)
KSBand(X,alpha=0.1,qmin=0,qmax=2000)

# Illustration of the K-S-bands
# with simulated data:
qq <- seq(0,2000,length.out=1001)
Fqq <- pgamma(qq,shape=4,scale=125)
n <- 500
X <- rgamma(n,shape=4,scale=125)
KSBand(X,0.05,qmin=0,qmax=2000,qq=qq,Fqq=Fqq)
