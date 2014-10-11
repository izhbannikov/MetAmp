#-----------------Analysis direcotory-----------------------------------------------------#
analysis_dir <- "analysis"
tmp_dir <- paste(analysis_dir, "/tmp", sep='')
#-----------------Alignment--------------------------------------------#
usearch <- "usearch8.0.1403_i86osx32"
if (Sys.info()['sysname'] == "Darwin") { # OS-X
  usearch <- "bin/./usearch8.0.1403_i86osx32"
}
if (Sys.info()['sysname'] == "Linux") { # Linux
  usearch <- "bin/./usearch8.0.1403_i86linux32"
}
usearch7 <- "bin/./usearch7.0.1090_i86osx32"
#--------------Miscellaneous------------------------------------------#
# Output file with final clusters:
clust_filename <- "clusters.clstr"
# Output OTU table:
otu_table_filename <- "otu_table.txt"
# Output file with coordinates:
coord_filename <- "coordinates.crd"
# Chimeric reference database:
chime_ref <- "data/gold/gold.fa"
# Keep or not temporary files:
keep_tmp_files <- F