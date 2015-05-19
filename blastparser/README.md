library("BLASTParser")
BuildIdentityMatrix(system.file("extdata", "test.txt", package="BLASTParser"))



library("BLASTParser")
ans <- BuildIdentityMatrixUSEARCH(system.file("extdata", "refSet16S_10.fasta", package="BLASTParser"), system.file("extdata", "test-10.aln", package="BLASTParser"))


library("BLASTParser")
ans <- BuildIdentityMatrixUSEARCH("refSet16S_1000.fasta", "test-1000.aln")


library("BLASTParser")
ans <- BuildIdentityMatrixUSEARCH2("refSet16S-10.fasta", "empV13-100-10.fasta", "res.usearch","res.blastn", "resV13.usearch")