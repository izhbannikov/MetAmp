# This script splits libraries obtained from sequencing with different markers. I.e. one library - one marker.
# You will have to provide read ids where another marker start. Read ids should be provided in text file: one line - one read id.
# For now you should provide only one stop read id, i.e. when the program sees this id, it stops and writes content into provided 
# output file.

from Bio.Seq import Seq
from Bio import SeqIO
from Bio.Alphabet import generic_dna
import sys

def split_by_marker1(infile, outfile, id) :
	handle = open(infile, "rU")
	records = []
	for record in SeqIO.parse(handle, "fastq") :
		if record.id == id :
			break
	
		records.append(record)
	handle.close()
	
	# Writing output
	handle = open(outfile, "w")
	SeqIO.write(records, handle, "fastq")


def split_by_marker2(infile, outfile, id) :
	handle = open(infile, "rU")
	records = []
	flag = False
	for record in SeqIO.parse(handle, "fastq") :
		if record.id == id :
			#break
			flag = True
		if flag == True :
			records.append(record)
			
		
	handle.close()
	
	# Writing output
	handle = open(outfile, "w")
	SeqIO.write(records, handle, "fastq")


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
	outfile = sys.argv[-2]
	infile = sys.argv[-3]
	read_id = sys.argv[-1]
	
	split_by_marker2(infile, outfile, read_id)


if __name__ == '__main__':
    main()