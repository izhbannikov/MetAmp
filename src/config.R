#-----------------Alignment--------------------------------------------#
usearch <- "usearch8.0.1403_i86osx32"
if (Sys.info()['sysname'] == "Darwin") { # OS-X
  usearch <- "bin/./usearch8.0.1403_i86osx32"
}
if (Sys.info()['sysname'] == "Linux") { # Linux
  usearch <- "bin/./usearch8.0.1403_i86linux32"
}
usearch7 <- "bin/./usearch7.0.1090_i86osx32"
if (Sys.info()['sysname'] == "Darwin") { # OS-X
  usearch7 <- "bin/./usearch7.0.1090_i86osx32"
}
if (Sys.info()['sysname'] == "Linux") { # Linux
  usearch7 <- "bin/./usearch7.0.1090_i86linux32"
}
#--------------Denoising----------------------------------------------#
min_len <- 250
qual <- 15
#--------------Miscellaneous------------------------------------------#
# Path to installed BLASTParser library:
R_LIBS <- "R_Lib"
# Output file with final clusters:
clust_filename <- "clusters.clstr"
# Output OTU table:
otu_table_filename <- "otu_table.txt"
# Output file with coordinates:
coord_filename <- "coordinates.crd"
# Chimeric reference database:
chime_ref <- "data/gold/gold.fa"
# A directory that contains temporary files:
tmp_dir <- paste(analysis_dir, "/tmp", sep='')
# Keep or not temporary files:
keep_tmp_files <- T