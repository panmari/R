### fibonacci (you know what this does..)
Fibonacci1 <- function(n1=1, n2=1, kmax=10) 
{
  if (kmax == 1)
  {
    return (n1)
  }
  else 
  {
    return (Fibonacci1(n2, n1+n2, kmax-1))
  }
}

Fibonaci2 <- function(n1=1, n2=1, kmax=10)
{
  #todo
}