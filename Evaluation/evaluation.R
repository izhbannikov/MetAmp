# -*- coding: utf-8 -*-
#
# MetAmp - a software application for meta-amplicon data analysis.
# Written by Ilya Y. Zhbannikov, Feb 2, 2014
# Updated on Sept 7, 2014
# Usage: 
# Set the working directory by changing the "dir_path" variable
# Under R-environmentL $>source("main.R")
#
# Set the work directory:
dir_path <- "~/Projects/metamp/" # Working directory where all analysis data will be stored
setwd(dir_path)
# Provide your data here (can be raw or preprocessed libs, program assumes one file for each region):
libs <- c("Evaluation/data/staggered/SRR072221_forward.fastq", # V1-3
          "Evaluation/data/staggered/SRR072237_forward.fastq", # V3-5
          "Evaluation/data/staggered/SRR072236_forward.fastq") # V6-9
# Reference sequences:
#ref16S <- "data/LTP/LTP-10271.fasta"
#refs <- c("data/LTP/LTP-10271_V13.fasta", # V1-3
#          "data/LTP/LTP-10271_V35.fasta", # V3-5
#          "data/LTP/LTP-10271_V69.fasta") # V6-9
ref16S <- "Evaluation/data/16S.fasta"
refs <- c("Evaluation/data/V13.fasta", # V1-3
          "Evaluation/data/V35.fasta", # V3-5
          "Evaluation/data/V69.fasta") # V6-9

source("evaluation_config.R") # Link the configuration file with default program parameters and path to the data
source("evaluation_metamp.R") # Link the analysis pipeline