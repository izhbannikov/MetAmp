#
# Contains methods for calculating distance matrices
#
# Computes a distance matrix for 16S gene sequences:
generate_distance_matrix16S <- function(filename) {
  usearch_out <- paste(tmp_dir, '/', basename(filename),"_out.mx",sep='')
  
  #num_threads <- detectCores()
  #if (num_threads > max_threads)
  #  num_threads <- max_threads
  #system(paste(usearch, "-distmx_brute -calc_distmx", filename, "-distmxout", usearch_out, "-format square"))
  #system(paste(usearch, "-calc_distmx", filename, "-distmxout", usearch_out, "-format square -threads", num_threads))
  #reads <- read.fasta(filename)
  #identity_matrix <- BuildDistanceMatrixUSEARCH_v8(filename, usearch_out)
  #identity_matrix[which(duplicated(identity_matrix)==T),] <- identity_matrix[which(duplicated(identity_matrix)==T),] + runif(length(which(duplicated(identity_matrix)==T)), 0.0001, 0.1)
  #identity_matrix
  system(paste(usearch, "-acceptall -allpairs_global", filename, "-uc", usearch_out))
  identity_matrix <- BuildIdentityMatrixUSEARCH(filename, filename, usearch_out, F)
  identity_matrix[which(duplicated(identity_matrix)==T),] <- identity_matrix[which(duplicated(identity_matrix)==T),] + runif(length(which(duplicated(identity_matrix)==T)), 0.0000001, 0.00001)
  identity_matrix
}

generate_distance_matrix <- function(fnameREF16S, fnameREF="", fnameEMP="", dt=0.04) {
  # This function calculates distance matrix between reference marker sequences and empirical reads.
  # fnameREF - guide (reference marker) reads
  # fnameEMP - empirical reads of microbial community of interest
  
  # Merging reference and empirical (consensus) sequences together:
  ref_emp <- paste(tmp_dir, '/', basename(fnameREF), "_", basename(fnameEMP), sep='' )
  system(paste("cat", fnameREF, fnameEMP, '>', ref_emp))
  # Computing distance matrices for both reference and empirical (clustered) sequences:
  dmx_out <- paste(tmp_dir, '/', basename(ref_emp), ".dmx",sep='')
  
  #-distmx_brute 
  #system(paste(usearch, "-distmx_brute -calc_distmx", ref_emp, "-distmxout", dmx_out, "-format square"))
  #system(paste(usearch, "-calc_distmx", ref_emp, "-distmxout", dmx_out, "-format square -threads", num_threads))
  #identity_matrix <- BuildDistanceMatrixUSEARCH_v8(ref_emp, dmx_out)
  #identity_matrix[which(duplicated(identity_matrix)==T),] <- identity_matrix[which(duplicated(identity_matrix)==T),] + runif(length(which(duplicated(identity_matrix)==T)), 0.0001, 0.1)
  #identity_matrix
  system(paste(usearch, "-acceptall -allpairs_global", ref_emp, "-uc", dmx_out)) # &
  identity_matrix <- BuildIdentityMatrixUSEARCH(fnameREF16S, ref_emp, dmx_out, T)
  identity_matrix[which(duplicated(identity_matrix)==T),] <- identity_matrix[which(duplicated(identity_matrix)==T),] + runif(length(which(duplicated(identity_matrix)==T)), 0.0000001, 0.00001)
  # Merge highly similar objects:
  d1 = identity_matrix
  sz = dim(d1)[1]
  del = c()
  m_table <- c()
  for (i in 1:sz) {
    for (j in 1:dim(score16S)[1]) {
      if ((d1[i,j]<dt) && (i > dim(score16S)[1]) && (i != j)) {
        #print(c(i,j))
        del = c(del,i)
        if ((rownames(identity_matrix)[i] %in% m_table) == F)
          m_table = c(m_table, colnames(identity_matrix)[j], rownames(identity_matrix)[i])
      }
    }
  }
  keep.idx <- setdiff(seq_len(nrow(d1)), del)
  identity_matrix = d1[keep.idx, keep.idx]
  identity_matrix
  if (length(m_table>=2)) {
    m_table <- matrix(m_table, ncol=2, byrow=T)
  }
  list(identity_matrix, m_table)
}


# This function reads/generates distance matrices for all provided guide sequences.
#readDistanceMatrices <- function(use_custom_matrix = F, work_libs) {
readDistanceMatrices <- function(ref_16S, work_libs, dt=0.04) {
  scoresV <- list()
  merged_table <- list()
  for(i in 1:length(libs)) {
    cat("Library: ", basename(work_libs[i,1]),'\n')
    distances <- generate_distance_matrix(fnameREF16S=ref_16S, fnameREF=refs[i], fnameEMP=work_libs[i,1], dt)
    scoresV[[i]] <- distances[[1]]
    merged_table[[i]] <- distances[[2]]
  }
  list(scoresV, merged_table)
}