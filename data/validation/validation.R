# This script test the precision of the meta-amplicon analysys algorithm
# 10/500 - first number is reference and the second is 'empirical sequences'
# Extract 10 reference sequences from gold.fa:
library(ShortRead)
reads = readFasta("~/Projects/Extracter/gold.fa")
fwd = reads[1:10]
rev = reads[(10362/2+1):(10362/2+1+9)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold10.fa")
# Empirical reads (100 reads):
fwd = reads[11:110]
writeFasta(fwd, "~/Projects/metamp_data/emp10_100.fa")
# Now we generate file containing all 16S - reference and empirical:
fwd = reads[1:110]
rev = reads[(10362/2+1):(10362/2+1+109)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold110.fa")
# Extracting variable regions:
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold10.fa -o ~/Projects/metamp_data/gold10_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold10.fa -o ~/Projects/metamp_data/gold10_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold10.fa -o ~/Projects/metamp_data/gold10_V69 -pos -spos 888 -epos 1400 -nr 30000")
#Emp
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp10_100.fa -o ~/Projects/metamp_data/emp10_100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp10_100.fa -o ~/Projects/metamp_data/emp10_100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp10_100.fa -o ~/Projects/metamp_data/emp10_100_V69 -pos -spos 888 -epos 1400 -nr 30000")





# 100/100
reads = readFasta("~/Projects/Extracter/gold.fa")
fwd = reads[1:100]
rev = reads[(10362/2+1):(10362/2+1+99)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold100.fa")
# Empirical reads (100 reads):
fwd = reads[101:200]
writeFasta(fwd, "~/Projects/metamp_data/emp100_100.fa")
# Now we generate file containing all 16S - reference and empirical:
fwd = reads[1:200]
rev = reads[(10362/2+1):(10362/2+1+199)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold200.fa")
# Extracting variable regions:
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold100.fa -o ~/Projects/metamp_data/gold100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold100.fa -o ~/Projects/metamp_data/gold100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold100.fa -o ~/Projects/metamp_data/gold100_V69 -pos -spos 888 -epos 1400 -nr 30000")
#Emp
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp100_100.fa -o ~/Projects/metamp_data/emp100_100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp100_100.fa -o ~/Projects/metamp_data/emp100_100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp100_100.fa -o ~/Projects/metamp_data/emp100_100_V69 -pos -spos 888 -epos 1400 -nr 30000")



# 200/100
reads = readFasta("~/Projects/Extracter/gold.fa")
fwd = reads[1:200]
rev = reads[(10362/2+1):(10362/2+1+199)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold200.fa")
# Empirical reads (100 reads):
fwd = reads[201:300]
writeFasta(fwd, "~/Projects/metamp_data/emp200_100.fa")
# Now we generate file containing all 16S - reference and empirical:
fwd = reads[1:300]
rev = reads[(10362/2+1):(10362/2+1+299)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold300.fa")
# Extracting variable regions:
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold200.fa -o ~/Projects/metamp_data/gold200_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold200.fa -o ~/Projects/metamp_data/gold200_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold200.fa -o ~/Projects/metamp_data/gold200_V69 -pos -spos 888 -epos 1400 -nr 30000")
#Emp
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp200_100.fa -o ~/Projects/metamp_data/emp200_100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp200_100.fa -o ~/Projects/metamp_data/emp200_100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp200_100.fa -o ~/Projects/metamp_data/emp200_100_V69 -pos -spos 888 -epos 1400 -nr 30000")


#500/100
reads = readFasta("~/Projects/Extracter/gold.fa")
fwd = reads[1:500]
rev = reads[(10362/2+1):(10362/2+1+499)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold500.fa")
# Empirical reads (100 reads):
fwd = reads[501:600]
writeFasta(fwd, "~/Projects/metamp_data/emp500_100.fa")
# Now we generate file containing all 16S - reference and empirical:
fwd = reads[1:600]
rev = reads[(10362/2+1):(10362/2+1+599)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold600.fa")
# Extracting variable regions:
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold500.fa -o ~/Projects/metamp_data/gold500_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold500.fa -o ~/Projects/metamp_data/gold500_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold500.fa -o ~/Projects/metamp_data/gold500_V69 -pos -spos 888 -epos 1400 -nr 30000")
#Emp
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp500_100.fa -o ~/Projects/metamp_data/emp500_100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp500_100.fa -o ~/Projects/metamp_data/emp500_100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp500_100.fa -o ~/Projects/metamp_data/emp500_100_V69 -pos -spos 888 -epos 1400 -nr 30000")

#1000/100
reads = readFasta("~/Projects/Extracter/gold.fa")
fwd = reads[1:1000]
rev = reads[(10362/2+1):(10362/2+1+999)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold1000.fa")
# Empirical reads (100 reads):
fwd = reads[1001:1100]
writeFasta(fwd, "~/Projects/metamp_data/emp1000_100.fa")
# Now we generate file containing all 16S - reference and empirical:
fwd = reads[1:1100]
rev = reads[(10362/2+1):(10362/2+1+1099)]
writeFasta(fwd, "~/Projects/metamp_data/fwd.fa")
writeFasta(rev, "~/Projects/metamp_data/rev.fa")
system("cat ~/Projects/metamp_data/fwd.fa ~/Projects/metamp_data/rev.fa > ~/Projects/metamp_data/gold1100.fa")
# Extracting variable regions:
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold1000.fa -o ~/Projects/metamp_data/gold1000_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold1000.fa -o ~/Projects/metamp_data/gold1000_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/gold1000.fa -o ~/Projects/metamp_data/gold1000_V69 -pos -spos 888 -epos 1400 -nr 30000")
#Emp
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp1000_100.fa -o ~/Projects/metamp_data/emp1000_100_V13 -pos -spos 33 -epos 496 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp1000_100.fa -o ~/Projects/metamp_data/emp1000_100_V35 -pos -spos 347 -epos 887 -nr 30000")
system("python ~/Projects/Extracter/extract.py -i ~/Projects/metamp_data/emp1000_100.fa -o ~/Projects/metamp_data/emp1000_100_V69 -pos -spos 888 -epos 1400 -nr 30000")



