This is a workflow for analysis of meta-amplicon data. Project website: [Meta-Amplicon Analysis Project](http://izhbannikov.github.io/MetAmp/)

By Ilya Y. Zhbannikov, ilyaz@uidaho.edu, i.zhbannikov@mail.ru

# Program description

MetAmp tool is developed for analysis of amplicon data by combining several marker regions from 16S rRNA genes.
Such marker regions serve as unique identificators for species. There are nine marker regions in bacterial 
16S rRNA gene.

# How to install

Download or clone from the GitHub, save it in some folder you wish. Then simply run ```make```. 
This will check for required packages and install in case if some packages were not found.

# Provided data description

We provided data that can be used in your projects. This data located in ```data``` directory.
We also provided data for evaluation of MetAmp (located in ```data/``` directory as well). 
Notice that the amount of data is large (unzipped files take several hundred MBytes). 

Detailed description of provided data is given below:

* LTP folder contains data (full-length 16S sequences and three marker regions) for
data extracted from All Species Living Tree Project.

```
+-data-+
	   +-gold-+
	   		  +-gold.fa - ChimeraSlayer reference database in the Broad Microbiome Utilities (http://microbiomeutil.sourceforge.net/), version microbiomeutil-r20110519.
	   +-LTP-+
			 +-LTP-10271.fasta - reference sequences for the whole 16S gene
	  		 +-LTP-10271_V13.fasta - reference sequences for marker 1-3
	  		 +-LTP-10271_V35.fasta - sequences for marker 3-5
	  		 +-LTP-10271_V69.fasta - sequences for marker 6-9
	   +-16S_gold_hmc_V13V31.fasta - Marker regions 1-3 from 16S_gold_hmc.fasta
	   +-16S_gold_hmc_V35V53.fasta - Marker regions 3-5 from 16S_gold_hmc.fasta
       +-16S_gold_hmc_V69V96.fasta - Marker regions 6-9 from 16S_gold_hmc.fasta
	   +-16S_gold_hmc.fasta - Reference genomes of 21 species extracted from gold.fa
	   +-even.zip - Even Human Mock Community (HMC) data
	   +-staggered.zip - Staggered HMC data
```

The ```even``` and ```staggered``` are the Human mock communuty (from Human Microbiome Project) pyrosequence data (SRX021555).
Detailed description of these datasets (and sequencing protocols) you can find under the following link: (http://www.hmpdacc.org/HMMC/)

To run the program on test data open main.R and set the work directory and run the script from R-environment or R-Studio:

~~~R
>source("main.R")
~~~

# How to run the program on your data

Before analysis, you may need to perform re-labeling of your read headers: a read header should contain ```barcodelabel``` (see more at www.drive5.com),
for example: 

~~~Python
@read1;barcodelabel=TCAG;
GATGAACGCTGGCGGCGTGCCTAATACATGCAAGT...AT
+
IIIAAAIIIIIIIIIIIIIIIHHHIAAAAAAAAAA...II
~~~

If you use Illumina sequence data, you also have to merge overlapping paired-end reads.

Later I will provide the scripts that can do these things above, but for now you can simply use scripts provided at www.drive5.com.

## 1. Set the program and analysis directories in ```main.R```, for example:

~~~R
dir_path <- "~/Projects/metamp/"
analysis_dir <- "analysis"
~~~

## 2. Provide your sequences (in ```main.R``` file), for example:

Amplicon data:

~~~R
libs <- c("data/staggered/SRR072223_V13V31_1_relabeled.fastq", # V1-3
          "data/staggered/SRR072223_V35V53_1_relabeled.fastq", # V3-5
          "data/staggered/SRR072223_V69V96_1_relabeled.fastq") # V6-9
~~~

and reference sequences:

~~~R
# Reference sequences:
ref16S <- "data/16S_gold_hmc.fasta"
refs <- c("data/16S_gold_hmc_V13V31.fasta", # V1-3
          "data/16S_gold_hmc_V35V53.fasta", # V3-5
          "data/16S_gold_hmc_V69V96.fasta") # V6-9
~~~

Warning! Reference sequences and your data must be concordant, i.e., for example, in ```libs``` array library ```SRR072223_V13V31_1.fastq``` 
must be in the same position that ```16S_gold_hmc_V13V31.fasta``` in ```refs``` array.

## 3. Run the script ```main.R```:

~~~R
source("main.R")
~~~

## 4. Output files

* clusters.clstr - contains large table in ```uc``` format (see www.drive5.com)
* otu_table.txt - OTU table, where rows are OTUs and colums are barcodes.
* coordinates.crd - file that contains NMDS coordinates of each point (reference and empirical, see provided explanations in UserGuide.pdf)
* log.txt - a simple log file that record every stage of analysis.