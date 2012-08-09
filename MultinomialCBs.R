MultinomialCBs <- function(TX, p0, overall.alpha=0.05)
{
	levels = length(TX)
	n = sum(TX)
	p.emp <- TX/n
	
	a <- rep(0,levels)  # lower bounds
	b <- rep(1,levels)  # upper bounds
	inIntervall <- rep(TRUE, levels) # initialize with true
	
	for (j in 1:levels)
	{
		result <- binom.test(TX[j],n,
			conf.level=1-overall.alpha/levels)
		a[j] <- result$conf.int[1]
		b[j] <- result$conf.int[2]
		inIntervall[j] <- (TX[j] >= a[j] && TX[j] <= b[j])
	}
	return(cbind(Practical.values=TX,p.emp,p.theo=p0, a,b, sig=inIntervall))
}