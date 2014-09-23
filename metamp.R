# -*- coding: utf-8 -*-
#
#MetAmp - a software application for meta-amplicon data analysis.
#Written by Ilya Y. Zhbannikov, Feb 2, 2014.
#
# Setting the work directory:
#==============Source files
source("src/methods-Denoising.R")
source("src/methods-Merge.R")
source("src/methods-Convert.R")
source("src/methods-Clust.R")
source("src/methods-Dist.R")
source("src/methods-Stat.R")
source("src/methods-Affine.R")
source("src/methods-Misc.R")
source("src/methods-Triangulation.R")
# Libraries with functions used in MetAmp
library(seqinr) # For manupulations with sequences
library(CDHITConverter) # For translating the CD-HIT's output files into machine-readable format
library(BLASTParser) # Parses BLAST output file
library(tripack) # For triangulation
library(RANN) # For kd-tree
library(fpc) # For clustering using the DBSCAN algorithm
library(amap)
library(doMC) # For parallel clustering
library(foreach) # For parallel clustering
library(ShortRead) # For manipulations with sequences
#----Create "analysis" directory------#
analysis_path <- paste(dir_path, analysis_dir,sep='')
system(paste("mkdir", analysis_path))
# All information is recorded in log.txt:
logfile <- paste(analysis_path, '/', "log.txt", sep='')

writeMessage(paste("Analysis path: ", analysis_path), logfile, F)
writeMessage("Starting analysis...", logfile, T)

#----Data denoising------#
#work_libs <- matrix(nrow=length(libs), ncol=3)
#for (i in seq(libs)) {
#  if (denoise_data == T) {
#    ans <- denoise(infiles=libs[i],
#                   libtype="454",
#                   outprefix=paste(analysis_dir, '/', "work_lib", i, sep=''))
#  } else {
#    # Checking if provided files are in Fasta format:
#    #ans <- tryCatch(readFastq(paste(analysis_dir, '/', "work_lib", i, ".fasta", sep='')), error=function(e) {e <- -1}, finally=function(ans) {ans <--1})
#    
#    #if (ans == -1) {
#    # If so, we just directly copy them into analysis directory:
#    system(paste("cp", libs[i], paste(analysis_dir, '/', "work_lib", i, ".fasta", sep='')))
#    #} else {
#    #  # Otherwise, rase an error and stop:
#    #  print("Error! Provided sequences not in Fasta format!")
#    #}
#  }
#  work_libs[i,1] <- paste(analysis_dir, '/', "work_lib", i, ".fasta", sep='')
#  work_libs[i,2] <- libs[i]
#  
#  # Remove chimeras
#  removeChimeras(infile_reads=work_libs[i,1], infile_uchime=paste(work_libs[i,1],".uchime",sep=''))
#  
#}
#
#
#
#print(paste("Running clustering application", cluster_app, "...") )
#registerDoMC(length(work_libs)) # Register cores and run in parallel
#foreach(i=1:dim(work_libs)[1]) %dopar%
#  cluster(analysis_dir, default_pref, work_libs[i,1])

work_libs <- matrix(nrow=length(libs), ncol=3)
for (i in seq(libs)) {
  work_libs[i,1] <- libs[i] #paste(analysis_dir, '/', "work_lib", i, ".fasta", sep='')
  work_libs[i,2] <- libs[i]
}
print(paste("Running clustering application", cluster_app, "...") )
for(i in 1:dim(work_libs)[1]) {
  work_libs[i,1] <- cluster2(analysis_dir, default_pref, work_libs[i,1])
}

#==============Read distance matrices==================#
writeMessage("Distance matrix for 16S gene sequences...", logfile, T)
score16S <- generate_distance_matrix16S(ref16S)
writeMessage("Done!", logfile, T)

writeMessage("Distance matrix for guide and amplicon reads...", logfile, T)
scoresV <- readDistanceMatrices(work_libs) # This function reads pre-computed distance matrices sequentially
writeMessage("Done!", logfile, T)

#================Compute MDS for 16S=============#
writeMessage("Computing MDS for 16S...", logfile, T)
mds16S <- read16S(ref16S, score16S ) # Here we are computing a multi-dimensional scaling for 16S gene sequences.
num_ref_points <- dim(mds16S)[1] # Number of reference points.
writeMessage("Done!", logfile, T)

#=============Normalize amplicons=============#
# This is the core of the meta-amplicon analysis algorithm.
writeMessage("Normalization...", logfile, T)
summary_matrix <- normalizeAmplicons(scoresV, mds16S, num_ref_points)
writeMessage("Done!", logfile, T)

#=============Perform final clustering with DBSCAN================#
# Also is an important stage. We have to cluster everything after guide sequences carried back the empirical amplicons.
writeMessage("clustering with DBSCAN...", logfile, T)
tmp_clusters <- clusterDBSCAN(rownames(score16S), summary_matrix,scoresV)
writeMessage("Done!", logfile, T)

#=============Assign the final OTUs================#
writeMessage("Assigning the final OTUs...", logfile, T)
OTUS <- assignClusters(tmp_clusters, work_libs)
writeMessage("Done!", logfile, T)

writeMessage("Computing large OTUs...", logfile, T)
largeOTUS <- computeLargeClusters(rownames(score16S), OTUS) 
writeMessage("Done!", logfile, T)

writeMessage("Writing output data...", logfile, T)
write_clust_data(paste(dir_path, analysis_dir, '/', final_clust_filename, sep=''))
write_coordinates(paste(dir_path, analysis_dir, '/', coord_filename, sep=''))

#=============End of analysis===============#
writeMessage("End of analysis", logfile, T)