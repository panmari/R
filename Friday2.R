# Date: Friday, August 10, 2012

##########################
### Contingency Tables ###
##########################


# Example of Contingency table, see also
# "Schnarchen" on the course's web page:

TXY <- matrix(c(24,1355,35,603,21,192,30,224),nrow=2)
TXY
dimnames(TXY)
dimnames(TXY) <- list(c("heart.disease","healthy"),
	c("snores.never","sometimes","frequently","heavily"))

TXY

# Extended table:
TXY.ext <- cbind(TXY,rowSums(TXY))
TXY.ext
TXY.ext <- rbind(TXY.ext,colSums(TXY.ext))
TXY.ext


help.search("Chisquared test")
?chisq.test

chisq.test(TXY)

# For (sm)all data sets one should use p-values
# based on random permutations:

chisq.test(TXY,simulate.p.value=TRUE,B=19999)

# An alternative which tells something about
# the direction (!) of the association:
# Reduce the table to a 2x2 table in a
# reasonable way and apply Fisher's exact test:

S <- cbind(TXY[,1] + TXY[,2], TXY[,3] + TXY[,4])
S
dimnames(S)
dimnames(S)[[2]] <- c("snores.rarely","frequently")
S

fisher.test(S)
fisher.test(S,conf.level=0.999)
