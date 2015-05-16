
import sys
import subprocess
import argparse
import traceback
import os
import time

src_path = "src/main.R"

def run() :
	return
	
def main():
	start = time.time()
	
	# Parsing command-line variables
	parser = argparse.ArgumentParser(prog='metamp.py', usage='%(prog)s -o [--output] -r [--ref] <reference 16S seqs> -r1 [--ref1] <reference marker seqs> -l1 [--lib1] <your amplicon library> [options]') # argparse parser initialization
   	# Adding arguments:
   	parser.add_argument("-o", "--output", dest="output",action="store", help="Output directory.", required=True)
   	# Reference libraries:
   	parser.add_argument("-r", "--ref", dest="ref16s", action="store", help="Output file with keywords.", required=True)
   	parser.add_argument("-r1", "--ref1", dest="ref1", help="Reference marker sequences for marker type #1", action="store", required=True)
   	parser.add_argument("-r2", "--ref2", dest="ref2", help="Reference marker sequences for marker type #2", action="store")
	parser.add_argument("-r3", "--ref3", dest="ref3", help="Reference marker sequences for marker type #3", action="store")
	parser.add_argument("-r4", "--ref4", dest="ref4", help="Reference marker sequences for marker type #4", action="store")
	parser.add_argument("-r5", "--ref5", dest="ref5", help="Reference marker sequences for marker type #5", action="store")
	parser.add_argument("-r6", "--ref6", dest="ref6", help="Reference marker sequences for marker type #6", action="store")
	parser.add_argument("-r7", "--ref7", dest="ref7", help="Reference marker sequences for marker type #7", action="store")
	parser.add_argument("-r8", "--ref8", dest="ref8", help="Reference marker sequences for marker type #8", action="store")
	parser.add_argument("-r9", "--ref9", dest="ref9", help="Reference marker sequences for marker type #9", action="store")
   	# Amplicon libraries
   	parser.add_argument("-l1", "--lib1", dest="lib1", help="Amplicon sequences for marker #1", action="store", required=True)
   	parser.add_argument("-l2", "--lib2", dest="lib2", help="Amplicon sequences for marker #2", action="store")
	parser.add_argument("-l3", "--lib3", dest="lib3", help="Amplicon sequences for marker #3", action="store")
	parser.add_argument("-l4", "--lib4", dest="lib4", help="Amplicon sequences for marker #4", action="store")
	parser.add_argument("-l5", "--lib5", dest="lib5", help="Amplicon sequences for marker #5", action="store")
	parser.add_argument("-l6", "--lib6", dest="lib6", help="Amplicon sequences for marker #6", action="store")
	parser.add_argument("-l7", "--lib7", dest="lib7", help="Amplicon sequences for marker #7", action="store")
	parser.add_argument("-l8", "--lib8", dest="lib8", help="Amplicon sequences for marker #8", action="store")
	parser.add_argument("-l9", "--lib9", dest="lib9", help="Amplicon sequences for marker #9", action="store")
	# Quality trimming parameters:
	parser.add_argument("-qual", "--qual", dest="qual", type=int, help="Quality score threshold", action="store", default=15)
	parser.add_argument("-minlen", "--minlen", type=int, dest="minlen", help="Minimum read length", action="store", default=250)
   	# Getting args from command line:
   	args = parser.parse_args()
   	
   	# Checking pairs:
	# Marker 2
	if args.ref2 != None and args.lib2 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref2 == None and args.lib2 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 3
	if args.ref3 != None and args.lib3 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref3 == None and args.lib3 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 4
	if args.ref4 != None and args.lib4 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref4 == None and args.lib4 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 5
	if args.ref5 != None and args.lib5 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref5 == None and args.lib5 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 6
	if args.ref6 != None and args.lib6 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref6 == None and args.lib6 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 7
	if args.ref7 != None and args.lib7 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref7 == None and args.lib7 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 8
	if args.ref8 != None and args.lib8 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref8 == None and args.lib8 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
	# Marker 9
	if args.ref9 != None and args.lib9 == None :
		print "Error. You can't simultaneously have non-empy reference and empty amplicon library for marker 1"
		sys.exit(1)
	elif args.ref9 == None and args.lib9 != None :
		print "Error. You can't simultaneously have empy reference and non-empty amplicon library for marker 1"
		sys.exit(1)
			
	# If everything is ok, run the metamp script:
	try :
		subprocess.call(["Rscript", src_path, "-d", os.getcwd(),
									"-o", str(args.output),
									"--ref", str(args.ref16s), 
									"--ref1", str(args.ref1),
									"--ref2", str(args.ref2),
									"--ref3", str(args.ref3),
									"--ref4", str(args.ref4),
									"--ref5", str(args.ref5),
									"--ref6", str(args.ref6),
									"--ref7", str(args.ref7),
									"--ref8", str(args.ref8),
									"--ref9", str(args.ref9),
									"--lib1", str(args.lib1),
									"--lib2", str(args.lib2),
									"--lib3", str(args.lib3),
									"--lib4", str(args.lib4),
									"--lib5", str(args.lib5),
									"--lib6", str(args.lib6),
									"--lib7", str(args.lib7),
									"--lib8", str(args.lib8),
									"--lib9", str(args.lib9),
									"--qual", str(args.qual),
									"--minlen", str(args.minlen)])
		done = time.time()
		elapsed = done - start
		print "Elapsed time:", elapsed
	except :
		print "Can't run Rscript. Perhaps R is not installed. Terminating..."
		done = time.time()
		elapsed = done - start
		print "Elapsed time:", elapsed
		sys.exit(2)
		
if __name__ == '__main__' :
	main() # Call the main function
