This is a workflow for analysis of meta-amplicon data. Project website: [Meta-Amplicon Analysis Project](http://izhbannikov.github.io/MetAmp/)

By Ilya Y. Zhbannikov, zhba3458@vandals.uidaho.edu, i.zhbannikov@mail.ru

# Program description

MetAmp tool is developed for analysis of amplicon data by combining several marker regions from 16S rRNA genes.
Such marker regions serve as unique identificators for species. There are nine marker regions in bacterial 
16S rRNA gene.

# How to install

Download or clone from the GitHub, save it in some folder you wish. Then simply run ```make```. 
This will check for required packages and install in case if some packages were not found.

# Provided data description

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
	   +-RDP-+
```

* RDP folder contains the same kind of data but extracted from [Ribosomal Database Project](http://rdp.cme.msu.edu/)
Only 100 species. Can be used for quick small projects.

```
+-data-+
	   +-LTP-+
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
			 		+-even-+
			 		+-staggered+
			 				   +-SRR072221_forward.fastq - staggered V1-3 Human Mock Community (HMC) sequences in forward (5'->3') direction
			 				   +-SRR072236_forward.fastq - staggered V3-5 Human Mock Community (HMC) sequences in forward (5'->3') direction
			 				   +-SRR072237_forward.fastq - staggered V6-9 Human Mock Community (HMC) sequences in forward (5'->3') direction
			 		+-16S.fasta - contains 30 reference 16S sequences
		     		+-V13.fasta - contains 30 reference marker sequences (1-3 regions)
		     		+-V35.fasta - contains 30 reference marker sequences (3-5 regions)
		     		+-V69.fasta - contains 30 reference marker sequences (6-9 regions)
```

The ```even``` and ```staggered``` are the Human mock communuty (HMP) pyrosequence data (SRX021555).
Detailed description of these datasets (and sequencing protocols) you can find under the following link: (http://www.hmpdacc.org/HMMC/)

To run the program on test data open evaluation.R and set the working directory and run the script from R-environment or R-Studio:

~~~R
>source("evaluation.R")
~~~

# How to run the program on your data

Before analysis, you may need to perform data denoising and (if you use Illumina sequence data), merge overlapping reads.

All reads in your library must be in forward (5'->3') direction.

Later I will provide the scripts that do it.

## 1. Edit script ```main.R```, specifically:

Set the work directory ```dir_path```, for example:

~~~R
dir_path <- "~/Projects/metamp/"
~~~
Working directory where all analysis data will be stored

Provide your sequences, for example:

~~~R
libs <- c("Evaluation/data/staggered/SRR072221_forward.fastq", # V1-3
          "Evaluation/data/staggered/SRR072237_forward.fastq", # V3-5
          "Evaluation/data/staggered/SRR072236_forward.fastq") # V6-9
~~~

and (if you need) reference sequences:

~~~R
# Reference 16S gene sequences
ref16S <- "Evaluation/data/16S.fasta"  
# Reference gude (marker) regions
refs <- c("Evaluation/data/V13.fasta", # V1-3 
          "Evaluation/data/V35.fasta", # V3-5
          "Evaluation/data/V69.fasta") # V6-9
~~~

Warning! Reference sequences and your data must be concordant, i.e., for example, in ```libs``` array library ```SRR072221_forward.fastq``` 
must be in the same position that ```V13.fasta``` in ```refs``` array.

## 2. Set the program directory in ```main.R```, for example:

~~~R
dir_path <- "~/Projects/metamp/"
~~~


## 3. Run the script ```main.R```:

~~~R
source("main.R")
~~~