### Some simple deterministic models for ###
### the growth of (female) populations   ###
 

Fibonacci1 <- function(n1=1,n2=1,kmax=10)
# Computes and displays a Fibonacci sequence.
# n[1], n[2], n[3], ... are the population sizes
# in generations 1, 2, 3, ...  and satisfy
#     n[k] = n[k-1] + n[k-2]
# Input: n1, n2 and kmax = maximal number
#        of generations to be considered.
# Output: n = vector with population sizes
#         in years 1, 2, ..., kmax.
{
	# Initialize output vector n
	# of population sizes:
	n <- rep(0,kmax)
	n[1] <- n1
	n[2] <- n2
	# Compute
	for (k in 3:kmax)
	{
		n[k] <- n[k-1] + n[k-2]	
	}
	plot(1:kmax,n,pch=16,
		xlab="t",ylab="n(t)",
		main="Population sizes")
	return(n)
}

Fibonacci2 <- function(n1=1,n2=1,kmax=10)
# Does the same as Fibonacci1().
# In addition, the ratios of two
# consecutive population sizes are plotted.
{
	n <- rep(0,kmax)
	n[1] <- n1
	n[2] <- n2
	for (k in 3:kmax)
	{
		n[k] <- n[k-1] + n[k-2]	
	}
	ratios <- n[2:kmax]/n[1:(kmax-1)]

	# Need a plot window with two plots:
	par(mfrow=c(2,1))
	plot(1:kmax,n,pch=16,
		xlab="t",ylab="n(t)",
		main="Population sizes")
	plot(2:kmax,ratios,pch=16,
		xlim=c(1,kmax), #specifies limits in x-axis
		xlab="t",ylab="n(t)/n(t-1)",
		main="Ratios of two consecutive population sizes")
	# add a horizontal line with the limit
	# of the ratios as k --> infinity:
	limit <- (1 + sqrt(5))/2
	# limit = solution x > 1 of the equation
	# x^2 = x + 1.
	abline(h=limit,col="blue")

	return(list(n=n,ratios=ratios))
}


#everybody survives by default!
PopulationGrowth1 <- function(n.init,offspring,survival=rep(1,length(n.init)-1),kmax=20)
{
	# Determine d: (aka maximal number an individual can live)
	d <- length(offspring)

	# Initialize and compute matrix n:
	n <- matrix(0,nrow=kmax,ncol=d)
	n[1,] <- n.init
	
	
	for (k in 2:kmax)
	{
		n[k,2:d] <- n[k-1,2:d-1]*survival[2:d-1]
  
		n[k,1] <- sum(n[k,2:d]*offspring[2:d])
	}

	# Compute population sizes:
	pop.size <- rep(0,kmax) #initialize vectors of right size
	
	# or apply(n,1,sum)
	pop.size = rowSums(n)
	
	# Compute population size ratios:
	pop.incr <- pop.size[2:kmax]/pop.size[1:(kmax-1)]
	
	# Compute age distributions:
	age.distr <- n
	### At least one of the following two nested
	### loops can be avoided!
	#done
	for (k in 1:kmax)
	{
		age.distr[k,1:d] <- n[k,1:d]/pop.size[k]
	}

	# Graphical displays:
	par(mfrow=c(2,2))

	# Plot population sizes:
	plot(1:kmax,pop.size,type="l",col="blue",
		main="population sizes",xlab="year",ylab="")
	points(1:kmax,pop.size,pch=16)
	# Plot population increases:
	plot(2:kmax,pop.incr,type="l",col="blue",
		main="population size ratios",xlab="year",ylab="",
		xlim=c(1,kmax))
	points(2:kmax,pop.incr,pch=16)
	# Plot age distributions:
	barplot(t(age.distr), main="age distributions in percent",xlab="year",ylab="")
	barplot(t(n), main="age distributions by numbers",xlab="year",ylab="")
	return(list(n=n, pop.size=pop.size,pop.incr=pop.incr,
		age.distr=age.distr))
}
