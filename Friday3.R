# Date: Friday, August 10, 2012

#################################
### Installing and Activating ###
### Additional Packages       ###
#################################

### Built-in packages ###

# R comes with lots of packages not all of
# which are activated. To see, which packages
# are available:
library()

# To get more info on certain packages:
help(package=class)
help(package=KernSmooth)
# To find out more about a single function:
help(locpoly)
? locpoly
?? locpoly
# The corresponding package hasn't been
# loaded yet. To activate it:
library(KernSmooth)
# Another try:
? locpoly

# Example:
X <- rnorm(500,mean=180,sd=7)
   # simulate a random sample from
   # a Gaussian distribution.
par(mfrow=c(2,1))
hist(X,breaks=seq(150,210,by=2),
	col="blue",freq=FALSE)
rug(X)
res <- locpoly(X,bandwidth=2)
str(res)
plot(res$x,res$y,type="l",lwd=2,col="blue")
rug(X)

# The same plots with the underlying true
# density f superimposed:
xx <- seq(150,210,length.out=501)
fxx <- dnorm(xx,mean=180,sd=7)
X <- rnorm(500,mean=180,sd=7)
par(mfrow=c(2,1))
hist(X,breaks=seq(150,210,by=2),
	col="blue",freq=FALSE)
lines(xx,fxx,col="green",lwd=2)
rug(X)
res <- locpoly(X,bandwidth=2)
str(res)
plot(xx,fxx,type="l",col="green",lwd=2)
lines(res$x,res$y,lwd=2,col="blue")
rug(X)


### External Packages ###

# Example: pvclass

# Installing while running R and
# having reasonable access to the internet:
install.packages("pvclass")
# but don't do this now!
   
# I this doesn't work, go to the CRAN website
# and download the package directly:
# download the binary, (unzip it,) put it into
#  the subfolder "library" of your local folder
#  "R"...).

library(pvclass)
help(package=pvclass)
help(cvpvs)
# Searching through the index and examples ...
# Repeat one of the examples there:
iris
str(iris)
# All but three observations of the iris data:
X <- iris[c(1:49,51:99,101:149),1:4]
Y <- iris[c(1:49,51:99,101:149),5]
# Treat the three remaining observations as
# "new" observations:
Xnew <- iris[c(50,100,150),1:4]
# P-values for class memberships:
pv <- pvs.logreg(Xnew,X,Y)
pv
analyze.pvs(pv)
