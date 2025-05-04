# 🎓 Gestion de Projets Étudiants

<p align="center">
  <img src="https://github.com/user-attachments/assets/82fae575-bda5-454a-8c53-1ea68a56de7e" alt="Logo de l'application" width="300">
</p>


---
## 📚 Sommaire  
- [📌 Contexte](#-contexte)  
- [❓ Problématique](#-problématique)  
- [🎯 Objectifs](#-objectifs)  
- [🧩 Diagramme de Classe](#-diagramme-de-classe)  
- [🗃️ Modèle Conceptuel de la Base](#-modèle-conceptuel-de-la-base-généré)  
- [⚙️ Exécution des Tests](#-exécution-des-tests-dans-la-console)  
- [🛠 Technologies](#-technologies)  
- [🏗️ Architecture](#-architecture)  

---

## 📌 Contexte

Ce projet est une application web développée en Java pour la gestion des projets académiques. Il permet :
- Aux **enseignants** d'encadrer des projets et d'affecter des étudiants
- Aux **étudiants** de consulter leurs projets attribués
- À l'**administration** de suivre les statistiques par encadrant

---

## ❓ Problématique

La gestion manuelle des projets étudiants présente plusieurs défis :
- Difficulté à suivre les affectations projet/étudiant
- Manque de visibilité sur la charge des encadrants
- Processus d'attribution chronophage
- Absence de statistiques centralisées

---

## 🎯 Objectifs

- Créer une plateforme centralisée pour :
  - 📋 Lister tous les projets disponibles
  - 👥 Affecter dynamiquement des étudiants (via AJAX)
  - 📊 Générer des statistiques par encadrant (Chart.js)
- Fournir aux étudiants :
  - 👀 Visualisation de leurs projets
  - 🔔 Notifications des deadlines

---

## 🧩 Diagramme de Classe
![image](https://github.com/user-attachments/assets/40e898b5-82e4-49f8-94c3-6de36cdaa9ee)

---
## 🗃️ Modèle conceptuel de la base généré

![La base de données ](https://github.com/user-attachments/assets/d2c8c9b1-82fa-4ef5-8f27-6fedffd7a28d)

---

## ⚙️ Exécution des tests dans la console

![La création des table](https://github.com/user-attachments/assets/8459d4d0-70b6-488b-92fa-54fa901ed51d)
![Ajout de clés étrangères ](https://github.com/user-attachments/assets/0192d4d5-b59a-4ac3-8e82-3baf3700083b)
![Insertion des données dans les table](https://github.com/user-attachments/assets/35ac66db-1b96-46fc-83ba-e3c4d19324f2)
![Selection des données dans les table](https://github.com/user-attachments/assets/ab5dc2e6-3e8b-4195-b431-4e90754afb55)
---

## 🛠 Technologies

### 🖥️ Côté client (Frontend) :
- **HTML5 / CSS3** – Pour la structure et le style des pages.
- **JavaScript** – Pour les interactions dynamiques et la logique côté client.
- **AJAX** – Permet des échanges asynchrones avec le serveur sans recharger la page (affectation en temps réel).
- **Chart.js** – Génération de graphiques interactifs pour les statistiques liées aux encadrants et projets.

### ⚙️ Côté serveur (Backend) :
- **Java Web** – Technologie principale pour la logique métier.
- **Hibernate** – Pour la gestion de la persistance des données de manière orientée objet.
- **JDBC** – Utilisé ponctuellement pour des requêtes spécifiques non prises en charge par l’ORM.

### 🗃️ Base de données :
- **MySQL** – Système relationnel pour la gestion des données (étudiants, enseignants, projets, affectations).

---
## 🏗️ Architecture 
![interaction avec l'utilisateur](https://github.com/user-attachments/assets/85aa5984-d888-42ab-b9f1-7d19b2f37fcc)
