# -*- coding: utf-8 -*-
#MetAmp - a software application for meta-amplicon data analysis.
# Written by Ilya Y. Zhbannikov, Feb 2, 2014
# Updated on October 9, 2014
# Usage: 
# Set the working directory by changing the "dir_path" variable
# Under R-environmentL $>source("main.R")
#
# Set the work directory:
dir_path <- "~/Projects/metamp/" # Working directory where all analysis data will be stored
setwd(dir_path)
# Provide your data here (can be raw or preprocessed libs, program assumes one file for each region):
#libs <- c("data/staggered/SRR072223_V13V31_1_relabeled.fastq", # V1-3
#          "data/staggered/SRR072223_V35V53_1_relabeled.fastq", # V3-5
#          "data/staggered/SRR072223_V69V96_1_relabeled.fastq") # V6-9
libs <- c("data/even/SRR072220_V13V31_relabeled.fastq", # V1-3
          "data/even/SRR072220_V35V53_relabeled.fastq", # V3-5
          "data/even/SRR072239_V69V96_relabeled.fastq") # V6-9

# Reference sequences:
ref16S <- "data/16S_gold_hmc.fasta"
refs <- c("data/16S_gold_hmc_V13V31.fasta", # V1-3
          "data/16S_gold_hmc_V35V53.fasta", # V3-5
          "data/16S_gold_hmc_V69V96.fasta") # V6-9

source("config.R") # Link the configuration file with default program parameters and path to the data
source("metamp.R") # Link the analysis pipeline
