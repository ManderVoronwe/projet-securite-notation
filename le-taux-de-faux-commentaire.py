import mysql.connector
from mysql.connector import Error
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

    # Execute a SELECT query
    query = 'SELECT * FROM review'
    cursor.execute(query)

    # Get the number of rows returned by the query
    #row_count = cursor.fetchone()[0]
    rows = cursor.fetchall()
    row_count_total = len(rows)
	

    print(f'There are {row_count_total} rows in the result.')

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
with open("tmp_requete.txt") as f:
    row_count_supprime = sum(1 for _ in f)
print(f"There are {row_count_supprime} rows in the file.")


#bon commentaire
connection = mysql.connector.connect(host='localhost',
                                     database='restau-from-git',
                                     user='root',
                                     password='',
                                     charset='utf8mb4',
                                     collation='utf8mb4_unicode_ci')
cursor = connection.cursor()
query = 'SELECT * FROM review WHERE rating = "4"'
cursor.execute(query)
rows = cursor.fetchall()
row_count_bon = len(rows)
	
print(f'There are {row_count_bon} rows in the result.')

if connection.is_connected():
    db_Info = connection.get_server_info()
    print("Connected to MySQL Server version ", db_Info)
    cursor = connection.cursor()
    cursor.execute("select database();")
    record = cursor.fetchone()
    print("You're connected to database: ", record)
#mauvais commentaire
row_count_mauvais = row_count_total - row_count_supprime - row_count_bon
print(f'There are {row_count_mauvais} rows in the result.')
#taux de faux commentaire
bad_comment_rate = (row_count_mauvais / row_count_total) * 100
print(f'The bad comment rate is {bad_comment_rate:.2f}%')

