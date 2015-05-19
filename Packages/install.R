#!/usr/bin/env Rscript
# This is an installation script
#
# Installing required libraries:

default_repo = "http://cran.us.r-project.org"

.libPaths(paste(getwd(),"/Packages",sep=''))
#print(.libPaths())

print("Checking for required packages...")
if("seqinr" %in% rownames(installed.packages()) == FALSE) {install.packages("seqinr", repos=default_repo, lib="Packages")}
if("Rcpp" %in% rownames(installed.packages())==FALSE) {install.packages("Rcpp",repos=default_repo)}
if("tripack" %in% rownames(installed.packages()) == FALSE) {install.packages("tripack", repos=default_repo, lib="Packages")}
if("RANN" %in% rownames(installed.packages()) == FALSE) {install.packages("RANN", repos=default_repo, lib="Packages")}
if("modeltools" %in% rownames(installed.packages()) == FALSE) {install.packages("modeltools", repos=default_repo, lib="Packages")}
if("robustbase" %in% rownames(installed.packages()) == FALSE) {install.packages("robustbase", repos=default_repo, lib="Packages")}
if("kernlab" %in% rownames(installed.packages()) == FALSE) {install.packages("kernlab", repos=default_repo, lib="Packages")}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo, lib="Packages")}
if("cluster" %in% rownames(installed.packages()) == FALSE) {install.packages("cluster", repos=default_repo, lib="Packages")}
if("mclust" %in% rownames(installed.packages()) == FALSE) {install.packages("mclust", repos=default_repo, lib="Packages")}
if("flexmix" %in% rownames(installed.packages()) == FALSE) {install.packages("flexmix", repos=default_repo, lib="Packages")}
if("prabclus" %in% rownames(installed.packages()) == FALSE) {install.packages("prabclus", repos=default_repo, lib="Packages")}
if("class" %in% rownames(installed.packages()) == FALSE) {install.packages("class", repos=default_repo, lib="Packages")}
if("diptest" %in% rownames(installed.packages()) == FALSE) {install.packages("diptest", repos=default_repo, lib="Packages")}
if("mvtnorm" %in% rownames(installed.packages()) == FALSE) {install.packages("mvtnorm", repos=default_repo, lib="Packages")}
if("trimcluster" %in% rownames(installed.packages()) == FALSE) {install.packages("trimcluster", repos=default_repo, lib="Packages")}
if("ade4" %in% rownames(installed.packages()) == FALSE) {install.packages("ade4", repos=default_repo, lib="Packages")}
if("fpc" %in% rownames(installed.packages()) == FALSE) {install.packages("fpc", repos=default_repo, lib="Packages")}
if("amap" %in% rownames(installed.packages()) == FALSE) {install.packages("amap", repos=default_repo, lib="Packages")}
if("foreach" %in% rownames(installed.packages()) == FALSE) {install.packages("foreach", repos=default_repo, lib="Packages")}
if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("ShortRead")
  #source("Packages/biocLite.R")
  #system("R CMD INSTALL Packages/ShortRead_1.26.0.tar.gz -l Packages")
}
#if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", repos=default_repo, lib="Packages")}
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr", repos=default_repo, lib="Packages")}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo, lib="Packages")}
if("optparse" %in% rownames(installed.packages()) == FALSE) {install.packages("optparse", repos=default_repo, lib="Packages")}
#if("rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("rcpp", repos=default_repo, lib="Packages")}

#
print("Done!")
