#This script extracts variable regions from 16S rRNA. 

##Example run:

`python extract.py 16S.fasta test --fp CCTACGGGAGGCAGCAG --rp CCGTCAATTCMTTTRAGN`

Here: 
16S.fasta - an input file that contains 16S sequences, must be provided in FASTA format;
test - an output prefix for file that contains extracted variable regions, will be in FASTA format (i.e. test.fasta);
CCTACGGGAGGCAGCAG - forward primer
CCGTCAATTCMTTTRAGN - reverse primer


## Some primer sequences that can be used

### V1-3 primers:

```
forward_primer = "NGAGTTTGATCCTGGCTCAG" # -m=2 -p=-5 g=-8
reverse_primer = "ATTACCGCGGCTGCTGG"
```
### V3-5 primers:

```
forward_primer = "CCTACGGGAGGCAGCAG" # -m=2 -p=-5 g=-8
reverse_primer = "CCGTCAATTCMTTTRAGN"
```

### V6-9 primers:

```
forward_primer = "GAATTGACGGGGRCCC" # -m=2 -p=-5 -g=-1
reverse_primer = "TACGGYTACCTTGTTAYGACTT"
```

##How to use Shiny version of Extracter:

* Open ui.R with for example, RStudio and then click on "Run App" button.
* Provide your 16S records, set up parameters if necessary and then click on "Start computation" button.

Table on the right will show the final statistics. 

##General suggestions:

- Change the alignment parameters (match award, mismatch penalty, open gap penalty) if average length is too small (less then 50 bp or even zero).

Last change was made on 2014/09/05
Author: Ilya Y. Zhbannikov
