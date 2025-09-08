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

declare -A NAMES
while IFS=',' read -r id identifier rest; do
  NAMES["$id"]="$identifier"
done < <(tail -n +2 ./data/pokemon.csv)

declare -A STATS
while IFS=',' read -r pokemon_id stat_id base_value; do
  (( STATS["$pokemon_id"] += base_value ))
done < <(tail -n +2 ./data/pokemon_stats.csv)

RESULT="$DIR/resultado.txt"
> "$RESULT"

while IFS=',' read -r pokemon_id type_id; do
  if [[ "$type_id" -eq "$TIPO" ]]; then
    if [[ ${STATS[$pokemon_id]} -ge $MIN_ESTADISTICA ]]; then
      if ! grep -qx "${NAMES[$pokemon_id]}" "$RESULT"; then
        echo "${NAMES[$pokemon_id]}" >> "$RESULT"
      fi
    fi
  fi
done < <(tail -n +2 ./data/pokemon_types.csv)

echo "Archivo generado en $RESULT"
