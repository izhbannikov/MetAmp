#A function that implements the affine transformation:
affine_transform <- function(P, Q) {
  A = tryCatch({
    A <- Q %*% t(P) %*% solve(P %*% t(P))#,tol=.Machine$double.eps/10e150)
 	}, warning = function(w) {
    	#warning-handler-code
	}, error = function(e) {
		#print("Q")
		#print(Q)
		#print("P")
		#print(P)
    	A <- matrix(c(1,1,1,1,1,1,0,0,1),byrow=T,nrow=3,ncol=3)
	}, finally = {
    	#cleanup-code
	}) # END tryCatch

}

# Function that carries empirical points back to the reference space. I.e. we apply the affine transformation
# found to each empirical point.
apply_affine <- function(data,ATS,tindx) {
  for(i in 1:dim(data)[1]) {
    #Here I am extracting the triangles from V4 reference plane:
    point.x <- data[i,1]
    point.y <- data[i,2]
    P <- rbind(c(point.x[1]),c(point.y[1]),c(1))
    A <- matrix(ATS[tindx[i,1],],nrow=3,ncol=3,byrow=T) # Matrix that contains an affine transformation
    PP <- A %*% P
    data[i,] <- PP[1:2,1]
  }
  data
}

# This function does the core work for the meta-amplicon algorithm
process_amplicon_data <- function(mds16S, mdsV, q) {
  #======Make triangulation (Use reference 16S plane for this):=======#
  ans <- triangulation(mds16S=mds16S,mdsV=mdsV)
  ATS <- ans[[1]] #A matrix that contains affine matrices for each triangle
  centroids <- ans[[2]] #This is a matrix that contain centroids and vertices of triangles
  mdsV_new <- ans[[3]][[1]] #V-reference plane after transform it back to reference 16S plane
  
  #======Determine which empirical point belongs to which triangle:======#
  ans <- nn2(centroids[,1:2],q,k=3)
  indices <- ans[1]$nn.idx
  
  #=======Now for each empirical point we have to apply the affine transform:======#
  q_new <- apply_affine(q,ATS,indices)
  
  list(mdsV_new,q_new) # Return back the normalized empirical points
}
