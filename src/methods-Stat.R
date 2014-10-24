# This script provides some statistical computations for meta-amplicon analysis

assignClusters <- function(tmp_clusters, work_libs) {
  
  # Then assign each read to its cluster:
  tmp_final_clusters <- vector(mode="list", length=length(unique(tmp_clusters$cluster)))
  for (i in 1:length(unique(tmp_clusters$cluster))) {
    core <- rownames(cluster_matrix)[which(tmp_clusters$cluster == i)]
    tmp_final_clusters[[i]] <- core
    for (j in 1:length(merged_table)) {
      for (k in 1:length(core)) {
        tmp_final_clusters[[i]] <- c(tmp_final_clusters[[i]], merged_table[[j]][which(merged_table[[j]][,1]==core[k]),2])
      }
    }
  }
  final_clusters <- list()
  j=1
  for (i in 1:length(tmp_final_clusters)) {
    if (length(which(tmp_final_clusters[[i]] %in% rownames(score16S)) == T) != length(tmp_final_clusters[[i]]) ) {
      final_clusters[[j]] <- tmp_final_clusters[[i]]
      j <- j+1
    }
  }

  #tmp_final_clusters <- tmp_final_clusters[!sapply(tmp_final_clusters, is.null)]
  final_clusters
  
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