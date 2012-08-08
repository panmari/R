# Date: Monday, August 6, 2012

###########################
### Arrays and Patterns ###
### (and some plots)    ###
###########################


# There are various possibilities to create
# one-dimensional arrays (vectors):
# 
# If x is an array, x[j] is its j-th component.
# length(x) is the number of its components.

# The simplest command to generate an array is
# the command c(ombine)(...):

x <- c(1.8, 6, 7.5)
x
# Careful, the first element is indeed number 1, not 0
x[1]
x[2]
x[3]

length(x)

y <- c(x, 30, 1000)
y
y[3:5]

length(y)


# Creation of arrays with regular patterns:

# For integers a <= b,
#    x <- a:b
# generates an array x with components
# a, a+1, a+2, ..., b.
# In case of a > b, one obtains a vector with components
# a, a-1, a-2, ..., b.

x <- -5:5
x

x <- 10:0
x

# To obtain different increments, use seq(...),
# seq standing for "sequence":

x <- seq(0,10,by=0.1)
x

x <- seq(0,10,by=0.7)
x

x <- seq(0,10,length.out=201)
x

x <- seq(0,10,length.out=77)
x

# Create a vector y with components
# y[i] = sin(x[i]):
y <- sin(x)
y

# Visualize the two vectors:
plot(x,y)
plot(y) #Just numbers the components, using this as x axis.
# p(oint) ch(aracter):
plot(x,y,pch="+")
plot(x,y,pch=16)
plot(x,y,pch=25)

# Obviously, the procedure plot(.) has
# many options. To find out more about it:
? plot

# Line plots:
plot(x,y,type="l")

plot(x,y,type="l",lty=2)
plot(x,y,type="l",lty=3)
plot(x,y,type="l",lty=1,col="red")
plot(x,y,type="l",lty=1,col="red",lwd=5)

# plot(..) always starts a new plot,
# i.e. overwrites an existing plot.
# To add further plots, use points()
# or lines()

plot(x,y,type="l",lty=1,col="red",lwd=5)
points(x,cos(x),type="l",col="blue")
lines(x,cos(x-0.1*pi),col="magenta")
points(x,cos(x-0.2*pi),pch=4,col="cyan")


# Help files:
# 
# help.search("key word(s)"):
#    Useful, if one has only a vague idea.
#
# help("name_of_fct")
#  or help(name_of_fct)
#   or ? name_of_fct :
#    Useful if one knows that there is a function
#    called name_of_fct

help.search("sequence")

help("seq")
help(seq)
?seq

# Building up larger arrays from smaller ones:
# rep(...) !

?rep

# Try to generate with rep() rather than c(...):
x = c(1,2,3, 1,2,3, 1,2,3, 1,2,3, 1,2,3, 1,2,3, 1,2,3)
x
y = c(1,1,1,1, 2,2,2,2, 3,3,3,3)
y
z = c(1,1,1,1,1,1,1, 2,2,2,2,2, 3,3,3, 4)
z
rep(1:4, times=c(7,5,3,1))

# Try yourself - don't read on yet...


# Solutions:
rep(1:3, 7)
rep(1:3, times=7)

rep(1:3, each=4)

rep(1:4, times=c(7,5,3,1))
rep(c(1,2,3,4), times=c(7,5,3,1))
rep(1:4, times=seq(7,1,by=-2))
# Note that the usage of "times" and "each" is not
# entirely coherent...

# There are arrays of other objects,
# e.g. character strings:
x <- c("Frieda","Fritz","Frederik") 
rep(x, times= 4)
rep(x, each=5)
rep(x, times=c(4, 1, 2))
rep(c("misch", "fa", "lea"), times=c(100, 50,23))

x = seq(0,1, length.out=10000)
y = x*sin(2*pi/x)
y[1] = 0
plot(x, y, type="l", ylab="x*sin(2*pi/x)", main="Mein erster Plot")
lines(x,x, col="Cyan")
lines(x,-x, col="Cyan")

#version number 2, higher resolution the closer to 0! 
# also doesn't create any nans
x <- 1/seq(500,1,-0.02)
y <- x*sin(2*pi/x)
plot(c(0,x),c(0,y), type = "l", ylab="x*sin(2*pi/x)", main="Lösungsplot")