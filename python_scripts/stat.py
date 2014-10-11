# Script to compute final statistics

import sys
import os

# Loading .clstr file and building a dictionary from it:
def build_otus_dict1(filename) :
	#handle = open("clusters.clstr", 'rU')
	otus = dict()
	handle = open(filename, 'rU')
	i=0
	for line in handle.readlines() :
		if i > 2 :
			splitted = line[:-1].split(' ')
			val = splitted[0]
			keys = splitted[1].split(',')
			for k in keys :
				otus[k] = val
		
		i+=1
	
	handle.close()
	return otus
	
def build_otus_dict2(filename) :
	# Loading .clstr file and building a dictionary from it:
	#handle = open("clusters.clstr", 'rU')
	handle = open(filename, 'rU')
	otus = dict()
	i=0
	for line in handle.readlines() :
		if i > 2 :
			splitted = line[:-1].split(' ')
			key = splitted[0]
			values = splitted[1].split(',')
			otus[key] = values
		i+=1
	handle.close()
	return otus


def make_final_uctable(infilename, outfilename, num_markers) :
	#outhandle = open("test.clstr",'w')
	otus = build_otus_dict1(infilename)
	outhandle = open(outfilename,'w')
	for i in range(num_markers) :
		handle = open(os.path.dirname(infilename)+"/map_"+str(i+1)+".uc",'rU')
		for line in handle.readlines() :
			splitted = line[:-1].split('\t')
			otu = splitted[-1]
			hit = splitted[0]
			if hit != 'N' :
				splitted[-1] = otus[otu]
			
			string_to_write = '\t'.join(map(str,splitted))+'\n'
			outhandle.write(string_to_write)
			
	outhandle.close()	
	handle.close()

def make_final_otutable(infilename, otu_table_filename, num_markers) :
	# Processing final OTU table
	# Do read each file with otu table separately
	
	otus = build_otus_dict2(infilename)
	
	handle = open(os.path.dirname(infilename)+"/otu_table_1.txt",'rU')
	barcodes = handle.readline()[:-1].split('\t')[1:]
	#print barcodes
	dictionaries = []
	for i in range(1,num_markers+1) :
		#print i
		# Read otu table:
		handle = open(os.path.dirname(infilename)+"/otu_table_"+str(i)+".txt",'rU')
		d = dict()
		j=0
		for line in handle.readlines() :
			if j > 0 : # Skip the First line
				splitted = line[:-1].split('\t')
				d[splitted[0]] = dict()
				for l in range(1,len(splitted)) :
					d[splitted[0]][barcodes[l-1]] = splitted[l]	
			j += 1
		handle.close()
		dictionaries.append(d)



	summary = dict()
	for k in otus.keys() :
		summary[k] = dict()
		for b in barcodes :
			summary[k][b] = dict()
			for i in range(1, len(dictionaries)+1) :
				summary[k][b][i] = 0

	for k in otus.keys() :
		vals = otus[k]
		for v in vals :
			for i in range(1,len(dictionaries)+1) :
				if v in dictionaries[i-1] :
					for b in barcodes :
						if b in dictionaries[i-1][v] :
							summary[k][b][i] += int(dictionaries[i-1][v][b])

	#print summary
	outhandle = open(otu_table_filename, 'w')
	string_to_write = "OTUId\t" + '\t'.join(map(str,barcodes))
	print string_to_write
	outhandle.write(string_to_write)
	outhandle.write('\n')
	# Now we write to output file:
	for k in summary.keys() :
		string_to_write = k
		for b in summary[k].keys() :
			maxnum = []
			for v in summary[k][b].keys() :
				maxnum.append(summary[k][b][v])
			string_to_write += '\t' + str(max(maxnum))
		print string_to_write
		outhandle.write(string_to_write)
		outhandle.write('\n')
		
	outhandle.close()
		
def main():

	argv = sys.argv
	num_markers = int(argv[-1]) # Number of marker regions
	otu_table_filename = argv[-2] # OTU table output filename
	clstr_outfilename = argv[-3] # output file for final uc map table
	clstr_infilename = argv[-4] # clustering table ("clusters.clstr")
	
	
	make_final_uctable(clstr_infilename, clstr_outfilename, num_markers)
	make_final_otutable(clstr_infilename, otu_table_filename, num_markers)
	
	return 0



if __name__ == "__main__":
	sys.exit(main())