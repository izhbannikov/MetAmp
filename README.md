This is a workflow for analysis of meta-amplicon data. Project website: [Meta-Amplicon Analysis Project](http://izhbannikov.github.io/MetAmp/)

By Ilya Y. Zhbannikov, ilyaz@uidaho.edu, i.zhbannikov@mail.ru

# Program description

MetAmp tool is developed for analysis of amplicon data by combining several marker regions from 16S rRNA genes.
Such marker regions serve as unique identificators for species. There are nine marker regions in bacterial 
16S rRNA gene.

# How to install

Make sure that you have a stable Internet connection. Download or clone from the GitHub, save it in some folder you wish. Then simply run ```make```. In some cases you need to be an admin and in this case you have to use ```sudo make```.
This will check for required packages and install in case if some packages were not found.
You will need Python 2.7.6 (older versions may not support some features), R and GCC.

# Provided data description

We provided data that can be used in your projects. This data located in ```data``` directory.
We also provided data for evaluation of MetAmp (located in ```data/``` directory as well). 
Notice that the amount of data is large (unzipped files take several hundred MBytes). 

Detailed description of provided data is given below:

```
+-data-+
	   +-gold-+
	   		  +-gold.fa - ChimeraSlayer reference database in the Broad Microbiome Utilities (http://microbiomeutil.sourceforge.net/), version microbiomeutil-r20110519.
	   		  +-gold_V13V31.fasta - Marker regions 1-3 from gold.fa
	   		  +-gold_V35V53.fasta - Marker regions 3-5 from gold.fa
       		  +-gold_V69V96.fasta - Marker regions 6-9 from gold.fa
	   +-gold1500-+
	   			+-gold1500_V13V31.fasta - Marker regions 1-3 from gold1500.fa
	   			+-gold1500_V35V53.fasta - Marker regions 3-5 from gold1500.fasta
       			+-gold1500_V69V96.fasta - Marker regions 6-9 from gold1500.fasta
	   			+-gold1500.fa - Reference genomes of 1500 species extracted from gold.fa
	   +-gold21-+
	   			+-gold21_V13V31.fasta - Marker regions 1-3 from gold21.fasta
	   			+-gold21_V35V53.fasta - Marker regions 3-5 from gold21.fasta
       			+-gold21_V69V96.fasta - Marker regions 6-9 from gold21.fasta
	   			+-gold21.fasta - Reference genomes of 21 species extracted from gold.fa
	   +-even.zip - Even Human Mock Community (HMC) data
	   +-staggered.zip - Staggered HMC data
```

The ```even``` and ```staggered``` are the Human mock communuty (from Human Microbiome Project) pyrosequence data (SRX021555).
Detailed description of these datasets (and sequencing protocols) you can find under the following link: (http://www.hmpdacc.org/HMMC/)

# Quick start
To run the program on test data run the following script:

```
python metamp.py -o ~/test -r data/gold21/gold21.fasta \
			-r1 data/gold21/gold21_V13V31.fasta -l1 data/even/SRR072220_V13V31_relabeled.fastq \
			-r2 data/gold21/gold21_V35V53.fasta -l2 data/even/SRR072220_V35V53_relabeled.fastq \
			-r3 data/gold21/gold21_V69V96.fasta -l3 data/even/SRR072239_V69V96_relabeled.fastq			
```

Here:
* ```metamp.py``` - the name of starting script.
* ```-r data/gold21/gold21.fasta``` - passing the reference file, that contains whole 16S sequences, in forward and reverse complement.
* ```-r1 data/gold/gold21\_V13V31.fasta``` - passing the reference file that contains marker (region V1-3) sequences extracted from gold21.fasta (whole 16S), in forward and reverse complement.\\
* ```-l1 data/even/SRR072220\_V13V31\_relabeled.fastq``` - amplicon emprirical reads for marker V1-3. "relabeled" means that a barcode sequences were attached to each read label.\\
* ```-r2 data/gold/gold21\_V13V31.fasta``` - passing the reference file that contains marker (region V3-5) sequences extracted from gold21.fasta (whole 16S), in forward and reverse complement.\\
* ```-l2 data/even/SRR072220_V35V53_relabeled.fastq``` - amplicon emprirical reads for marker V3-5. "relabeled" means that a barcode sequences were attached to each read label.\\
* ```-r3 data/gold/gold21\_V13V31.fasta``` - passing the reference file that contains marker (region V6-9) sequences extracted from gold21.fasta (whole 16S), in forward and reverse complement.\\
* ```-l3 data/even/SRR072239_V69V96_relabeled.fastq``` - amplicon emprirical reads for marker V6-9. "relabeled" means that a barcode sequences were attached to each read label.\\
* ```-o ~/test``` - output directory with all analysis results.


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

## 1. Prepare reference sequences.

We provided some reference sequences in ```data``` directory.

## 2. Prepare your empirical amplicon sequences.

You have to do sample pooling and merging paired-end Illumina libraries (if your data is paired-end Illumina).

## 3. Run the script ```metamp.py```

```
python metamp.py -o [--output] -r [--ref] <reference 16S seqs> \
			-r1 [--ref1] <reference marker seqs> -l1 [--lib1] <your amplicon library> \
			[options]
```
Here is the description of command line arguments:

```
-h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output directory.
  -r REF16S, --ref REF16S
                        Output file with keywords.
  -r1 REF1, --ref1 REF1
                        Reference marker sequences for marker type #1
  -r2 REF2, --ref2 REF2
                        Reference marker sequences for marker type #2
  -r3 REF3, --ref3 REF3
                        Reference marker sequences for marker type #3
  -r4 REF4, --ref4 REF4
                        Reference marker sequences for marker type #4
  -r5 REF5, --ref5 REF5
                        Reference marker sequences for marker type #5
  -r6 REF6, --ref6 REF6
                        Reference marker sequences for marker type #6
  -r7 REF7, --ref7 REF7
                        Reference marker sequences for marker type #7
  -r8 REF8, --ref8 REF8
                        Reference marker sequences for marker type #8
  -r9 REF9, --ref9 REF9
                        Reference marker sequences for marker type #9
  -l1 LIB1, --lib1 LIB1
                        Amplicon sequences for marker #1
  -l2 LIB2, --lib2 LIB2
                        Amplicon sequences for marker #2
  -l3 LIB3, --lib3 LIB3
                        Amplicon sequences for marker #3
  -l4 LIB4, --lib4 LIB4
                        Amplicon sequences for marker #4
  -l5 LIB5, --lib5 LIB5
                        Amplicon sequences for marker #5
  -l6 LIB6, --lib6 LIB6
                        Amplicon sequences for marker #6
  -l7 LIB7, --lib7 LIB7
                        Amplicon sequences for marker #7
  -l8 LIB8, --lib8 LIB8
                        Amplicon sequences for marker #8
  -l9 LIB9, --lib9 LIB9
                        Amplicon sequences for marker #9
  -qual QUAL, --qual QUAL
                        Quality score threshold (default=15)
  -minlen MINLEN, --minlen MINLEN
                        Minimum read length (default=250)
```

## 4. Output files

* clusters.clstr - contains large table in ```uc``` format (see www.drive5.com)
* otu_table.txt - OTU table, where rows are OTUs and colums are barcodes.
* coordinates.crd - file that contains NMDS coordinates of each point (reference and empirical, see provided explanations in UserGuide.pdf)
* log.txt - a simple log file that record every stage of analysis.
