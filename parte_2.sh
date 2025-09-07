#!/bin/bash

while read nombre; do
  # Obtener id, altura y peso
  info=$(awk -F',' -v n="$nombre" 'NR>1 && tolower($2)==tolower(n) {print $1, $4*10, $5/10}' ./data/pokemon.csv)
  if [ -z "$info" ]; then
    echo "Pokemon no encontrado: $nombre"
    echo ""
    continue
  fi
  id=$(echo $info | cut -d' ' -f1)
  altura=$(echo $info | cut -d' ' -f2)
  peso=$(echo $info | cut -d' ' -f3)

  echo "Pokemon: $nombre"
  echo "Altura: $altura centímetros"
  echo "Peso: $peso kilos"
  echo ""
  echo "Habilidades:"

  habilidades=$(awk -F',' -v pid="$id" 'NR>1 && $1==pid {print $2}' ./data/pokemon_abilities.csv)
  if [ -z "$habilidades" ]; then
    echo "* Sin habilidades registradas"
  else
    while read abid; do
      habilidad=$(awk -F',' -v aid="$abid" 'NR>1 && $1==aid && $2==7 {print $3}' "./data/ability_names (1).csv")
      if [ -n "$habilidad" ]; then
        echo "* $habilidad"
      fi
    done <<< "$habilidades"
  fi
  echo ""
done