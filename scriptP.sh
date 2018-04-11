#!/bin/bash
#A partir de la salida de deconseqPE.sh (filtrado de secuencias humanas y soporte paired end custom). Se llama con la parte comun del nombre de los dos archivos paired end limpios.
#Se realiza QC con prinseq y alineamiento con bwa a la referencia de TB.
#Se obtienen archivos de estadisticas del alineamiento (stats y flagstat). Tambien archivo depth con el coverage de cada posicion de la referencia. Por ultimo, un depth.0 customizado con todas las posiciones con coverage 0.
#Este script era para probar el procedimiento. Sirve como modelo para incorporarlo a otras pipelines.

#Manejamos los argumentos de entrada
while getopts 1: option
do
        case "${option}"
        in
                1) FQ=${OPTARG};;                               
		\?) exit 1;;
		:) exit 1;;
        esac
done

if [[ -z "$FQ" ]];
then
	echo "Compulsory argument (-1) needed!"	
	exit 2
fi 


#Desde el directorio con las salidas de lo anterior (deconseq)
#comprobar ruta a script
/home/laura/Documentos/Programas/scriptsNuria/plataforma/deconseqPE.sh -1 "$FQ"_R1_clean.fq -2 "$FQ"_R2_clean.fq

test -d prinseq || mkdir prinseq

perl /home/laura/Documentos/Programas/prinseq-lite-0.20.4/prinseq-lite.pl -fastq "$FQ"_R1_clean.fq.PE -fastq2 "$FQ"_R2_clean.fq.PE -min_len 50 -trim_qual_right 20 -trim_qual_type mean -trim_qual_window 20 -out_good prinseq/"$FQ"_clean_trimmed

test -d prinseq/bwa || mkdir prinseq/bwa

bwa mem -t 7 /home/laura/Documentos/referencias/ancestorII/MTB_ancestorII_reference.fas prinseq/"$FQ"_clean_trimmed_1.fastq prinseq/"$FQ"_clean_trimmed_2.fastq > prinseq/bwa/"$FQ"_clean.PE.sam

samtools view -bS prinseq/bwa/"$FQ"_clean.PE.sam > prinseq/bwa/"$FQ"_clean.PE.bam

samtools sort prinseq/bwa/"$FQ"_clean.PE.bam -o prinseq/bwa/"$FQ"_clean.PE.sorted

samtools depth -a prinseq/bwa/"$FQ"_clean.PE.sorted > prinseq/bwa/"$FQ"_clean.PE.depth

samtools stats prinseq/bwa/"$FQ"_clean.PE.sam > prinseq/bwa/"$FQ"_clean.PE.stats

samtools flagstat prinseq/bwa/"$FQ"_clean.PE.sam > prinseq/bwa/"$FQ"_clean.PE.flagstat

grep -w 0 prinseq/bwa/"$FQ"_clean.PE.depth > prinseq/bwa/"$FQ"_clean.PE.depth.0

rm prinseq/bwa/"$FQ"_clean.PE.sam

mv *prinseq_bad* prinseq

