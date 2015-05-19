### R code from vignette source 'Overview.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=60)


###################################################
### code chunk number 2: preliminaries
###################################################
library("ShortRead")


###################################################
### code chunk number 3: SolexaPath-root
###################################################
exptPath <- system.file("extdata", package="ShortRead")


###################################################
### code chunk number 4: SolexaPat
###################################################
sp <- SolexaPath(exptPath)
sp


###################################################
### code chunk number 5: firecrest
###################################################
imageAnalysisPath(sp)
analysisPath(sp)


###################################################
### code chunk number 6: readAligned-simple
###################################################
aln <- readAligned(sp, "s_2_export.txt")
aln


###################################################
### code chunk number 7: filter-egs
###################################################
nfilt <- nFilter()
cfilt <- chromosomeFilter('chr5.fa')
sfilt <- strandFilter("+")
ofilt <- occurrenceFilter(withSread=FALSE)


###################################################
### code chunk number 8: readAligned-filter
###################################################
chr5 <- readAligned(sp, "s_2_export.txt", filter=cfilt)


###################################################
### code chunk number 9: readAligned-compose-filter
###################################################
filt <- compose(cfilt, sfilt)
chr5plus <- readAligned(sp, "s_2_export.txt", filter=filt)


###################################################
### code chunk number 10: AlignedRead-filter
###################################################
chr5 <- aln[cfilt(aln)]


###################################################
### code chunk number 11: aln-sread-quality
###################################################
sread(aln)
quality(aln)


###################################################
### code chunk number 12: chromosomes
###################################################
whichStrand <- strand(aln)
class(whichStrand)
levels(whichStrand)
table(whichStrand, useNA="ifany")


###################################################
### code chunk number 13: alignData
###################################################
alignData(aln)


###################################################
### code chunk number 14: varMetadata
###################################################
varMetadata(alignData(aln))


###################################################
### code chunk number 15: aln-okreads
###################################################
mapped <- !is.na(position(aln))
filtered <- alignData(aln)[["filtering"]] =="Y"
sum(!mapped) / length(aln)
sum(filtered) / length(aln)


###################################################
### code chunk number 16: aln-failed
###################################################
failedAlign <- aln[filtered & !mapped]
failedAlign


###################################################
### code chunk number 17: sread-filter-fail-subset
###################################################
failedReads <- sread(aln)[filtered & !mapped]


###################################################
### code chunk number 18: qa
###################################################
qaSummary <- qa(sp)


###################################################
### code chunk number 19: Overview.Rnw:363-364 (eval = FALSE)
###################################################
## save(qaSummary, file="/path/to/file.rda")


###################################################
### code chunk number 20: Overview.Rnw:370-374 (eval = FALSE)
###################################################
## library("Rmpi")
## mpi.spawn.Rslaves(nsl=8)
## qaSummary <- qa(sp)
## mpi.close.Rslaves()


###################################################
### code chunk number 21: Overview.Rnw:378-380 (eval = FALSE)
###################################################
## library(multicore)
## qaSummary <- qa(sp)


###################################################
### code chunk number 22: qa-elements
###################################################
qaSummary


###################################################
### code chunk number 23: qa-readCounts
###################################################
qaSummary[["readCounts"]]
qaSummary[["baseCalls"]]


###################################################
### code chunk number 24: report (eval = FALSE)
###################################################
## report(qaSummary, dest="/path/to/report_directory")


###################################################
### code chunk number 25: export
###################################################
pattern <- "s_2_export.txt"
fl <- file.path(analysisPath(sp), pattern)
strsplit(readLines(fl, n=1), "\t")
length(readLines(fl))


###################################################
### code chunk number 26: colClasses
###################################################
colClasses <- rep(list(NULL), 21)
colClasses[9:10] <- c("DNAString", "BString")
names(colClasses)[9:10] <- c("read", "quality")


###################################################
### code chunk number 27: readXStringColumns
###################################################
cols <- readXStringColumns(analysisPath(sp), pattern, colClasses)
cols


###################################################
### code chunk number 28: size
###################################################
object.size(cols$read)
object.size(as.character(cols$read))


###################################################
### code chunk number 29: fastq-format
###################################################
fqpattern <- "s_1_sequence.txt"
fl <- file.path(analysisPath(sp), fqpattern)
readLines(fl, 4)


###################################################
### code chunk number 30: readFastq
###################################################
fq <- readFastq(sp, fqpattern)
fq


###################################################
### code chunk number 31: ShortReadQ
###################################################
reads <- sread(fq)
qualities <- quality(fq)
class(qualities)
id(fq)


###################################################
### code chunk number 32: ShortReadQ-subset
###################################################
fq[1:5]


###################################################
### code chunk number 33: intensity-files
###################################################
int <- readIntensities(sp, withVariability=FALSE)
int


###################################################
### code chunk number 34: intensities-cycle-2
###################################################
print(splom(intensity(int)[[,,2]], pch=".", cex=3))


###################################################
### code chunk number 35: tables
###################################################
tbls <- tables(aln)
names(tbls)
tbls$top[1:5]
head(tbls$distribution)


###################################################
### code chunk number 36: srdistance
###################################################
dist <- srdistance(sread(aln), names(tbls$top)[1])[[1]]
table(dist)[1:10]


###################################################
### code chunk number 37: aln-not-near
###################################################
alnSubset <- aln[dist>4]


###################################################
### code chunk number 38: polya
###################################################
countA <- alphabetFrequency(sread(aln))[,"A"] 
alnNoPolyA <- aln[countA < 30]


###################################################
### code chunk number 39: readSeq
###################################################
seqFls <- list.files(baseCallPath(sp), "_seq.txt", full=TRUE)
strsplit(readLines(seqFls[[1]], 1), "\t")
colClasses <- c(rep(list(NULL), 4), "DNAString")
reads <- readXStringColumns(baseCallPath(sp), "s_1_0001_seq.txt",
                            colClasses=colClasses)


###################################################
### code chunk number 40: readSeq-all
###################################################
reads <- readXStringColumns(baseCallPath(sp), "s_1_.*_seq.txt",
                            colClasses=colClasses)


###################################################
### code chunk number 41: calcInt-demo
###################################################
calcInt <- function(file, cycle, verbose=FALSE)
{
    if (verbose)
        cat("calcInt", file, cycle, "\n")
    int <- readIntensities(dirname(file), basename(file),
                           intExtension="", withVariability=FALSE)
    apply(intensity(int)[,,12], 2, mean)
}


###################################################
### code chunk number 42: calcInt-sapply
###################################################
intFls <- list.files(imageAnalysisPath(sp), ".*_int.txt$", full=TRUE)
lres <- lapply(intFls, calcInt, cycle=12)


###################################################
### code chunk number 43: srapply-simple
###################################################
srres <- srapply(intFls, calcInt, cycle=12)
identical(lres, srres)


###################################################
### code chunk number 44: srapply-mpi (eval = FALSE)
###################################################
## library("Rmpi")
## mpi.spawn.Rslaves(nsl=16)
## srres <- srapply(intFls, calcInt, cycle=12)
## mpi.close.Rslaves()


###################################################
### code chunk number 45: srapply-multicore (eval = FALSE)
###################################################
## library(multicore)
## srres <- srapply(intFls, calcInt, cycle=12)


###################################################
### code chunk number 46: sessionInfo
###################################################
toLatex(sessionInfo())


