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
analysis_dir <- "analysis" # Directory that keeps all analysis data and results

setwd(dir_path) # <-DO NOT edit this line

# Provide your data here (can be raw or preprocessed libs, program assumes one file for each region):
# Staggered community (22 species are in very unequal concentration):
#libs <- c("data/staggered/SRR072223_V13V31_1_relabeled.fastq", # V1-3
#          "data/staggered/SRR072223_V35V53_1_relabeled.fastq", # V3-5
#          "data/staggered/SRR072223_V69V96_1_relabeled.fastq") # V6-9
# Even community (all 22 species are in roughly equal concentration):
#libs <- c("data/even/SRR072220_V13V31_relabeled.fastq")#, # V1-3
          #"data/even/SRR072220_V35V53_relabeled.fastq", # V3-5
          #"data/even/SRR072239_V69V96_relabeled.fastq") # V6-9

# Reference sequences (small dataset, 21 microbial species):
#ref16S <- "data/16S_gold_hmc.fasta"
#refs <- c("data/16S_gold_hmc_V13V31.fasta")#, # V1-3
#          "data/16S_gold_hmc_V35V53.fasta", # V3-5
#          "data/16S_gold_hmc_V69V96.fasta") # V6-9

# Reference sequences (larger dataset, 1500 microbial species):
#ref16S <- "data/gold.fa"
#refs <- c("data/gold_V13.fasta", # V1-3
#          "data/gold_V35.fasta", # V3-5
#          "data/gold_V69.fasta") # V6-9

# Accuracy test:
# 10/100:
#libs <- c("data/validation/emp10_100_V13.fasta", "data/validation/emp10_100_V35.fasta", "data/validation/emp10_100_V69.fasta")
#ref16S <- "data/validation/gold10.fa"
#refs <- c("data/validation/gold10_V13.fasta", # V1-3
#          "data/validation/gold10_V35.fasta", # V3-5
#          "data/validation/gold10_V69.fasta") # V6-9

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
libs <- c("data/validation/emp1000_100_V13.fasta", "data/validation/emp1000_100_V35.fasta", "data/validation/emp1000_100_V69.fasta")
ref16S <- "data/validation/gold1000.fa"
refs <- c("data/validation/gold1000_V13.fasta", # V1-3
          "data/validation/gold1000_V35.fasta", # V3-5
          "data/validation/gold1000_V69.fasta") # V6-9






# Do not edit:
source("config.R") # Link the configuration file with default program parameters and path to the data
source("metamp_validation.R") # Link the analysis pipeline
