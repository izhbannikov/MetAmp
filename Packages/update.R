#!/usr/bin/env Rscript
# This is an updating script
#
default_repo = "http://cran.us.r-project.org"

# Updating packages before installing to make sure that everything is fine:
print("Updating packages before installing to make sure that everything is fine...")
update.packages(repos=default_repo, ask = F)
print("Done!")