class Passenger:
    def __init__(self, data):
        self.passengerId = data[0]
        self.survived = data[1]
        self.pclass = data[2]
        self.name = data[3]
        self.sex = data[4]
        self.age = data[5]
        self.sibSp = data[6]
        self.parCh = data[7]
        self.ticket = data[8]
        self.fare = data[9]
        self.cabin = data[10]
        self.embarked = data[11]