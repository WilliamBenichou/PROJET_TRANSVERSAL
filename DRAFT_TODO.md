# GENERAL
	Création d'un .ova pour chaque VM à partager
# RESEAU
	Configurer tout le réseau
	Ajout des ACL
	Lien externe (communication VM / GNS3)
	Connexion à internet via module NAT
# IOT
	Communication Sensors -> Data collector
	Définition d'un protocole léger (absence des non-incendies)
	Collaboration python/micro-controller
	Mécanisme de switch mode réel/simu

# DEV Java
## Simulateur
	UI de gestion
	Paramétrable (proba incendies, taille map, etc...)
	Optionnel: Gestion des conditions (météo, etc...)
	Le pyromane, peut-il cramer...
	Envoi vers le serveur les changements d'état
	Met à jour la BD simulation
	Gestion de l'évolution de l'intensité en fonction de la pos des camions
## Emergency Manager
	* UI de gestion
	* Configurable(nb Camions, vitesse camions, type des camions)
	* Gère le mouvement des camions
	* Affectation des camions / priorité des feux
	* Met à jour la BD 


# VM
	* VM Datacenter & WEB
		** Serveur DHCP
		** Serveurs WEB (lamp ?) - 2
		** Bases de données
		** Application Simulator
		** Application EmergencyManager
	* VM Firemans
		** Firefox
		
# WEB
	* Protocole de communication client serveur
	* CLIENT
		** Vue map des feux / camions
		** Statistiques (vitesse de réaction, etc...)
		** interface Paramétrage du simulateur à distance
		** interface Paramétrage de l'emergency manager à distance
		** trajet des camions

	* SERVER
		** Recherche de chemin
		** MAJ des DB
		** Communication avec les clients
		** Mise à jour settings clients
		** Communication python micro-controleur



