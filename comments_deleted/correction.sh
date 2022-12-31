
i=0

cat /dev/null > tmp_requete.txt
USER=$1
PASSWORD=$2
SERVER=$3
DB_name=$4

#ma liste de commentaires temporaires reviews.txt
while read line  
do   

	mysql -h $SERVER -u $USER -p$PASSWORD -B $DB_name -e "select review from review where review='$line'" > tmp_requete.txt
	
	test -s tmp_requete.txt
	returnval="$?"
	if [ $returnval -ne 0 ]
	then
		i=$(($i + 1))
	fi 
     
	
done < reviews.txt

echo $i