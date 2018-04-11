## Plataforma_laura

Scripts para manipular los datos del experimento de la plataforma.

Algunos pueden ser de proposito mas general:
* filtrarPEcabeceras.py y su wrapper deconseqPE.sh sirven para simular paired end en deconseq. Ademas en general podrían ser usados para igualar un par de archivos paired end que no tengan los mismos reads (wrapper), o conservar solo algunos reads de un fastq (.py)
* mindepth.py sirve para calcular, a partir de un archivo de salida de samtools depth -a o genomeCoverageBed, las posiciones que tienen al menos un depth determinado.
* filtrarZonas.py y filtrarNoCodificantes.py son para filtrar, en un archivo del tipo anterior (depth) zonas que no interesan, identificadas en el archivo de anotacion H37Rv_annotation2sytems.ptt

scriptP.sh conducia el proceso desde la salida de deconseq (filtrado humanas) hasta alineamiento y obtener archivos informativos. Puede servir como modelo para incorporar este proceso a otras pipelines

Para Laura en el IISGM.
