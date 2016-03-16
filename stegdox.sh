#!/bin/bash
# Dox steganography database

# Path del database
DB_PATH=""

# Ruta de almacenamiento de datos temporales
TMP_PATH="/tmp/st3gd0x"

# Ruta del script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e $DIR

# Colores
blanco="\033[1;37m"
gris="\033[0;37m"
magenta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
rescolor="\e[0m"



###############################################################################
######                             FUNCIONES                            #######
###############################################################################

#Pregunta si consultar o modificar
function askTask {

	while true; do
		echo -e $rojo "Operación a realizar:"
		echo -e $verde "	1) Consultar Base de Datos"
		echo -e $verde "	2) Modificar Base de Datos"
		echo -e $rescolor ""
		echo "                                       "
		echo -n "      #> "
		read choice
		case $choice in
			1 ) echo -e "has elegido 1"; consultar; break ;;
			2 ) echo -e "has elegido 2"; modificar; break ;;
			* ) echo -e "opción desconocida, elige de nuevo" ;;
		esac	
	done

}

# Consultar Base de Datos
function consultar {
	# Imprimir todos los objetivos de la base de datos indexados, de manera
	# que se elija un numero y disponga la información en pantalla
	disList
	echo -e ""
}

# Modificar Base de Datos
function modificar {
	# Preguntar qué es lo que se desea modificar
	# Posibles acciones:
		# Crear nueva entidad
		# Modificar campo de identidad
	echo -e ""
}

function requirements {
	echo -e "Consultando requerimientos:"
	echo -ne "Steghide..........."
	if [ ! hash steghide 2>/dev/null ]; then
		echo -e "\e[1;31mNo se encuentra instalado"$rescolor" (prueba con sudo apt-get install steghide)"
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
}

function askPath { 
	while true; do
		echo -e $amarillo "Inserte la ruta hacia su base de datos"
		echo -e $rescolor ""
		echo "                                       "
		echo -n "      #> "
		read dir_path
	
		if [ ! -d $dir_path ]; then
			echo -e $rojo "Este directorio no existe, por favor ingrese alguno válido"
		else
			DB_PATH=$dir_path
			break 
		fi
	echo -e $DB_PATH
	done
}

# Desencriptar y mostrar listado de objetivos en la base de datos con sus respectivos
# archivos asociados 
function disList { 
	if [ ! -d  $DB_PATH"/"description.jpg ]; then
		echo -e "En este directorio no existe el archivo description.jpg,"
		echo -e "¿qué desea hacer al respecto?"
		echo -e $rojo "Operación a realizar:"
		echo -e $verde "	1) Crear el archivo en este directorio"
		echo -e $verde "	2) Elegir otro directorio"
		echo -e $rescolor ""
		echo "                                       "
		echo -n "      #> "
		read choice
		case $choice in
			1 ) cp -i $DIR"/"description.jpg $DB_PATH"/"description.jpg;
				steghide embed -cf $DB_PATH"/"description.jpg -ef texto.txt;
				echo "";;
			2 ) echo -e "" ;;
			* ) echo -e "opción desconocida, elige de nuevo" ;;
		esac
	else
		steghide --extract -sf $DB_PATH"/"description.jpg
	fi
}
###############################################################################
######                                MAIN                              #######
###############################################################################

# Crea directorio temporal
if [ ! -d $TMP_PATH ]; then
	mkdir $TMP_PATH
fi

requirements
askPath
askTask
read # eliminar esto

# Elimina el directorio temporal y todo su contenido
rm -R $TMP_PATH
