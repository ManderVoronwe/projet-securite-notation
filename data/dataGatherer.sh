#!/bin/bash
#read data from a file data
CONF_FILE="data.cfg"

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

NUMBER = 0

read_config $CONF_FILE

cat << EOF > ../webinterface/src/data/data.js
const  DataJson ={"releve":[

]};
EOF

for i in {1..120}
do
    DATA_PROCESSUS=$(../checkProcessus/ProcessusGeter.sh $SERVER $CERTIFICATE $PROCESSUS)
    DATA_ADVERTISING=$(../Advertising/checkAdvertisment.sh $URL)
    DATA_ACCESS_TO_DATABASE = $(../dataAccessCheker/dataAccessCheker.py)
    #replace the last line of the file
    sed -i '$ d' ../webinterface/data/data.js
    #add the new data
    POINT = $DATA_PROCESSUS + $DATA_ADVERTISING + $DATA_ACCESS_TO_DATABASE
    DATA = ",
        {
        \"rnumber\": $NUMBER,
        \"processus\": $DATA_PROCESSUS,
        \"advertising\": $DATA_ADVERTISING,
        \"DBaccess\": $DATA_ACCESS_TO_DATABASE,
        \"point\": $POINT
        }
    ]};"
    
    echo "    \"processus\": $DATA_PROCESSUS," >> ../webinterface/src/data/data.js
    NUMBER = $NUMBER + 1
    sleep 60
done
