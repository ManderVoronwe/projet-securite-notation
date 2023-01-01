#!/bin/bash
#read data from a file data
CONF_FILE="data.cfg"
IP_SERVER=$1
GROUPE=$2

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
    DATA_PROCESSUS=$(/app/checkProcessus/ProcessusGeter.sh $IP_SERVER)
    DATA_ADVERTISING=$(/app/Advertising/checkAdvertisment.sh $URL)
    DATA_DB_CONNECTED=$(/app/dataAccessCheker/DBaccountcheck.sh $IP_SERVER)
    DATA_DB_ONLINE=$(/app/dataAccessCheker/DBonline.sh $IP_SERVER $GROUPE)
    DATA_SSH_CONNECTED=$(/app/checkSSH/SSHconnection.sh $IP_SERVER $GROUPE)
    DATA_REVERSE_SHELL=$(/app/checkRerverseShell/checkReverse.sh $IP_SERVER)
    # DATA_ACCESS_TO_DATABASE = $(../dataAccessCheker/dataAccessCheker.py)
    TMP_NOMBRE_DE_VRAIS_COMM_DEL=$(/app/Advertising/checkAdvertisment.sh)
    NOMBRE_DE_VRAIS_COMM_DEL=$(echo $TMP_NOMBRE_DE_VRAIS_COMM_DEL | cut -d " " -f1)
    NB_COM_LEGIT=$(echo $TMP_NOMBRE_DE_VRAIS_COMM_DEL | cut -d " " -f2)
    TAUX_DE_FAUX_COMM=$(/app/../tauxdeFauxCom.sh $IP_SERVER $NB_COM_LEGIT)
    POINT=$(($DATA_PROCESSUS+$DATA_ADVERTISING+$DATA_DB_CONNECTED))
    sed -i '$ d' /app/webInterface/src/data/data.js

    echo "Ajout des Point: $POINT"
    DATA="{ \
        \"rnumber\": $NUMBER, \
        \"processus\": $DATA_PROCESSUS, \
        \"advertising\": $DATA_ADVERTISING, \
        \"DBaccess\": $DATA_DB_CONNECTED, \
        \"NombreDeVraisCommDel\": $NOMBRE_DE_VRAIS_COMM_DEL, \
        \"TauxDeFauxComm\": $TAUX_DE_FAUX_COMM, \
        \"point\": $POINT \
        },"

    echo $DATA >> /app/webInterface/src/data/data.js
    echo "]};" >> /app/webInterface/src/data/data.js

    NUMBER=$((NUMBER+1))

    echo "Attente de 60s"
    sleep 60
done
