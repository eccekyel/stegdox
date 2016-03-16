#!/bin/bash
# Dox steganography database

# Path del database
DB_PATH=""

# Ruta de almacenamiento de datos temporales
DUMP_PATH="/tmp/st3gd0x"

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
			DB_PATH=dir_path
			break 
		fi
	echo -e $DB_PATH
	done
}

###############################################################################
######                                MAIN                              #######
###############################################################################

# Crea directorio temporal
if [ ! -d $DUMP_PATH ]; then
	mkdir $DUMP_PATH
fi

requirements
askPath
askTask
read # eliminar esto

# Elimina el directorio temporal y todo su contenido
rm -R $DUMP_PATH
