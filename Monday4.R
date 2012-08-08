# Date: Monday, August 6, 2012

######################################
### Writing Programs - First Steps ###
######################################

# General structure of a function:
#
# Name_of_function <- function(input argument(s))
# {
#		... commands to be executed ...
#		return(output)
# }


# A file "filename.R" may be a
# - script file: a collection of executable commands
#                plus comments (please!)
# - function file: contains the code of one or several
#                  functions plus comments (please!)
# It may be a mixture of both, but mixing usual
# commands and function code is not recommended!

# Now open a new file and call it "Temperatures.R" ...

# Two ways to compile a function:
# (1) Mark and execute full text, then use the function
# within Console (command window) or script files... 
# (2) Run the command "source("filename")" to compile
# all functions in a function file; then use the function(s)
# within Console (command window) or script files...

source("Temperatures.R")

# Example 1:
# A function "Temperature1()" converting
# temperatures in degrees of Celsius into
# degress of Fahrenheit...

Temperature1(25)
Temperature1B(Temperature1(20:30))


# Exercise:
# Write a function "Temperature1B()" converting
# temperatures in degrees of Fahrenheit into
# degrees of Celsius...

source("Temperatures.R")

Temperature1B(80)
Temperature1B(seq(50,100,by=5))


# Example 2:
# A function "Temperature2()" converting
# temperatures in degrees of Celsius or Fahrenheit
# into degress of Fahrenheit or Celsius ...

Temperature2(celsius=25)
Temperature2(fahrenheit=100)
Temperature2(celsius=seq(0,30,by=5))
Temperature2(fahrenheit=seq(0,100,by=5))

# Example 3:
# A function "Temperature3()" converting
# temperatures in any scale into the three scales
# Celsius, Fahrenheit and Kelvin...

Temperature3(fahrenheit=seq(0,100,by=5))

result <- Temperature3(k=299:310)
result
result$celsius
result$fahrenheit
result$kelvin
result$all.scales


# Examples 4-5: Fibonacci sequences; see Fibonacci.R

source("Fibonacci_etc.R")

Fibonacci1(n1=3,n2=4,kmax=10)

Fibonacci2(kmax=20)

# Comment about graphics in Fibonacci2():
# In general, the command "par(mfrow)=c(nr,nc)"
# opens a graphics window with a (still invisible)
# plot matrix, nr rows and nc columns.
# ("mfrow" =
#  "m(ultiple) f(rame) (to be filled) row(-wise)")
# Any call of "plot()" will fill one position of
# this plot matrix, the order is row-wise.
# To fill a plot matrix column-wise, use the
# command "par(mfcol)=c(nr,nc)"...

# General comments about input arguments of functions,
# argument names and default values:
# When writing a function of the form
#    NameF <- function(a1,a2,a3,...)
# one may specify default values for some of the input
# arguments a1,a2,a3,...:
#    NameF <- function(a1=def1,a2=def2,a3,...).
# When calling a function, one can cite the names in the
# function declaration. That way one can change the order
# of the input arguments or omit some.
# 
# With explicit numbers or current variables v1, v2, v3, ...
# one may type
#    NameF(v1,v2,v3,...)
# or
#    result <- NameF(v1,v2,v3,...)
# to execute Fname with a1=v1, a2=v2, a3=v3, ... .
# In the first case, the result is displayed in the console
# window, in the latter case, the output is saved to a
# variable "result" and may be used later.
#
# If one knows that, say, a1 and a2 have default values one
# is happy with, one may also type
#    result <- NameF(a3=v3,...) .
# Here it is important that all arguments are typed with
# their name specifier ("ak=vk"), because now the order of
# the specified arguments differs from the order in the
# function code...


# Exercise: Modify the program "Fibonacci2.R" such that
# the population model is a little more realistic and
# flexible:
# Any individual lives d years. In its j-th year of life
# it produces (on averge) offspring[j] newborns.
# Input parameters:
# - n.init: a vector describing the age distribution
#           in the first year,
#           n.init[j] = number of individuals at age j.
# - offspring: a vector of (mean) offspring numbers
#              as mentioned above.
# - kmax: maximal number of years to be considered.
# (The number d is hidden in the vectors n.init and
#  offspring.)
# 
# Output:
# - n: a matrix with kmax rows and d columns, where
#      n[k,j] = number of individuals at age j in year k.
# - graphics of
#   - total population sizes,
#   - increases of population sizes, and
#   - age distributions (percentages of different
#                        age groups).

source("Earnings.R")
Earnings(100, 5, y = 10)
Earnings(100, 5, d = 10)