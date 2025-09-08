#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Uso: $0 <padron> <directorio>"
  exit 1
fi

PADRON=$1
DIR=$2

TIPO=$(( ($PADRON % 18) + 1 ))
MIN_ESTADISTICA=$(( ($PADRON % 100) + 350 ))

mkdir -p "$DIR"
RESULTADO="$DIR/resultado.txt"
> "$RESULTADO"

# Sumar estadísticas por pokemon_id
declare -A STATS
while IFS=',' read -r pokemon_id stat_id base_stat effort; do
  if [ "$pokemon_id" != "pokemon_id" ]; then
    STATS["$pokemon_id"]=$(( ${STATS["$pokemon_id"]:-0} + base_stat ))
  fi
done < ./data/pokemon_stats.csv

# Obtener nombres por pokemon_id
declare -A NAMES
while IFS=',' read -r id identifier species_id height weight base_experience order is_default; do
  if [ "$id" != "id" ]; then
    NAMES["$id"]="$identifier"
  fi
done < ./data/pokemon.csv

# Filtrar por tipo y estadística mínima
while IFS=',' read -r pokemon_id type_id slot; do
  if [ "$pokemon_id" != "pokemon_id" ] && [ "$type_id" -eq "$TIPO" ]; then
    if [ "${STATS[$pokemon_id]:-0}" -ge "$MIN_ESTADISTICA" ]; then
      name="${NAMES[$pokemon_id]}"
      if ! grep -qx "$name" "$RESULTADO"; then
        echo "$name" >> "$RESULTADO"
      fi
    fi
  fi
done < ./data/pokemon_types.csv

echo "Archivo generado en $RESULTADO"