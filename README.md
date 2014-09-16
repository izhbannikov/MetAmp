This is a workflow for analysis of meta-amplicon data. Project website: [Meta-Amplicon Analysis Project](http://izhbannikov.github.io/MetAmp/)

By Ilya Y. Zhbannikov, zhba3458@vandals.uidaho.edu, i.zhbannikov@mail.ru

## Program description

MetAmp tool is developed for analysis of amplicon data by combining several marker regions from 16S rRNA genes.
Such marker regions serve as unique identificators for species. There are nine marker regions in bacterial 
16S rRNA gene.

## How to install

Download or clone from the GitHub, save it in some folder you wish. Then simply run ```make```. 
This will check for required packages and install in case if some packages were not found.

## Provided data description

We provided data that can be used in your projects. This data located in ```data``` folder.
We also provided data for evaluation of MetAmp (located in ```Evaluation/data/``` folder). 
Notice that the amount of data is large (unzipped files take several hundred MBytes). 

Detailed description of provided data is given below:

* LTP folder contains data (full-length 16S sequences and three marker regions) for
data extracted from All Species Living Tree Project.

```
+-data-+
	   +-LTP-+
			 +-LTP-10271.fasta - reference sequences for the whole 16S gene
	  		 +-LTP-10271_V13.fasta - reference sequences for marker 1-3
	  		 +-LTP-10271_V35.fasta - sequences for marker 3-5
	  		 +-LTP-10271_V69.fasta - sequences for marker 6-9
```

* RDP folder contains the same kind of data but extracted from [Ribosomal Database Project](http://rdp.cme.msu.edu/)
Only 100 species. Can be used for quick small projects.

```
+-data-+
	   +-RDP-+
	   		 +-refSetV69-100.fasta - reference sequences for marker 1-3
	   		 +-refSetV13-100.fasta - reference sequences for marker 3-5
	  		 +-refSetV35-100.fasta - reference sequences for marker 6-9
	  		 +-refSet16S-100.fasta - whole 16S reference sequences
```
* Evaluation data set (```Evaluation/data```) contains a smal set of reference sequences (30 sequences) and amplicon sequences.
Amplicon sequences contain sequence data from Human Mock Community. More information  provided here: (http://www.hmpdacc.org/HMMC/)

```
+-Evaluation-+
			 +-data-+
			 		+-Dataset1
			 		+-Dataset2
	 	     		+-Dataset1.zip - zipped sequence data for even community (ids)
		     		+-Dataset2.zip - zipped sequence data for staggered community (ids )
		     		+-HMC_ref_16S.fasta - contains 30 reference 16S sequences
		     		+-HMC_ref_V13.fasta - contains 30 reference marker sequences (1-3 regions)
		     		+-HMC_ref_V35.fasta - contains 30 reference marker sequences (3-5 regions)
		     		+-HMC_ref_V69.fasta - contains 30 reference marker sequences (6-9 regions)
```

The ```Dataset1``` and ```Dataset2``` are the Human mock communuty (HMP) pyrosequence data (SRX021555: (http://www.ncbi.nlm.nih.gov/sra?term=SRR053818)), and can be cleaned with [SeqyClean](https://bitbucket.org/izhbannikov/seqyclean).
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
libs <- c("~/Projects/metamp/Evaluation/data/Dataset1/SRR053817_V1_V3/SRR053817_3.fastq",  # V1-3
          "~/Projects/metamp/Evaluation/data/Dataset1/SRR053818_V3_V5/SRR053818_3.fasta",  # V3-5
          "~/Projects/metamp/Evaluation/data/Dataset1/SRR053819_V6_V9/SRR053819_3.fastq")  # V6-9
~~~

and reference sequences:

~~~R
ref16S <- "~/Projects/metamp/Evaluation/data/HMC_ref_16S.fasta" # Reference 16S gene sequences
refs <- c("~/Projects/metamp/Evaluation/data/HMC_ref_V13.fasta", # Reference gude (marker) regions
          "~/Projects/metamp/Evaluation/data/HMC_ref_V35.fasta",        
          "~/Projects/metamp/Evaluation/data/HMC_ref_V69.fasta")
~~~

### 2. Set the program directory in ```main.R```, for example:

~~~R
dir_path <- "~/Projects/metamp/"
~~~


### 3. Run the script ```main.R```:

~~~R
source("main.R")
~~~