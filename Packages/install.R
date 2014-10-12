#!/usr/bin/env Rscript
# This is an installation script
#
print("Checking for required packages...")
default_repo = "http://cran.us.r-project.org"
R_LIBS = "R_Lib"
#if("seqinr" %in% rownames(installed.packages()) == FALSE) {install.packages("seqinr", repos=default_repo, lib=R_LIBS)}
#if("tripack" %in% rownames(installed.packages()) == FALSE) {install.packages("tripack", repos=default_repo, lib=R_LIBS)}
#if("RANN" %in% rownames(installed.packages()) == FALSE) {install.packages("RANN", repos=default_repo, lib=R_LIBS)}
#if("fpc" %in% rownames(installed.packages()) == FALSE) {install.packages("fpc", repos=default_repo, lib=R_LIBS)}
#if("amap" %in% rownames(installed.packages()) == FALSE) {install.packages("amap", repos=default_repo, lib=R_LIBS)}
#if("foreach" %in% rownames(installed.packages()) == FALSE) {install.packages("foreach", repos=default_repo, lib=R_LIBS)}
#if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
#  source("http://bioconductor.org/biocLite.R")
#  biocLite("ShortRead", lib=R_LIBS)
#}
#if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", repos=default_repo, lib=R_LIBS)}
#if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr", repos=default_repo, lib=R_LIBS)}
#if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo, lib=R_LIBS)}

install.packages("seqinr", repos=default_repo, lib=R_LIBS)
install.packages("tripack", repos=default_repo, lib=R_LIBS)
install.packages("RANN", repos=default_repo, lib=R_LIBS)
install.packages("fpc", repos=default_repo, lib=R_LIBS)
install.packages("amap", repos=default_repo, lib=R_LIBS)
install.packages("foreach", repos=default_repo, lib=R_LIBS)
source("http://bioconductor.org/biocLite.R")
biocLite("ShortRead", lib=R_LIBS)
install.packages("Rcpp", repos=default_repo, lib=R_LIBS)
install.packages("stringr", repos=default_repo, lib=R_LIBS)
install.packages("MASS", repos=default_repo, lib=R_LIBS)

#
print("Done!")
