### Earnings
# Function computing the amount of money on a savings account
# with starting capital S
# yearly interest rate rp (in %)
# after d days (default 30)
# or after y years (default 1)
# Caveats: assumes interest is paid daily
Earnings <- function(S, rp, y=1, d) 
{
  if (missing(d)) {    
    return (cbind(years=y, S=(S*(1+rp/100)^y)))
  }
  else {
    DAYS_OF_YEAR = 365
    return (cbind(days=d, S=S*(1+rp/100)^(d/DAYS_OF_YEAR)))
  }
}