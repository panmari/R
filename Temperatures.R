### Various programs for temperature conversion ###

Temperature1 <- function(temp)
# This method converts the given value into degree Fahrenheit
# The given value(s) must be in degree Celsius to generate a valid output
{
	return(temp*1.8 + 32)
}

Temperature1B <- function(temp)
# This method converts the given value into degree Fahrenheit
# The given value(s) must be in degree Celsius to generate a valid output
{
	return((temp - 32)/1.8)
}

### Programm 2: One program doing both conversions 
# and returning a table
Temperature2 <- function(celsius, fahrenheit, kelvin) 
# The user specifies only one of the two input argument; the program then
# provides the other value(s)
{
  # If celsius is given, compute fahrenheit
  if (!missing(celsius))
  {
    fahrenheit <- Temperature1(celsius)
    kelvin <- celsius + 273.15
    }
  if (!missing(fahrenheit))
  {
    celsius <- Temperature1B(fahrenheit)
    kelvin <- celsius + 273.15
    }
  if (!missing(kelvin))
  {
    celsius <- kelvin - 273.15
    fahrenheit <- Temperature1(celsius)
    }
  return(cbind(celsius=celsius, fahrenheit=fahrenheit, kelvin=kelvin)) # with column descriptions!
}