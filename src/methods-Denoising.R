# This script is provides data denoising for meta-amplicon analysis pipeline
denoise <- function(infiles,libtype, outprefix) {
  # Calls SeqyClean to rid off noise:
  if (libtype == "454") {
    # Denoise:
    system(paste(denoise_app, "-454", infiles[1], "-o", outprefix, "-qual","--fasta_output"))
    # Convert to fasta:
  } else if (libtype== "pe") {
    system(paste(denoise_app, "-1", infiles[1], "-2", infile[2], "-o", outprefix))
  } else {
    cat(paste("Error: unknown library type",librype))
  }
}

denoise454 <- function(denoise_app, dir_path, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9, analysis_path, default_pref) {
  if(lib1 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib1,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV1",sep=''), sep=' '))
  }
  if(lib2 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib2,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV2",sep=''), sep=' '))
  }
  if(lib3 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib3,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV3",sep=''), sep=' '))
  }
  if(lib4 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib4,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV4",sep=''), sep=' '))
  }
  if(lib5 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib5,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV5",sep=''), sep=' '))
  }
  if(lib6 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib6,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV6",sep=''), sep=' '))
  }
  if(lib7 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib7,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV7",sep=''), sep=' '))
  }
  if(lib8 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib8,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV8",sep=''), sep=' '))
  }
  if(lib9 != "") {
    system( paste(denoise_app, "-454", paste(dir_path,lib9,sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV9",sep=''), sep=' '))
  }
}

denoiseIllumina <- function(denoise_app, dir_path, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9, analysis_path, default_pref) {
  if(lib1 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_1.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV1",sep=''), sep=' ')) #"-i64"
  }
  if(lib2 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_2.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV2",sep=''), sep=' '))
  }
  if(lib3 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_3.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV3",sep=''), sep=' '))
  }
  if(lib4 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_4.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV4",sep=''), sep=' '))
  }
  if(lib5 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_5.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV5",sep=''), sep=' '))
  }
  if(lib6 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_6.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV6",sep=''), sep=' '))
  }
  if(lib7 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_7.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV7",sep=''), sep=' '))
  }
  if(lib8 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_8.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV8",sep=''), sep=' '))
  }
  if(lib9 != "") {
    system( paste(denoise_app, "-U", paste(analysis_path, "/", default_pref, "_9.extendedFrags.fastq", sep=''), "-qual", "-o", paste(analysis_path, "/", default_pref, "_denoised_libV9",sep=''), sep=' '))
  }
}