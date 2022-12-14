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

../webinterface/data/data.json < "{"

../webinterface/data/data.json <<EOF
    
}
EOF

for i in {1..120}
do
    DATA_PROCESSUS=$(../checkProcessus/ProcessusGeter.sh $SERVER $CERTIFICATE $PROCESSUS)
    DATA_ADVERTISING=$(../Advertising/checkAdvertisment.sh $URL)
    #replace the last line of the file
    sed -i '$ d' ../webinterface/data/data.json
    #add the new data
    DATA = "releve: {
        \"rnumber\": $NUMBER,
        \"processus\": $DATA_PROCESSUS,
        \"advertising\": $DATA_ADVERTISING
        }
    }"
    
    echo "    \"processus\": $DATA_PROCESSUS," >> ../webinterface/data/data.json
    NUMBER = $NUMBER + 1
    sleep 60
done
