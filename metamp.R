# -*- coding: utf-8 -*-
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
library(BLASTParser) # Parses BLAST output file
library(tripack) # For triangulation
library(RANN) # For kd-tree
library(fpc) # For clustering using the DBSCAN algorithm
library(amap)
library(stringr)
library(foreach) # For parallel clustering
library(ShortRead) # For manipulations with sequences
library(MASS)
#----Create "analysis" and "tmp" directories------#
analysis_path <- paste(dir_path, analysis_dir,sep='')
system(paste("mkdir", analysis_path))
system(paste("mkdir", tmp_dir))

# All information is recorded in log.txt:
logfile <- paste(analysis_path, '/', "log.txt", sep='')

writeMessage(paste("Analysis path: ", analysis_path), logfile, F)
writeMessage("Starting analysis...", logfile, T)

#----Data preparation------#
print(paste("Running preprocessing pipeline...") )
writeMessage(paste("Running preprocessing pipeline..."), logfile, T)
work_libs <- matrix(nrow=length(libs), ncol=3)
for (i in seq(libs)) {
  work_libs[i,1] <- libs[i] 
  work_libs[i,2] <- libs[i]
}
for(i in 1:dim(work_libs)[1]) {
  work_libs[i,1] <- cluster2(analysis_dir=tmp_dir, lib=work_libs[i,1], num=i)
}

#==============Builging distance matrices==================#
writeMessage("Building distance matrix for 16S gene sequences...", logfile, T)
score16S <- generate_distance_matrix16S(ref16S)
writeMessage("Done!", logfile, T)

writeMessage("Building distance matrix for guide and amplicon reads...", logfile, T)
distancesEmp <- readDistanceMatrices(ref16S, work_libs)
scoresV <- distancesEmp[[1]] # This function reads pre-computed distance matrices sequentially
merged_table <- distancesEmp[[2]]
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
#--Temporary commenting
#cluster_matrix <- summary_matrix[1:dim(score16S)[1],]
#cluster_matrix <- rbind(cluster_matrix, summary_matrix[(dim(score16S)[1]+5):dim(summary_matrix)[1],])
#--End of temporary commenting
cluster_matrix <- summary_matrix
tmp_clusters <- clusterDBSCAN(rownames(score16S), cluster_matrix,scoresV)
writeMessage("Done!", logfile, T)

#=============Assign the final OTUs================#
writeMessage("Assigning the final OTUs...", logfile, T)
OTUS <- assignClusters(tmp_clusters, work_libs)
writeMessage("Done!", logfile, T)

writeMessage("Writing output data...", logfile, T)
write_clust_data(paste(dir_path, tmp_dir, '/tmp_clusters.clstr', sep=''))
write_coordinates(paste(dir_path, analysis_dir, '/', coord_filename, sep=''))
make_otu_table(clstr_infilename=paste(dir_path, tmp_dir, '/tmp_clusters.clstr', sep=''), 
               clstr_outfilename=paste(dir_path, analysis_dir, '/', clust_filename, sep=''), 
               otu_table_filename=paste(dir_path, analysis_dir, '/', otu_table_filename, sep=''), 
               num_markers=length(refs))
  
if (keep_tmp_files) {
  writeMessage("Cleaning up temporary files...", logfile, T)
  system(paste("rm -r", tmp_dir))
}  

#=============End of analysis===============#
writeMessage("End of analysis", logfile, T)
