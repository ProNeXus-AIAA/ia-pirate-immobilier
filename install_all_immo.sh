
#!/bin/bash

echo "🚀 Initialisation de l'installation GalaXLytique™ IMMOBOOST..."
echo "📁 Dossier actuel : $(pwd)"
echo ""

# Création des dossiers de travail
mkdir -p make_scenarios
mkdir -p airtable_structures
mkdir -p prompts
mkdir -p emails
mkdir -p docs
mkdir -p logs

echo "📦 Dossiers créés : make_scenarios, airtable_structures, prompts, emails, docs, logs"

# Déplacement des fichiers dans les bons dossiers
mv make_scenario_diagnostic.json make_scenarios/ 2>/dev/null
mv make_scenario_scoring.json make_scenarios/ 2>/dev/null
mv make_scenario_lead_magnet.json make_scenarios/ 2>/dev/null

mv csv-leads-ia.csv airtable_structures/airtable_structure_diagnostic.csv 2>/dev/null
mv csv-lead-magnet.csv airtable_structures/airtable_structure_lead_magnet.csv 2>/dev/null

mv prompt_gpt_diagnostic.txt prompts/ 2>/dev/null
mv prompt_gpt_scoring.txt prompts/ 2>/dev/null

mv email_template_diagnostic.html emails/ 2>/dev/null
mv email_template_lead_magnet.html emails/ 2>/dev/null

mv Guide_10_Automatisations_IA_Rentables_ProNeXus.pdf docs/ 2>/dev/null
mv Checklist_Audit_IA_5_Etapes_ProNeXus.pdf docs/ 2>/dev/null

touch logs/xp.log
echo "📝 Log XP initialisé dans logs/xp.log"

echo ""
echo "✅ Tous les fichiers ont été organisés avec succès."
echo "📂 Structure prête pour exécution via SHEIKAHX™ Terminal"
