# Merges overlapping reads:
merge <- function(merge_app, dir_path, analysis_path, default_pref, lib1, lib2, lib3, lib4, lib5, lib6, lib7, lib8, lib9) {
  if (lib1 != "") {
    lib_files <- unlist(strsplit(lib1, ' '))
    system( paste( merge_app, "-o", paste(analysis_path, "/", default_pref, "_1", sep=''), paste(dir_path, lib_files[1], sep=''), paste(dir_path, lib_files[2], sep='') ) )
  }
  if (lib2 != "") {
    lib_files <- unlist(strsplit(lib2, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_2", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib3 != "") {
    lib_files <- unlist(strsplit(lib3, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_3", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib4 != "") {
    lib_files <- unlist(strsplit(lib4, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_4", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib5 != "") {
    lib_files <- unlist(strsplit(lib5, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_5", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib6 != "") {
    lib_files <- unlist(strsplit(lib6, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_6", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib7 != "") {
    lib_files <- unlist(strsplit(lib7, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_7", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib8 != "") {
    lib_files <- unlist(strsplit(lib8, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_8", sep=''), lib_files[1], lib_files[2] ) )
  }
  if (lib9 != "") {
    lib_files <- unlist(strsplit(lib9, ' '))
    system( paste(merge_app, "-o", paste(analysis_path, "/", default_pref, "_9", sep=''), lib_files[1], lib_files[2] ) )
  }
}