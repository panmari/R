QuantileCBs <- function(X,p=0.5,alpha=0.05)
# Compute (1-alpha)-confidence bounds and
# a (1-alpha)-confidence interval for the
# p-quantile of a distribution, based on a
# sample X.
{
	# Vector of ordered observations:
	Xs <- sort(X[!is.na(X)])

	# Sample size:
	n <- length(Xs)
		
	# Index for lower bound:
	l1 <- n - qbinom(1-alpha,n,1-p)
	# Resulting lower bound:
	if (l1 >= 1)
	{LB1 <- Xs[l1]}
	else
	{LB1 <- -Inf}
	
	# Index for upper bound:
	k1 <- 1 + qbinom(1-alpha,n,p)
	# Resulting upper bound:
	if (k1 <= n)
	{UB1 <- Xs[k1]}
	else
	{UB1 <- Inf}
	
	# Index for lower bound in conf.interval:
	l2 <- n - qbinom(1-alpha/2,n,1-p)
	# Resulting lower bound in conf.interval:
	if (l2 >= 1)
	{LB2 <- Xs[l2]}
	else
	{LB2 <- -Inf}

	# Index for upper bound in conf.interval:
	k2 <- 1 + qbinom(1-alpha/2,n,p)
	# Resulting upper bound in conf.interval:
	if (k2 <= n)
	{UB2 <- Xs[k2]}
	else
	{UB2 <- Inf}

	return(list(
		Xs=Xs,
		n=n,
		p=p,
		alpha=alpha,
		conf.level=1-alpha,
		index.for.lower.bound=l1,
		index.for.upper.bound=k1,
		indices.for.conf.interval=c(l2,k2),
		lower.conf.bound=LB1,
		upper.conf.bound=UB1,
		conf.interval=c(LB2,UB2)
	))
}