### Hand-in-Exercise 2 ###

# Stefan Moser 09-277-013
 
CaptureRecapture <- function(m,k,X,alpha=0.05)
{
	# m+k-X is a trivial lower bound
	# for upper bound
	# case: X = 0, b(X,alpha) = b(X,a/2) = inf 
	a2 <- m + k - X
	while (phyper(X,m,a2-m,k) <= alpha/2) {
		a2 <- a2 + 1
	}
	a1 <- a2
	while (phyper(X,m,a1-m,k) <= alpha) {
		a1 <- a1 + 1
	}
	
	if (X == 0) {
		b1 = b2 = Inf
	} 
	else {
		b1 = m+k-X
		while (phyper(X-1,m,b1+1-m,k) < 1-alpha) {
			b1 = b1 + 1
		}
		b2 = b1
		while (phyper(X-1,m,b2+1-m,k) < 1-alpha/2) {
			b2 = b2 + 1
		}
	}

	return(list(point.estimator=round(k*m/X),
		lower.bound=a1,
		upper.bound=b1,
		confidence.interval=c(a2,b2),
		confidence.level=1-alpha))
}


# Example output for checking your program:

# > CaptureRecapture(20,20,3)
# $point.estimator
# [1] 133
# 
# $lower.bound
# [1] 64
# 
# $upper.bound
# [1] 459
# 
# $confidence.interval
# [1]  59 601
# 
# $confidence.level
# [1] 0.95

# > CaptureRecapture(20,20,3,alpha=0.01)
# $point.estimator
# [1] 133
# 
# $lower.bound
# [1] 55
# 
# $upper.bound
# [1] 845

# $confidence.interval
# [1]   52 1085
# 
# $confidence.level
# [1] 0.99

# > CaptureRecapture(20,40,0)
# $point.estimator
# [1] Inf
# 
# $lower.bound
# [1] 298
# 
# $upper.bound
# [1] Inf
# 
# $confidence.interval
# [1] 248 Inf
# 
# $confidence.level
# [1] 0.95



# Please send this file after completion to
# to one of the following six persons, depending on
# the first letter of your last name:
# 
# A-E:  lutz.duembgen@stat.unibe.ch
# F-I:  benjamin.baumgartner@stat.unibe.ch
# J-Me: josephine.daub@iee.unibe.ch
# Mo-R: sebastien.nussle@unil.ch  (or snussle@gmail.com)
# S:    anna.sramkova@iee.unibe.ch
# T-Z:  kaspar.stucki@stat.unibe.ch
# 
# You may submit in pairs (and, if necessary,
# toss a coin whom to send your solution to).
