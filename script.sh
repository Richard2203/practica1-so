#! /bin/bash
####################################################################
#                          EJERCICIO 1

####################################################################
#                          EJERCICIO 2



####################################################################
#                          EJERCICIO 3
# Usa expresiones condicionales para validar 3 archivos. EL primer
# archivo debe tener permisos de lectura, el segundo debe existir
# y tener permisos de ejecucion. Mostrar quin es el propietario del
# tercer archivo. Mostrar cual de los tres es el archivo mas antiguo
# (en creacion). El nombre de los archivos se recibe por argumento
# al momento de ejecutar el script.
function tienePermisoLectura(){
    if test -r "/home/ricardo/Escritorio/practica1/practica1-so/$1"; then
        echo "El archivo $1 tiene permiso de lectura..." 
    fi
}

function obtenerDuenioArchivo(){
    owner=$(stat -c '%U' "/home/ricardo/Escritorio/practica1/practica1-so/$1")
    echo "El dueño del archivo $1 es $owner"
}

function tienePermisoEjecucion(){
    if test -x "/home/ricardo/Escritorio/practica1/practica1-so/$1"; then
        echo "El archivo $1 tiene permiso de ejecución..." 
	else
		echo "El archivo $1 NO tiene permiso de ejecución..."
    fi
}

function archivoMasAntiguo(){
    file1="/home/ricardo/Escritorio/practica1/practica1-so/$1"
    file2="/home/ricardo/Escritorio/practica1/practica1-so/$2"
    file3="/home/ricardo/Escritorio/practica1/practica1-so/$3"

    if [ "$file1" -ot "$file2" ] && [ "$file1" -ot "$file3" ]; then
        echo "$1 es el archivo más viejo"
        return 0
    elif [ "$file2" -ot "$file1" ] && [ "$file2" -ot "$file3" ]; then
        echo "$2 es el archivo más viejo"
        return 0
    else
        echo "$3 es el archivo más viejo"
        return 0
    fi
}

function existe(){
    if [ -e "/home/ricardo/Escritorio/practica1/practica1-so/$1" ]; then
        return 0
    else
        echo "El archivo $1 no existe" 
        return 1
    fi
}

# COMANDOS PARA ASIGNAR Y REMOVER PERMISOS: LECTURA, EJECUCION
#							ASIGNA
# chmod +r archivo.txt 				-- lectura
# chmod +x archivo.txt 				-- ejecucion
# chmod +rx archivo.txt  			-- asigna ambos permisos

#							REMUEVE
# chmod -r archivo.txt  			-- lectura
# chmod -x archivo.txt				-- ejecucion
# chmod -rx archivo.txt	 			-- remueve ambos permisos


####################################################################


####################################################################
#                          EJERCICIO 4
# Completa el siguiente codigo para verificar el contenido de todas
# las variables de entorno, tip usa env para conocer esas variables
function ejercicio4(){
	env=($(env | cut -d= -f1))
	
	for varENV in "${env[@]}"; do
		value=$(printenv "$varENV")

		if [ -z "$value" ] || [ "$value" = "(none)" ]; then
			echo "la variable de entorno $varENV no tiene ningun valor" 
		else
			echo "$varENV = $value"
		fi
	done
}

####################################################################



####################################################################
#                          EJERCICIO 5
####################################################################



####################################################################
#                          EJERCICIO 6

# Que lea nombres de archivos de un archivo de texto y los copie a
# otro directorio. El usuario introduce el nombre del archivo
# y el nombre del directorio destino.
function ejercicio6(){
	read -p "Digite el nombre del archivo: " nombreArchivo
	read -p "Digite el nombre del directorio destino: " nomDirectorio

	if [ ! -f "$1" ]; then
		echo "El archivo $1 no existe."
		return 0
	fi

	if [ ! -d "$2" ]; then
		echo "El directorio destino $2 no existe."
		return 0
	fi

	while IFS= read -r nombre_archivo; do
		if [ -f "$nombre_archivo" ]; then
			cp "$nombre_archivo" "$2/"
			echo "Archivo '$nombre_archivo' copiado a '$2/'."
		else
			echo "El archivo '$nombre_archivo' no existe."
		fi
	done < "$1"
	
}


####################################################################

#####################################################################
#####################################################################
#                          MENU
bucle=1
while [ $bucle -eq 1 ]; do
	echo -en "¿Qué ejercicio te gustaría ejecutar? (digite el número).\n 
		1.- Imprimir las últimas 15 líneas del sistema.\n
		2.- Expresiones matematicas en shellscript.\n 
		3.- Expresiones condicionales para validar 3 archivos.\n 
		4.- Visualizar contenido de las variables de entorno.\n 
		5.- Validar argumentos de ejecución del shellscript.\n 
		6.- Copiar ficheros escritos en un .txt a otro directorio.\n 
		7.- SALIR.\n
		Opción: "
	read opc

	case "$opc" in 
		1)
			echo "EJERCICIO 1"
			echo -e "\n"
			echo -e "\n"
		;;

		2)
	        echo "EJERCICIO 2"
			echo -e "\n"
			echo -e "\n"
		;;

		3)
			echo "EJERCICIO 3"
			
			# VALIDACION DE ARCHIVOS
			if [ $# -ge 3 ]; then 
					if existe "$1"; then
						# PERMISO DE LECTURA
						tienePermisoLectura "$1"
					else
						echo "El archivo $1 no existe..."
					fi

					echo -e "\n"

					if existe "$2"; then
						# EXISTE Y TIENE PERMISOS DE EJECUCION
						echo "El archivo $2 existe..."
						tienePermisoEjecucion "$2"
					else
						echo "El archivo $2 no existe..."
					fi

					echo -e "\n"

					if existe "$3"; then
						# OBTENER DUENO ARCHIVO
						obtenerDuenioArchivo "$3"
					else
						echo "El archivo $3 no existe..."
					fi

					echo -e "\n"

					if existe "$1" && existe "$2" && existe "$3"; then
						# ARCHIVO MAS VIEJO
						archivoMasAntiguo "$1" "$2" "$3"
					fi
			else
				echo "Debes proporcionar el nombre de tres 
				archivos al compilar el programa"
			fi	


			echo -e "\n"
			echo -e "\n"
		;;

		4)
			echo "EJERCICIO 4"
			ejercicio4
			echo -e "\n"
		;;

		5)
			
			echo "EJERCICIO 5"
			echo -e "\n"
			echo -e "\n"
		;;

		6)
			echo "EJERCICIO 6"
			echo -e "\n"
			echo -e "\n"
		;;

		7)
			echo -e "\nFIN DEL PROGRAMA\n"
			bucle=0
		;;

		*)
			echo -e "\nNO EXISTE LA OPCION TECLEADA"
			echo -e "\n"
			echo -e "\n"
		esac
done
