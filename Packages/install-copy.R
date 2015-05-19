#!/usr/bin/env Rscript
# This is an installation script
#
# Installing required libraries:

default_repo = "http://cran.us.r-project.org"

print("Checking for required packages...")
if("ShortRead" %in% rownames(installed.packages()) == FALSE) {
  source("http://bioconductor.org/biocLite.R")
  #source("Packages/biocLite.R")
  #library("Packages/BiocInstaller/")
  biocLite("ShortRead")
}

#
print("Done!")
