#!/usr/bin/python
"""
Para calcular, a partir de un archivo de salida de samtools depth -a o genomeCoverageBed (.depth o .merged.bam.cov), las posiciones que tienen al menos un depth determinado.
"""
import sys

infile=sys.argv[1] #archivo salida de samtools depth -a a tratar
umbral=int(sys.argv[2]) #minimo depth para que la posicion se considere cubierta
outfile=sys.argv[3] #archivo de salida con todas las posiciones que tienen al menos ese depth


try:
	inputfile = open(infile)
except IOError:
	print("%s does not exist!!" % infile)


try:
	output = open(outfile,'w')
except IOError:
	print("File %s cannot be created!!" % outfile)


count=0

for line in inputfile:
#	print line
	line=line.rstrip()
	words=line.split()
#	print words [2]
	if int(words[2]) >=umbral:
		count+=1
		output.write(line+"\n")

print "Posiciones con una profundidad de al menos "+str(umbral)+": "+str(count)

inputfile.close()
output.close()



