# This R-script plots the points on the reference plane
# Plot reference points:
plot(mds16S, cex=0.1, col = "red")
# Now plot empirical points:
points(summary_matrix[35:161,],cex=0.1,col="blue")
points(summary_matrix[162:298,],cex=0.1,col="yellow")
points(summary_matrix[299:419,],cex=0.1,col="green")
# An a legend:
legend("topright", legend=c("Reference", "V13", "V35", "V69"), col=c("red","blue","yellow","green"),cex=0.7, lty=c(1,4), pch=1)
