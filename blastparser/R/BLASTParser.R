#BLASTParser.R

BuildIdentityMatrix <- function(fname) 
{
    ans <- .Call("BuildIdentityMatrix",fname)
    rownames(ans[[1]]) <- ans[[2]];
    colnames(ans[[1]]) <- ans[[2]];
    ans[[1]]
}

BuildIdentityMatrixUSEARCH <- function(fname_ref, fname_ref_emp, table, refemp=F)
{
  if (refemp) { 
  	reads_ref <- read.fasta(fname_ref) # Reference reads only
  	reads_ref_emp <- read.fasta(fname_ref_emp) # Empirical and reference reads
  	ans <- .Call("BuildIdentityMatrixUSEARCH",table,length(reads_ref_emp),length(reads_ref))
  	rownames(ans) <- names(reads_ref_emp)
  	colnames(ans) <- names(reads_ref_emp)
  	ans <- ans[ c( 1:(length(reads_ref)/2), (length(reads_ref)+1):length(reads_ref_emp) ), c( 1:(length(reads_ref)/2), (length(reads_ref)+1):length(reads_ref_emp) ) ] 
  } else {
  	reads_ref <- read.fasta(fname_ref) # Reference reads only
  	ans <- .Call("BuildIdentityMatrixUSEARCH",table,length(reads_ref),length(reads_ref))
  	rownames(ans) <- names(reads_ref)
  	colnames(ans) <- names(reads_ref)
  	ans <- ans[1:(length(reads_ref)/2), 1:(length(reads_ref)/2)]
  }
  ans
}

BuildIdentityMatrixUSEARCH2 <- function(fname_REF, fname_EMP, table_REF, fname_BLAST_REF_EMP, fnameU_EMP)
{
  reads <- read.fasta(fname_REF)
  e_reads <- read.fasta(fname_EMP)
  ans <- .Call("BuildIdentityMatrixUSEARCH2",table_REF,length(reads)+length(e_reads), fname_BLAST_REF_EMP, fnameU_EMP)
  rownames(ans) <- c(names(reads),names(e_reads))
  colnames(ans) <- c(names(reads),names(e_reads))
  ans
}

BuildDistanceMatrixUSEARCH_v8 <- function(fname, table)
{
  reads <- read.fasta(fname)
  t<-read.table(table, header=T)
  t<-t[,2:dim(t)[2]]
  rownames(t) <- names(reads)
  colnames(t) <- names(reads)
  t
}