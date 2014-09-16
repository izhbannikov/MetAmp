#-----------------Analysis direcotory-----------------------------------------------------#
analysis_dir <- "Evaluation/analysis"
#-----------------Reference sequences-------------------------------------------# 
ref16S <- "Evaluation/data/HMC_ref_16S.fasta"
refs <- c("Evaluation/data/HMC_ref_V13.fasta", "Evaluation/data/HMC_ref_V35.fasta", "Evaluation/data/HMC_ref_V69.fasta")
#-----------------Amplicon data----------------------------------------#
#---Can be raw or preprocessed libs------#
libs <- c("Evaluation/data/Dataset1/SRR053817_V1_V3/SRR053817_3.fastq", # V1-3
          "Evaluation/data/Dataset1/SRR053818_V3_V5/SRR053818_3.fastq", # V3-5
          "Evaluation/data/Dataset1/SRR053819_V6_V9/SRR053819_3.fastq") # V6-9

#-----------------Third-party applications to use----------------------#
denoise_data <- T # If you use raw libs, we strongly recommend set it to 'T' !
denoise_app <- "bin/./seqyclean" # Denoising.
merge_app <- "bin/./flash" # Merging overlapping reads.
use_custom_matrix <- T # A 'T' indicates that the user don't want to use pre-aligned references
#-----------------Clustering-------------------------------------------#
# Path to clustering application. Clustering reads to have consensus sequences.
if (Sys.info()['sysname'] == "Darwin") { # OS-X
  cluster_app <- "bin/./cd-hit"
}
if (Sys.info()['sysname'] == "Linux") { # Linux
  cluster_app <- "bin/./cd-hit_lin"
}
cit <- 0.90 # Cluster identity threshold
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