
i=0

cat /dev/null > tmp_requete.txt

#ma liste de commentaires temporaires reviews.txt
while read line  
do   
	echo $line
	#$line="$(tr -d "\n" <<< "$line")" 
	mysql -h 127.0.0.1 -u root -B restau-from-git -e "select review from review where review='$line'" > tmp_requete.txt
	
	test -s tmp_requete.txt
	returnval="$?"
	if [ $returnval -ne 0 ]
	then
		i=$(($i + 1))
	fi 
     
	
done < reviews.txt

echo $i