#!/bin/bash

while read nombre; do
  # Obtener id, altura y peso
  info=$(awk -F',' -v n="$nombre" 'NR>1 && $2==n {print $1, $4*10, $5/10}' ./data/pokemon.csv)
  [ -z "$info" ] && continue
  id=$(echo $info | cut -d' ' -f1)
  altura=$(echo $info | cut -d' ' -f2)
  peso=$(echo $info | cut -d' ' -f3)

  echo "Pokemon: $nombre"
  echo "Altura: $altura centímetros"
  echo "Peso: $peso kilos"
  echo ""
  echo "Habilidades:"

  # Obtener habilidades en español (local_language_id == 7)
  awk -F',' -v pid="$id" 'NR>1 && $1==pid {print $2}' ./data/pokemon_abilities.csv | while read abid; do
    habilidad=$(awk -F',' -v aid="$abid" 'NR>1 && $1==aid && $2==7 {print $3}' "./data/ability_names (1).csv")
    [ -n "$habilidad" ] && echo "* $habilidad"
  done
  echo ""
done