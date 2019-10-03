#creation de la bd
CREATE DATABASE gmao;
use gmao;

#creation de la table utilisateur
CREATE TABLE utilisateur (code int primary key auto_increment, nom varchar(50) DEFAULT 'admin',
 password varchar(50) DEFAULT 'gmao123@');

#creation de la table personnel
CREATE TABLE personnel (code int  primary key auto_increment, nom varchar(40), sexe varchar(15),
   domaine varchar(30), grade varchar(30), statut_suppression int DEFAULT 1);

#creation de la table machine
CREATE TABLE machine(code int primary key auto_increment, nom varchar(50),
  anneeCreation int, confectionneuse varchar(50) default '', assembleuse varchar(50) default '',type varchar(25),
  statut_suppression int DEFAULT 1);

#CREATION DE LA TABLE SOUS_SYSTEME
CREATE TABLE sous_systeme(code int primary key auto_increment, nom varchar(40), categorie varchar(20), type varchar(25),
  statut_suppression int DEFAULT 1);

#creation de la table piece
CREATE TABLE piece(code int primary key auto_increment, statut varchar(20), nom varchar(40), ref varchar(40),
  ptCommande int, nbStocks int, localisation varchar(100), code_sous_systeme int, statut_suppression int DEFAULT 1,
  enCommande int, FOREIGN KEY(code_sous_systeme) REFERENCES sous_systeme(code));

#creation de la table machine_sous_systeme
CREATE TABLE machine_sous_systeme(code_machine int, code_sous_systeme int, statut_suppression int DEFAULT 1, PRIMARY KEY(code_machine, code_sous_systeme),
  FOREIGN KEY (code_machine) REFERENCES machine(code), FOREIGN KEY (code_sous_systeme) REFERENCES sous_systeme(code));

#creation de la table Intervention
CREATE TABLE intervention(code int primary key auto_increment, shift integer(1), date_intervention datetime, duree varchar(20), description_defaillance varchar(255),
  description_solution varchar(255), code_machine int, code_sous_systeme int,statut_suppression int DEFAULT 1, nature int, FOREIGN KEY(code_machine) REFERENCES machine(code),
  FOREIGN KEY(code_sous_systeme) REFERENCES sous_systeme(code));

#creation de la table Intervenant
CREATE TABLE intervenant(code_intervention int, code_intervenant int, statut_suppression int DEFAULT 1, PRIMARY KEY(code_intervention, code_intervenant),
  FOREIGN KEY(code_intervention) REFERENCES intervention(code), FOREIGN KEY(code_intervenant) REFERENCES personnel(code));

#creation de la table element_remplace
CREATE TABLE piece_remplace(code_intervention int, code_piece int, statut_suppression int DEFAULT 1, PRIMARY KEY(code_intervention, code_piece),
  FOREIGN KEY(code_intervention) REFERENCES intervention(code), FOREIGN KEY(code_piece) REFERENCES piece(code));

#creation de la table planning
CREATE TABLE planning(code int auto_increment, nom varchar(40), statut_actif boolean, statut_suppression int DEFAULT 1, PRIMARY KEY(code));

#creation de la table action
CREATE TABLE action(code int PRIMARY KEY auto_increment, nom varchar(25), code_planning int, description_tache varchar(255),
  frequence_remplacement int, niveau_maintenance int, code_machine int, code_sous_systeme int, statut_suppression int DEFAULT 1,
  FOREIGN KEY(code_machine) REFERENCES machine(code), FOREIGN KEY(code_sous_systeme) REFERENCES sous_systeme(code),
   FOREIGN KEY(code_planning) REFERENCES planning(code));

INSERT INTO utilisateur(nom, password) VALUES('admin','admin');
