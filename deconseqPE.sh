#!/bin/bash

#Para simular Paired-End en deconseq(filtrado secuencias humanas). Se llama con los dos archivos paired end ya filtrados con deconseq. Elimina de ambos los reads que no aparecen en la pareja. (Se supone que en el momento que se detecta un read como humano, su pareja tambien lo va a ser aunque deconseq no lo detecte como tal)
#Llama a filtrarPEcabeceras.py, que es el que realmente hace el trabajo. Revisar ruta del script.
#Manejamos los argumentos de entrada
while getopts 1:2: option
do
        case "${option}"
        in
                1) FQ1=${OPTARG};;                
		2) FQ2=${OPTARG};;                
		\?) exit 1;;
		:) exit 1;;
        esac
done

if [[ -z "$FQ1" || -z "$FQ2" ]];
then
	echo "Compulsory arguments (-1, -2) needed!"	
	exit 2
fi 

grep @M $FQ1 | cut -f 1 --delimiter=" " >"$FQ1"_cabeceras
grep @M $FQ2 | cut -f 1 --delimiter=" " >"$FQ2"_cabeceras

#comprobar ruta a script
python /home/laura/Documentos/Programas/scriptsNuria/plataforma/filtrarPEcabeceras.py $FQ1 "$FQ2"_cabeceras "$FQ1".PE
python /home/laura/Documentos/Programas/scriptsNuria/plataforma/filtrarPEcabeceras.py $FQ2 "$FQ1"_cabeceras "$FQ2".PE

rm "$FQ1"_cabeceras
rm "$FQ2"_cabeceras
