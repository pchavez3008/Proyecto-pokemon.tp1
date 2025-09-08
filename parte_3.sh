#!/bin/bash

# filepath: c:\Users\lopez\OneDrive\Desktop\pokemon\parte_3.sh

PADRON="$1"
DIRECTORIO="directorio_resultados"

echo "=== Ejecutando Parte 1: Filtrando Pokemones ==="
./parte_1.sh $PADRON $DIRECTORIO

echo "=== Ejecutando Parte 2: Mostrando información ==="
./parte_2.sh < $DIRECTORIO/resultado.txt > output.txt

echo "=== Proceso terminado ==="
echo "La información de los Pokemones filtrados se encuentra en 'output.txt'."
