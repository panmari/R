# Date: Tuesday, August 7, 2012

################################################
### Some more programming                    ###
### Simple (deterministic) population models ###
################################################

# Some syntax we have used or shall use:
# 
# if (condition)
# {
#     ... commands to be executed
#     ... if 'condition' is satisfied
# }
# 
# if (condition)
# {
#    ... commands to be executed
#    ... if 'condition' is satisfied
# }
# else
# {
#    ... commands to be executed
#    ... otherwise
# }
# 
# for (i in a:b)
# {
#    ... commands to be executed
#    ... for each value of i = a, a+1, ..., b
# }


# Download the file "Fibonacci_etc.R"

source("Fibonacci_etc.R")

Fibonacci1(n1=3,n2=4,kmax=10)

#Doesn't show output but saves it in variable
result1 <- Fibonacci1(n1=3,n2=4,kmax=10)
result1

Fibonacci2(kmax=20)

# Comment about graphics in Fibonacci2():
# In general, the command "par(mfrow=c(nr,nc))"
# opens a graphics window with a (still invisible)
# plot matrix, nr rows and nc columns.
# Any call of "plot()" will fill one position of
# this plot matrix, the order is row-wise.
# To fill a plot matrix column-wise, use the
# command "par(mfcol=c(nr,nc))"...

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
# one may call
#    NameF(v1,v2,v3,...)
#    result <- NameF(v1,v2,v3,...)
#    NameF(v1,v2,v3,...) -> result
# to execute NameF with a1=v1, a2=v2, a3=v3, ... .
# In the first case, the result is displayed in the console
# window, in the latter two cases, the output is saved to a
# variable "result" for later use.
#
# If one knows that, say, a1 and a2 have default values one
# is happy with, one may also type
#    result <- NameF(a3=v3,...) .
# Here it is important that all arguments are typed with
# their name specifier ("ak=vk"), because now the order of
# the specified arguments differs from the order in the
# function code...


# The program "PopulationGrowth1()" uses a slightly
# more complex and realistic population model:
# Any individual lives d years. During its j-th year
# of life it gives birth to offspring[j] newborns
# on average, where offspring[1] = 0.
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

source("Fibonacci_etc.R")

PopulationGrowth1(n.init=c(1,1,0),offspring=c(0,1,1))
PopulationGrowth1(n.init=c(1,0,0),offspring=c(0,1,1),kmax=50)

PopulationGrowth1(n.init=c(1,1,0),offspring=c(0,1,1), survival=c(1,0.5,0.5))
# Exercise: Write a new program PopulationGrowth2()
# fulfilling two tasks:
# Task 1: Try to avoid loops where indicated.
# Task 2: Introduce an additional input vectors 'survival'
#         with the following meaning:
#         An individual survives its j-th year with
#         probability survival[j]
#         (survival[j] > 0 for j < d, survival[d] = 0).

# Exercise for fans of mathematics:
# The (column!) vector n[k,] describes the population
# in year k. There is a (dxd) matrix A such that
#    n[k,] = A n[k-1,]  for k = 2, 3, 4, ... .
# Matrix multiplication is denoted with %*% in R.
# Thus
#    n[k,] = A %*% n[k-1,]  for k = 2, 3, 4, ... .
# Task 1: Determine the matrix A in terms of
#         'survival' and 'offspring'.
# Task 2: Write a new program PopulationGrowth3()
#         doing the same as PopulationGrowth2()
#         but using matrix calculations and returning
#         also the matrix A.
# Task 3: Use R's function eigen() to find eigenvalues
#         and eigenvectors of A. What are you guessing
#         about the population dynamics?