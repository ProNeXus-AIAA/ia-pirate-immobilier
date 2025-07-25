#!/bin/bash

echo "💻 Import Pirate IA™ – ProNexus GalaXlytique™"
echo "📦 Fichiers détectés dans /blueprints :"
ls blueprints/

echo ""
read -p "🧬 Tape le nom exact du fichier blueprint à importer (ex: make_scenario_diagnostic.json) : " FILE

FILEPATH="blueprints/$FILE"

if [ ! -f "$FILEPATH" ]; then
  echo "❌ Le fichier $FILEPATH est introuvable. Vérifie le nom et réessaie."
  exit 1
fi

echo "📋 Copie du contenu JSON dans le presse-papiers..."
cat "$FILEPATH" | pbcopy

echo "🌐 Ouverture de Make pour import manuel..."
open "https://www.make.com/scenarios/import"

echo "✅ Le contenu JSON est prêt dans ton presse-papiers. Fais un ⌘+V dans la page Make !"
echo "🏴‍☠️ À l'abordage des scénarios IA, Capitaine Monkey D. Oly™ 🚀"

