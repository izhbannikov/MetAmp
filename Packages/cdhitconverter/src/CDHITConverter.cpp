#include <stdlib.h>     /* malloc, free, rand */
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <Rcpp.h>

#define SFF_MAGIC_NUM   0x2e736666 /* ".sff" */

using namespace Rcpp;

typedef struct {
    uint32_t  magic; /*Magic number: identical for all sff files (0x2E736666, the newbler manual explains that this is ‘the uint32_t encoding of the string „.sff“ ‘)*/
    char      version[4]; /*Version: also identical for all sff files (0001)*/
    uint64_t  index_offset; /*Index offset and length: has to do with the index of the binary sff file (points to the location of the index in the file)*/
    uint32_t  index_len;
    uint32_t  nreads; /* # of reads: stored in the sff file*/
    uint16_t  header_len;/*Header length: looks like it is 440 for GS FLX reads, 840 for GS FLX Titanium reads*/
    uint16_t  key_len;/*Key length: the length (in bases) of the key sequence that each read starts with, so far always 4*/
    uint16_t  flow_len;/*# of Flows: each flow consists of a base that is flowed over the plate; for GS20, there were 168 flows (42 cycles of all four nucleotides), 400 for GS FLX (100 cycles) and 800 for Titanium (200 cycles)*/
    uint8_t   flowgram_format;/*Flowgram code: kind of the version of coding the flowgrams (signal strengths); so far, ’1′ for all sff files*/
    char     *flow;/*Flow Chars: a string consisting of’ # of flow’ characters (168, 400 or 800) of the bases in flow order (‘TACG’ up to now)*/
    char     *key; /* Key Sequence: the first four bases of reads are either added during library preparation (they are the last bases of the ‘A’ adaptor) or they are a part of the control beads. For example, Titanium sample beads have key sequence TACG (default library protocol) or GACT (rapid library protocol), control beads have CATG or ATGC. Control reads never make it into sff files*/
} sff_c_header;

/* convert 64 bit Big Endian integer to Native Endian(means current machine) */
// As far as I know, there is no standard function for 64 bit conversion on OSX
uint64_t BE64toNE(uint64_t bigEndian)
{
    uint64_t littleEndian = ((bigEndian & (0x00000000000000FF)) << 56) |
                            ((bigEndian & (0x000000000000FF00)) << 40) |
                            ((bigEndian & (0x0000000000FF0000)) << 24) |
                            ((bigEndian & (0x00000000FF000000)) << 8) |
                            ((bigEndian & (0x000000FF00000000)) >> 8) |
                            ((bigEndian & (0x0000FF0000000000)) >> 24) |
                            ((bigEndian & (0x00FF000000000000)) >> 40) |
                            ((bigEndian & (0xFF00000000000000)) >> 56);
    return littleEndian;
}

std::string remove_letter( std::string str, char c )
{
    str.erase( std::remove( str.begin(), str.end(), c ), str.end() ) ;
    return str ;
}

std::vector<std::string> split_str(const std::string& s, const std::string& delim, const bool keep_empty = true) {
    std::vector<std::string> result;
    if (delim.empty()) {
        result.push_back(s);
        return result;
    }
    std::string::const_iterator substart = s.begin(), subend;
    while (true) {
        subend = search(substart, s.end(), delim.begin(), delim.end());
        std::string temp(substart, subend);
        if (keep_empty || !temp.empty()) {
            result.push_back(temp);
        }
        if (subend == s.end()) {
            break;
        }
        substart = subend + delim.size();
    }
    return result;
}

RcppExport SEXP Convert(SEXP fnames, SEXP v) 
{
	std::map< std::string, std::vector<std::string> > records;
	std::map< std::string, std::vector<std::string> >::iterator it;
	
	Rcpp::CharacterVector cx(fnames); 
	std::vector<char*> files;
	for (int i=0; i<cx.size(); i++) 
    {
		files.push_back(cx[i]);  
    }
    
    
	bool verbose = false;
	verbose = as<bool>(v);
	
	unsigned long read_counter = 0;

	for(int f=0; f < files.size(); ++f) {
		std::string line;
        std::ifstream in(files[f]);
        
        if(verbose)
			std::cout << "Processing files: " << files[f] << "\n";
	    
	    std::string cluster_id = "";
	        
        while ( getline(in,line) ) {
        	if(line[0]=='>') { //Cluster ID found:
        		std::vector<std::string> record;
        		cluster_id = remove_letter(line.substr(1,line.length()-1),' ');
        		if (records[cluster_id].size() == 0) { records[cluster_id] = record; } 
        	    read_counter++;
        	    continue;
        	} else //Record inside the cluster
        	{
        		records[cluster_id].push_back( split_str( split_str(line,">")[1],"..." )[0] );
        		if(verbose) {
        			//std::cout << split_str( split_str(line,">")[1],"..." )[0] << " " << split_str( split_str(line,">")[1],"..." )[1] << "\n";
        			std::cout << split_str( split_str(line,">")[1],"..." )[0] << "\n";
        		}
			}
		}
	}
	
	if(verbose)
		std::cout << "Records processed: " << read_counter << std::endl;
	
	return Rcpp::wrap( records );
}

void  get_sff_common_header(FILE *fp, sff_c_header *h) {
    char *flow;
    char *key;
    int header_size;

    size_t bytes = fread(&(h->magic)          , sizeof(uint32_t), 1, fp);
    bytes = fread(&(h->version)        , sizeof(char)    , 4, fp);
    bytes = fread(&(h->index_offset)   , sizeof(uint64_t), 1, fp);
    bytes = fread(&(h->index_len)      , sizeof(uint32_t), 1, fp);
    bytes = fread(&(h->nreads)         , sizeof(uint32_t), 1, fp);
    bytes = fread(&(h->header_len)     , sizeof(uint16_t), 1, fp);
    bytes = fread(&(h->key_len)        , sizeof(uint16_t), 1, fp);
    bytes = fread(&(h->flow_len)       , sizeof(uint16_t), 1, fp);
    bytes = fread(&(h->flowgram_format), sizeof(uint8_t) , 1, fp);

    /* sff files are in big endian notation so adjust appropriately */
    /* Linux: not in use any more
    h->magic        = htobe32(h->magic);
    h->index_offset = htobe64(h->index_offset);
    h->index_len    = htobe32(h->index_len);
    h->nreads       = htobe32(h->nreads);
    h->header_len   = htobe16(h->header_len);
    h->key_len      = htobe16(h->key_len);
    h->flow_len     = htobe16(h->flow_len);
     */
    
    h->magic        = htonl(h->magic);
    h->index_offset = BE64toNE(h->index_offset);
    h->index_len    = htonl(h->index_len);
    h->nreads       = htonl(h->nreads);
    h->header_len   = htons(h->header_len);
    h->key_len      = htons(h->key_len);
    h->flow_len     = htons(h->flow_len);

    /* finally appropriately allocate and read the flow and key strings */
    flow = (char *) malloc( h->flow_len * sizeof(char) );
    if (!flow) {
        fprintf(stderr,
                "Out of memory! Could not allocate header flow string!\n");
        exit(1);
    }

    key  = (char *) malloc( h->key_len * sizeof(char) );
    if (!key) {
        fprintf(stderr,
                "Out of memory! Could not allocate header key string!\n");
        exit(1);
    }

    bytes = fread(flow, sizeof(char), h->flow_len, fp);
    h->flow = flow;

    bytes = fread(key , sizeof(char), h->key_len , fp);
    
    h->key = key;
    
    /* the common header section should be a multiple of 8-bytes 
       if the header is not, it is zero-byte padded to make it so */

    header_size = sizeof(h->magic)
                  + sizeof( h->version )
                  + sizeof(h->index_offset)
                  + sizeof(h->index_len)
                  + sizeof(h->nreads)
                  + sizeof(h->header_len)
                  + sizeof(h->key_len)
                  + sizeof(h->flow_len)
                  + sizeof(h->flowgram_format)
                  + (sizeof(char) * h->flow_len)
                  + (sizeof(char) * h->key_len);

     
}

void free_sff_c_header(sff_c_header *h) {
    free(h->flow);
    free(h->key);
}

short  check_sff_common_header(sff_c_header *h) {
    /* ensure that the magic file type is valid */
    if (h->magic != SFF_MAGIC_NUM) {
        free_sff_c_header(h);
        return -1;
    }
    return 0;
}

RcppExport SEXP GetFileFormat(SEXP file_name) {
    /*This function determines format of input file*/
    std::string filename = as<std::string>(file_name);
    int size = 1024, pos;
    int c;
    char *buffer = (char *)malloc(size);
    short format = 3; // 0 - Fasta, 1 - Fastq, 2 - Sff, 3 - Unknown
    
    // At first, try to open a file in text mode:
    FILE *f = fopen((char*)filename.c_str(), "r");
    if (f) {
        do { // Read one lines from file
            pos = 0;
            do { // Read one line
                c = fgetc(f);
                if (c != EOF) buffer[pos++] = (char)c;
                if(pos >= size-1) { // Increase buffer length - leave room for 0
                    size *=2;
                    buffer = (char*) realloc(buffer, size);
                }
            } while(c != EOF && c != '\n');
            buffer[pos] = 0;
            // Line is now in buffer!
            // Now let's hande line:
            if (buffer[0] == '>') { // Fasta format
                format = 0;
            } else if (buffer[0] == '@') { // Fastq format
                format = 1;
            } else {
                format = 3;// Unknown file format, trying to open it in a binary mode:
            }
            break;
        } while(c != EOF);
        fclose(f);
    }
    free(buffer);
    
    if (format == 3) { // Unknown file format, try to open it in a binary mode:
        sff_c_header ch;
        FILE *sff_fp;

        if ( (sff_fp = fopen((char*)filename.c_str(), "r")) == NULL ) {
            fprintf(stderr,
                "[err] Could not open file '%s' for reading.\n", (char*)filename.c_str());
          }
    
        get_sff_common_header(sff_fp, &ch);
        short res = check_sff_common_header(&ch);
        
        if (res == 0) {
            format = 2; // Recognized as Sff file!
        }
    }
    
    return Rcpp::wrap(format);
}

