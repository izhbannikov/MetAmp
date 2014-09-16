This is a workflow for analysis of meta-amplicon data.

By Ilya Y. Zhbannikov, zhba3458@vandals.uidaho.edu, i.zhbannikov@mail.ru

## Program description

MetAmp tool is developed for analysis of amplicon data by combining several marker regions from 16S rRNA genes.
Such marker regions serve as unique identificators for species. There are nine marker regions in bacterial 
16S rRNA gene.

## How to install

Download or clone from the Bitbucket, save it in some folder you wish. Then simply run make. 
This will check for required packages and install in case if some packages were not found.

## Provided data description

We provided data that can be used in your projects. We used data hosting provided by copy.com.
Notice that the amount of data is very large (even unzipped files can take several Gb). For evaluation 
purposes we provided small data set. Description of our data is
given below:

* LTP folder contains data (full-length 16S sequences and three marker regions) for
data extracted from All Species Living Tree Project. The size of this folder is about 300 Mb.

```
+-LTP-+
	  +-LTP-10271.fasta - reference sequences for the whole 16S gene
	  +-LTP-10271_V13.fasta - reference sequences for marker 1-3
	  +-LTP-10271_V35.fasta - sequences for marker 3-5
	  +LTP-10271_V69.fasta - sequences for marker 6-9
```
Link to this folder: https://copy.com/ULDKijpPra6n3hvA

* RDP folder contains the same type of data but extracted from Ribosomal Database Project: http://rdp.cme.msu.edu/ 

```
+-RDP-+
	  +-1000.zip - zipped distance matrices (whole 16S and 1-3, 3-5, 6-9 markers) for 1,000 reference sequences.

Inside:	+-RFP_ref13-1000.fasta - reference sequences for marker 1-3
		+-RDP_ref35-1000.fasta - reference sequences for marker 3-5
		+-RDP_ref69-1000.fasta - reference sequences for marker 6-9
		+-RDP_ref16S-1000.fasta - whole 16S reference sequences
```

RDP folder is much smaller than LTP and takes about 300 Mb unzipped.
Link to this folder: https://copy.com/1rHaBXQSXM7SUtk2

* Evaluation data set contains a smal set of reference sequences (30 sequences) and amplicon sequences.
Amplicon sequences contain sequence data from Human Mock Community. More information  provided here: http://www.hmpdacc.org/HMMC/

```
+-Evaluation-+
	 	     +--Dataset1.zip - zipped sequence data for even community (ids)
		     +--Dataset2.zip - zipped sequence data for staggered community (ids )
		     +--HMC_ref_16S.fasta - contains 30 reference 16S sequences
		     +--HMC_ref_V13.fasta - contains 30 reference marker sequences (1-3 regions)
		     +--HMC_ref_V35.fasta - contains 30 reference marker sequences (3-5 regions)
		     +--HMC_ref_V69.fasta - contains 30 reference marker sequences (6-9 regions)
```

Link to this folder: https://copy.com/KZvTQvh01vgh8dAp

The Dataset1.zip and Dataset2.zip are the Human mock communuty (HMP) pyrosequence data (SRX021555: http://www.ncbi.nlm.nih.gov/sra?term=SRR053818), cleaned with SeqyClean.
Detailed description of these datasets (and sequencing protocols) is under the following link: http://www.hmpdacc.org/HMMC/

To run the program on test data open evaluation.R and set the working directory (this directory should contain test_data directory) and run the script test.R from R-environment:
~~~R
>source("evaluation.R")
~~~



## How to run the program on your data

Before analysis, you may need to perform data denoising and (if you use Illumina sequence data), merge overlapping reads.

Later I will provide the scripts that do it.

### 1. Edit script config.R, specifically:

Provide your sequences, for example:

~~~R
libs <- c("~/Projects/metamp/test_data/Dataset1/SRR053817_V1_V3/SRR053817_3_cleaned.fasta",  # V1-3
          "~/Projects/metamp/test_data/Dataset1/SRR053818_V3_V5/SRR053818_3_cleaned.fasta",  # V3-5
          "~/Projects/metamp/test_data/Dataset1/SRR053819_V6_V9/SRR053819_3_cleaned.fasta")  # V6-9
~~~

and reference sequences:

~~~R
ref16S <- "~/Projects/metamp/test_data/1000/refSet16S-1000.fasta" # Reference 16S gene sequences
refs <- c("~/Projects/metamp/test_data/1000/refSetV13-1000.fasta", # Reference gude (marker) regions
          "~/Projects/metamp/test_data/1000/refSetV35-1000.fasta",        
          "~/Projects/metamp/test_data/1000/refSetV69-1000.fasta")
~~~

### 2. Set the program directory in "main.R", for example:

~~~R
dir_path <- "~/Projects/metamp/"
~~~


### 3. Run the script "main.R":

~~~R
source("main.R")
~~~