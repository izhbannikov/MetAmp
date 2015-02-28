#Step 3. Make triangulation (Use reference 16S plane for this):
triangulation <- function(mds16S, mdsV) {
  #mds16S = mds16s
  #mdsV = ref_points
  
  tri_mesh <- tri.mesh( mdsV[, 1], mdsV[, 2] )
  #plot(tri_mesh)
  #text(mdsV[, 1], mdsV[, 2], rownames(mdsV), cex = 0.6,pos=3)
  #Here we extract the triangles but from the marker regions!!
  tr <- triangles(tri_mesh)
  tr_indices <- tr[,1:3]
  tr_coords <- matrix(0, nrow = dim(tr)[1], ncol = 6) # V
  tr_coords2 <- matrix(0, nrow = dim(tr)[1], ncol = 6) # 16S
  
  tr_coords[,1:3]<-tri_mesh$x[tr[,1:3]]
  tr_coords[,4:6]<-tri_mesh$y[tr[,1:3]]
  tr_coords2[,1:3]<-mds16S[tr[,1:3],1]
  tr_coords2[,4:6]<-mds16S[tr[,1:3],2]
  
  #Try to test the affine transformation for each triangle:
  diff <- matrix(0,nrow=dim(tr)[1], ncol=3)
  
  #Calculate centroids of triangles in order to transmit them later into k-d tree:
  centroids <- matrix(0,nrow=dim(tr)[1],ncol = 8) # V
  centroids2 <- matrix(0,nrow=dim(tr)[1],ncol = 8) # 16S
  #?????? V
  centroids[,1] <- rowSums(tr_coords[,1:3])/3
  centroids[,2] <- rowSums(tr_coords[,4:6])/3
  centroids[,3:8] <- tr_coords[,1:6]
  
  #?????? 16S
  centroids2[,1] <- rowSums(tr_coords2[,1:3])/3
  centroids2[,2] <- rowSums(tr_coords2[,4:6])/3
  centroids2[,3:8] <- tr_coords2[,1:6]
  
  #-----------???????????????? ????????????????????????????------------#
  for (i in 1:3) {
    mdsV <- rbind(mdsV,centroids[,1:2])
    mds16S <- rbind(mds16S,centroids2[,1:2])
    ##?????????? ???????????????? ???????????????? ???? ?????????? ???????????? ????????????????????????:
    ans <- add_triangles(centroids, centroids2,mdsV,tr_indices)
    tr_coords <- ans[[1]]
    tr_coords2 <- ans[[2]]
    #tr_indices_new <- ans[[3]]
    tr_indices <- ans[[3]]
    ##list(tr_coords,tr_coords2,tr_indices_new)
  
    #Calculate centroids of triangles in order to transmit them later into k-d tree:
    centroids <- matrix(0,nrow=dim(tr_coords)[1],ncol = 8)
    centroids2 <- matrix(0,nrow=dim(tr_coords2)[1],ncol = 8)
    #?????? V
    centroids[,1] <- rowSums(tr_coords[,1:3])/3
    centroids[,2] <- rowSums(tr_coords[,4:6])/3
    centroids[,3:8] <- tr_coords[,1:6]
    #?????? 16S
    centroids2[,1] <- rowSums(tr_coords2[,1:3])/3
    centroids2[,2] <- rowSums(tr_coords2[,4:6])/3
    centroids2[,3:8] <- tr_coords2[,1:6]
  }
  mdsV <- rbind(mdsV,centroids[,1:2])
  mds16S <- rbind(mds16S,centroids2[,1:2])
  #
  centroids <- matrix(0,nrow=dim(tr_coords)[1],ncol = 8)
  centroids2 <- matrix(0,nrow=dim(tr_coords2)[1],ncol = 8)
  #V
  centroids[,1] <- rowSums(tr_coords[,1:3])/3
  centroids[,2] <- rowSums(tr_coords[,4:6])/3
  centroids[,3:8] <- tr_coords[,1:6]
  ##16S
  centroids2[,1] <- rowSums(tr_coords2[,1:3])/3
  centroids2[,2] <- rowSums(tr_coords2[,4:6])/3
  centroids2[,3:8] <- tr_coords2[,1:6]
  #------------------------------------
  #Matrix for affine transformation for each triangle:
  transformations <- matrix(0, nrow=dim(tr_coords)[1],ncol = 9)
  mdsV_new <- matrix(0,nrow=dim(mdsV)[1], ncol=dim(mdsV)[2])
  for(i in 1:dim(tr_coords)[1]) {
    
    point.x <- tr_coords2[i,1:3]
    point.y <- tr_coords2[i,4:6]
  
    Q <- rbind(c(point.x[1],point.x[2],point.x[3]),#point.x[1]),
               c(point.y[1],point.y[2],point.y[3]),#point.y[1]),
               c(0,0,1)) #c(1,1,1))#,1))
  
    #Here I am extracting the triangles:
    point.x <- tr_coords[i,1:3]
    point.y <- tr_coords[i,4:6]
    P <- rbind(c(point.x[1],point.x[2],point.x[3]),#point.x[1]),
             c(point.y[1],point.y[2],point.y[3]),#point.y[1]),
             c(0,0,1)) #c(1,1,1))#,1))
    
    #Affine tr-m:
    A <- affine_transform(P,Q)
  
    transformations[i,1] <- A[1,1]
    transformations[i,2] <- A[1,2]
    transformations[i,3] <- A[1,3]
  
    transformations[i,4] <- A[2,1]
    transformations[i,5] <- A[2,2]
    transformations[i,6] <- A[2,3]
  
    transformations[i,7] <- A[3,1]
    transformations[i,8] <- A[3,2]
    transformations[i,9] <- A[3,3]
  
    #Bring P to Q:
    PP <- A %*% P
  
    mdsV_new[tr_indices[i,1:3],1] <- PP[1,1:3]
    mdsV_new[tr_indices[i,1:3],2] <- PP[2,1:3]
    #print(i)
  }
  
  #print(mean(diff))
  #print(centroids)
  list(transformations, centroids, list(mdsV_new), mean(diff), centroids2)
}

sign <- function(p1, p2, p3) {
  ans <- (p1[1] - p3[1]) * (p2[2] - p3[2]) - (p2[1] - p3[1]) * (p1[2] - p3[2])
  ans
}


#This function determines if the given point lies within a triangle tcoords:
PointInTriangle <- function(pt, v1, v2, v3)
{
  b1 <- ifelse(sign(pt, v1, v2) > 0,T,F)
  b2 <- ifelse(sign(pt, v2, v3) > 0,T,F)
  b3 <- ifelse(sign(pt, v3, v1) > 0,T,F)
  ans <- ifelse( (b1 == b2) & (b2 == b3) , T, F)
  ans
}

#Determines the triangle the given point belongs to:
find_triangle <- function(point,triangles, indices,k) {
  index <- -1
  for(i in 1:k) {
    ans <- PointInTriangle(point,triangles[indices[i],3:4],triangles[indices[i],5:6],triangles[indices[i],7:8])
    if(ans == T) {
      index <- indices[i]
      break
    }
  }
  index
}

break_triangle <- function(t) {
  #t[1] - centroid.x, t[2] - centroid.y
  #t[3:4] - first vertices, x & y
  #t[5:6] - second vertices, x & y
  #t[7:8] - third vertices, x & y
  
  t1 <- c(t[1], t[3],t[4],t[2],t[6],t[7])
  t2 <- c(t[1], t[3],t[5],t[2],t[6],t[8])
  t3 <- c(t[1], t[4],t[5],t[2],t[7],t[8])
  
  list(t1, t2, t3)
}

add_triangles <- function(centroids, centroids2,mdsV,tr_indices) {
  tr_coords <- matrix(0, nrow=3*dim(centroids)[1], ncol=6)
  tr_indices_new <- matrix(0, nrow=3*dim(centroids)[1], ncol=3)
  j <- 0
  for(i in 1:dim(centroids)[1]) {
    ans <- break_triangle(centroids[i,])
    tr_coords[i+j,] <- ans[[1]]
    tr_coords[i+j+1,] <- ans[[2]]
    tr_coords[i+j+2,] <- ans[[3]]
    tr_indices_new[i+j,] <-  c(dim(mdsV)[1]-dim(centroids)[1]+i,tr_indices[i,1],tr_indices[i,2])
    tr_indices_new[i+j+1,] <-  c(dim(mdsV)[1]-dim(centroids)[1]+i,tr_indices[i,1],tr_indices[i,3])
    tr_indices_new[i+j+2,] <-  c(dim(mdsV)[1]-dim(centroids)[1]+i,tr_indices[i,2],tr_indices[i,3])
    j <- j + 2
  }
  
  tr_coords2 <- matrix(0, nrow=3*dim(centroids2)[1], ncol=6)
  j<-0
  for(i in 1:dim(centroids2)[1]) {
    ans <- break_triangle(centroids2[i,])
    tr_coords2[i+j,] <- ans[[1]]
    tr_coords2[i+j+1,] <- ans[[2]]
    tr_coords2[i+j+2,] <- ans[[3]]
    j<-j+2
  }
  list(tr_coords,tr_coords2,tr_indices_new)
}

