#BLASTParser.R

BuildIdentityMatrix <- function(fname) 
{
    ans <- .Call("BuildIdentityMatrix",fname)
    rownames(ans[[1]]) <- ans[[2]];
    colnames(ans[[1]]) <- ans[[2]];
    ans[[1]]
}

BuildIdentityMatrixUSEARCH <- function(fname, table)
{
  reads <- read.fasta(fname)
  ans <- .Call("BuildIdentityMatrixUSEARCH",table,length(reads))
  rownames(ans) <- names(reads)
  colnames(ans) <- names(reads)
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

BuildIdentityMatrixUSEARCH3 <- function(fname_REF, fname_EMP, table_REF, fname_BLAST_REF_EMP, fnameU_EMP)
{
  reads <- read.fasta(fname_REF)
  e_reads <- read.fasta(fname_EMP)
  ans <- .Call("BuildIdentityMatrixUSEARCH3",table_REF,length(reads)+length(e_reads), fname_BLAST_REF_EMP, fnameU_EMP)
  rownames(ans) <- c(names(reads),names(e_reads))
  colnames(ans) <- c(names(reads),names(e_reads))
  ans
}