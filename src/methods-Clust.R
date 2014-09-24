get_ref_clusters <- function(references, clusters, mds_v) {
  ref_clusters <- c()
  for(ref in rownames(references)) {
    for(item in names(clusters)) { 
      if(ref %in% clusters[[item]]) {
        ref_clusters <- c(ref_clusters,item)
        break
      }
    }
  }
  ref_clusters
}

remove_small_clusters <- function(references, clusters, t) {
  # This function removes the clusters with size less than 't'
  # Parameters: 
  # references - an array of reference clusters
  # clusters - an array of clusters
  # t - a threshold (the minimum number of reads that have to be in a cluster)
  # Here we will not remove a small OTU if it is a reference OTU.
  ans <- list()
  for(name in names(clusters)) {
    if(length(clusters[[name]]) >= t ) {
      ans[[name]] <- clusters[[name]]
    }
  }
  ans
}

# Call clustering program
cluster <- function(analysis_dir, default_pref, lib) {
  system(paste(cluster_app, "-c", cit, "-i", lib, "-o", paste(analysis_dir, "/", basename(lib), '_', cluster_suff, sep=''), "-g", "1", "-M", '0') )
}

# Perform the final clustering with DBSCAN:
clusterDBSCAN <- function(refnames, summary_matrix,scoresV) {
  eps <- quantile(dist(summary_matrix),probs=0.005)[[1]] #0.025)
  #tmp_clusters <- dbscan(summary_matrix[sample.int(nrow(summary_matrix)),],MinPts=2,  eps=eps)
  tmp_clusters <- dbscan(summary_matrix,MinPts=1,  eps=eps)
  #tmp_clusters <- dbscan(summary_matrix[sample.int(nrow(summary_matrix)),],MinPts=1,  eps*0.01)
  
  #flag <- F
  #while(flag==F) {
  #  # Clustering the points using DBSCAN method:
  #  tmp_clusters <- dbscan(summary_matrix,MinPts=1,  eps=eps)
  #  
  #  for (i in seq(1,length(tmp_clusters$cluster))) {
  #    #if ( length(which(tmp_clusters$cluster == i)) > 10 ) {
  #    if ( length(getRefOTUNum(refnames, rownames(summary_matrix)[which(tmp_clusters$cluster == i)] )) > 1) {
  #      eps <- eps/10
  #      if (eps < 0) {
  #        break
  #      }
  #      flag = F
  #      break
  #    } else {
  #      flag = T
  #    }
  #  } 
  #  
  #  if (flag == T) {
  #    break
  #  }
  #}
  tmp_clusters
}

isReferenceOTU <- function(ref_points, otu) {
  # This function checks if the otu if a reference otu
  # Another input parameter is 'ref_points' - i.e. a list of reference points
  ans <- F
  if ( length(which( (otu %in% ref_points) == T) != 0) ) {
    ans <- T
  }
  ans
}

getRefOTUNum <- function(ref_points, otu) {
  # This function computes number of reference points in given OTU
  ans <- 0
  if ( length(which( (otu %in% ref_points) == T)) != 0) {
    ans <- which( (otu %in% ref_points) == T)
  }
  ans
}

# Call clustering program
cluster2 <- function(analysis_dir, default_pref, lib, num) {
  # Denoising:
  denoisedlib <- paste(analysis_dir, "/", basename(lib), "_denoised", sep='')
  system(paste(usearch7, "-fastq_filter", lib,  "-fastaout", denoisedlib, "-fastq_truncqual 15 -fastq_trunclen 250"))
  # Dereplication:
  dreplib <- paste(denoisedlib, "_drep", sep='')
  system(paste(usearch7, "-derep_fulllength", denoisedlib, "-output", dreplib, "-sizeout"))
  # Pre-clustering:
  preclustlib <- paste(dreplib, "_pre", sep='')
  system(paste(usearch7, "-cluster_smallmem", dreplib, "-centroids", preclustlib, "-sizeout -id 0.99 -maxdiffs 1"))
  # Sorting (remove singletons):
  sortlib <- paste(preclustlib, "_sorted", sep='')
  system(paste(usearch7, "-sortbysize", preclustlib, "-output", sortlib, "-minsize 2"))
  # Clustering:
  clusterlib <- paste(sortlib, "_clustered", sep='')
  system(paste(usearch7, "-cluster_otus", sortlib, "-otus", clusterlib, "-minsize 2"))
  # Filtering chimeric sequences:
  nochimericlib <- paste(clusterlib, "_nochimeric", sep='')
  system(paste(usearch7, "-uchime_ref", clusterlib, "-db", ref16S, "-strand plus -nonchimeras", nochimericlib))
  # python python_scripts/fasta_number.py ../../metamp/analysis/SRR072221_forward.fastq_denoised_drep_pre_sorted_clustered_nochimeric OTU_ > otus.fa
  finalotus <- paste(nochimericlib, "_otus.fasta", sep='')
  system(paste("python python_scripts/fasta_number.py", nochimericlib, paste("OTU_",num,'_',sep=''), ">", finalotus))
  # ../usearch7.0.1090_i86osx32 -usearch_global ../../metamp/analysis/SRR072221_forward.fastq_denoised -db otus.fa -strand plus -id 0.97 -uc map.uc
  finalotus
}

