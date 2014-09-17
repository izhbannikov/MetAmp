# Description

Data for evaluation purposes. If you want to see how the meta-amplicon analysis algorithm works.
This folder contains evaluation data for Meta-Amplicon analysis pipeline (MetAmp).

# Content

This folder contains the following subfolders and files:

```
+-Evaluation-+
			 +-data-+ - contains the following evaluation data:
	   		 +-Dataset1.zip
	   		 +-Dataset2.zip - compressed libraries
	   		 +-HMC_ref_16S.fasta - reference whole 16S sequences.
	   		 +-HMC_ref_V13.fasta - reference marker sequences (for markers 1-3, 3-5 and 6-9).
	   		 +-HMC_ref_V35.fasta
	   		 +-HMC_ref_V69.fasta
+-evaluation.R - a script to run evaluation
+-evaluation_metamp.R - an actual evaluation workflow run by evaluation.R
+-evaluation_config.R - a config file for evaluation. Contains path to the data and holds program settings.
+-README.md - this readme.
```
