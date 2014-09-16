# This script provides joing overlapping paired-end reads
# By Ilya Y Zhbannikov, 2014-08-15
join_flash <- function() {
  # Calls SeqyClean to rid off noise:
  system("bin/seqyclean/./seqyclean -1", "-2")
}