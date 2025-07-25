#!/bin/bash

echo "🔐 Initialisation de la connexion Airtable pour Make..."

# 1. Création du fichier .env
echo "AIRTABLE_TOKEN=patRtbls4lyBt2VUZ.6f28a303bd97a4cbc7691f8e7899de07b3309f02e232f98adec0d295a6015315" > .env
echo "✅ Token enregistré dans .env"

# 2. Confirmation du dossier Make
if [ ! -d "make_scenarios" ]; then
  echo "❌ Dossier 'make_scenarios' introuvable."
  exit 1
fi

# 3. Ping Airtable
echo "📡 Test de connexion à Airtable..."
curl -s -H "Authorization: Bearer $(grep AIRTABLE_TOKEN .env | cut -d '=' -f2)" \
     https://api.airtable.com/v0/meta/bases \
     | grep '"bases"' > /dev/null

if [ $? -eq 0 ]; then
  echo "✅ Connexion Airtable OK."
else
  echo "❌ Erreur de connexion à Airtable. Vérifie ton token."
  exit 1
fi

# 4. Confirmation
echo "🚀 Connexion prête pour Make. Scénarios à importer avec ce token."
