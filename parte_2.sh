#!/usr/bin/env bash

# Buscar los archivos en cualquier subdirectorio
POKEMON_CSV=$(find . -type f -name "pokemon.csv" | head -n1)
POKEMON_ABILITIES=$(find . -type f -name "pokemon_abilities.csv" | head -n1)
ABILITY_NAMES=$(find . -type f -name "ability_names*.csv" | head -n1)

while read nombre; do
  info=$(tail -n +2 "$POKEMON_CSV" | grep -i ",$nombre," | head -n 1)
  if [ -z "$info" ]; then
    echo "Error: Pokémon '$nombre' no encontrado."
    echo ""
    continue
  fi

  id=$(echo "$info" | cut -d',' -f1)
  altura=$(echo "$info" | cut -d',' -f4)
  peso=$(echo "$info" | cut -d',' -f5)

  altura=$((altura * 10))
  peso=$((peso / 10))

  echo "Pokemon: $nombre"
  echo "Altura: $altura centímetros"
  echo "Peso: $peso kilos"
  echo ""
  echo "Habilidades:"

  grep -E "^$id," "$POKEMON_ABILITIES" | cut -d',' -f2 | while read abid; do
    habilidad=$(grep -E "^$abid,7," "$ABILITY_NAMES" | cut -d',' -f3)
    [ -n "$habilidad" ] && echo "* $habilidad"
  done

  echo ""