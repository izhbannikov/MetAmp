#-----------------Analysis direcotory-----------------------------------------------------#
analysis_dir <- "analysis"
#-----------------Third-party applications to use----------------------#
#-----------------Clustering-------------------------------------------#
use_variable_trhreshold <- F
cit_step <- 0.01
min_cit <- 0.5
cluster_suff <- "clustered"
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
# Pooling (mixing) samples
pooling_samples <- T # If it is 'T' than the program assumes that the read headers have 'barcodelabel=<SAMPLE_ID>' inside. More: http://drive5.com/usearch/manual/mapreadstootus.html
# Output file with final clusters:
final_clust_filename <- "clusters.clstr"
# Output file with coordinates:
coord_filename <- "coordinates.crd"
max_threads <- 16
chime_ref <- "data/gold/gold.fa"