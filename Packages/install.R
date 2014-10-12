#!/usr/bin/env Rscript
# This is an installation script
#
print("Checking for required packages...")
rlibs = "~/R"
default_repo = "http://cran.us.r-project.org"
if("seqinr" %in% rownames(installed.packages()) == FALSE) {install.packages("seqinr", repos=default_repo, lib=rlibs)}
if("tripack" %in% rownames(installed.packages()) == FALSE) {install.packages("tripack", repos=default_repo, lib=rlibs)}
if("RANN" %in% rownames(installed.packages()) == FALSE) {install.packages("RANN", repos=default_repo, lib=rlibs)}
if("fpc" %in% rownames(installed.packages()) == FALSE) {install.packages("fpc", repos=default_repo, lib=rlibs)}
if("amap" %in% rownames(installed.packages()) == FALSE) {install.packages("amap", repos=default_repo, lib=rlibs)}
if("foreach" %in% rownames(installed.packages()) == FALSE) {install.packages("foreach", repos=default_repo, lib=rlibs)}
if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("ShortRead",lib=rlibs)
}
if("Rcpp" %in% rownames(installed.packages()) == FALSE) {install.packages("Rcpp", repos=default_repo, lib=rlibs)}
if("stringr" %in% rownames(installed.packages()) == FALSE) {install.packages("stringr", repos=default_repo, lib=rlibs)}
if("MASS" %in% rownames(installed.packages()) == FALSE) {install.packages("MASS", repos=default_repo, lib=rlibs)}
#
print("Done!")
