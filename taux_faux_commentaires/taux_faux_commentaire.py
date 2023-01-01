## Ce code prends en arguments 2 values bon_commentaire_supprimee et bon_commentaire_original
#  Il calcule le taux de faux commentaire.
##

import mysql.connector
from mysql.connector import Error
import sys

#total de commentaire
connection = None
try:
    connection = mysql.connector.connect(host='localhost',
                                         database='restau-from-git',
                                         user='root',
                                         password='',
										 charset='utf8mb4',
                                     	 collation='utf8mb4_unicode_ci')
    cursor = connection.cursor()

    query = 'SELECT * FROM review'
    cursor.execute(query)

    rows = cursor.fetchall()
    total_commentaire = len(rows)
	
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

except Error as e:
    print("Error while connecting to MySQL", e)
finally:
	
    if connection is not None and connection.is_connected():
    
        cursor.close()
        connection.close()
        print("MySQL connection is closed")

#bon commentaire supprimee

# Get the value of "i" as a command-line argument
i = sys.argv[1]
bon_commentaire_supprimee = int(i)

#bon commentaire original

j = sys.argv[2]
bon_commentaire_original = int(j)

#mauvaise commentaire

mauvaise_commentaire = total_commentaire - bon_commentaire_original + bon_commentaire_supprimee

# taux de mauvaise commentaire

taux_faux_commentaire = mauvaise_commentaire / total_commentaire

print('Le taux de faux commentaires: ', taux_faux_commentaire)
