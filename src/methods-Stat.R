# This script provides some statistical computations for meta-amplicon analysis

assignClusters <- function(tmp_clusters, work_libs) {
  consensus_reads <- vector(mode="list", length=0 )
  # Consensus reads & clusters:
  for (i in seq(num_ref_points-4)) {
    consensus_reads[[rownames(summary_matrix)[i]]] <- rownames(summary_matrix)[i]
  }
  clustered_libs <- matrix("", nrow=length(work_libs),ncol=1)
  for (i in 1:dim(work_libs)[1]) {
    clustered_libs[i,] <- paste(analysis_dir, "/", basename(work_libs[i]), '_', cluster_suff, ".clstr", sep='')
  }
  
  # Statistical analysis:
  #First, determine the number of clusters for each consensus sequences:
  for ( k in seq(dim(work_libs)[1]) ) {
    clusters <- convert(clustered_libs[k,])
    for (i in seq(length(rownames(summary_matrix)))) {
      for (j in seq(length(clusters))) {
        if (rownames(summary_matrix)[i] %in% clusters[[j]]) {
          consensus_reads[[rownames(summary_matrix)[i]]] <- clusters[[j]]
          break
        }
      }
    }
  }

  # Then assign each read to its cluster:
  tmp_final_clusters <- vector(mode="list", length=length(unique(tmp_clusters$cluster)))
  for (i in 1:length(unique(tmp_clusters$cluster))) {
    for (ii in 1:length(rownames(summary_matrix)[which(tmp_clusters$cluster == i)])) {
      if (is.null(consensus_reads[ rownames(summary_matrix)[which(tmp_clusters$cluster == i)][ii] ][[1]])==F) {
        if (is.null(tmp_final_clusters[[i]])) {
          tmp_final_clusters[[i]] <- consensus_reads[ rownames(summary_matrix)[which(tmp_clusters$cluster == i)][ii] ][[1]]
        } else {
          tmp_final_clusters[[i]] <- c(tmp_final_clusters[[i]],consensus_reads[ rownames(summary_matrix)[which(tmp_clusters$cluster == i)][ii] ][[1]])
        }
      }
    }
  }

  tmp_final_clusters <- tmp_final_clusters[!sapply(tmp_final_clusters, is.null)]
  tmp_final_clusters
  
  # Calculating the mean number of points in each cluster:
  #final_statistics = vector(mode="list", length=length(unique(tmp_clusters$cluster)))
  #for (i in 1:length(tmp_final_clusters)) {
  #  final_statistics[[i]] <- mean( length(which( (tmp_final_clusters[[i]] %in% rownames(norm_data_v13[[2]]) ) == T))+1, length(which( (tmp_final_clusters[[i]] %in% rownames(norm_data_v35[[2]]) ) == T))+1, length(which( (tmp_final_clusters[[i]] %in% rownames(norm_data_v69[[2]]) ) == T))+1 )
  #}

  #tf_array <- matrix(0, nrow=1, ncol=length(tmp_final_clusters))
  #for (i in seq(length(tmp_final_clusters))) {
  # tf_array[1,i] <- length(which((rownames(mds16S) %in% tmp_final_clusters[[i]])==T))
  #}
  #if (max(tf_array) <= 20) {
  #  break
  #} 
  
}

computeLargeClusters <- function(ref_points_list, clusters) {
  #Here we do not remove an OTU if it is a reference OTU
  largeClusters <- list()
  cnt <- 0
  for (i in 1:length(clusters)) {
    if ( (length(clusters[[i]]) >= 10) || (isReferenceOTU(ref_points_list, clusters[[i]]) == T) ) {
      cnt <- cnt + 1
      largeClusters[[cnt]] <- clusters[[i]]
    }
  }
  largeClusters
}