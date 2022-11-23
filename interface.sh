#!/bin/bash

##################################################
### FONCTIONS
##################################################

function options() {
    # $1 : valeur a chercher
    while ! [[ $search =~ (commence|contient|^$) ]]
    do
        read -p "Commence par ou Contient ${_bold_}$1${_reset_} (commence|${_underline_}contient${_reset_}): " search
    done
    if [[ $search = "commence" ]]
    then
        echo "$1%"
    else
        echo "%$1%"
    fi
}

function request(){
    # $1 : colonne à chercher
    # $2 : valeur à chercher
    case $1 in 
        nom)
            where="c.Denomination_du_medicament LIKE '$(options $2)'";;
        sub)
            where="compo.Denomination_de_la_substance LIKE '$(options $2)'";;
        patho)
            extra_join="""
                INNER JOIN CIS_HAS_SMR AS smr ON c.Code_CIS=smr.Code_CIS
                INNER JOIN CIS_HAS_ASMR AS asmr ON c.Code_CIS=asmr.Code_CIS
                """
            where="smr.Libelle_du_SMR LIKE '%$2%' OR asmr.Libelle_du_ASMR LIKE '%$2%'"
    esac
    
    echo """
        SELECT c.Denomination_du_medicament, c.Forme_pharmaceutique, c.Voies_administration, compo.Denomination_de_la_substance, cip.Prix_du_medicament_en_euro 
        FROM CIS_bdpm AS c 
        INNER JOIN CIS_COMPO_bdpm AS compo ON c.Code_CIS=compo.Code_CIS 
        INNER JOIN CIS_CIP_bdpm AS cip ON c.Code_CIS=cip.Code_CIS
        $extra_join
        WHERE $where
        ORDER BY c.Denomination_du_medicament
        ;"""
}


##################################################
### MAIN
##################################################

mariadb="mariadb --table -u user_medicaments -p0000 medicaments"
_underline_=$'\033[4m'
_bold_=$'\033[1m'
_reset_=$'\033[0m'

run=1
while [[ $run -eq 1 ]]
do
    search=0
    while ! [[ $search =~ (nom|sub|patho|exit|^$) ]]
    do
        read -p "Chercher un medicament par nom|sub|patho|${_underline_}exit${_reset_} : " search
    done
    if [[ $search =~ (exit|^$) ]]
    then
        run=0
    else
        read -p "Entrer la valeur cherché pour ${_bold_}$search${_reset_} : " value
        echo $(request $search $value) | $mariadb
    fi
done