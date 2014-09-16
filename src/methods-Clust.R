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
  #Clustering with automatic epsilon calclulation:
  r1 <- remove_outliers(summary_matrix[,1])
  r2 <- remove_outliers(summary_matrix[,2])
  rr <- cbind(r1,r2)
  
  array <- c()
  # Calculate the coefficient for the eps:
  for (i in 1:length(libs)) {
    array <- c(array,dim(scoresV[[i]])[1]-num_ref_points-4) 
  }
  
  #k <- sum(array)/(( min(array) + sum(array) )/2)
  #eps <- k+( max(r1,na.rm=T) - min(r1,na.rm=T) )*( max(r2,na.rm=T) - min(r2,na.rm=T) ) / (dim(summary_matrix)[1])
  eps <- quantile(dist(mds16S),probs=0.01)#0.025)
  tmp_clusters <- dbscan(summary_matrix[sample.int(nrow(summary_matrix)),],MinPts=1,  eps)
  #tmp_clusters <- dbscan(summary_matrix[sample.int(nrow(summary_matrix)),],MinPts=1,  eps*0.01)
  #flag <- F
  #while(flag==F) {
  #  # Clustering the points using DBSCAN method:
  #  tmp_clusters <- dbscan(summary_matrix[sample.int(nrow(summary_matrix)),],MinPts=1,  eps*0.01)
  #  
  #  for (i in seq(1,length(tmp_clusters$cluster))) {
  #    #if ( length(which(tmp_clusters$cluster == i)) > 10 ) {
  #    if ( length(getRefOTUNum(refnames, rownames(summary_matrix)[which(tmp_clusters$cluster == i)] )) > 1) {
  #      eps <- eps - 0.001
  #      if (eps < 0) {
  #        break
  #      }
  #      flag = F
  #      break
  #    } else {
  #      flag = T
  #    }
  #  } 
    
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
