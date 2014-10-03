# -*- coding:utf8 -*-
#!/usr/bin/env python

"""
This script extracts variable regions from 16S rRNA. Author: Ilya Y. Zhbannikov

Example run:

python extract.py 16S.fasta test --fp CCTACGGGAGGCAGCAG --rp CCGTCAATTCMTTTRAGN

Here: 
16S.fasta - an input file that contains 16S sequences, must be provided in FASTA format;
test - an output prefix for file that contains extracted variable regions, will be in FASTA format (i.e. test.fasta);
CCTACGGGAGGCAGCAG - forward primer
CCGTCAATTCMTTTRAGN - reverse primer


Some primer sequences that can be used
V1-3 primers:
forward_primer = "NGAGTTTGATCCTGGCTCAG" # -m=2 -p=-5 g=-8
reverse_primer = "ATTACCGCGGCTGCTGG"

V3-5 primers:
forward_primer = "CCTACGGGAGGCAGCAG" # -m=2 -p=-5 g=-8
reverse_primer = "CCGTCAATTCMTTTRAGN"

V6-9 primers:
forward_primer = "GAATTGACGGGGRCCC" # -m=2 -p=-5 -g=-1
reverse_primer = "TACGGYTACCTTGTTAYGACTT"
 

Last change was made on 2014/10/02

"""

import sys
from Bio import *
from Bio.Seq import Seq
from Bio.Alphabet import generic_dna
from Bio.SeqRecord import SeqRecord
from optparse import OptionParser
from smgb import *
from AmbiguityTable import *


class Extract :
	match = None # Match award
	mismatch = None # Mismatch penalty
	gap = None # Gap penalty
	forward_primer = None
	reverse_primer = None
	start_avg = []
	stop_avg = []
	length_avg = []
	
	
	
	def __init__(self): # Initialization
		self.match = 2 # Matсh award (-ma)
		self.mismatch = -5 # Gap mismatch penalty (-mp)
		self.gap = -8 # (-gap) Gap penalty
		self.forward_primer = "NGAGTTTGATCCTGGCTCAG"
		self.reverse_primer = "ATTACCGCGGCTGCTGG"
 
	def extract(self, bacteria_filename, output_prefix) :
		# Main method that extracts variable regions from complete 16S sequences
		handle = open(bacteria_filename, "rU")
		#Output files:
		report = output_prefix + ".txt"
		report_handle = open(report, "w")
		output_prefix = output_prefix+".fasta"
		output_handle = open(output_prefix, "w")
		print "Output file:", output_prefix
		
		prev_start = 0
		prev_stop = 0
		start_pos = stop_pos = 0
		# For each line:
		cnt = 0 # Counter
		for record in SeqIO.parse(handle, "fasta") :
			cnt += 1
			#Try to find a forward primer
			v_region_found = False
			# We generate primers from ambiguity table:
			forward_primers_set = Primer().get_primer_set(self.forward_primer)
			start = Smgb()
			start.set_params(self.match,self.mismatch,self.gap)
			scores = []
			positions = []
			# For each generated primer (we are using an ambiguity table):
			for p in forward_primers_set :
				results = start.smgb(record.seq,p)
				positions.append(results[0])
				scores.append(results[1])
			start_pos = positions[scores.index(max(scores))]
			if start_pos != -1 : # Start found! Let's try to find stop position
				start_pos += len(self.forward_primer)
				#Try to find a reverse primer:
				reverse_primers_set = Primer().get_primer_set(self.reverse_primer)
				stop = Smgb()
				stop.set_params(self.match,self.mismatch,self.gap)
				scores = []
				positions = []
				for p in reverse_primers_set :
					results = stop.smgb(record.seq,Seq(self.reverse_primer, generic_dna).reverse_complement())
					positions.append(results[0])
					scores.append(results[1])
					stop_pos = positions[scores.index(max(scores))]
				if stop_pos > start_pos + 2*len(self.forward_primer) : 
					SeqIO.write(record[start_pos:stop_pos], output_handle, "fasta")
					v_region_found = True
					prev_start = start_pos
					prev_stop = stop_pos
				#else : # Use previously found good values:
				#	start_pos = prev_start
				#	stop_pos = prev_stop
				#	SeqIO.write(record[start_pos:stop_pos], output_handle, "fasta")
				#	v_region_found = True
			if v_region_found == False :
				# Try reverse complement
				revcomp = record.reverse_complement()
				for p in forward_primers_set :
					results = start.smgb(revcomp.seq,p)
					positions.append(results[0])
					scores.append(results[1])
				start_pos = positions[scores.index(max(scores))]
				if start_pos != -1 : # Start found! Let's try to find stop position
					start_pos += len(self.forward_primer)
					#Try to find a reverse primer:
					reverse_primers_set = Primer().get_primer_set(self.reverse_primer)
					stop = Smgb()
					stop.set_params(self.match,self.mismatch,self.gap)
					scores = []
					positions = []
					for p in reverse_primers_set :
						results = stop.smgb(revcomp.seq,Seq(self.reverse_primer, generic_dna).reverse_complement())
						positions.append(results[0])
						scores.append(results[1])
						stop_pos = positions[scores.index(max(scores))]
					if stop_pos > start_pos + 2*len(self.forward_primer) : 
						SeqIO.write(record[start_pos:stop_pos].reverse_complement(), output_handle, "fasta")
						v_region_found = True
						prev_start = start_pos
						prev_stop = stop_pos
			#	start_pos = prev_start
			#	stop_pos = prev_stop
			#	SeqIO.write(record[start_pos:stop_pos], output_handle, "fasta")
			#	v_region_found = True
			print record.id, start_pos, stop_pos, v_region_found
			self.start_avg.append(start_pos)
			self.stop_avg.append(stop_pos)
			self.length_avg.append(stop_pos-start_pos)
		# Cleaning up:
		handle.close()
		report_handle.write("Total records\tAvg start pos\tAvg end pos\tAvg length\n")
		report_handle.write(str(cnt)+'\t'+str(sum(self.start_avg)/len(self.start_avg))+'\t'+str(sum(self.stop_avg)/len(self.stop_avg))+'\t'+str(sum(self.length_avg)/len(self.length_avg))+'\n')
		output_handle.close()  
		report_handle.close()
    	
def main() :
	# Setting-up options for option parser:
	usage = "usage: %prog <input file path> <output file prefix> [options]"
	parser = OptionParser(usage=usage)
	parser.add_option("--fp", "--forward_primer", action="store", type="string", dest="forward_primer", default=None, help="forward primer sequence") # V13 forward primer
	parser.add_option("--rp", "--reverse_primer", action="store", type="string", dest="reverse_primer", default=None, help="reverse primer sequence") # V13 reverse primer
	parser.add_option("-m", "--match_award", action="store", type="int", dest="match_award", default=2, help="match award")
	parser.add_option("-p", "--mismatch_penalty", action="store", type="int", dest="mismatch_penalty", default=-5, help="mismatch penalty")
	parser.add_option("-g", "--gap", action="store", type="int", dest="gap_penalty", default=-8, help="gap penalty")
	(options, args) = parser.parse_args()
	
	# Checking the input parameters:
	if len(sys.argv) < 3 :
		print "Error: no input files provided."
		parser.print_help()
	else :
		if options.forward_primer == None or options.reverse_primer == None :
			print "Warning: no primer sequences provided. The program will use V1-3 forward and reverse primer sequences: {NGAGTTTGATCCTGGCTCAG, ATTACCGCGGCTGCTGG}"
			options.forward_primer = "NGAGTTTGATCCTGGCTCAG"
			options.reverse_primer = "ATTACCGCGGCTGCTGG"
			
		# Extracter instantiation:
		obj = Extract()
		obj.match = options.match_award
		obj.mismatch = options.mismatch_penalty
		obj.gap = options.gap_penalty
		obj.forward_primer = options.forward_primer
		obj.reverse_primer = options.reverse_primer
	
		print "Extraction started..."
	
		obj.extract(sys.argv[1], sys.argv[2])
	
if __name__ == '__main__':
    main()
    
