#!/bin/bash

flutter test --coverage

if [ -f coverage/lcov.info ]; then
  total_lines=$(grep -o "DA:[0-9]*,[0-9]*" coverage/lcov.info | wc -l)
  covered_lines=$(grep -o "DA:[0-9]*,1" coverage/lcov.info | wc -l)

  if [ "$total_lines" -eq 0 ]; then
    echo "No hay líneas para calcular cobertura."
  else
    coverage_percentage=$(echo "scale=2; ($covered_lines/$total_lines)*100" | bc)
    echo ""
    echo "Cobertura total: $coverage_percentage%"
    echo ""
  fi
else
  echo "Archivo coverage/lcov.info no encontrado. Asegúrate de correr primero 'flutter test --coverage'"
fi
