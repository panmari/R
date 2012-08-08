# Date: Monday, August 6, 2012

############################
### Data Structures in R ###
############################

# Simplest data structure is an object
# with only one entry of type
# "numeric", "logical" or "character"

x <- 3
x
str(x) #structure of the object

1 > 2 # is a relation, gives right or false back
x <- (1 > 2)
x
str(x)

x <- 'hallo'
x
str(x)

# The command str(.) gives information about an
# object.


# Second simplest data structure are
# one-dimensional arrays (vectors).
# These are objects with several entries
# of the same type.
# Entry number j of vector x is accessed with
# x[j]:

x <- c(3,5,11)
x
x[2]
str(x)

y <- (x < 4) #computed component-wise
y
y[3]
str(y)


# Higher-dimensional arrays (tables, matrices)
# are also possible.
# Any vector may be converted into a
# higher-dimensional array with array(.):

xx <- array(1:20,dim=c(4,5)) 
#arrange this numbers as two dimensional array with the dimensions (4, 5)
# so 4 rows and 5 columns
xx
str(xx)
xx[1,2] # value in first row, second column
xx[4,3]
xx[2,] # the second row
xx[,3] # the third column
xx[1:2,] # the first and the second row


# a three dimensional array/matrix
xxx <- array(1:60,dim=c(4,5,3))
xxx
xxx[1,2,1]
xxx[4,1,3]

# For two-dimensional arrays (matrices) the
# commmand matrix(.) is more intuitive:

xx <- matrix(1:20,nrow=4,ncol=5)
xx
xx <- matrix(1:20,nrow=4)
xx
xx <- matrix(1:20,ncol=5)
xx
xx <- matrix(1:15,nrow=7)
xx


# The most general type of data structure
# are lists. Various objects may be concatenated
# as a list. Entry number j of a list x is obtained
# with x[[j]]:

Name <- "Duembgen" # Surname
Vorname <- "Lutz"  # Given name
Alter <- 49        # Age
CH <- FALSE        # Swiss citizen?
Oepper <- list(Name,Vorname,Alter,CH)
Oepper
str(Oepper)
Oepper[[1]]

# It is usually advisable to use names for the entries.
# Then one can obtain entries by their names:
Oepper <- list(Name=Name,Given.name=Vorname,Age=Alter,Swiss=CH)
Oepper
Oepper[[1]]
# Use $ for accessing attributes
Oepper$Name
Oepper$Age

# Creating a list and providing entries later on:
Someone <- list(Name=NA,Surname=NA,Age=NA,Citizenship=NA)
Someone
# NA means "not available"

# With $ you can also write attributes!
Someone$Name <- 'Leuthard'
Someone$Surname <- "Doris"
Someone$Citizenship <- 'swiss'
Someone

Someone$Age <- 50
Someone

# There is a special type of list, called "data frame",
# but this will be treated in detail later on ...
