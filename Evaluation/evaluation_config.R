#-----------------Analysis direcotory-----------------------------------------------------#
analysis_dir <- "analysis"
#-----------------Third-party applications to use----------------------#
denoise_data <- T # If you use raw libs, we strongly recommend set it to 'T' !
denoise_app <- "bin/./seqyclean" # Denoising.
merge_app <- "bin/./flash" # Merging overlapping reads.
#-----------------Clustering-------------------------------------------#
# Path to clustering application. Clustering reads to have consensus sequences.
if (Sys.info()['sysname'] == "Darwin") { # OS-X
  cluster_app <- "bin/./cd-hit"
}
if (Sys.info()['sysname'] == "Linux") { # Linux
  cluster_app <- "bin/./cd-hit_lin"
}
cit <- 0.97 # Cluster identity threshold
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
#--------------Miscellaneous------------------------------------------#
# Pooling (mixing) samples
pooling_samples <- T # If it is 'T' than the program assumes that the read headers have 'barcodelabel=<SAMPLE_ID>' inside. More: http://drive5.com/usearch/manual/mapreadstootus.html
# Output file with final clusters:
final_clust_filename <- "clusters.clstr"
# Output file with coordinates:
coord_filename <- "coordinates.crd"