#!/bin/bash

# Este script se encarga de combinar la funcionalidad de parte_1.sh y parte_2.sh

# El padrón que se usará para filtrar Pokemones
PADRON="$1gi"
# El nombre del directorio donde se guardará el resultado de la Parte 1
DIRECTORIO="directorio_resultados"

echo "=== Ejecutando Parte 1: Filtrando Pokemones ==="
# Ejecuta el script de la Parte 1 con el padrón y el directorio.
# Esto creará 'resultado/resultado.txt'
./parte_1.sh $PADRON $DIRECTORIO

echo "=== Ejecutando Parte 2: Mostrando información ==="
# Ejecuta el script de la Parte 2, pasando el archivo 'resultado.txt' como entrada
# y redirigiendo la salida a 'output.txt'
./parte_2.sh < "$DIRECTORIO/resultado.txt" > "output.txt"

echo "=== Proceso finalizado ==="
echo "La información de los Pokemones filtrados se encuentra en 'output.txt'."