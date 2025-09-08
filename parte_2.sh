#!/bin/bash

while read nombre; do
  info=$(tail -n +2 ./data/pokemon.csv | grep -i ",$nombre," | head -n 1)
  [ -z "$info" ] && continue

  id=$(echo "$info" | cut -d',' -f1)
  altura=$(echo "$info" | cut -d',' -f4)
  peso=$(echo "$info" | cut -d',' -f5)

  altura=$((altura * 10))
  peso=$(echo "scale=1; $peso/10" | bc)

  echo "Pokemon: $nombre"
  echo "Altura: $altura centímetros"
  echo "Peso: $peso kilos"
  echo ""
  echo "Habilidades:"

  grep -E "^$id," ./data/pokemon_abilities.csv | cut -d',' -f2 | while read abid; do
    habilidad=$(grep -E "^$abid,7," ./data/ability_names.csv | cut -d',' -f3)
    [ -n "$habilidad" ] && echo "* $habilidad"
  done

  echo ""
done
