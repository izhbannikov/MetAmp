# -*- coding: utf-8 -*-

library(seqinr) # For manupulations with sequences
#library(BLASTParser,lib.loc=R_LIBS) # Parses USEARCH output file
library(BLASTParser)
library(tripack) # For triangulation
library(RANN) # For kd-tree
library(fpc) # For clustering using the DBSCAN algorithm
library(amap)
library(stringr)
library(foreach) # For parallel clustering
library(ShortRead) # For manipulations with sequences
library(MASS)


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
write_clust_data(paste(tmp_dir, '/tmp_clusters.clstr', sep=''))
write_coordinates(paste(analysis_path, '/', coord_filename, sep=''))

test_id <- toString(readFastq(work_libs[1,2])[1]@id)
if (length(grep("barcodelabel",test_id, fixed=T))!=0) {
  make_otu_table(clstr_infilename=paste(tmp_dir, '/tmp_clusters.clstr', sep=''), 
                 clstr_outfilename=paste(analysis_path, '/', clust_filename, sep=''), 
                 otu_table_filename=paste(analysis_path, '/', otu_table_filename, sep=''), 
                 num_markers=length(refs))
  
} else {
  print("Can't make an OTU table - read id should contain barcodelabel.")
  writeMessage("Can't make an OTU table - read id should contain barcodelabel.", logfile, T)
}

  
if (keep_tmp_files==F) {
  writeMessage("Cleaning up temporary files...", logfile, T)
  system(paste("rm -r", tmp_dir))
}  

#=============End of analysis===============#
writeMessage("End of analysis", logfile, T)
