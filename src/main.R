# -*- coding: utf-8 -*-
# MetAmp - a software application for meta-amplicon data analysis.
# Written by Ilya Y. Zhbannikov, Feb 2, 2014
# Updated on November 9, 2014

.libPaths(paste(getwd(),"/Packages",sep=''))

library(optparse)
.libPaths("Packages")
# Lst for options:
option_list <- list(
  make_option(c("-d", "--dir"), dest="script_dir", action="store", type="character"),
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print extra output [default]"),
  make_option(c("-q", "--quietly"), action="store_false",
              dest="verbose", help="Print little output"),
  make_option(c("-r", "--ref"), type="character", dest="ref16S", action = "store",
              help="Reference 16S sequences"),
  make_option(c("-r1", "--ref1"), type="character", dest="ref1", action = "store", # Rference marker sequences (9 is max)
              help="Reference sequences for marker 1 region"),
  make_option(c("-r2", "--ref2"), type="character", dest="ref2", action = "store",
              help="Reference sequences for marker 2 region"),
  make_option(c("-r3", "--ref3"), type="character", dest="ref3", action = "store",
              help="Reference sequences for marker 3 region"),
  make_option(c("-r4", "--ref4"), type="character", dest="ref4", action = "store",
              help="Reference sequences for marker 4 region"),
  make_option(c("-r5", "--ref5"), type="character", dest="ref5", action = "store",
              help="Reference sequences for marker 5 region"),
  make_option(c("-r6", "--ref6"), type="character", dest="ref6", action = "store",
              help="Reference sequences for marker 6 region"),
  make_option(c("-r7", "--ref7"), type="character", dest="ref7", action = "store",
              help="Reference sequences for marker 7 region"),
  make_option(c("-r8", "--ref8"), type="character", dest="ref8", action = "store",
              help="Reference sequences for marker 8 region"),
  make_option(c("-r9", "--ref9"), type="character", dest="ref9", action = "store",
              help="Reference sequences for marker 9 region"),
  make_option(c("-l1", "--lib1"), type="character", dest="lib1", action = "store", # Amplicon libraries (9 is max)
              help="Amplicon library for marker 1 region"),
  make_option(c("-l2", "--lib2"), type="character", dest="lib2", action = "store",
              help="Amplicon library for marker 2 region"),
  make_option(c("-l3", "--lib3"), type="character", dest="lib3", action = "store",
              help="Amplicon library for marker 3 region"),
  make_option(c("-l4", "--lib4"), type="character", dest="lib4", action = "store",
              help="Amplicon library for marker 4 region"),
  make_option(c("-l5", "--lib5"), type="character", dest="lib5", action = "store",
              help="Amplicon library for marker 5 region"),
  make_option(c("-l6", "--lib6"), type="character", dest="lib6", action = "store",
              help="Amplicon library for marker 6 region"),
  make_option(c("-l7", "--lib7"), type="character", dest="lib7", action = "store",
              help="Amplicon library for marker 7 region"),
  make_option(c("-l8", "--lib8"), type="character", dest="lib8", action = "store",
              help="Amplicon library for marker 8 region"),
  make_option(c("-l9", "--lib9"), type="character", dest="lib9", action = "store",
              help="Amplicon library for marker 9 region"),
  make_option(c("-o", "--output"), type="character", dest="output", action = "store",
              help = "Output analysis directory"),
  make_option(c("-qual", "--qual"), type="numeric", dest="qual", action = "store",
              help = "Quality threshold"),
  make_option(c("-minlen", "--minlen"), type="numeric", dest="minlen", action = "store",
              help = "Minimum read length")
)

# Parsing command line arguments:
parser <- OptionParser(usage = "%prog [options] file", option_list=option_list)
args <- commandArgs(T) 
# Provided options:
opt<-parse_args(parser, args = args)

dir_path <- paste(opt$script_dir,"/",sep='')
analysis_dir <- opt$output
ref16S <- opt$ref16S
# Quality trimming parameters:
qual <- as.numeric(opt$qual)
min_len <- as.numeric(opt$minlen)

refs <- c()
if (opt$ref1 != "None") {
  refs <- c(opt$ref1)
}
if (opt$ref2 != "None") {
  refs <- c(refs, opt$ref2)
}
if (opt$ref3 != "None") {
  refs <- c(refs, opt$ref3)
}
if (opt$ref4 != "None") {
  refs <- c(refs, opt$ref4)
}
if (opt$ref5 != "None") {
  refs <- c(refs, opt$ref5)
}
if (opt$ref6 != "None") {
  refs <- c(refs, opt$ref6)
}
if (opt$ref7 != "None") {
  refs <- c(refs, opt$ref7)
}
if (opt$ref8 != "None") {
  refs <- c(refs, opt$ref8)
}
if (opt$ref9 != "None") {
  refs <- c(refs, opt$ref9)
}

libs <- c()
if (opt$lib1 != "None") {
  libs <- c(opt$lib1)
}
if (opt$lib2 != "None") {
  libs <- c(libs, opt$lib2)
}
if (opt$lib3 != "None") {
  libs <- c(libs, opt$lib3)
}
if (opt$lib4 != "None") {
  libs <- c(libs, opt$lib4)
}
if (opt$lib5 != "None") {
  libs <- c(libs, opt$lib5)
}
if (opt$lib6 != "None") {
  libs <- c(libs, opt$lib6)
}
if (opt$lib7 != "None") {
  libs <- c(libs, opt$lib7)
}
if (opt$lib8 != "None") {
  libs <- c(libs, opt$lib8)
}
if (opt$lib9 != "None") {
  libs <- c(libs, opt$lib9)
}

#==============Source files=================#
source("src/config.R") # Link the configuration file with default program parameters and path to the data
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

#----Create "analysis" and "tmp" directories------#
analysis_path <- paste(analysis_dir,sep='')
system(paste("mkdir", analysis_path))
system(paste("mkdir", tmp_dir))
# All information is recorded in log.txt:
logfile <- paste(analysis_path, '/', "log.txt", sep='')
writeMessage(paste("Analysis path: ", analysis_path), logfile, F)
writeMessage("Starting analysis...", logfile, T)
#----Data preparation------#
checkInputData() # Making sure that everything is alright.
source("src/metamp.R") # Link the analysis pipeline

#---The commented code below is obsolete and preserved for the future---#
#------------------OBSOLETE---------------------#
# Usage: 
# Set the working directory by changing the "dir_path" variable
# Under R-environment: source("main.R")
#
## Set the work directory:
# For test
#dir_path <- "~/Projects/metamp/" # Path to the program directory
#analysis_dir <- "analysis" # Directory that keeps all analysis data and results
#
#setwd(dir_path) # <-DO NOT edit this line
#
## Provide your data here (can be raw or preprocessed libs, program assumes one file for each region):
## Even Human Mock Community (all 22 species are in roughly equal concentration):
#==for test
#libs <- c("data/even/SRR072220_V13V31_relabeled.fastq", # V1-3
#          "data/even/SRR072220_V35V53_relabeled.fastq", # V3-5
#          "data/even/SRR072239_V69V96_relabeled.fastq") # V6-9
#
## Reference sequences (small dataset, 21 microbial species and one eucariote):
#ref16S <- "data/16S_gold_hmc.fasta"
#refs <- c("~/Projects/metamp/data/gold/gold_V13.fasta", # V1-3
#          "~/Projects/metamp/data/gold/gold_V35.fasta", # V3-5
#          "~/Projects/metamp/data/gold/gold_V69.fasta") # V6-9
#==end for test
# Do not edit:
#source("config.R") # Link the configuration file with default program parameters and path to the data
#source("metamp.R") # Link the analysis pipeline





