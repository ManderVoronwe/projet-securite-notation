#!/bin/bash
#read data from a file data
CONF_FILE="data.cfg"
IP_SERVER=$1

function read_config()
{
    CONF_FILE="$1"
    VAR_CONF=$(cat $CONF_FILE)

    for LINE in $VAR_CONF
    do
        VARNAME1=${LINE%%:}
        VARNAME2=${VARNAME1^^}
        VAR=${LINE#:}
        eval ${VARNAME2}=$VAR
    done
}

NUMBER=0

echo "Lecture du fichier de configuration"
read_config $CONF_FILE


echo "Génération du fichier vide"
cat << EOF > /app/webInterface/src/data/data.js
const DataJson = {"releve":[


]};
EOF

echo "Lancement de la boucle de collecte de données"
for i in {1..200}
do
 
    echo "Releve $i"
    DATA_PROCESSUS=$(/app/checkProcessus/ProcessusGeter.sh $SERVER)
    # DATA_ADVERTISING=$(/app/Advertising/checkAdvertisment.sh $URL)
    # DATA_ACCESS_TO_DATABASE = $(../dataAccessCheker/dataAccessCheker.py)
    DATA_ADVERTISING=60
    DATA_PROCESSUS=40
    DATA_ACCESS_TO_DATABASE=20
    sed -i '$ d' /app/webInterface/src/data/data.js
    POINT=$(($DATA_PROCESSUS+$DATA_ADVERTISING+$DATA_ACCESS_TO_DATABASE))

    echo "Ajout des Point: $POINT"
    DATA="{ \
        \"rnumber\": $NUMBER, \
        \"processus\": $DATA_PROCESSUS, \
        \"advertising\": $DATA_ADVERTISING, \
        \"DBaccess\": $DATA_ACCESS_TO_DATABASE, \
        \"point\": $POINT \
        },"

    echo $DATA >> /app/webInterface/src/data/data.js
    echo "]};" >> /app/webInterface/src/data/data.js

    NUMBER=$((NUMBER+1))

    echo "Attente de 60s"
    sleep 60
done
