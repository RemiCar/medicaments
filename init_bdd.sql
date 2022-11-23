-- Creation de la database si elle n'existe pas
CREATE DATABASE IF NOT EXISTS medicaments;

-- Creation d'un user
CREATE USER IF NOT EXISTS 'user_medicaments'@'localhost' IDENTIFIED BY '0000';
GRANT ALL PRIVILEGES ON medicaments.* TO 'user_medicaments'@'localhost';

-- Suppression des tables si elles existent
DROP TABLE IF EXISTS `CIS_COMPO_bdpm`;
DROP TABLE IF EXISTS `CIS_CPD_bdpm`;
DROP TABLE IF EXISTS `CIS_HAS_SMR`;
DROP TABLE IF EXISTS `CIS_HAS_ASMR`;
DROP TABLE IF EXISTS `CIS_GENER_bdpm`;
DROP TABLE IF EXISTS `CIS_InfoImportantes`;
DROP TABLE IF EXISTS `CIS_CIP_bdpm`;
DROP TABLE IF EXISTS `HAS_LiensPageCT_bdpm`;
DROP TABLE IF EXISTS `CIS_bdpm`;

-- Creation des tables
CREATE TABLE `CIS_bdpm` (
    `Code_CIS` int NOT NULL,
    `Denomination_du_medicament` TEXT,
    `Forme_pharmaceutique` TEXT,
    `Voies_administration` TEXT,
    `Statut_administratif_de_AMM` TEXT,
    `Type_de_procedure_AMM` TEXT,
    `Etat_de_commercialisation` TEXT,
    `Date_AMM` TEXT,
    `StatutBdm` TEXT,
    `Numero_autorisation_europeenne` TEXT,
    `Titulaires` TEXT,
    `Surveillance_renforcee` TEXT,
    PRIMARY KEY (`Code_CIS`)
);
CREATE TABLE `HAS_LiensPageCT_bdpm` (
    `Code_de_dossier_HAS` varchar(8) NOT NULL,
    `Lien_vers_la_page_avis_de_la_CT` TEXT,
    PRIMARY KEY (`Code_de_dossier_HAS`)
);
CREATE TABLE `CIS_COMPO_bdpm` (
    `Code_CIS` int NOT NULL,
    `Designation_element_pharmaceutique` TEXT,
    `Code_de_la_substance` TEXT,
    `Denomination_de_la_substance` TEXT,
    `Dosage_de_la_substance` TEXT,
    `Reference_de_ce_dosage` TEXT,
    `Nature_du_composant` TEXT,
    `Numero_de_liaison_SA_FT` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`)
);
CREATE TABLE `CIS_CPD_bdpm` (
    `Code_CIS` int NOT NULL,
    `Condition_de_prescription_ou_de_delivrance` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`)
);
CREATE TABLE `CIS_HAS_SMR` (
    `Code_CIS` int NOT NULL,
    `Code_de_dossier_HAS` varchar(8) NOT NULL,
    `Motif_evaluation` TEXT,
    `Date_avis_de_la_commision_de_la_transparence` TEXT,
    `Valeur_du_SMR` TEXT,
    `Libelle_du_SMR` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`),
    CONSTRAINT FOREIGN KEY (`Code_de_dossier_HAS`) REFERENCES `HAS_LiensPageCT_bdpm` (`Code_de_dossier_HAS`)
);

CREATE TABLE `CIS_HAS_ASMR` (
    `Code_CIS` int NOT NULL,
    `Code_de_dossier_HAS` varchar(8) NOT NULL,
    `Motif_evaluation` TEXT,
    `Date_avis_de_la_commision_de_la_transparence` TEXT,
    `Valeur_du_ASMR` TEXT,
    `Libelle_du_ASMR` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`),
    CONSTRAINT FOREIGN KEY (`Code_de_dossier_HAS`) REFERENCES `HAS_LiensPageCT_bdpm` (`Code_de_dossier_HAS`)
);
CREATE TABLE `CIS_GENER_bdpm` (
    `Identifiant_du_groupe_generique` TEXT,
    `Libelle_du_groupe_generique` TEXT,
    `Code_CIS` int NOT NULL,
    `Type_de_generique` TEXT,
    `Numero_de_tri` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`)
);
CREATE TABLE `CIS_InfoImportantes` (
    `Code_CIS` int NOT NULL,
    `Date_de_debut_de_information_de_securite` TEXT,
    `Date_de_fin_de_information_de_securite` TEXT,
    `Texte_a_afficher_et_lien_vers_information_de_securite` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`)
);
CREATE TABLE `CIS_CIP_bdpm` (
    `Code_CIS` int NOT NULL,
    `Code_CIP7` int,
    `Libelle_de_la_presentation` TEXT,
    `Statut_administratif_de_la_presentation` TEXT,
    `Etat_de_commercialisation` TEXT,
    `Date_de_la_declaration_de_commercialisation` TEXT,
    `Code_CIP13` TEXT,
    `Agrement_aux_collectivites` TEXT,
    `Taux_de_remboursement` TEXT,
    `Prix_du_medicament_en_euro` TEXT,
    `Prix_2` TEXT,
    `Difference_Prix` TEXT,
    `Indication_ouvrant_droit_au_remboursement` TEXT,
    CONSTRAINT FOREIGN KEY (`Code_CIS`) REFERENCES `CIS_bdpm` (`Code_CIS`)
);