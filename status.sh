#!/bin/bash

echo "🛰️  STATUT DU COCKPIT GalaXlytique™"

# Lister les fichiers blueprint détectés
echo ""
echo "📦 Fichiers blueprint détectés :"
for file in blueprints/*.json; do
    echo "   - $(basename "$file")"
done

echo ""
echo "📁 Dossier blueprints : OK ✅"
echo ""

# Check existence des scripts clés
[[ -f blueprints/import-blueprint-make.sh ]] && echo "🛠️ Script import-blueprint-make.sh : PRÊT ✅" || echo "❌ Script import-blueprint-make.sh manquant"
[[ -f blueprints/import-all-blueprints.sh ]] && echo "🛠️ Script import-all-blueprints.sh : PRÊT ✅" || echo "❌ Script import-all-blueprints.sh manquant"

echo ""
echo "⚙️  Prochaine étape :"
echo "👉 Tape : ./blueprints/import-blueprint-make.sh"
echo "ou bien : ./blueprints/import-all-blueprints.sh"
echo ""
echo "🚀 Ensuite : Va sur https://www.make.com/scenarios/import et fais ⌘+V pour importer ton scénario."
echo ""
echo "✨ Que la Force Pirate soit avec toi, Capitaine Monkey D. Oly™"
