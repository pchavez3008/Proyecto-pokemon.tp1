#!/usr/bin/env bash

if [ $# -ne 2 ]; then
  echo "Uso: $0 <padron> <directorio>"
  exit 1
fi

PADRON="$1"
DIR="$2"

TIPO=$(( ($PADRON % 18) + 1 ))
MIN_ESTADISTICA=$(( ($PADRON % 100) + 350 ))

mkdir -p "$DIR"
RESULTADO="$DIR/resultado.txt"
> "$RESULTADO"

POKEMON_STATS=$(find . -type f -name "pokemon_stats.csv" | head -n1)
POKEMON_TYPES=$(find . -type f -name "pokemon_types.csv" | head -n1)
POKEMON_CSV=$(find . -type f -name "pokemon.csv" | head -n1)

cut -d',' -f1,2 "$POKEMON_TYPES" | tail -n +2 | grep ",$TIPO$" | cut -d',' -f1 | sort -u | while read pokemon_id; do
  total_stat=0
  # Sumar las estadísticas de ese pokemon_id sin bc
  for stat in $(grep "^$pokemon_id," "$POKEMON_STATS" | cut -d',' -f3); do
    total_stat=$((total_stat + stat))
  done
  if [ "$total_stat" -ge "$MIN_ESTADISTICA" ]; then
    nombre=$(grep "^$pokemon_id," "$POKEMON_CSV" | cut -d',' -f2)
    echo "$nombre" >> "$RESULTADO"
  fi
done

echo "Archivo generado en $RESULTADO"