#!/bin/bash

# $1 : nom du root de la bdd
# $2 : mot de passe du root

if [[ -z $1 ]] || [[ -z $2 ]]
then
    echo "nom du root de la bdd et mot de passe nécessaire"
    exit 1
fi

cat init_bdd.sql | mariadb -u $1 -p$2 medicaments

mariadb="mariadb -u $1 -p$2 medicaments"

echo "LOADING CIS_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_bdpm.txt"'
option='''
INTO TABLE `CIS_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING HAS_LiensPageCT_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/HAS_LiensPageCT_bdpm.txt"'
option='''
INTO TABLE `HAS_LiensPageCT_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_COMPO_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_COMPO_bdpm.txt"'
option='''
INTO TABLE `CIS_COMPO_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_CPD_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_CPD_bdpm.txt"'
option='''
INTO TABLE `CIS_CPD_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_HAS_SMR.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_HAS_SMR_bdpm.txt"'
option='''
INTO TABLE `CIS_HAS_SMR`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_HAS_ASMR.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_HAS_ASMR_bdpm.txt"'
option='''
INTO TABLE `CIS_HAS_ASMR`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_GENER_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_GENER_bdpm.txt"'
option='''
INTO TABLE `CIS_GENER_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_InfoImportantes.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_InfoImportantes.txt"'
option='''
INTO TABLE `CIS_InfoImportantes`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"
echo

echo "LOADING CIS_CIP_bdpm.txt"
load='LOAD DATA INFILE "/var/lib/mysql/medicaments/source/CIS_CIP_bdpm.txt"'
option='''
INTO TABLE `CIS_CIP_bdpm`
FIELDS TERMINATED BY "\t";'''
echo "$load$option" | $mariadb
[[ $? -ne 0 ]] && echo "IGNORE MODE" && echo "${load} IGNORE ${option}" | $mariadb
echo "DONE"