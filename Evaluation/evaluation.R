# -*- coding: utf-8 -*-
#
# MetAmp - a software application for meta-amplicon data analysis.
# Written by Ilya Y. Zhbannikov, Feb 2, 2014
# Updated on Sept 7, 2014
# Usage: 
# Set the working directory by changing the "dir_path" variable
# Under R-environmentL $>source("evaluation.R")
#
# Setting the work directory:
dir_path <- "~/Projects/metamp/" # Working directory where all analysis data will be stored
setwd(dir_path)
source("Evaluation/evaluation_config.R") # Configuration file with default program parameters and path to the data
source("Evaluation/evaluation_metamp.R") # Link the analysis pipeline
