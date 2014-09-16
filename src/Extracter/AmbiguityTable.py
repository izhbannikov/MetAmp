# -*- coding:utf8 -*-
#Ambiguity table:
acodes = dict([('A',['A']),
	('T', ['T']),
	('G', ['G']),
	('C', ['C']),
	('K', ['G','T']),
	('M', ['A','C']),
	('R', ['A','G']),
	('Y', ['C','T']),
	('S', ['C','G']),
	('W', ['A','T']),
	('B', ['C','G','T']),
	('V', ['A','C','G']),
	('H', ['A','C','T']),
	('D', ['A','G','T']),
	('X', ['A','G','C','T']),
	('N', ['A','G','C','T'])])
	
	
class Primer :
 #def __init(self)__:
 # pass
 
 
 def get_primer_set(self, primer_string) :
  primers = []
  self.generate_primers(0, "", primer_string,primers)
  
  return primers
  
 def generate_primers(self,i, tstr, primer_string,primers) :
  #Generates primers from the given string with ambiguity codes
  #Здесь:
  #i - глубина рекурсии
  #tstr - рабочая строка
  #primer_string - строка с использующимся праймером
  tt = acodes[primer_string[i]]	
  for k in range(len(tt)) :
   if i < len(primer_string) - 1 :
    self.generate_primers(i+1,tstr + tt[k], primer_string,primers)
   else :
    primers.append(tstr)
  

