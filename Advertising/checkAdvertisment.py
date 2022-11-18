#check http://IP/index.php if there is a reference to celene2
import re
import requests


class Scoring:
    def __init__(self):
        self.adresse = "maki.fr"

    def add(self, value):
        self.scoring = value

    def get(self):
        return self.scoring

    def setAdresse(self, adresse):
        self.adresse = adresse

    def checkAccess(self):
        response = requests.get("http://"+self.adresse)
        if response.status_code == 200:
            return True
        else:
            return False

    def checkAdvertisment(self):
        url = "http://"+self.adresse+"/index.php"
        response = requests.get(url)
        if re.search("celene2", response.text):
            return True
        else:
            return False

    def main(self):
        if self.checkAccess():
            if self.checkAdvertisment():
                return 5
            else:
                return 10
        else:
            return 0
    


    




