# Basic house-keeping tasks:
checkInputData <- function() {
  # Checking provided empirical data:
  for (i in 1:length(libs)) {
    if (file.exists(libs[i]) == F) {
      stop(paste("Error: file", libs[i], "not exists. Terminating."))
    }
  }
  # Checking for reference libraries:
  if (file.exists(ref16S) == F) {
    stop(paste("Error: file", ref16S, "not exists. Terminating."))
  }
  for (i in 1:length(refs)) {
    if (file.exists(refs[i]) == F) {
      stop(paste("Error: file", refs[i], "not exists. Terminating."))
    }
  }
}