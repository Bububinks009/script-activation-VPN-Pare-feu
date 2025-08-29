#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Vérification droits root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Ce script doit être lancé en root (sudo)${RESET}"
    exit 1
fi

# Installation si nécessaire
install_tools() {
    echo -e "${YELLOW}Installation des paquets nécessaires...${RESET}"
    apt update && apt install -y riseup-vpn tor proxychains curl
}

# Lancement RiseupVPN
start_vpn() {
    echo -e "${YELLOW}Lancement de RiseupVPN...${RESET}"
    riseup-vpn &
    sleep 10
    echo -e "${GREEN}IP via VPN : $(curl -s ifconfig.me)${RESET}"
}

# Arrêt RiseupVPN
stop_vpn() {
    echo -e "${YELLOW}Arrêt de RiseupVPN...${RESET}"
    pkill -f riseup-vpn
}

# Lancement Tor + Proxychains
start_tor() {
    echo -e "${YELLOW}Démarrage du service Tor...${RESET}"
    systemctl start tor
    systemctl enable tor
    sed -i 's/^socks4.*/socks5 127.0.0.1 9050/' /etc/proxychains.conf
    sleep 5
    echo -e "${GREEN}IP via Tor : $(proxychains -q curl -s ifconfig.me)${RESET}"
}

# Arrêt Tor
stop_tor() {
    echo -e "${YELLOW}Arrêt du service Tor...${RESET}"
    systemctl stop tor
}

# Lancer VPN + Tor
start_vpn_tor() {
    start_vpn
    start_tor
    echo -e "${GREEN}IP via VPN + Tor : $(proxychains -q curl -s ifconfig.me)${RESET}"
}

# Arrêt complet
stop_all() {
    stop_vpn
    stop_tor
    echo -e "${RED}Tous les services sont arrêtés.${RESET}"
}

# Menu
while true; do
    echo -e "\n${GREEN}=== Menu VPN / Tor / Proxychains ===${RESET}"
    echo "1) Activer RiseupVPN"
    echo "2) Activer Tor + Proxychains"
    echo "3) Activer RiseupVPN + Tor + Proxychains"
    echo "4) Arrêter tous les services"
    echo "5) Quitter"
    read -p "Choix : " choice

    case $choice in
        1) install_tools; start_vpn ;;
        2) install_tools; start_tor ;;
        3) install_tools; start_vpn_tor ;;
        4) stop_all ;;
        5) exit 0 ;;
        *) echo -e "${RED}Choix invalide.${RESET}" ;;
    esac
done
