#!/usr/bin/python
"""
A falta de soporte Paired End en deconseq, me lo invento
Se llama desde deconseqPE.sh
Se elimina de un archivo Paired-End F o R los reads que no estuvieran en su pareja. Ha de pasarsele un archivo con las cabeceras de los reads a conservar (creado por ejemplo con grep). Solo la parte comun a ambos pares de reads.
"""
import sys

infile=sys.argv[1] #archivo F o R a filtrar
compfile=sys.argv[2] #archivo con las cabeceras a guardar, del otro PE
outfile=sys.argv[3] #archivo de salida 


try:
	inputfile = open(infile)
except IOError:
	print("%s does not exist!!" % infile)

try:
	cabfile = open(compfile)
except IOError:
	print("%s does not exist!!" % compfile)

try:
	output = open(outfile,'w')
except IOError:
	print("File %s cannot be created!!" % outfile)


cabeceras=set()
count=0

for line in cabfile:
	line=line.rstrip()
#	print line
	cabeceras.add(line)

#print cabeceras

cabfile.close()

#for line in inputfile:
while True:
	line = inputfile.readline()
	if not line: break
	line=line.rstrip()
	words=line.split()
	if words[0] in cabeceras:
		output.write(line+"\n")

		line=inputfile.readline()
		output.write(line)
		line=inputfile.readline()
		output.write(line)
		line=inputfile.readline()
		output.write(line)


inputfile.close()

output.close()
