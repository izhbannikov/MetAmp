#include <stdlib.h>     /* malloc, free, rand */
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <map>
#include <vector>
#include <Rcpp.h>
#include <time.h>

using namespace Rcpp;

double random(double min, double max)
{
    return min + (max - min) / RAND_MAX * rand();
}

std::string remove_letter( std::string str, char c )
{
    str.erase( std::remove( str.begin(), str.end(), c ), str.end() ) ;
    return str ;
}

std::vector<std::string> split_str(const std::string str, const std::string delimiters = ",")
{
	/*Splits the string based on tokens*/
	std::vector<std::string> tokens;
    std::string::size_type lastPos = str.find_first_not_of(delimiters, 0);
    std::string::size_type pos = str.find_first_of(delimiters, lastPos);
    
    while (std::string::npos != pos || std::string::npos != lastPos)
    {
       // cout << str.substr(lastPos, pos - lastPos) << endl;
        tokens.push_back(str.substr(lastPos, pos - lastPos));
        lastPos = str.find_first_not_of(delimiters, pos);
        pos = str.find_first_of(delimiters, lastPos);
    }
    
    return tokens;
}

void replaceAll(std::string& str, const std::string& from, const std::string& to) {
    if(from.empty())
        return;
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != std::string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // In case 'to' contains 'from', like replacing 'x' with 'yx'
    }
}


RcppExport SEXP BuildIdentityMatrix(SEXP fname) 
{
	std::vector<float> temp_matrix;
	std::vector<std::string> tmp_names;
	std::string line;
	std::string filename = Rcpp::as<std::string>(fname);
    std::ifstream in(filename.c_str());
    
	bool query_sequence_found = false;
	bool subject_sequence_found = false;
	std::string query_sequence_id;
	std::string subject_sequence_id;
	float sequence_identity = 0.0;
	
    while ( getline(in,line) ) {
    	size_t pos = line.find("Query=");
        if (pos != std::string::npos) { // Find query sequence id
        	query_sequence_found = true;
        	// Получаем соотв. имя:
        	query_sequence_id = split_str(line," ")[1];
        	continue;
        }
        pos = line.find("Subject=");
        if (pos != std::string::npos) {
        	if (query_sequence_found) {
        		subject_sequence_found = true;
        		// Получаем соотв. имя:
        		subject_sequence_id = split_str(line," ")[1];
        	}
        	continue;
        }
        pos = line.find("Identities");
        if ((pos != std::string::npos) && query_sequence_found && subject_sequence_found) {
        	// Сохраняем в словаре:
        	// Получаем идентичность:
        	sequence_identity = 1.0 - atof(split_str(split_str(line," ")[2], "/")[0].c_str())/atof(split_str(split_str(line," ")[2], "/")[1].c_str());
        	temp_matrix.push_back(sequence_identity);
        	tmp_names.push_back(query_sequence_id);
        	query_sequence_found = false; 
        	subject_sequence_found = false;
        	continue;
        }
        if ((line == "***** No hits found *****") && query_sequence_found && subject_sequence_found) {
        	sequence_identity = 1.0 - 0.20 + (float)(rand() % 100)/100.0;
        	temp_matrix.push_back(sequence_identity);
        	tmp_names.push_back(query_sequence_id);
        	query_sequence_found = false; 
        	subject_sequence_found = false;
        }
        
	}
	
	int n = sqrt(tmp_names.size());
	Rcpp::NumericMatrix imatrix(n, n);
	std::vector<std::string> names;
	for (int i=0; i<temp_matrix.size(); i+=n) {
		names.push_back(tmp_names[i]);
		for (int j=0; j<n; j++) {
			imatrix(i/n,j) = temp_matrix[i+j];
		}	
	}
	
	return Rcpp::List::create(imatrix, Rcpp::wrap(names));
}

RcppExport SEXP BuildIdentityMatrixUSEARCH(SEXP fnameU, SEXP sz /*Total reads*/, SEXP sz_ref /*Total reference reads*/) 
{
	srand((unsigned int)time(0));
	std::string line;
	std::string filename = Rcpp::as<std::string>(fnameU);
    std::ifstream in(filename.c_str());
    
    int n = as<int>(sz); // Total library size
    int n_ref = as<int>(sz_ref); // Reference library size
    int n_emp = n - n_ref; // Number of empirical reads
    
	long i = 0;
	NumericMatrix imatrix(n, n);
	
	getline(in,line);
	replaceAll(line, "\t", " ");
	std::vector<std::string> splitted_line = split_str(line," ");
	std::string prev_subject = splitted_line[8];
	long j = atoi((splitted_line[1]).c_str());
	imatrix(i, j) = atof((splitted_line[3]).c_str())/100.0;
	imatrix(j, i) = imatrix(i,j);
    
    while ( getline(in,line) ) {
    	replaceAll(line, "\t", " ");
    	splitted_line = split_str(line," ");
    	
    	std::string subject = splitted_line[8];
    	
    	if (subject != prev_subject) {
    		i += 1;
    		prev_subject = subject;
    	}
    	
    	if (splitted_line[0] == "N") {
    		continue;
    	}
    	
    	long j = atoi((splitted_line[1]).c_str());
    	imatrix(i, j) = atof((splitted_line[3]).c_str())/100.0;
    	imatrix(j, i) = imatrix(i,j);
    	
	}
	
	
	in.close();
	
	for (int _i=0; _i<n; _i++) {
		for (int _j=0; _j<n; _j++) {
			if (_i == _j) {
    			imatrix(_i, _j) = 0.0;
    			continue;
    		}
    		// Calculating distance:
    		imatrix(_i, _j) = 1.0-imatrix(_i, _j);
    		if (imatrix(_i, _j) == 0) {
    			imatrix(_i, _j) = random(0.001, 0.01);
    		}
    	}
	}
	
	if (n_emp != 0) {
		//std::cout << n_ref << " " << n_emp << " " << n << std::endl;
		// Handle empirical points:
		for (int ii=n_ref; ii<n; ii++) {
			for (int jj=0; jj<n_ref/2; jj++) {
				if (ii != jj) {
					if (imatrix(ii,jj) > imatrix(ii,jj+n_ref/2)) {
						//std::cout << imatrix(ii,jj) << " " << imatrix(ii,jj+n_ref/2) << " ";
						imatrix(ii,jj) = imatrix(ii,jj+n_ref/2);
						//std::cout << imatrix(ii,jj) << std::endl;
					} else {
						imatrix(ii,jj+n_ref/2) = imatrix(ii,jj);
					}
					imatrix(jj,ii) = imatrix(ii,jj);
				}
			}
		}
	}
	
	return Rcpp::wrap(imatrix);
}

RcppExport SEXP BuildIdentityMatrixUSEARCH2(SEXP table_REF, SEXP sz, SEXP fnameBLAST_REF_EMP, SEXP fnameU_EMP) 
{
	std::string line;
	std::string filename = Rcpp::as<std::string>(table_REF);
    std::ifstream in(filename.c_str());
    int n = as<int>(sz);
    
	long i = 0;
	NumericMatrix imatrix(n, n);
	
	getline(in,line);
	replaceAll(line, "\t", " ");
	std::vector<std::string> splitted_line = split_str(line," ");
	std::string prev_subject = splitted_line[8];
	long j = atoi((splitted_line[1]).c_str());
	imatrix(i, j) = 1.0 - atof((splitted_line[3]).c_str())/100.0;
	imatrix(j, i) = imatrix(i,j);
    
    while ( getline(in,line) ) {
    	replaceAll(line, "\t", " ");
    	splitted_line = split_str(line," ");
    	
    	std::string subject = splitted_line[8];
    	
    	if (subject != prev_subject) {
    		i += 1;
    		prev_subject = subject;
    	}
    	
    	if (splitted_line[0] == "N") {
    		break;
    	}
    	
    	long j = atoi((splitted_line[1]).c_str());
    	imatrix(i, j) = 1.0 - atof((splitted_line[3]).c_str())/100.0;
    	imatrix(j, i) = imatrix(i,j);
    	
	}
	
	for (int _i=0; _i<i; _i++) {
		for (int _j=0; _j<i; _j++) {
			if ( (imatrix(_i,_j) == 0) && (_i != _j) ) {
    			imatrix(_i,_j) = 1.0 - 0.10 + (float)(rand() % 150)/100.0;
    			imatrix(_j, _i) = imatrix(_i,_j);
    		} 
		}
	}
	in.close();
	
	// Reading BLAST output file:
	filename = Rcpp::as<std::string>(fnameBLAST_REF_EMP);
    in.open(filename.c_str());
    
	bool query_sequence_found = false;
	bool subject_sequence_found = false;
	std::string query_sequence_id;
	std::string subject_sequence_id;
	float sequence_identity = 0.0;
	std::string prev_query = "";
	std::string prev_sbj = "";
	long k=-1;
	long _i = i;
	while ( getline(in,line) ) {
    	size_t pos = line.find("Query=");
        if (pos != std::string::npos) { // Find query sequence id
        	query_sequence_found = true;
        	// Получаем соотв. имя:
        	query_sequence_id = split_str(line," ")[1];
        	if (prev_query != query_sequence_id) {
        		prev_query = query_sequence_id;
        		_i++;
        		k=-1;
        	}
        	continue;
        }
        pos = line.find("Subject=");
        if (pos != std::string::npos) {
        	if (query_sequence_found) {
        		subject_sequence_found = true;
        		// Получаем соотв. имя:
        		subject_sequence_id = split_str(line," ")[1];
        		k++;
        	}
        	continue;
        }
        pos = line.find("Identities");
        if ((pos != std::string::npos) && query_sequence_found && subject_sequence_found) {
        	// Сохраняем в словаре:
        	// Получаем идентичность:
        	sequence_identity = 1.0 - atof(split_str(split_str(line," ")[2], "/")[0].c_str())/atof(split_str(split_str(line," ")[2], "/")[1].c_str());
        	query_sequence_found = false; 
        	subject_sequence_found = false;
        	imatrix(_i,k) = sequence_identity;
        	imatrix(k,_i) = sequence_identity;
        	continue;
        }
        if ((line == "***** No hits found *****") && query_sequence_found && subject_sequence_found) {
        	sequence_identity = 1.0 - 0.10 + (float)(rand() % 150)/100.0;
        	query_sequence_found = false; 
        	subject_sequence_found = false;
        	imatrix(_i,k) = sequence_identity;
        	imatrix(k,_i) = sequence_identity;
        }
    }
	
	in.close();
	
	// Add self-aligned (with USEARCH) empirical data:
	// Reading USEARCH output file:
	filename = Rcpp::as<std::string>(fnameU_EMP);
    in.open(filename.c_str());
    
	getline(in,line);
	replaceAll(line, "\t", " ");
	splitted_line = split_str(line," ");
	prev_subject = splitted_line[8];
	
	_i = i+1;
	j = atoi((splitted_line[1]).c_str())+ i + 1;
	imatrix(_i, j) = atof((splitted_line[3]).c_str())/100.0;
	imatrix(j, _i) = imatrix(_i,j);
    
    while ( getline(in,line) ) {
    	replaceAll(line, "\t", " ");
    	splitted_line = split_str(line," ");
    	
    	std::string subject = splitted_line[8];
    	
    	if (subject != prev_subject) {
    		_i += 1;
    		prev_subject = subject;
    	}
    	
    	if (splitted_line[0] == "N") {
    		break;
    	}
    	
    	long j = atoi((splitted_line[1]).c_str()) + i + 1;
    	imatrix(_i, j) = 1.0 - atof((splitted_line[3]).c_str())/100.0;
    	imatrix(j, _i) = imatrix(_i,j);
    	
	}
	
	for (_i=i+1; _i<n; _i++) {
		for (int _j=i+1; _j<n; _j++) {
			if (imatrix(_i,_j) == 0) {
    			imatrix(_i,_j) = 1.0 - 0.10 + (float)(rand() % 150)/100.0;
    			imatrix(_j, _i) = imatrix(_i,_j);
    		} 
		}
	}
	in.close();
	
	return Rcpp::wrap(imatrix);
}