# This script is provides data denoising for meta-amplicon analysis pipeline
denoise <- function(infiles,libtype, outprefix) {
  # Calls SeqyClean to rid off noise:
  if (libtype == "454") {
    # Denoise:
    system(paste(denoise_app, "-454", infiles[1], "-o", outprefix, "-qual 30 30","--fasta_output -minimum_read_length 250"))
    # Convert to fasta:
  } else if (libtype== "pe") {
    system(paste(denoise_app, "-1", infiles[1], "-2", infile[2], "-o", outprefix))
  } else {
    cat(paste("Error: unknown library type",librype))
  }
}

removeChimeras <- function(infile_reads, infile_uchime) {
  # Looking for chimeras:
  system(paste(usearch,"-uchime_ref", infile_reads, "-db", ref16S, "-uchimeout", infile_uchime, "-strand plus"))
  chimes <- read.table(infile_uchime)
  reads <- read.fasta(infile_reads)
  reads_to_write <- reads[chimes[which(chimes$V17=='N'),]$V2]
  names_to_write <- chimes[which(chimes$V17=='N'),]$V2
  
  system(paste("rm", infile_reads)) # Remove old file
  write.fasta(reads_to_write, names_to_write, infile_reads) # Write chimera-free secs
  
}