#!/usr/bin/env Rscript
# This is an installation script
#
# Installing required libraries:

default_repo = "http://cran.us.r-project.org"

print("Checking for required packages...")
if("seqinr" %in% rownames(installed.packages()) == FALSE) {install.packages("seqinr", repos=default_repo,destdir="Packages")}
if("tripack" %in% rownames(installed.packages()) == FALSE) {install.packages("tripack", repos=default_repo,destdir="Packages")}
if("RANN" %in% rownames(installed.packages()) == FALSE) {install.packages("RANN", repos=default_repo,destdir="Packages")}
if("modeltools" %in% rownames(installed.packages()) == FALSE) {install.packages("modeltools", repos=default_repo,destdir="Packages")}
if("robustbase" %in% rownames(installed.packages()) == FALSE) {install.packages("robustbase", repos=default_repo,destdir="Packages")}
if("kernlab" %in% rownames(installed.packages()) == FALSE) {install.packages("kernlab", repos=default_repo,destdir="Packages")}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo,destdir="Packages")}
if("cluster" %in% rownames(installed.packages()) == FALSE) {install.packages("cluster", repos=default_repo,destdir="Packages")}
if("mclust" %in% rownames(installed.packages()) == FALSE) {install.packages("mclust", repos=default_repo,destdir="Packages")}
if("flexmix" %in% rownames(installed.packages()) == FALSE) {install.packages("flexmix", repos=default_repo,destdir="Packages")}
if("prabclus" %in% rownames(installed.packages()) == FALSE) {install.packages("prabclus", repos=default_repo,destdir="Packages")}
if("class" %in% rownames(installed.packages()) == FALSE) {install.packages("class", repos=default_repo,destdir="Packages")}
if("diptest" %in% rownames(installed.packages()) == FALSE) {install.packages("diptest", repos=default_repo,destdir="Packages")}
if("mvtnorm" %in% rownames(installed.packages()) == FALSE) {install.packages("mvtnorm", repos=default_repo,destdir="Packages")}
if("trimcluster" %in% rownames(installed.packages()) == FALSE) {install.packages("trimcluster", repos=default_repo,destdir="Packages")}
if("ade4" %in% rownames(installed.packages()) == FALSE) {install.packages("ade4", repos=default_repo,destdir="Packages")}
if("fpc" %in% rownames(installed.packages()) == FALSE) {install.packages("fpc", repos=default_repo,destdir="Packages")}
if("amap" %in% rownames(installed.packages()) == FALSE) {install.packages("amap", repos=default_repo,destdir="Packages")}
if("foreach" %in% rownames(installed.packages()) == FALSE) {install.packages("foreach", repos=default_repo,destdir="Packages")}
if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("ShortRead")
}
if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", repos=default_repo,destdir="Packages")}
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr", repos=default_repo,destdir="Packages")}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo,destdir="Packages")}
if("optparse" %in% rownames(installed.packages()) == FALSE) {install.packages("optparse", repos=default_repo,destdir="Packages")}
#
print("Done!")