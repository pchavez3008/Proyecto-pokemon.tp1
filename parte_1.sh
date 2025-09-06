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

awk -F',' -v tipo="$TIPO" -v min_stat="$MIN_ESTADISTICA" '
  BEGIN {
    # Leer nombres
    while ((getline line < "./data/pokemon.csv") > 0) {
      if (NR == 1) continue
      split(line, a, ",")
      name[a[1]] = a[2]
    }
    # Sumar estadísticas
    while ((getline line < "./data/pokemon_stats.csv") > 0) {
      if (FNR == 1) continue
      split(line, a, ",")
      stat[a[1]] += a[3]
    }
  }
  FNR > 1 {
    pid = $1
    t = $2
    if (t == tipo && stat[pid] >= min_stat && !(pid in printed)) {
      print name[pid]
      printed[pid]=1
    }
  }
' ./data/pokemon_types.csv > "$DIR/resultado.txt"

echo "Archivo generado en $DIR/resultado.txt"