# -*- coding: utf-8 -*-
# MetAmp - a software application for meta-amplicon data analysis.
# Written by Ilya Y. Zhbannikov, Feb 2, 2014
# Updated on October 12, 2014
# Usage: 
# Set the working directory by changing the "dir_path" variable
# Under R-environment: source("main.R")
#
# Set the work directory:
dir_path <- "~/Projects/metamp/" # Path to the program directory
analysis_dir <- "data/validation/analysis" # Directory that keeps all analysis data and results

setwd(dir_path) # <-DO NOT edit this line

# Accuracy test:
# 10/100:
libs <- c("data/validation/emp10_100_V13.fasta", "data/validation/emp10_100_V35.fasta", "data/validation/emp10_100_V69.fasta")
ref16S <- "data/validation/gold10.fa"
refs <- c("data/validation/gold10_V13.fasta", # V1-3
          "data/validation/gold10_V35.fasta", # V3-5
          "data/validation/gold10_V69.fasta") # V6-9

# 100/100:
#libs <- c("data/validation/emp100_100_V13.fasta", "data/validation/emp100_100_V35.fasta", "data/validation/emp100_100_V69.fasta")
#ref16S <- "data/validation/gold100.fa"
#refs <- c("data/validation/gold100_V13.fasta", # V1-3
#          "data/validation/gold100_V35.fasta", # V3-5
#          "data/validation/gold100_V69.fasta") # V6-9

##200/100
#libs <- c("data/validation/emp200_100_V13.fasta", "data/validation/emp200_100_V35.fasta", "data/validation/emp200_100_V69.fasta")
#ref16S <- "data/validation/gold200.fa"
#refs <- c("data/validation/gold200_V13.fasta", # V1-3
          "data/validation/gold200_V35.fasta", # V3-5
          "data/validation/gold200_V69.fasta") # V6-9

#500/100
#libs <- c("data/validation/emp500_100_V13.fasta", "data/validation/emp500_100_V35.fasta", "data/validation/emp500_100_V69.fasta")
#ref16S <- "data/validation/gold500.fa"
#refs <- c("data/validation/gold500_V13.fasta", # V1-3
#          "data/validation/gold500_V35.fasta", # V3-5
#          "data/validation/gold500_V69.fasta") # V6-9

#1000/100
#libs <- c("data/validation/emp1000_100_V13.fasta", "data/validation/emp1000_100_V35.fasta", "data/validation/emp1000_100_V69.fasta")
#ref16S <- "data/validation/gold1000.fa"
#refs <- c("data/validation/gold1000_V13.fasta", # V1-3
#          "data/validation/gold1000_V35.fasta", # V3-5
#          "data/validation/gold1000_V69.fasta") # V6-9






# Do not edit:
source("data/validation/config.R") # Link the configuration file with default program parameters and path to the data
source("data/validation/metamp_validation.R") # Link the analysis pipeline
