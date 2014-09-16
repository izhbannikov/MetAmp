Folder Evaluation.

This folder contains evaluation data for Meta-Amplicon analysis pipeline (MetAmp).
It contains the following subfolders and files:

analysis - contains pre-clustered libraries:

	SRR053817_3_cleaned.fasta_clustered
	SRR053817_3_cleaned.fasta_clustered.clstr
	SRR053818_3_cleaned.fasta_clustered
	SRR053818_3_cleaned.fasta_clustered.clstr
	SRR053819_3_cleaned.fasta_clustered
	SRR053819_3_cleaned.fasta_clustered.clstr

data - contains the following evaluation data:

	Dataset1.zip, Dataset2.zip - compressed libraries, denoised with SeqyClean.
	HMC_ref_16S.fasta - reference whole 16S sequences.
	HMC_ref_V13.fasta, HMC_ref_V35.fasta, HMC_ref_V69.fasta - reference marker sequences (for markers 1-3, 3-5 and 6-9).
	HMC_ref_16S.usearch - distance matrix for reference whole 16S sequences.
	HMC_ref_V13.usearch, HMC_ref_V35.usearch, HMC_ref_V69.usearch - distance matrices for correspoinding marker sequences (for markers 1-3, 3-5 and 6-9)
	
evaluation.R - a script to run evaluation
evaluation_metamp.R - an actual evaluation workflow run by evaluation.R
evaluation_config.R - a config file for evaluation. Contains path to the data and holds program settings.

README.txt - this readme.
