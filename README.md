# Application-de-gestion-Hotel-Ville
Ce projet est une application web Java EE développée avec les technologies EJB, JSP, et WildFly, permettant la gestion des informations sur les hôtels et les villes. Il offre des fonctionnalités complètes de CRUD (Create, Read, Update, Delete) sur les hôtels et les villes, ainsi qu'une fonction de filtrage des hôtels par ville.

## Introduction

L'objectif de ce projet est de créer une plateforme de gestion centralisée pour les hôtels et les villes. Les utilisateurs peuvent ajouter, mettre à jour et supprimer des informations sur les hôtels et les villes, ainsi que filtrer les hôtels en fonction de leur emplacement géographique.

## Fonctionnalités

### Gestion des Villes

- **Ajout d'une Ville:**
  - Les utilisateurs peuvent ajouter une nouvelle ville en spécifiant son nom.

- **Modification d'une Ville:**
  - Les détails d'une ville existante peuvent être modifiés, y compris son nom.

- **Suppression d'une Ville:**
  - Les utilisateurs peuvent supprimer une ville existante.

 [screen-capture (9).webm](https://github.com/Samia-Kouame/Application-de-gestion-Hotel-Ville/assets/147660832/5bcee5e2-8bc7-441b-ab2d-81ee4995695c)


    

### Gestion des Hôtels

- **Ajout d'un Hôtel:**
  - Les utilisateurs peuvent ajouter un nouvel hôtel en fournissant des informations telles que le nom, l'adresse, le numéro de téléphone et la ville associée.

- **Modification d'un Hôtel:**
  - Les détails d'un hôtel existant peuvent être modifiés, y compris le nom, l'adresse, le numéro de téléphone et la ville associée.

- **Suppression d'un Hôtel:**
  - Les utilisateurs peuvent supprimer un hôtel existant.

- **Filtrage des Hôtels par Ville:**
  - Les utilisateurs peuvent filtrer la liste des hôtels par ville, ce qui affiche uniquement les hôtels situés dans la ville sélectionnée.

[screen-capture (11).webm](https://github.com/Samia-Kouame/Application-de-gestion-Hotel-Ville/assets/147660832/8377403a-0f2a-4085-9a51-5085c86372a4)


## Prérequis

- [Java Development Kit (JDK)]
- [WildFly]
- Serveur de base de données :MySql.

## Configuration

1. **Base de Données:**
   - Configurer les paramètres de la base de données dans le fichier `src/main/resources/META-INF/persistence.xml`.

2. **Serveur WildFly:**
   - Déployer l'application sur WildFly en suivant les étapes décrites dans la section "Déploiement".

## Déploiement sur WildFly

1. Démarrez WildFly.
2. Construisez et déployez l'application avec Maven
## Auteurs
KOUAME SAMYA
