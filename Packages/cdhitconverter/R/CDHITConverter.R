#CDHITConverter.R
convert <- function(fnames, verbose=F) 
{
    ans <- .Call("Convert",fnames, verbose)
    ans
}

getFileFormat <- function(filename) 
{
  ans <- .Call("GetFileFormat",filename)
  if (ans == 0) { #Fasta format
    print("File in Fasta format.\n")
  } else if (ans == 1) { # Fastq
    print("File in Fastq format.\n")
  } else if (ans == 2) { # Sff
    print("File in Sff.\n")
  } else if (ans == 3) {
    print("Unknown file format.\n")
  }
  
}

