# Date: Monday, August 6, 2012

# The files "Monday1.R", "Monday2.R", ...,
# "Tuesday1.R", ...  are script files, containing
# executable commands and comments.
# (Comments are text preceded by a "#" ("hash").)
# 
# All script files (and other files used later)
# should be in the working directory.
# To find out the current working directory of R:
# Execute "getwd()" in the console window.
# To find out which files are in the current directory,
# execute "list.files()".
# To change the working directory: Use R's menu or type
# setwd("... path of intended working directory ...").
# 
# After opening a script file, to execute one or several
# commands in it, just mark them and then use
#    "Control & R" (Windows)
# or
#    "Command & Return" (Mac OSX) .
# Other systems (e.g. Linux) may use different keys for
# this task; see also the menu of R.
# SHIFT + F8
# When executing commands this way, they will automatically
# be copied into the console window. There one can type-in
# commands directly, but for book-keeping we recommend to
# use script files ...
# 

#####################################
### Using R as a calcutator       ###
### (Computers cannot calculate!) ###
#####################################

# Konsole window may be used as a calculator ...

12 + 24*34 - 678/2^10

10^2
2^10
pi
sin(pi/2)
exp(1)
log(10) # natural logarithm!
log10(10) # logarithm with base 10
log2(8) # logarithm with base 2
log(5,5) # logarithm with arbitrary base

# The output always starts with "[1]". This means,
# that the result of your command is written into
# an array with just one element, and "[1] ..."
# means "entry number 1 equals ...".

# Beware of hierarchies:
# exponentiation (^)
#    > multiplication/division (*,/)
#         > addition/subtraction (+,-) !
# Thus
# 12 + 24*34 - 678/2^10 = 12 + (24*34) - (678/(2^10))
# Several consecutive additions/subtractions
# (or multiplications/divisions) are executed
# from left to right:
# 12 + 816 + 0.6621 = (12 + 816) + 0.6621
# 12*34/10*5/3 = (((12*34)/10)*5)/3

# Use brackets in case of doubt!
# Example:

2^5^-1
(2^5)^-1
2^(5^-1)


# Computer has limited precision!

# Example 1:
1/3 + 1/3 + 1/3 - 1
1/3 + 1/3 - 1 + 1/3
1/3 - 1 + 1/3 + 1/3
-1 + 1/3 + 1/3 + 1/3

# Example 2:
1 + 2^10 - 2^10
1 + 2^100 - 2^100

n <- 79
n
# create a variable with name "n" and
# assign the value 70 to it.
# If "n" is already available, "n <- ..."
# will overwrite it!
n <- 52
n

1 + 2^n - 2^n
# Assignment also works to the right (with arrow to the other side)
53 -> n
1 + 2^n - 2^n


# Reason: computer represents a nonzero number x as
#    x = +/- (a[0] + a[1]/2 + a[2]/4 + a[3]/8 + ... + a[m]/2^m) * 2^C
# for some integer C and digits a[0], a[1], a[2], ..., a[m] in {0,1},
# where a[0] = 1 if possible. Short notation for these considerations:
#    x = [+/- ; a[0], a[1], a[2], a[3], ..., a[m] ; C]
# When adding x and
#    y = [+/- ; b[0], b[1], b[2], b[3], ..., b[m] ; D]
# where C < D, the computer first approximates x by some number
# between
#        [+/- ; 0, ..., 0, a[0], a[1], ..., a[m+C-D] ; D] ,
# and
#        [+/- ; 0, ..., 0, a[0], a[1], ..., a[m+C-D] ; D]
#      + [+/- ; 0, ..., 0,    0,    0, ...,        1 ; D]
# i.e. some digits of x get lost!
# 
# Another problem is that the exponent's modulus, |C|, may not be
# arbitrarily large. Otherwise there is so-called overflow and the
# computer produces +-Inf, or even NaN ("not a number").
# 
# A first example: Suppose our computer would work with m+1 = 6
# digits only. Then adding 23 and 2.125 works as follows:
#    23 = 16 + 4 + 2 + 1
#       = (1 + 0/2 + 1/4 + 1/8 + 1/16 + 0/32) * 2^4
#       = [+ ; 1, 0, 1, 1, 1, 0; 4] ,
#    2.125 = 2 + 1/8
#       = (1 + 0/2 + 0/4 + 0/8 + 1/16 + 0/32) * 2^1
#       = [+ ; 1, 0, 0, 0, 1, 0; 1] ,
# so
#    23 + 2.125
#       =   [+ ; 1, 0, 1, 1, 1, 0; 4]
#         + [+ ; 1, 0, 0, 0, 1, 0; 1]
#      "="  [+ ; 1, 0, 1, 1, 1, 0; 4]
#         + [+ ; 0, 0, 0, 1, 0, 0; 4]
#       =   [+ ; 1, 0, 1, 2, 1, 0; 4]
#       =   [+ ; 1, 0, 2, 0, 1, 0; 4]
#       =   [+ ; 1, 1, 0, 0, 1, 0; 4]
#       =   (1 + 1/2 + 0/4 + 0/8 + 1/16 + 0/32) * 2^4
#       =  16 + 8 + 1
#       =  25.
# 
# In our particular example, for general m,
#     1  = [+ ; 1, 0, 0, 0, ..., 0, 0 ; 0]
#        = [+ ; 0, 1, 0, 0, ..., 0, 0 ; 1]
#        = [+ ; 0, 0, 1, 0, ..., 0, 0 ; 2]
#       ...
#        = [+ ; 0, 0, 0, 0, ..., 0, 1 ; m] ,
#    2^n = [+ ; 1, 0, 0, 0, ..., 0, 0 ; n] ,
# so for 0 < n <= m,
#    2^n + 1 = [+ ; 1, 0, 0, ..., 0, 1, ... ; n] .
# But for n > m, the approximation of 1
# (to be added to 2^n) equals 0.


# Finding out m:
# Create an array "n", containing the numbers
# from 10 to 100:
n <- 10:100
# Equal also works for assignment
n = 10:100
n
1 + 2^n - 2^n

result <- 1 + 2^n - 2^n
result

# To see for which exponents an error appears,
# use "cbind" to create a matrix with the two
# columns n and result:
# (cbind : binding together vectors or matrices
#  column-wise)
cbind(n,result)

# This experiment shows that m = 52.
# Similar example:
1 + 2^(-52) - 1 - 2^(-52)
1 + 2^(-53) - 1 - 2^(-53)

# Other examples (showing the finite precision):
(1 + pi)*(1 + pi) - 2*pi - pi^2 - 1
(3 + pi)*(3 + pi) - 2*3*pi - pi^2 - 9
(3 + sqrt(3))*(3 + sqrt(3)) - 2*3*sqrt(3) - 3 - 9

# Note also that the displayed numbers
# are rounded versions of internally 
# used numbers:
40*(1 - 0.8)
40*(1 - 0.8) - 8


# Finally, what is the largest exponent C in the
# representation
#    x = +/- (a[0] + a[1]/2 + a[2]/4 + a[3]/8 + ... + a[m]/2^m) * 2^C
# which is manageable?

2^1000
2^1050
C <- 1000:1050
cbind(C,2^C)