import os

class checkProcessus:
    def __init__(self, processus):
        self.listOfBad = None
        self.adresse = ""

    def setBadProcessus(self):
         with open(".\bad.txt", "r") as f:
            for line in f:
                self.listOfBad.append(line)



    def main(self):
        #scrap ".\processus.txt" to a list
        count = 0

        os.remove(".\processus.txt")

        os.system("bash ProcessusGeter.sh "+ self.adresse)
        with open(".\processus.txt", "r") as f:
            processusList = f.readlines()
        #check if processus is in the list
        for processus in processusList:
            if self.processus in processus:
                count += 1
        return count

                
    