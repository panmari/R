# Date: Wednesday, August 8, 2012

###################
### Data frames ###
###################

# Data sets usually are given as data matrices,
# simple text files, where
# - each row corresponds to an observation
# - each column corresponds to a "variable"
# 

# Example: StatWiSo2003.txt

ds <- read.table(file="StatWiSo2003.txt")
str(ds)
# Something's wrong; the first line was interpreted
# as an observation!

ds <- read.table(file="StatWiSo2003.txt",header=TRUE)
# "header=TRUE" means: The first line contains
# the names of variables!

ds <- read.table(file="StatWiSo2003.txt",header=TRUE,sep="\t")
# "sep="\t"" means: Columns are separated by tabulators.


# To see, what ds contains:
ds      # Well, too many numbers :-(
str(ds) # str(ucture) of ds

# "data.frame" is a special type of data structure:
# It is a list, where all elements are one-dimensional
# arrays of the same length.

# "factor": a categorical variable
# "int", "num" : a numerical variable

# To convert a variable of type "int" into a categorical
# variable, use factor:

ds$ZufZiffer <- factor(ds$ZufZiffer)
ds$ZufZiffer <- factor(ds$ZufZiffer,levels=0:9)

# Analysing single factors and two factors simultaneously:

# Compute absolute frequencies:
table(ds$Herkunft)
table(ds$Rauchen)
table(ds$Geschlecht)

# Contingency table for two factors:
table(ds$Rauchen,ds$Geschlecht)

# Pie charts:
pie(table(ds$Rauchen))
pie(table(ds$ZufZiffer))

# Pie chart and bar plot in one window:

par(mfrow=c(2,1))
pie(table(ds$ZufZiffer))
barplot(table(ds$ZufZiffer))
# Hmm, the sizes are a little strange!
# Try to fix this with parameter "mai":
par(mfrow=c(2,1),mai=c(0.5,0.4,0.2,0))
pie(table(ds$ZufZiffer))
barplot(table(ds$ZufZiffer))
# Hmm, somewhat better, but...
? pie
# Try to use parameter "radius" of pie:
par(mfrow=c(2,1),mai=c(0.5,0.4,0.2,0))
pie(table(ds$ZufZiffer),radius=1)
barplot(table(ds$ZufZiffer))
# Yesss!
# If we want to set and match colors:
col<-c("red","green","blue","yellow","cyan")
par(mfrow=c(2,1),mai=c(0.5,0.4,0.2,0))
pie(table(ds$ZufZiffer),radius=1,col=col)
barplot(table(ds$ZufZiffer),col=col)



# Accessing particular components of a data frame:

ds[3,4] # value of variable 4 for observation no. 3.
ds$Herkunft[3]

ds[3,] # all entries for observation no. 3

ds$Alter # one particular variable

# One or several columns of the data frame:
ds[,2:4]
ds[,c(1,2,4,9)]

ds$MonMiete > 0
# gives a vector of logicals, TRUE, FALSE or NA

# How many students in the sample do pay rent?
sum(ds$MonMiete > 0)
# The entries 'NA' cause problems, but
sum(ds$MonMiete > 0, na.rm=TRUE)
# gives the number of entries == TRUE, ignoring NA
# TRUE = 1, FALSE = 0.

# How many students in the sample
# don't have to pay rent?
sum(ds$MonMiete == 0, na.rm=TRUE)
# Checking equalities with "==" not with "=" !
# With the command "ds$MonMiete = 0" you would set
# all entries in ds$MonMiete to zero !

# How many missing values:
sum(is.na(ds$MonMiete))


# Another way to obtain this information:
table(ds$MonMiete>0)