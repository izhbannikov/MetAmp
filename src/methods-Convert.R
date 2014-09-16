# Converts fastq to fasta
fastq2fasta <- function(analysis_dir, default_pref, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9) {
  if(lib1 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV1_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV1_SE.fasta", sep='') )
  }
  if(lib2 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV2_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV2_SE.fasta", sep='') )
  }
  if(lib3 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV3_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV3_SE.fasta", sep='') )
  }
  if(lib4 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV4_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV4_SE.fasta", sep='') )
  }
  if(lib5 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV5_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV5_SE.fasta", sep='') )
  }
  if(lib6 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV6_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV6_SE.fasta", sep='') )
  }
  if(lib7 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV7_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV7_SE.fasta", sep='') )
  }
  if(lib8 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV8_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV8_SE.fasta", sep='') )
  }
  if(lib9 != "") {
    reads <- readFastq( paste(analysis_dir, "/", default_pref, "_denoised_libV9_SE.fastq", sep=''), format="fastq" )
    writeFasta( reads, paste(analysis_dir, "/", default_pref, "_denoised_libV9_SE.fasta", sep='') )
  }
}

add_references <- function(analysis_dir, default_pref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9) {
  #if (lib1 != "") {
  #  system( paste("cat", ref1, paste(analysis_dir,"/",default_pref,"_denoised_libV1_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV1_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib2 != "") {
  #  system( paste("cat", ref2, paste(analysis_dir,"/",default_pref,"_denoised_libV2_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV2_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib3 != "") {
  #  system( paste("cat", ref3, paste(analysis_dir,"/",default_pref,"_denoised_libV3_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV3_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib4 != "") {
  #  system( paste("cat", ref4, paste(analysis_dir,"/",default_pref,"_denoised_libV4_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV4_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib5 != "") {
  #  system( paste("cat", ref5, paste(analysis_dir,"/",default_pref,"_denoised_libV5_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV5_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib6 != "") {
  #  system( paste("cat", ref6, paste(analysis_dir,"/",default_pref,"_denoised_libV6_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV6_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib7 != "") {
  #  system( paste("cat", ref7, paste(analysis_dir,"/",default_pref,"_denoised_libV7_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV7_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib8 != "") {
  #  system( paste("cat", ref8, paste(analysis_dir,"/",default_pref,"_denoised_libV8_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV8_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  #if (lib9 != "") {
  #  system( paste("cat", ref9, paste(analysis_dir,"/",default_pref,"_denoised_libV9_SE.fasta", sep=''), '>', paste(analysis_dir, "/", default_pref, "_merged_libV9_SE.fasta", sep='') ) ) #, "shell=True") )
  #}
  
  if (lib1 != "") {
    system( paste("cat", ref1, paste(analysis_dir,"/",default_pref,"_clustered_libV1", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV1", sep='') ) ) #, "shell=True") )
  }
  if (lib2 != "") {
    system( paste("cat", ref2, paste(analysis_dir,"/",default_pref,"_clustered_libV2", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV2", sep='') ) ) #, "shell=True") )
  }
  if (lib3 != "") {
    system( paste("cat", ref3, paste(analysis_dir,"/",default_pref,"_clustered_libV3", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV3", sep='') ) ) #, "shell=True") )
  }
  if (lib4 != "") {
    system( paste("cat", ref4, paste(analysis_dir,"/",default_pref,"_clustered_libV4", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV4", sep='') ) ) #, "shell=True") )
  }
  if (lib5 != "") {
    system( paste("cat", ref5, paste(analysis_dir,"/",default_pref,"_clustered_libV5", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV5", sep='') ) ) #, "shell=True") )
  }
  if (lib6 != "") {
    system( paste("cat", ref6, paste(analysis_dir,"/",default_pref,"_clustered_libV6", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV6", sep='') ) ) #, "shell=True") )
  }
  if (lib7 != "") {
    system( paste("cat", ref7, paste(analysis_dir,"/",default_pref,"_clustered_libV7", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV7", sep='') ) ) #, "shell=True") )
  }
  if (lib8 != "") {
    system( paste("cat", ref8, paste(analysis_dir,"/",default_pref,"_clustered_libV8", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV8", sep='') ) ) #, "shell=True") )
  }
  if (lib9 != "") {
    system( paste("cat", ref9, paste(analysis_dir,"/",default_pref,"_clustered_libV9", sep=''), '>', paste(analysis_dir, "/", default_pref, "_clustered_merged_libV9", sep='') ) ) #, "shell=True") )
  }
  
}