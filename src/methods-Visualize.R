library(MASS)
# This R-script plots the points on the reference plane
# Plot reference points:
plot(summary_matrix, cex=0.1, col = "black")
points(mds16S, cex=0.1, col="red")
# Now plot empirical points:
wlib1 <- read.fasta("~/Projects/metamp/analysis/SRR072221_forward.fastq_denoised_drep_pre_sorted_clustered_nochimeric")
wlib2 <- read.fasta("~/Projects/metamp/analysis/SRR072237_forward.fastq_denoised_drep_pre_sorted_clustered_nochimeric")
wlib3 <- read.fasta("~/Projects/metamp/analysis/SRR072236_forward.fastq_denoised_drep_pre_sorted_clustered_nochimeric")
points(summary_matrix[35:36,],cex=0.1,col="blue")
points(summary_matrix[37,],cex=0.5,col="black")
points(summary_matrix[38:dim(summary_matrix)[1],],cex=0.1,col="green")
# An a legend:
#legend("topright", legend=c("Reference", "V13", "V35", "V69"), col=c("red","blue","yellow","green"),cex=0.7, lty=c(1,4), pch=1)
#text(mds16S,rownames(mds16S),cex=0.5,offset = 1.5)
d1<-scoresV[[1]]
#cmd1=isoMDS(d1)
#cmd1=cmd1$points
cmd1=cmdscale(d1)
plot(cmd1,cex=0.1)
points(cmd1[1:30,],cex=0.5,col="red")
text(x=cmd1[9,1],y=cmd1[9,2],rownames(cmd1)[9],cex=0.5,offset = 1.5)
text(x=cmd1[31,1],y=cmd1[31,2],rownames(cmd1)[31],cex=0.5,offset = 1.5)
#text(x=cmd1[19,1],y=cmd1[19,2],rownames(cmd1)[19],cex=0.5,offset = 1.5)
#
#text(x=cmd1[15,1],y=cmd1[15,2],rownames(cmd1)[15],cex=0.5,offset = 1.5)
#text(x=cmd1[43,1],y=cmd1[43,2],rownames(cmd1)[43],cex=0.5,offset = 1.5)



d2 = scoresV[[2]]
cmd2=cmdscale(d2)
plot(cmd2,cex=0.1)
points(cmd2[1:30,],cex=0.5,col="red")
text(cmd2,rownames(cmd2),cex=0.5,offset = 1.5)


d3 = scoresV[[3]]
cmd3=cmdscale(d3)
plot(cmd3,cex=0.1)
points(cmd3[1:30,],cex=0.1,col="red")
text(cmd3,rownames(cmd3),cex=0.5,offset = 1.5)
