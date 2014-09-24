# This script brings all sequences in provided amplicon data library to forward direction:
from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna
import sys

def rev2fwd(infile, outfile) :
	handle = open(infile, "rU")
	records = []
	revcomp = False
	for record in SeqIO.parse(handle, "fastq") :
		if record.id == "SRR072221.58746" :
			break
		if record.id == "SRR072221.29034" :
			revcomp = True
		if revcomp == True :
			new_record = record.reverse_complement()
			new_record.id = record.id
			new_record.description = record.description
			records.append(new_record)
		else :
			records.append(record)
			
		
		
	handle.close()
	
	# Writing output
	handle = open(outfile, "w")
	SeqIO.write(records, handle, "fastq")


def main() :
	outfile = sys.argv[-1]
	infile = sys.argv[-2]
	rev2fwd(infile, outfile)


if __name__ == '__main__':
    main()