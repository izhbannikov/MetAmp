#
# Contains methods for calculating distance matrices
#
# Computes a distance matrix for 16S gene sequences:
generate_distance_matrix16S <- function(filename) {
  usearch_out <- paste(analysis_dir, '/', basename(filename),"_out.mx",sep='')
  system(paste(usearch, "-distmx_brute -calc_distmx", filename, "-distmxout", usearch_out, "-format square"))
  reads <- read.fasta(filename)
  identity_matrix <- BuildDistanceMatrixUSEARCH_v8(filename, usearch_out)
  identity_matrix
}

generate_distance_matrix <- function(fnameREF="", fnameEMP="") {
  # This function calculates distance matrix between reference marker sequences and empirical reads.
  # fnameREF - guide (reference marker) reads
  # fnameEMP - empirical reads of microbial community of interest
  
  # Merging reference and empirical (consensus) sequences together:
  ref_emp <- paste(analysis_dir, '/', basename(fnameREF), "_", basename(fnameEMP), sep='' )
  system(paste("cat", fnameREF, fnameEMP, '>', ref_emp))
  # Computing distance matrices for both reference and empirical (clustered) sequences:
  dmx_out <- paste(analysis_dir, '/', basename(ref_emp), ".dmx",sep='')
  system(paste(usearch, "-distmx_brute -calc_distmx", ref_emp, "-distmxout", dmx_out, "-format square"))
  #reads <- read.fasta(ref_emp)
  identity_matrix <- BuildDistanceMatrixUSEARCH_v8(ref_emp, dmx_out)
  identity_matrix
}


# This function reads/generates distance matrices for all provided guide sequences.
#readDistanceMatrices <- function(use_custom_matrix = F, work_libs) {
readDistanceMatrices <- function(work_libs) {
  scoresV <- list()
  for(i in 1:length(libs)) {
    cat("Library: ", basename(work_libs[i,1]),'\n')
    scoresV[[i]] <- generate_distance_matrix(fnameREF=refs[i], fnameEMP=paste(analysis_dir, "/", basename(work_libs[i,1]), '_', cluster_suff, sep=''))
  }
  scoresV
}