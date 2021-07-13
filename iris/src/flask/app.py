from flask import Flask, jsonify, request, make_response
from flask_cors import CORS
import humps 
import threading
import json
from definitions.passenger import Passenger
from definitions.patient import Patient

import iris

# /usr/irissys/bin/irispython /opt/irisapp/src/flask/app.py

app = Flask(__name__)
CORS(app)


# GET all passengers
@app.route("/api/integratedML/passengers", methods=["GET"])
def getAllPassengers():
    query = "SELECT * FROM Titanic_Table.Passenger"
    name = request.args.get('name')
    currPage = request.args.get('currPage')
    pageSize = request.args.get('pageSize')
    # Search by name 
    if not (name is None):
        query += " WHERE name %STARTSWITH ?"
        rs = iris.sql.exec(query, name)
    else:
        # Paginator
        if not (currPage is None or pageSize is None):
            currPage = int(currPage)
            pageSize = int(pageSize)
            query += " WHERE ID > ? AND ID <= ?"
            rs = iris.sql.exec(query, pageSize * (currPage - 1), pageSize * currPage)
        # If no queries, return all passengers
        else:
            rs = iris.sql.exec(query)
    payload = {}
    payload['passengers'] = []
    for p in rs:
        payload['passengers'].append(Passenger(p).__dict__)
    rs = iris.sql.exec("SELECT COUNT(ID) FROM Titanic_Table.Passenger")
    payload['total'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/passengers", methods=["POST"])
def createPassenger():
    passenger = request.get_json()
    query = "INSERT INTO Titanic_Table.Passenger (survived, pclass, name, sex, age, sibSp, parCh, ticket, fare, cabin, embarked, passenger_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    newId = int(iris.sql.exec("SELECT MAX(ID) FROM Titanic_Table.Passenger").__next__()[0]) + 1
    iris.sql.exec(query, passenger['survived'], passenger['pclass'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'], newId)
    payload = {
        'query': query,
        'passengerId': newId
    }
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["GET"])
def getPassenger(id):
    payload = {}
    query = "SELECT * FROM Titanic_Table.Passenger WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try :
        passenger = Passenger(rs.__next__()).__dict__
    except:        
        return make_response(
            'Not Found',
            204
        )
    payload['passengers'] = passenger
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["PUT"])
def updatePassenger(id):
    passenger = request.get_json()
    query = "UPDATE Titanic_Table.Passenger SET survived = ?, class = ?, name = ?, sex = ?, age = ?, sibSp = ?, par_ch = ?, ticket = ?, fare = ?, cabin = ?, embarked = ? WHERE ID = ?"
    iris.sql.exec(query, passenger['survived'], passenger['class'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'], id)
    payload = {
        'query': query,
    }
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["DELETE"])
def deletePassenger(id):
    payload = {}
    query = "SELECT ID FROM Titanic_Table.Passenger WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try:
        rs.__next__()
    except:
        return make_response(
            'Not Found',
            204
        )
    query = "DELETE FROM Titanic_Table.Passenger WHERE ID = ?"
    iris.sql.exec(query, str(id))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/patients", methods=["GET"])
def getAllPatients():
    query = "SELECT ID, * FROM Noshow_Table.Appointment"
    name = request.args.get('name')
    currPage = request.args.get('currPage')
    pageSize = request.args.get('pageSize')
    # Search by name 
    if not (name is None):
        query += " WHERE name %STARTSWITH ?"
        rs = iris.sql.exec(query, name)
    else:
        # Paginator
        if not (currPage is None or pageSize is None):
            currPage = int(currPage)
            pageSize = int(pageSize)
            query += " WHERE ID > ? AND ID <= ?"
            rs = iris.sql.exec(query, pageSize * (currPage - 1), pageSize * currPage)
        # All patients
        else:
            rs = iris.sql.exec(query)
    payload = {}
    payload['patients'] = []
    for p in rs:
        payload['patients'].append(Patient(p).__dict__)
    rs = iris.sql.exec("SELECT MAX(ID) FROM Noshow_Table.Appointment")
    payload['maxId'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/patients", methods=["POST"])
def createPatient():
    patient = request.get_json()

    query = "INSERT INTO Noshow_Table.Appointment (gender, scheduledDay, scheduledHour, appointmentDay, age, neighborhood, scholarship, hypertension, diabetes, alcoholism, handicap, smsReceived, noShow) VALUES (?, DATE(?), ?, DATE(?), ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    newId = int(iris.sql.exec("SELECT MAX(ID) FROM Noshow_Table.Appointment").__next__()[0]) + 1
    iris.sql.exec(query, patient['gender'], patient['scheduledDay'], patient['scheduledHour'], patient['appointmentDay'], patient['age'], patient['neighborhood'], patient['scholarship'], patient['hypertension'], patient['diabetes'], patient['alcoholism'], patient['handicap'], patient['smsReceived'], patient['noShow'])
    payload = {
        'query': query,
        'patientId': newId
    }
    return jsonify(payload)

@app.route("/api/integratedML/patients/<int:id>", methods=["GET"])
def getPatient(id):
    payload = {}
    query = "SELECT ID, * FROM Noshow_Table.Appointment WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try:
        patient = Patient(rs.__next__()).__dict__
    except:
        return make_response(
            'Not Found',
            204
        )
    payload['patient'] = patient
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/patients/<int:id>", methods=["PUT"])
def updatePatient(id):
    patient = request.get_json()
    query = "UPDATE Noshow_Table.Appointment SET gender = ?, scheduledDay = DATE(?), scheduledHour = ?, appointmentDay = DATE(?), age = ?, neighborhood = ?, scholarship = ?, hypertension = ?, diabetes = ?, alcoholism = ?, handicap = ?, smsReceived = ?, noShow = ? WHERE ID = ?"
    iris.sql.exec(query, patient['gender'], patient['scheduledDay'], patient['scheduledHour'], patient['appointmentDay'], patient['age'], patient['neighborhood'], patient['scholarship'], patient['hypertension'], patient['diabetes'], patient['alcoholism'], patient['handicap'], patient['smsReceived'], patient['noShow'], id)
    payload = {
        'query': query,
    }
    return jsonify(payload)

@app.route("/api/integratedML/patients/<int:id>", methods=["DELETE"])
def deletePatient(id):
    payload = {}
    query = "SELECT ID FROM Noshow_Table.Appointment WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try:
       rs.__next__()
    except:
        return make_response(
            'Not Found',
            204
        )
    query = "DELETE FROM Noshow_Table.Appointment WHERE ID = ?"
    iris.sql.exec(query, str(id))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/tablesize", methods=["GET"])
def getTableSize():
    query = "SELECT COUNT(*) FROM " + request.args.get('table')
    try:
        rs = iris.sql.exec(query)
    except:
        return make_response(
            'Not Found',
            204
        )
    total = rs.__next__()   
    return jsonify({'total': total[0]})

@app.route("/api/integratedML/ml/models", methods=["GET"])
def getAllModels():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_MODELS"
    rs = iris.sql.exec(query)
    payload = {}
    payload['models'] = humps.camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/models", methods=["POST"])
def createModel():
    createInfo = request.get_json()
    query = "CREATE MODEL " + createInfo['modelName'] + " PREDICTING(" + createInfo['predictValue'] + ")"
    if ('withVariables' in createInfo):
        query += " WITH("
        varIter = iter(createInfo['withVariables'])
        query += varIter.__next__()
        for var in varIter:
            query += ", " + var
        query += ")"
    query += " FROM " + createInfo['fromTable']
    rs = iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/models", methods=["DELETE"])
def deleteModel():
    query = "DROP MODEL " + request.args.get('modelName')
    rs = iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/models/purge", methods=["DELETE"])
def purgeModel():
    query = "ALTER MODEL " + request.args.get('modelName') + " PURGE ALL"
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings", methods=["GET"])
def getTrainingRuns():
    query = "SELECT MODEL_NAME, TRAINING_RUN_NAME, PROVIDER, START_TIMESTAMP, COMPLETED_TIMESTAMP, TRAINING_DURATION, RUN_STATUS, STATUS_CODE, SETTINGS, ML_CONFIGURATION_NAME, TRAINING_RUN_QUERY FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    payload['trainingRuns'] = humps.camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings", methods=["POST"])
def trainModel():
    trainingInfo = request.get_json()
    query = "TRAIN MODEL " + trainingInfo['modelName'] + " AS " + trainingInfo['trainingName'] + " FROM " + trainingInfo['fromTable']
    iris.sql.exec(query)
    # trainProcess = threading.Thread(target=iris.cls("IntegratedML.REST.impl").executeQuery, args=(query,))
    # trainProcess.start()
    # iris.cls("IntegratedML.REST.impl").executeQuery(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/states", methods=["GET"])
def getStateTrainingRun():
    query = "SELECT RUN_STATUS FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME=? AND MODEL_NAME=?"
    rs = iris.sql.exec(query, request.args.get('trainingName'), request.args.get('modelName'))
    payload = {}
    try:
        payload['state'] = rs.__next__()[0]
    except:
        payload['state'] = ""
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/configurations", methods=["GET"])
def getAllConfigurations():
    payload = {}
    payload['configs'] = iris.cls("%SYS.ML.Configuration")._GetListOfAllConfigNames()
    payload['defaultConfigName'] = iris.cls("%SYS.ML.Configuration")._GetSystemDefault()
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/configurations", methods=["PUT"])
def changeConfiguration():
    configName = request.get_json()
    iris.cls("%SYS.ML.Configuration")._SetSystemDefault(configName['configName'])
    return make_response(
        'Expected Result',
        200
    )

@app.route("/api/integratedML/ml/trainings/configurations/datarobot", methods=["POST"])
def createDRConfiguration():
    configInfo = request.get_json()
    query = "CREATE ML CONFIGURATION DataRobotConfig PROVIDER DataRobot URL '" + configInfo['url'] + "' APITOKEN '" + configInfo['apiToken'] + "'"
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/configurations/datarobot", methods=["PUT"])
def alterDRConfiguration():
    configInfo = request.get_json()
    query = "ALTER ML CONFIGURATION DataRobotConfig PROVIDER DataRobot URL '" + configInfo['url'] + "' APITOKEN '" + configInfo['apiToken'] + "'"
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/logs", methods=["GET"])
def getLogTrainingRun():
    query = "SELECT substring(LOG,1,CHAR_LENGTH(LOG)) FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME = ?"
    rs = iris.sql.exec(query, request.args.get('trainingName'))
    payload = {}
    payload['log'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/validations", methods=["GET"])
def getValidationRuns():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    payload['validationRuns'] = humps.camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/validations", methods=["POST"])
def validateModel():
    validationInfo = request.get_json()
    query = "VALIDATE MODEL " + validationInfo['modelName'] 
    if ('validationName' in validationInfo):
        query += " AS " + validationInfo['validationName'] 
    query += " USE " + validationInfo['trainedModelName'] + " FROM " + validationInfo['fromTable']
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/validations/metrics", methods=["GET"])
def getMetrics():
    query = "SELECT METRIC_NAME, METRIC_VALUE, TARGET_VALUE FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS WHERE (VALIDATION_RUN_NAME='" + request.args.get('validationName') + "' AND MODEL_NAME='" + request.args.get('modelName') + "')"
    rs = iris.sql.exec(query)
    payload = {}
    payload['metrics'] = humps.camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/predictions/models", methods=["GET"])
def getTrainedModels():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS"
    rs = iris.sql.exec(query)
    payload = {}
    payload['models'] = humps.camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/predictions", methods=["GET"])
def predict():
    query = "SELECT PREDICT(" + request.args.get('model') + " USE " + request.args.get('trainedModel') + ") FROM " + request.args.get('fromTable') + " WHERE ID = ?"
    rs = iris.sql.exec(query, request.args.get('id'))
    payload = {}
    payload['predictedValue'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/predictions/probabilities", methods=["GET"])
def probability():
    query = "SELECT PROBABILITY(" + request.args.get('model') + " USE " + request.args.get('trainedModel') + " FOR " + request.args.get('labelValue') + ") FROM " + request.args.get('fromTable') + " WHERE ID = ?"
    rs = iris.sql.exec(query, request.args.get('id'))
    payload = {}
    payload['probability'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

if __name__ == '__main__':
    app.run('0.0.0.0', port = "8080")