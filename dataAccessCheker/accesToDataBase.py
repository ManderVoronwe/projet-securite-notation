
import mysql.connector

class accesToDataBase:

    def __init__(self, dbPath):
        self.dbPath = dbPath
        self.conn = None
        self.c = None

    def connect(self):
        self.conn = mysql.connect(self.dbPath)
        self.c = self.conn.cursor()

