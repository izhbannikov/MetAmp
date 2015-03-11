# -*- coding: utf-8 -*-
# Installing required libraries:
print("Checking for required packages...")
default_repo = "http://cran.us.r-project.org"
if("seqinr" %in% rownames(installed.packages()) == FALSE) {install.packages("seqinr", repos=default_repo)}
if("tripack" %in% rownames(installed.packages()) == FALSE) {install.packages("tripack", repos=default_repo)}
if("RANN" %in% rownames(installed.packages()) == FALSE) {install.packages("RANN", repos=default_repo)}
if("fpc" %in% rownames(installed.packages()) == FALSE) {install.packages("fpc", repos=default_repo)}
if("amap" %in% rownames(installed.packages()) == FALSE) {install.packages("amap", repos=default_repo)}
if("foreach" %in% rownames(installed.packages()) == FALSE) {install.packages("foreach", repos=default_repo)}
if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("ShortRead")
}
if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", repos=default_repo)}
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr", repos=default_repo)}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo)}

#==============Source files
source("src/methods-Denoising.R")
source("src/methods-Merge.R")
source("src/methods-Convert.R")
source("src/methods-Clust.R")
source("src/methods-Dist.R")
source("src/methods-Stat.R")
source("src/methods-Affine.R")
source("src/methods-Misc.R")
source("src/methods-Triangulation.R")
source("src/methods-Utils.R")
# Libraries with functions used in MetAmp
#library(seqinr,lib.loc=R_LIBS) # For manupulations with sequences
#library(BLASTParser,lib.loc=R_LIBS) # Parses USEARCH output file
#library(tripack,lib.loc=R_LIBS) # For triangulation
#library(RANN,lib.loc=R_LIBS) # For kd-tree
#library(fpc,lib.loc=R_LIBS) # For clustering using the DBSCAN algorithm
#library(amap,lib.loc=R_LIBS)
#library(stringr,lib.loc=R_LIBS)
#library(foreach,lib.loc=R_LIBS) # For parallel clustering
#library(ShortRead,lib.loc=R_LIBS) # For manipulations with sequences
#library(MASS,lib.loc=R_LIBS)

library(seqinr) # For manupulations with sequences
library(BLASTParser,lib.loc=R_LIBS) # Parses USEARCH output file
library(tripack) # For triangulation
library(RANN) # For kd-tree
library(fpc) # For clustering using the DBSCAN algorithm
library(amap)
library(stringr)
library(foreach) # For parallel clustering
library(ShortRead) # For manipulations with sequences
library(MASS)

#----Create "analysis" and "tmp" directories------#
analysis_path <- paste(dir_path, analysis_dir,sep='')
system(paste("mkdir", analysis_path))
system(paste("mkdir", tmp_dir))

# All information is recorded in log.txt:
logfile <- paste(analysis_path, '/', "log.txt", sep='')

writeMessage(paste("Analysis path: ", analysis_path), logfile, F)
writeMessage("Starting analysis...", logfile, T)

#----Data preparation------#

checkInputData() # Making sure that everything is alright.

print(paste("Running preprocessing pipeline...") )
writeMessage(paste("Running preprocessing pipeline..."), logfile, T)
work_libs <- matrix(nrow=length(libs), ncol=3)
for (i in seq(libs)) {
  work_libs[i,1] <- libs[i] 
  work_libs[i,2] <- libs[i]
}
#for(i in 1:dim(work_libs)[1]) {
#  work_libs[i,1] <- cluster2(analysis_dir=tmp_dir, lib=work_libs[i,1], num=i)
#}

#==============Builging distance matrices==================#
writeMessage("Building distance matrix for 16S gene sequences...", logfile, T)
score16S <- generate_distance_matrix16S(ref16S)
writeMessage("Done!", logfile, T)

writeMessage("Building distance matrix for guide and amplicon reads...", logfile, T)
distancesEmp <- readDistanceMatrices(ref16S, work_libs, dt=0)
scoresV <- distancesEmp[[1]] # This function reads pre-computed distance matrices sequentially
merged_table <- distancesEmp[[2]]
writeMessage("Done!", logfile, T)

#================Compute MDS for 16S=============#
writeMessage("Computing MDS for 16S...", logfile, T)
mds16S <- read16S(ref16S, score16S ) # Here we are computing a multi-dimensional scaling for 16S gene sequences.
num_ref_points <- dim(mds16S)[1] # Number of reference points.
writeMessage("Done!", logfile, T)

#=============Normalize amplicons=============#
# This is the core of the meta-amplicon analysis algorithm.
writeMessage("Normalization...", logfile, T)
summary_matrix <- normalizeAmplicons(scoresV, mds16S, num_ref_points)
writeMessage("Done!", logfile, T)

## 10/100:
## Loading gold reference matrix:
score_gold16S <- generate_distance_matrix16S("data/validation/gold110.fa")
mds_gold16S <- read16S("data/validation/gold110.fa", score_gold16S ) 
## Computing the difference with the following equation: sqrt((x0-x1)^2+(y0-y1)^2):
ans= sqrt( (summary_matrix[11:110,1]-mds_gold16S[11:110,1])^2 + (summary_matrix[11:110,2]-mds_gold16S[11:110,2])^2 )
mean(ans)
median(ans)
#plot(summary_matrix,cex=0.1)
#points(mds_gold16S,col="red",cex=0.1)
plot(mds_gold16S,cex=0.1)
points(mds_gold16S[1:10,],col="red",cex=0.1)

summary_matrix_edited <- summary_matrix[which(summary_matrix[,2] < 2),]
plot(summary_matrix_edited,cex=0.1)
points(summary_matrix_edited[1:10,],col="red",cex=0.1)


#
# 100/100:
# Loading gold reference matrix:
#score_gold16S <- generate_distance_matrix16S("data/validation/gold200.fa")
#mds_gold16S <- read16S("data/validation/gold200.fa", score_gold16S ) 
## Computing the difference with the following equation: sqrt((x0-x1)^2+(y0-y1)^2):
#ans= sqrt( (summary_matrix[101:200,1]-mds_gold16S[101:200,1])^2 + (summary_matrix[101:200,2]-mds_gold16S[101:200,2])^2 )
#mean(ans)
#median(ans)
#plot(summary_matrix,cex=0.1)
#points(mds_gold16S,col="red",cex=0.1)
#
# 200/100
#score_gold16S <- generate_distance_matrix16S("data/validation/gold300.fa")
#mds_gold16S <- read16S("data/validation/gold300.fa", score_gold16S ) 
## Computing the difference with the following equation: sqrt((x0-x1)^2+(y0-y1)^2):
#ans= sqrt( (summary_matrix[201:300,1]-mds_gold16S[201:300,1])^2 + (summary_matrix[201:300,2]-mds_gold16S[201:300,2])^2 )
#mean(ans)
#median(ans)
#plot(summary_matrix,cex=0.1)
#points(mds_gold16S,col="red",cex=0.1)

# 500/100
#score_gold16S <- generate_distance_matrix16S("data/validation/gold600.fa")
#mds_gold16S <- read16S("data/validation/gold600.fa", score_gold16S ) 
## Computing the difference with the following equation: sqrt((x0-x1)^2+(y0-y1)^2):
#ans= sqrt( (summary_matrix[501:600,1]-mds_gold16S[501:600,1])^2 + (summary_matrix[501:600,2]-mds_gold16S[501:600,2])^2 )
#mean(ans)
#median(ans)
#plot(summary_matrix[1:510,],cex=0.1)
#points(mds_gold16S,col="red",cex=0.1)

# 1000/100
#score_gold16S <- generate_distance_matrix16S("data/validation/gold1100.fa")
#mds_gold16S <- read16S("data/validation/gold1100.fa", score_gold16S ) 
## Computing the difference with the following equation: sqrt((x0-x1)^2+(y0-y1)^2):
#ans= sqrt( (summary_matrix[1001:1100,1]-mds_gold16S[1001:1100,1])^2 + (summary_matrix[1001:1100,2]-mds_gold16S[1001:1100,2])^2 )
#mean(ans)
#median(ans)
#plot(summary_matrix,cex=0.1)
#points(mds_gold16S,col="red",cex=0.1)


