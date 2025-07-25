#!/bin/bash

echo "🚀 DÉPLOIEMENT TVX™ EN COURS... (Landing + Vitrine) 🌌"

# === Déploiement landing-ia ===
echo "🛸 Déploiement de la landing IA..."
cd ~/Desktop/Cockpit\ GalaXlytique™/landing-ia || {
  echo "❌ Dossier landing-ia introuvable."
  exit 1
}
vercel --prod --yes
vercel domains add ia.pronexus.fr

# === Déploiement site-vitrine ===
echo "🛸 Déploiement du site vitrine..."
cd ~/Desktop/Cockpit\ GalaXlytique™/site-vitrine || {
  echo "❌ Dossier site-vitrine introuvable."
  exit 1
}
vercel --prod --yes
vercel domains add www.pronexus.fr

echo "✅ TOUS LES DÉPLOIEMENTS TERMINÉS ! 🌐"
echo "🔗 https://ia.pronexus.fr (landing)"
echo "🔗 https://www.pronexus.fr (vitrine)"
echo "✨ TVA-X™ opérationnelle, le Multivers est en orbite."
