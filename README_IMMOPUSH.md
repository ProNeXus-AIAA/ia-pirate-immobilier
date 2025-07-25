
# 📦 README_IMMOPUSH.md – ProNeXus™ | Infra GalaXLytique™ IMMOBOOST™

Bienvenue dans l’infrastructure complète pour automatiser la génération, qualification et conversion de leads immobiliers via IA. Ce cockpit a été optimisé pour un usage immédiat depuis le terminal SHEIKAHX™.

---

## 🚀 OBJECTIF DU SYSTÈME

Activer en 1 clic depuis le terminal SHEIKAHX™ :

- 3 scénarios Make prêts à importer
- 2 bases Airtable compatibles
- 2 prompts GPT
- 2 modèles emails
- 2 PDF attachables
- 1 système de log XP Pirate™

---

## 📂 STRUCTURE DES DOSSIERS

| Dossier | Contenu |
|--------|---------|
| `make_scenarios/` | Tous les `.json` des scénarios Make |
| `airtable_structures/` | Fichiers `.csv` pour Airtable (diagnostic + lead magnet) |
| `prompts/` | Prompts GPT au format `.txt` |
| `emails/` | Templates HTML pour email automatique |
| `docs/` | Fichiers PDF envoyés en pièce jointe |
| `logs/` | Suivi des actions & XP Pirate (`xp.log`) |

---

## ⚙️ COMMANDES TERMINAL

```bash
# Depuis le dossier Cockpit GalaXLytique™ :
chmod +x install_all_immo.sh
./install_all_immo.sh
```

Puis pour afficher le statut :
```bash
bash status.sh
```

---

## 🧠 INTEGRATION MAKE – Étapes

1. Crée un **scénario vide** dans [Make](https://www.make.com)
2. Clique sur `... > Import Blueprint`
3. Sélectionne un des fichiers depuis `make_scenarios/`
4. Configure :
   - Webhook : Make Webhook
   - Airtable : Connecte ta base et mappe les champs
   - Slack (optionnel), Email (SMTP ou SendGrid)
   - PDF : Téléverse les fichiers dans Make ou héberge les liens publics

---

## 🤖 INJECTION PROMPTS DANS GPT

> Fichiers dans `prompts/` à coller directement dans ton GPT Builder ou Playground.

---

## ✉️ EMAILS HTML

- Fichiers prêts dans `emails/`
- S’intègrent dans n’importe quel module Email Make ou SMTP externe

---

## 🧩 À FAIRE POUR COMPLÉTER

- Importer les scénarios dans Make
- Injecter les CSV dans Airtable
- Associer les modules (webhook, slack, email)
- Lancer les premiers tests leads
- Activer le suivi XP avec `logs/xp.log`

---

## 🏁 OBJECTIF FINAL

> Tout ce système doit fonctionner sans aucun clic manuel : 1 lead → diagnostic, scoring, email, Slack → conversion → XP Pirate™ auto.

---

👑 ProNeXus™ – Powered by SHEIKAHX™, GalaXly™ et l’armée IA-Pirate™.
