"""
Class 'Smgb' implements "semiglobal" alignment:
AGAGTTTGATCCTGGCTCAG
----TTT-------------
Its main function 'smgb' returs a tuple: (alignment_score, alignment)
Example: 
a = Smgb()
print a.smgb("AGAGTTTGATCCTGGCTCAG","TTT")
Output:
(3, 'AGAGTTTGATCCTGGCTCAG\n----TTT-------------')
Written by: Ilya Y. Zhbannikov, January 25, 2014.
"""


import sys
from Bio import SeqIO

class Smgb :
 
 __match_award = None
 __mismatch_penalty = None
 __gap_penalty = None
 
 def __init__(self):
  self.__match_award = 2 #2
  self.__mismatch_penalty = -5 #-5
  self.__gap_penalty = -8 #-8
 
 def set_params(self,match,mismatch,gap) :
  self.__match_award = match
  self.__mismatch_penalty = mismatch
  self.__gap_penalty = gap
 
 
 #Creates empty matrix with all zeros
 def zeros(self,row,col):
  retval = []
  for x in range(row):
   retval.append([])
   for y in range(col):
    retval[-1].append(0)
  return retval

 #No substituition matrix, just simple linear gap penalty model
 def match_score(self,alpha, beta):
  if alpha == beta:
   return self.__match_award
  elif alpha == '-' or beta == '-':
   return self.__gap_penalty
  
  return self.__mismatch_penalty


 def smgb(self,seq1, seq2):
  m = len(seq1)
  n = len(seq2) # lengths of two sequences
  
  # Generate DP (Dynamic Programmed) table and traceback path pointer matrix
  score = self.zeros(n+1, m+1) # the DP table
  for i in range(n+1) :
   score[i][0] = i*0
  
  for j in range(m+1) :
   score[0][j] = j*0
    
  #Traceback matrix
  pointer = self.zeros(n+1, m+1) # to store the traceback path
  for i in range(n+1) :
   pointer[i][0] = 1
  for j in range(m+1) :
   pointer[0][j] = 2
  
  # Calculate DP table and mark pointers
  for i in range(1, n + 1):
   for j in range(1, m + 1):
    score_diagonal = score[i-1][j-1] + self.match_score(seq1[j-1], seq2[i-1])
    score_up = score[i][j-1] + self.__gap_penalty
    score_left = score[i-1][j] + self.__gap_penalty
    score[i][j] = max(score_left, score_up, score_diagonal)
    if score[i][j] == score_diagonal :
     pointer[i][j] = 3 # 3 means trace diagonal
    elif score[i][j] == score_up :
     pointer[i][j] = 2 # 2 means trace left
    elif score[i][j] == score_left :
     pointer[i][j] = 1 # 1 means trace up
	    
  max_i = i
  max_j = j
  
  align1, align2 = '', '' # initial sequences
    
  #Print traceback matrix as a table:
  #print "    *",
  #for j in range(len(seq1)):
  #  print " ", seq1[j],
  #print
    
  #for i in range(len(seq2)+1):
  #  print ("*" if i==0 else seq2[i-1]),
  #  for j in range(len(seq1)+1):
  #    print "%3d" % pointer[i][j],
  #  print
    
  #Print scoring matrix
  #print "    *",
  #for j in range(len(seq1)):
  #  print " ", seq1[j],
  #print
    
  #for i in range(len(seq2)+1):
  #  print ("*" if i==0 else seq2[i-1]),
  #  for j in range(len(seq1)+1):
  #    print "%3d" % score[i][j],
  #  print
    
  max_j = score[-1].index(max(score[-1]))
    
  #Traceback, follow pointers in the traceback matrix
  while 1 :
   if j > max_j :
    align1 = seq1[j-1] + align1
    align2 = '-' + align2
    j -= 1
   elif pointer[i][j] == 3 :
    align1 = seq1[j-1] + align1
    align2 = seq2[i-1] + align2
    i -= 1
    j -= 1
   elif pointer[i][j] == 2 : #2 means trace left
    align2 = '-' + align2
    align1 = seq1[j-1] + align1
    j -= 1
   elif  pointer[i][j] == 1 : # 1 means trace up
    align2 = seq2[i-1] + align2
    align1 = '-' + align1
    i -= 1
   if (i == 0 and j == 0) : break

  
  return  max_j, max(score[-1]), align1 + '\n' + align2
    
  
