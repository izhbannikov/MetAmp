#
# Miscellaneous methods
#

# Normalizes amplicon sequences:
normalizeAmplicons <- function(scoresV, mds16S, num_ref_points) {
  summary_matrix <- matrix(0, nrow=1, ncol=2)
  #
  norm_data_v <- list()
  for (i in 1:length(libs)) {
    
    if (dim(scoresV[[i]])[1]==dim(score16S)[1]) { # All OTUS are merged with references!
      if (i == 1) {
        summary_matrix <- rbind(summary_matrix, mds16S[1:num_ref_points,])
        summary_matrix <- summary_matrix[2:dim(summary_matrix)[1],] # Removing the first row
        rownames(summary_matrix) <- rownames(mds16S)
      }    
    } else {
      norm_data_v[[i]] <- process_data(imatrix=scoresV[[i]], mds16s=mds16S, nrp=num_ref_points)
      if (i == 1) {
        summary_matrix <- rbind(summary_matrix, norm_data_v[[1]][[1]][1:num_ref_points,])
        summary_matrix <- summary_matrix[2:dim(summary_matrix)[1],] # Removing the first row
        rownames(summary_matrix) <- rownames(mds16S)
      }
      summary_matrix <- rbind(summary_matrix, norm_data_v[[i]][[2]])
    }
  
  }
  
  summary_matrix
}

read16S <- function(infile, imatrix) {
  #=======Read the 16S reference genes (sequences)=======#
  #Read identity matrix of complete 16S sequences:
  matrix16S <- imatrix #as.matrix(read.csv(dmatrix,sep=',',header=F))
  #Make distance matrix out of identity matrix:
  dist_matrix16S <- matrix16S
  #Make multidimensional scaling in order to place 16S sequences into the plane:
  #mds16S <- cmdscale(dist_matrix16S) # Classical multidimensional scaling of a data matrix. Also known as principal coordinates analysis (Gower, 1966). 
  #mds16S <- isoMDS(dist_matrix16S,maxit = 500,tol = 0.00001)$points # NMDS
  mds16S <- sammon(dist_matrix16S,niter = 1000, magic=0.001, tol = .Machine$double.eps/10e150)$points # NMDS
  # Here we add corner points in order to make sure that each empirical point will be inside of some triangle:
  
  #--Temporary comment:
  #A <- c(min(mds16S[,1])-abs(min(mds16S[,1]))/100, min(mds16S[,2])-abs(min(mds16S[,2]))/100) # The most lower-left point
  #B <- c(min(mds16S[,1])-abs(min(mds16S[,1]))/100, max(mds16S[,2])+abs(max(mds16S[,2]))/100) # The most upper-left point
  #C <- c(max(mds16S[,1])+abs(max(mds16S[,1]))/100, max(mds16S[,2])+abs(max(mds16S[,2]))/100) # The most upper-right point
  #D <- c(max(mds16S[,1])+abs(max(mds16S[,1]))/100, min(mds16S[,2])-abs(min(mds16S[,2]))/100) # The most lower-right point
  #ans <- matrix(0,nrow=4,ncol=2)
  #ans[1,1] <- A[1]
  #ans[1,2] <- A[2]
  #ans[2,1] <- B[1] 
  #ans[2,2] <- B[2]
  #ans[3,1] <- C[1]
  #ans[3,2] <- C[2]
  #ans[4,1] <- D[1]
  #ans[4,2] <- D[2]
  #rownames(ans) <- seq(4)
  # Append the rows to the multidimensional 16S matrix:
  #mds16S <- rbind(mds16S, ans)
  #--End of temporary comment
  
  mds16S
}

#Read variable reference and empirical reads:
process_data <- function(imatrix, mds16s, nrp) {
  #Compute the distance matrix:
  dist_matrixV <- imatrix
  #Make multidimensional scaling:
  #mdsV <- cmdscale(dist_matrixV) #Classical multidimensional scaling of a data matrix. Also known as principal coordinates analysis (Gower, 1966).
  #mdsV <- isoMDS(dist_matrixV,maxit = 500,tol=0.00001)$points #NMDS
  mdsV <- sammon(dist_matrixV,niter = 1000, magic=0.001, tol = .Machine$double.eps/10e150)$points #NMDS
  # Here we add corner points in order to make sure that each empirical point will be inside of some triangle:
  
  #--Temporary comment:
  #A <- c(min(mdsV[,1])-abs(min(mdsV[,1]))/100, min(mdsV[,2])-abs(min(mdsV[,2]))/100) # The most lower-left point
  #B <- c(min(mdsV[,1])-abs(min(mdsV[,1]))/100, max(mdsV[,2])+abs(max(mdsV[,2]))/100) # The most upper-left point
  #C <- c(max(mdsV[,1])+abs(max(mdsV[,1]))/100, max(mdsV[,2])+abs(max(mdsV[,2]))/100) # The most upper-right point
  #D <- c(max(mdsV[,1])+abs(max(mdsV[,1]))/100, min(mdsV[,2])-abs(min(mdsV[,2]))/100) # The most lower-right point
  #ans <- matrix(0,nrow=4,ncol=2)
  #ans[1,1] <- A[1]
  #ans[1,2] <- A[2]
  #ans[2,1] <- B[1]
  #ans[2,2] <- B[2]
  #ans[3,1] <- C[1]
  #ans[3,2] <- C[2]
  #ans[4,1] <- D[1]
  #ans[4,2] <- D[2]
  #rownames(ans) <- seq(4)
  #
  # We need to arrange mdsV to be in the same order like mds16S.
  # Here we are determining guide points:
  #mdsV <- rbind(mdsV, ans)
  #--End of temporary comment
  
  ref_points <- mdsV[rownames(mds16S),] # Guide points
  
  if (dim(ref_points)[1] != dim(mds16S)[1]) {
    cat("WARNING: the length of V reference array does not match to 16S")
  }
  
  empir_points <- mdsV[!(rownames(mdsV) %in% rownames(mds16S)),] # Empirical points
  
  if (length(empir_points) == 2) { # But what is no empirical points left??
    empir_points <- matrix(empir_points, nrow=1, ncol=2, byrow=T)
    rownames(empir_points)=setdiff(rownames(mdsV),rownames(mds16S))
  }
  #print(empir_points)
  #print(dim(empir_points))
  #Finally, let us normalize the data:
  ans <- process_amplicon_data( mds16s, ref_points, empir_points)
  ans
  
}


#Reads data from file contained a distance matrix:
read_data <- function(filename) {
  rawdata <- read.table(filename,skip=3)
  dm <- matrix(nrow=dim(rawdata)[1],ncol=dim(rawdata)[2]-2)
  dm <- rawdata[,3:length(rawdata)]
  rownames(dm) <- rawdata$V2
  colnames(dm) <- rawdata$V2
  #This is not efficient. Use lapply instead.
  for(i in 1:length(dm)) {
    for(j in 1:length(dm)) {
      if(i == j) {
        dm[i,j] <- 0
      } else {
        dm[i,j] <- 100-dm[i,j]
      }
    }
  }
  dm
}

add_borders <- function(MDS) {
  MDS <- rbind( MDS, c(min(MDS[,1])-0.1,min(MDS[,2]))-0.1 )
  MDS <- rbind( MDS, c(max(MDS[,1])+0.1,min(MDS[,2]))-0.1 )
  MDS <- rbind( MDS, c(max(MDS[,1])+0.1,max(MDS[,2]))+0.1 )
  MDS <- rbind( MDS, c(min(MDS[,1])-0.1,max(MDS[,2]))+0.1 )
  
  MDS
}

plot_mds <- function(mds,caption,col) {
  ## note asp = 1, to ensure Euclidean distances are represented correctly
  plot(mds[, 1], mds[, 2], asp = 1, axes = T,main = caption, col=col,cex=0.5)
  text(mds[, 1], mds[, 2], rownames(mds), cex = 0.6,pos=3)
}

#This function generates a perfect test test by getting points that a close to the reference.
#Input: coordinates of reference points and number of test points. Output: a set of points
generate_test_set <- function(dat,num,limits) {
  #dat - reference points
  #num - #of empirical points arount each reference point, i.e. a 'cloud' of points
  test_set <- matrix(0, nrow=dim(dat)[1]*num, ncol=2)
  next_index <- 1
  for(i in 1:dim(dat)[1]) {
    for(j in seq(next_index,next_index+num-1)) {
      test_set[j,1] <- runif(1,dat[i,1]-limits[1],dat[i,1]+limits[1])
      test_set[j,2] <- runif(1,dat[i,2]-limits[2],dat[i,2]+limits[2])
    }
    next_index <- next_index + num 
  }
  test_set
}

remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

write_clust_data <- function(filename) {
  
  header <- paste("File(s):", paste(basename(work_libs[1:dim(work_libs)[1],2]), collapse=' '))
  write(header, file=filename,append=F)
  header <- paste("Total Clusters:", length(OTUS))
  write(header, file=filename,append=T)
  write('', file=filename,append=T)
  
  for (i in 1:length(OTUS)) {
    str <- paste("OTU_",i,sep='') 
    otus <- paste(str_replace_all(OTUS[[i]],'\t','.'), collapse=',')
    write(paste(str,otus),file=filename,append=T,sep = '')
  }
}

make_otu_table <- function(clstr_infilename, clstr_outfilename, otu_table_filename, num_markers) {
  #python stat.py clusters.clstr final_clusters.clstr final_otu_table.txt
  for (i in 1:num_markers) {
    maptable <- paste(tmp_dir, "/", "map_", i, ".uc", sep='')
    otutable <- paste(tmp_dir, "/", "otu_table_", i, ".txt", sep='')
    system(paste("python python_scripts/uc2otutab.py", maptable, ">", otutable))
  }
  # Making final otu table:
  system(paste("python python_scripts/stat.py", clstr_infilename, clstr_outfilename, otu_table_filename, num_markers))
}

writeMessage <- function(message, logfile, isAppend) {
  message <- paste(Sys.time(), message)
  print(message)
  write(x=message, file=logfile, append=isAppend)
}

write_coordinates <- function(filename) {
  colnames(summary_matrix) <- c('x', 'y')
  write.table(summary_matrix, file=filename, quote = F)
  for (i in 1:length(merged_table)) {
    for (j in 1:dim(merged_table[[i]])[1]) {
      coords <- c(summary_matrix[merged_table[[i]][j,1],] + runif(1, min = 0, max = 0.001))
      string_to_write <- paste(toString(merged_table[[i]][j,2]), coords[1], coords[2])
      #print(string_to_write) - printing to the screen is disabled
      write(x=string_to_write,file=filename,append=T)
    }
  }
  
}
