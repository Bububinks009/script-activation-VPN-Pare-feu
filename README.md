# script-activation-VPN-Pare-feu
Sécuriser la connexion Internet en établissant un tunnel VPN et en appliquant des règles de pare-feu pour bloquer tout trafic non désiré.

|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|      
|     Voici un bilan complet du script `vpn_tor_menu.sh`, avec ce qu’il fait, comment l’utiliser et à quoi s’attendre pour chaque option.
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                             1. RÔLE DU SCRIPT
|
|        Le script te permet de contrôler facilement trois couches de protection réseau sur Kali Linux :
|
|         1. RiseupVPN → change ton IP et chiffre tout ton trafic vers un serveur VPN.
|         2. Tor → redirige ton trafic via le réseau Tor pour anonymiser ta navigation.
|         3. Proxychains → force une application à passer par Tor (ou un autre proxy).
|
|        L’objectif est de pouvoir activer :
|
|             - VPN seul
|             - Tor seul
|             - VPN + Tor combinés (double anonymisation)
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                            2. FONCTIONNEMENT INTERNE
|
|              - Vérifie les droits root (obligatoire pour lancer les services).
|              - Installe automatiquement `riseup-vpn`, `tor`, `proxychains`, `curl` si manquants.
|              - Configure Proxychains pour utiliser Tor (`socks5 127.0.0.1 9050`).
|              - Affiche l’IP publique après chaque configuration, pour confirmer que le routage fonctionne.
|              - Propose un menu interactif pour démarrer ou arrêter les services.
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                            3. UTILISATION ÉTAPE PAR ÉTAPE
|
|              1. Sauvegarde le script sous le nom `vpn_tor_menu.sh`.
|              2. Rends-le exécutable :
|
|                     '' chmod +x vpn_tor_menu.sh ''
|   
|              3. Lance-le :
|
|                     '' sudo ./vpn_tor_menu.sh ''
|   
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                            4. MENU ET OPTIONS
|
|                Quand le script démarre, tu vois :
|
|
|                  === Menu VPN / Tor / Proxychains ===
|
|            1) Activer RiseupVPN
|            2) Activer Tor + Proxychains
|            3) Activer RiseupVPN + Tor + Proxychains
|            4) Arrêter tous les services
|            5) Quitter
|            Choix :
|
|
|                       📌 Option 1 : VPN seul
|
|	 Connexion → Serveur VPN → Internet.
|	 Masque ton IP mais ton fournisseur VPN connaît ton activité (il chiffre ton trafic).
|	 Vitesse : Rapide.
|	 Utilisation : Navigation classique, téléchargement sécurisé.
|
|                      📌 Option 2 : Tor seul
|
|	 Connexion → Tor → Internet.
|	 Fort anonymat mais vitesse réduite.
|	 Vitesse : Lente.
|	 Utilisation : Accéder au dark web, anonymat maximal, tests de sécurité.
|
|                       📌 Option 3 : VPN + Tor
|
|        Connexion → Serveur VPN → Tor → Internet.
|        Double anonymat :
|
|        VPN voit que tu utilises Tor, mais pas ton contenu.
|        Tor voit l’IP du VPN, pas la tienne.
|
|        Vitesse : Très lente.
|        Utilisation : Activités ultra-sensibles, tests avancés, éviter la corrélation IP.
|
|                      📌 Option 4 : Arrêt
|
|                  Coupe VPN et Tor.
|
|                    📌 Option 5 : Quitter
|
|              Ferme le script sans arrêter les services.
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                           5. COMMANDES À CONNAÎTRE APRÈS ACTIVATION
|
|                   - Tester ton IP :
|
|                        '' curl ifconfig.me ''
|                                  ou
|                        '' proxychains curl ifconfig.me ''
|  
|                  - Lancer un navigateur via Tor :
|
|                         '' proxychains firefox ''
|  
|                  - Lancer un scan via Tor :
|
|                         '' proxychains nmap example.com ''
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|                                  
|                                  6. POINTS À RETENIR
|                                  
|
|               - VPN seul : Rapide, IP masquée, pas totalement anonyme.
|               
|               - Tor seul : Lent, anonymat fort, pas de chiffrement complet si le site n’est pas HTTPS.
|               
|               - VPN + Tor : Très lent, anonymat maximal, utile pour éviter la corrélation IP.
|               
|                             ⚠ Proxychains n’affecte pas tout ton système → seulement les programmes que tu lances avec `proxychains`.
|                              
|                             ⚠ VPN affecte tout le trafic** → tout passe par le serveur VPN.
|
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|
|
