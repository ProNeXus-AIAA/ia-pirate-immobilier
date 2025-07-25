#!/bin/bash
# ================================================================
# 🌌 ProNeXus™ GALAXLYTIQUE - Installation Diagnostic IA Make
# ================================================================
# Script d'import automatique du scénario Make via API
# Version: 1.0.0
# Date: Janvier 2025
# ================================================================

set -euo pipefail

# ========== COULEURS GALAXLYTIQUE™ ==========
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ========== CONFIGURATION ==========
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BLUEPRINT_FILE="${SCRIPT_DIR}/blueprints/diagnostic_make.json"
MAKE_API_URL="https://eu2.make.com/api/v2"
LOG_FILE="${SCRIPT_DIR}/install_diagnostic_ia.log"

# ========== BANNER GALAXLYTIQUE™ ==========
print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                                                               ║"
    echo "║     🌌 ${BOLD}ProNeXus™ GALAXLYTIQUE${NC}${CYAN} - Make Installer 🌌          ║"
    echo "║                                                               ║"
    echo "║     ${MAGENTA}Architecte d'Infrastructures IA & Automatisation${CYAN}        ║"
    echo "║                                                               ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
}

# ========== FONCTIONS UTILITAIRES ==========
log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] ${message}" >> "${LOG_FILE}"
    echo -e "${message}"
}

error() {
    log "${RED}❌ ERREUR: $1${NC}"
    exit 1
}

success() {
    log "${GREEN}✅ $1${NC}"
}

info() {
    log "${CYAN}ℹ️  $1${NC}"
}

warning() {
    log "${YELLOW}⚠️  $1${NC}"
}

# ========== VALIDATION DES PRÉREQUIS ==========
check_prerequisites() {
    info "Vérification des prérequis..."
    
    # Vérifier les variables d'environnement
    if [[ -z "${MAKE_API_KEY:-}" ]]; then
        error "Variable MAKE_API_KEY non définie. Exportez-la avec: export MAKE_API_KEY='votre-clé'"
    fi
    
    if [[ -z "${MAKE_ORG_ID:-}" ]]; then
        error "Variable MAKE_ORG_ID non définie. Exportez-la avec: export MAKE_ORG_ID='votre-org-id'"
    fi
    
    # Vérifier la présence du fichier blueprint
    if [[ ! -f "${BLUEPRINT_FILE}" ]]; then
        error "Fichier blueprint introuvable: ${BLUEPRINT_FILE}"
    fi
    
    # Vérifier les dépendances
    command -v curl >/dev/null 2>&1 || error "curl n'est pas installé"
    command -v jq >/dev/null 2>&1 || error "jq n'est pas installé"
    
    success "Tous les prérequis sont satisfaits"
}

# ========== VALIDATION DU BLUEPRINT ==========
validate_blueprint() {
    info "Validation du blueprint JSON..."
    
    if ! jq empty "${BLUEPRINT_FILE}" 2>/dev/null; then
        error "Le fichier blueprint n'est pas un JSON valide"
    fi
    
    # Vérifier la structure requise
    local name=$(jq -r '.name // empty' "${BLUEPRINT_FILE}")
    if [[ -z "${name}" ]]; then
        error "Le blueprint doit contenir un champ 'name'"
    fi
    
    success "Blueprint validé: ${BOLD}${name}${NC}"
}

# ========== CRÉATION DU SCÉNARIO ==========
create_scenario() {
    info "Création du scénario dans Make..."
    
    # Préparer le payload
    local blueprint_content=$(cat "${BLUEPRINT_FILE}")
    local payload=$(jq -n \
        --arg name "ProNeXus™ - Diagnostic IA Immobilier [Import $(date +%Y%m%d-%H%M%S)]" \
        --argjson blueprint "${blueprint_content}" \
        '{
            name: $name,
            blueprint: $blueprint,
            teamId: env.MAKE_ORG_ID,
            scheduling: {
                interval: 900,
                type: "interval"
            }
        }')
    
    # Appel API pour créer le scénario
    local response=$(curl -s -X POST \
        -H "Authorization: Token ${MAKE_API_KEY}" \
        -H "Content-Type: application/json" \
        -d "${payload}" \
        "${MAKE_API_URL}/scenarios" \
        2>&1) || error "Échec de l'appel API"
    
    # Vérifier la réponse
    local scenario_id=$(echo "${response}" | jq -r '.id // empty')
    local error_message=$(echo "${response}" | jq -r '.message // empty')
    
    if [[ -n "${error_message}" ]] && [[ "${error_message}" != "null" ]]; then
        error "Erreur Make API: ${error_message}"
    fi
    
    if [[ -z "${scenario_id}" ]]; then
        error "Impossible de récupérer l'ID du scénario. Réponse: ${response}"
    fi
    
    success "Scénario créé avec succès! ID: ${BOLD}${scenario_id}${NC}"
    echo "${scenario_id}" > "${SCRIPT_DIR}/.scenario_id"
    
    return 0
}

# ========== CONFIGURATION POST-INSTALLATION ==========
configure_scenario() {
    local scenario_id="$1"
    info "Configuration du scénario..."
    
    # Activer le scénario
    local activate_response=$(curl -s -X PATCH \
        -H "Authorization: Token ${MAKE_API_KEY}" \
        -H "Content-Type: application/json" \
        -d '{"scheduling": {"state": "active"}}' \
        "${MAKE_API_URL}/scenarios/${scenario_id}" \
        2>&1)
    
    if [[ $? -eq 0 ]]; then
        success "Scénario activé"
    else
        warning "Impossible d'activer automatiquement le scénario"
    fi
}

# ========== AFFICHAGE DES INSTRUCTIONS ==========
display_instructions() {
    local scenario_id="$1"
    
    echo -e "\n${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                   🎉 INSTALLATION RÉUSSIE! 🎉                 ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${BOLD}📋 Prochaines étapes:${NC}\n"
    
    echo -e "1. ${YELLOW}Accédez au scénario:${NC}"
    echo -e "   ${CYAN}https://eu2.make.com/scenarios/${scenario_id}/edit${NC}\n"
    
    echo -e "2. ${YELLOW}Configurez les connexions:${NC}"
    echo -e "   • OpenAI API (GPT-4)"
    echo -e "   • Airtable (Base: appvMCqxCmYXcxvYA)"
    echo -e "   • WhatsApp Business API"
    echo -e "   • Email SMTP/SendinBlue"
    echo -e "   • Slack (optionnel)\n"
    
    echo -e "3. ${YELLOW}Testez le webhook:${NC}"
    echo -e "   ${CYAN}curl -X POST https://hook.eu2.make.com/[VOTRE_WEBHOOK_ID] \\"
    echo -e "        -H 'Content-Type: application/json' \\"
    echo -e "        -d @test/payload_test.json${NC}\n"
    
    echo -e "4. ${YELLOW}Vérifiez les logs:${NC}"
    echo -e "   ${CYAN}tail -f ${LOG_FILE}${NC}\n"
    
    echo -e "${GREEN}🚀 Votre infrastructure IA est prête à transformer l'immobilier!${NC}\n"
}

# ========== FONCTION PRINCIPALE ==========
main() {
    # Initialiser le log
    echo "========== Installation démarrée: $(date) ==========" > "${LOG_FILE}"
    
    # Afficher le banner
    print_banner
    
    # Étapes d'installation
    check_prerequisites
    validate_blueprint
    
    # Créer le scénario
    if create_scenario; then
        local scenario_id=$(cat "${SCRIPT_DIR}/.scenario_id")
        configure_scenario "${scenario_id}"
        display_instructions "${scenario_id}"
        
        # Sauvegarder les infos
        echo -e "\n${CYAN}📁 Informations sauvegardées dans:${NC}"
        echo -e "   • ID du scénario: ${SCRIPT_DIR}/.scenario_id"
        echo -e "   • Logs complets: ${LOG_FILE}\n"
    else
        error "L'installation a échoué. Consultez ${LOG_FILE} pour plus de détails."
    fi
    
    echo "========== Installation terminée: $(date) ==========" >> "${LOG_FILE}"
}

# ========== GESTION DES SIGNAUX ==========
trap 'error "Installation interrompue par l'utilisateur"' INT TERM

# ========== POINT D'ENTRÉE ==========
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

# ================================================================
# 🌌 Que la force GalaXLytique™ soit avec vous!
# ================================================================