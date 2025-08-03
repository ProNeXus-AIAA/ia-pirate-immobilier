#!/bin/bash

echo "🌀 Import IA Pirate X – ProNeXus™ GalaXlytique™"

for file in blueprints/*.json; do
  echo "🚀 Import de $file ..."
  cat "$file" | pbcopy
  open "https://www.make.com/scenarios/import"
  echo "✅ Fichier $file copié dans le presse-papier"
  read -p "⏳ Appuie sur Entrée pour passer au suivant..."
done

echo "🎉 Tous les scénarios ont été importés. À l'abordage !"
