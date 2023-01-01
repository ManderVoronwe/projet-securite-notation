#!/bin/bash

# Fichier des id des true
SERVER=$1


#a ne sert a rien juste pour laisser les commentaires
a=0

FILE_ID="./ids.txt"
#NUMBER_TRUE=$(cat ids.txt | wc -l)
ARRAY_WRONG_COMMENT=("test" "test2")
ACTUAL_TRUE=0

function check_in(){
    COMMENT_TO_CHECK=$1

    for i in "${ARRAY_WRONG_COMMENT[@]}"
    do
        if [ "$i" == "$COMMENT_TO_CHECK" ]
        then
            echo 1
        fi
    done
    echo 0
}


# for each line of an output command
while read line
do
    ID_LINE=$(echo $line | awk '{print $1}')
    COMMENT_LINE=$(echo $line | awk '{$1=""; sub("  ", " "); print}')

    CHECK_COMMENT=$(check_in "$COMMENT_LINE")
   
    if [ $CHECK_COMMENT -eq 1 ]
    then
        # "C'est un faux commentaire, on ajoute pas"
        a=$(($a + 1))
    else
        # "C'est un vrai commentaire, il faut check si son id est dans le fichier"
        IN=$(grep $ID_LINE $FILE_ID | wc -l)
        if [ $IN -gt 0 ]
        then
            a=$(($a + 1))
            # "Il est dans le fichier, on n'ajoute pas"
        else
            # "Il n'est pas dans le fichier, on va l'ajouter"
            echo $ID_LINE >> $FILE_ID
        fi
        ACTUAL_TRUE=$(($ACTUAL_TRUE+1))
    fi
    


done < <(mysql -h $1 -u notation -pnotation -B maki2 -e "SELECT re_id,review FROM review" | sed '1d')


NUMBER_TOTAL_TRUE=$(cat ids.txt | wc -l)
NUMBER_TRUE_COM_DELETED=$($NUMBER_TOTAL_TRUE-$ACTUAL_TRUE))


echo "$NUMBER_TRUE_COM_DELETED $ACTUAL_TRUE"

