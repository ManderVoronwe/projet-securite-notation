
import mysql.connector

host = "192.168.5.149"
user = "root"
password = "root"
port = "3306"


def connectToDataBase(_host = host, _user = user, _password = password, _port = port):
    mydb = mysql.connector.connect(
        host = _host,
        user = _user,
        password = _password,
        port = _port
    )
    return mydb
    

def checkIfConnectionIsOk(_mydbToCheck):
    _mydbToCheck = connectToDataBase()
    return _mydbToCheck.is_connected()

def checkPort(_host = host, _port = port):
    import socket
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        s.connect((_host, int(_port)))
        s.shutdown(2)
        return True
    except:
        return False


if checkPort():
    Db=connectToDataBase()
    if checkIfConnectionIsOk(Db):
        print(1)
        exit()

print(0)

