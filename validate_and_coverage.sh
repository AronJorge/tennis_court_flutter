#!/bin/bash

set -e

echo "🚀 Iniciando análisis de código..."
flutter analyze

echo "Análisis de código completado exitosamente."

echo "🚀 Ejecutando pruebas con cobertura..."
flutter test --coverage

echo "Pruebas ejecutadas exitosamente."

if ! command -v genhtml &> /dev/null
then
    echo "⚠️  'genhtml' no está instalado. Procediendo a instalarlo..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install lcov
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install lcov
    else
        echo "❌ Sistema operativo no soportado para instalación automática."
        exit 1
    fi
fi

echo "🚀 Generando reporte HTML de cobertura..."
genhtml coverage/lcov.info -o coverage/html

echo "Reporte HTML generado en coverage/html/index.html."

if [[ "$OSTYPE" == "darwin"* ]]; then
    open coverage/html/index.html
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open coverage/html/index.html
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    explorer.exe coverage/html/index.html
else
    echo "No se pudo abrir automáticamente. Abre manualmente: coverage/html/index.html"
fi
