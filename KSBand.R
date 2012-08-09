KSBand <- function(X,alpha=0.05,
	qmin=1.1*min(X,na.rm=TRUE)-0.1*max(X,na.rm=TRUE),
	qmax=1.1*max(X,na.rm=TRUE)-0.1*min(X,na.rm=TRUE),
	qq,Fqq)
{
	# getting rid of NAs and sorting X:
	X <- X[!is.na(X)]
	X <- sort(X)
	# Note: such changes to X are local and do not
	# affect the input vector the procedure was
	# called with from outside.
	
	# Effective sample size:
	n <- length(X)
	c <- sqrt(log(2/alpha)/2/n)
	
	# Correct qmin and qmax if necessary:
	qmin <- min(qmin,X[1])
	qmax <- max(qmax,X[n])
	
	# Create auxiliary vectors for plot:
	xx <- c(qmin,rep(X,each=2),qmax)
	Fhatxx <- rep((0:n)/n,each=2)
	LB <- pmax(Fhatxx - c, 0)
	UB <- pmin(Fhatxx + c, 1)
	
	# Plot:
	plot(xx,Fhatxx,type="l",lwd=2,
		xlab="q",ylab="Fhat(q)",
		main="")
	lines(xx,LB,lwd=1)
	lines(xx,UB,lwd=1)
	grid()
	rug(X)
	if (!missing(qq) && !missing(Fqq))
	{
		lines(qq,Fqq,lwd=1,col="green")
		lines(qq,Fqq,lty=3,col="blue")
	}
	
	# Output:
	return(list(
		xx=xx,
		Fhatxx=Fhatxx,
		LB=LB,
		UB=UB,
		n=n,
		c=c,
		conf.level=1-alpha
	))
}