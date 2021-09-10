from flask import Flask, jsonify, request, make_response
from flask_cors import CORS
from humps import camelize
import json
import threading
from definitions.passenger import Passenger
from definitions.patient import Patient
import iris

app = Flask(__name__)
CORS(app)


# ----------------------------------------------------------------
### CRUD FOR TITANIC_TABLE.PASSENGER
# ----------------------------------------------------------------

# GET all passengers
@app.route("/api/integratedML/passengers", methods=["GET"])
def getAllPassengers():
    payload = {}
    payload['passengers'] = []
    tp = {}
    name = request.args.get('name')
    currPage = request.args.get('currPage')
    pageSize = request.args.get('pageSize')
    if not (name is None):
        # If search by name 
        query = "SELECT ID FROM Titanic_Table.Passenger WHERE name %STARTSWITH ?"
        rs = iris.sql.exec(query, name)
        for i in rs:
            # We create an iris object
            tp = iris.ref(1)
            # We get the json in a string
            iris.cls("Titanic.Table.Passenger")._OpenId(i[0])._JSONExportToString(tp)
            # We normalize the string to get it in python
            tp = iris.cls("%String").Normalize(tp)
            # We load the string in a dict
            tp = json.loads(tp)
            # We add the id
            tp['passengerId'] = i[0]
            payload['passengers'].append(tp)
    else:
        if not (currPage is None or pageSize is None):
            # if paginator
            currPage = int(currPage)
            pageSize = int(pageSize)
            tStartRow = pageSize * (currPage - 1)
            tEndRow = tStartRow + pageSize
            tRow = 0
            query = "SELECT ID FROM Titanic_Table.Passenger"
            rs = iris.sql.exec(query)
            for i in rs:
                if tRow < tEndRow:
                    tRow += 1
                    if tRow > tStartRow:
                        # We create an iris object
                        tp = iris.ref(1)
                        # We get the json in a string
                        iris.cls("Titanic.Table.Passenger")._OpenId(i[0])._JSONExportToString(tp)
                        # We normalize the string to get it in python
                        tp = iris.cls("%String").Normalize(tp)
                        # We load the string in a dict
                        tp = json.loads(tp)
                        # We add the id
                        tp['passengerId'] = i[0]
                        payload['passengers'].append(tp)
        else:
            # If no queries, return all passengers
            query = "SELECT ID FROM Titanic_Table.Passenger"
            rs = iris.sql.exec(query)
            for i in rs:
                # We create an iris object
                tp = iris.ref(1)
                # We get the json in a string
                iris.cls("Titanic.Table.Passenger")._OpenId(i[0])._JSONExportToString(tp)
                # We normalize the string to get it in python
                tp = iris.cls("%String").Normalize(tp)
                # We load the string in a dict
                tp = json.loads(tp)
                # We add the id
                tp['passengerId'] = i[0]
                payload['passengers'].append(tp)
    # Getting the total number of passengers
    rs = iris.sql.exec("SELECT COUNT(*) FROM Titanic_Table.Passenger")
    payload['total'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

# POST a new passenger
@app.route("/api/integratedML/passengers", methods=["POST"])
def createPassenger():
    # Retreiving the data in request body
    passenger = request.get_json()
    query = "INSERT INTO Titanic_Table.Passenger (survived, pclass, name, sex, age, sibSp, parCh, ticket, fare, cabin, embarked) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    # Getting the new ID of the passenger
    newId = int(iris.sql.exec("SELECT MAX(ID) FROM Titanic_Table.Passenger").__next__()[0]) + 1
    try:
        iris.sql.exec(query, passenger['survived'], passenger['pclass'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'])
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {
        'query': query,
        'passengerId': newId
    }
    return jsonify(payload)

# GET passenger with id
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
    payload['passenger'] = passenger
    payload['query'] = query
    return jsonify(payload)

# PUT to update passenger with id
@app.route("/api/integratedML/passengers/<int:id>", methods=["PUT"])
def updatePassenger(id):
    # First, checking to see if the passenger exists
    query = "SELECT ID FROM Titanic_Table.Passenger WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try :
        rs.__next__()
    except:        
        return make_response(
            'Not Found',
            204
        )
    # Updating
    passenger = request.get_json()
    query = "UPDATE Titanic_Table.Passenger SET survived = ?, pclass = ?, name = ?, sex = ?, age = ?, sibSp = ?, parCh = ?, ticket = ?, fare = ?, cabin = ?, embarked = ? WHERE ID = ?"
    try:
        iris.sql.exec(query, passenger['survived'], passenger['pclass'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'], id)
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {
        'query': query,
    }
    return jsonify(payload)

# DELETE passenger with id
@app.route("/api/integratedML/passengers/<int:id>", methods=["DELETE"])
def deletePassenger(id):
    payload = {}  
    query = "DELETE FROM Titanic_Table.Passenger WHERE ID = ?"
    try:
        iris.sql.exec(query, str(id))
    except:
        return make_response(
            'Not Found',
            204
        )
    payload['query'] = query
    return jsonify(payload)


# ----------------------------------------------------------------
### CRUD FOR NOSHOW_TABLE.APPOINTMENT
# ----------------------------------------------------------------

# GET all patients, same as for passengers
@app.route("/api/integratedML/patients", methods=["GET"])
def getAllPatients():
    query = "SELECT ID, * FROM Noshow_Table.Appointment"
    id = request.args.get('id')
    currPage = request.args.get('currPage')
    pageSize = request.args.get('pageSize')
    # Search by name 
    if not (id is None):
        query += " WHERE ID = ?"
        rs = iris.sql.exec(query, id)
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

# POST new patient, same as for passengers
@app.route("/api/integratedML/patients", methods=["POST"])
def createPatient():
    patient = request.get_json()
    query = "INSERT INTO Noshow_Table.Appointment (gender, scheduledDay, scheduledHour, appointmentDay, age, neighborhood, scholarship, hypertension, diabetes, alcoholism, handicap, smsReceived, noShow) VALUES (?, DATE(?), ?, DATE(?), ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    newId = int(iris.sql.exec("SELECT MAX(ID) FROM Noshow_Table.Appointment").__next__()[0]) + 1
    try:
        iris.sql.exec(query, patient['gender'], patient['scheduledDay'], patient['scheduledHour'], patient['appointmentDay'], patient['age'], patient['neighborhood'], patient['scholarship'], patient['hypertension'], patient['diabetes'], patient['alcoholism'], patient['handicap'], patient['smsReceived'], patient['noShow'])
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {
        'query': query,
        'patientId': newId
    }
    return jsonify(payload)

# GET patient with id, same as for passengers
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

# PUT to update patient with id, same as for passengers
@app.route("/api/integratedML/patients/<int:id>", methods=["PUT"])
def updatePatient(id):
    query = "SELECT ID FROM Titanic_Table.Passenger WHERE ID = ?"
    rs = iris.sql.exec(query, str(id))
    try :
        rs.__next__()
    except:        
        return make_response(
            'Not Found',
            204
        )
    patient = request.get_json()
    query = "UPDATE Noshow_Table.Appointment SET gender = ?, scheduledDay = DATE(?), scheduledHour = ?, appointmentDay = DATE(?), age = ?, neighborhood = ?, scholarship = ?, hypertension = ?, diabetes = ?, alcoholism = ?, handicap = ?, smsReceived = ?, noShow = ? WHERE ID = ?"
    try:
        iris.sql.exec(query, patient['gender'], patient['scheduledDay'], patient['scheduledHour'], patient['appointmentDay'], patient['age'], patient['neighborhood'], patient['scholarship'], patient['hypertension'], patient['diabetes'], patient['alcoholism'], patient['handicap'], patient['smsReceived'], patient['noShow'], id)
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {
        'query': query,
    }
    return jsonify(payload)

# DELETE patient with id, same as for passengers
@app.route("/api/integratedML/patients/<int:id>", methods=["DELETE"])
def deletePatient(id):
    payload = {}
    query = "DELETE FROM Noshow_Table.Appointment WHERE ID = ?"
    try:
        iris.sql.exec(query, str(id))
    except:
        return make_response(
            'Not Found',
            204
        )
    payload['query'] = query
    return jsonify(payload)


# ----------------------------------------------------------------
### ADDITIONAL METHODS FOR ALL TABLES
# ----------------------------------------------------------------

# GET the size of a table
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


# ----------------------------------------------------------------
### MODEL MANAGEMENT
# ----------------------------------------------------------------

# ----- MODELS -----

# GET all models
@app.route("/api/integratedML/ml/models", methods=["GET"])
def getAllModels():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_MODELS"
    rs = iris.sql.exec(query)
    payload = {}
    # We first take the rs as a dataframe. We then replace the values Nan with "". We camelize the keys of this dataframe (to have camel case, in accord with the swagger). Finally, we convert this dataframe to a dictionary, wde orient that conversion with records so that we have an array with each model as an element.
    payload['models'] = camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

# POST new model
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
    try:
        iris.sql.exec(query)
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# DELETE model by name
@app.route("/api/integratedML/ml/models", methods=["DELETE"])
def deleteModel():
    query = "DROP MODEL " + request.args.get('modelName')
    try:
        iris.sql.exec(query)
    except:
        return make_response(
            'Not Found',
            204
        )
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# DELETE to purge model
@app.route("/api/integratedML/ml/models/purge", methods=["DELETE"])
def purgeModel():
    query = "ALTER MODEL " + request.args.get('modelName') + " PURGE ALL"
    try:
        iris.sql.exec(query)
    except:
            return make_response(
                'Not Found',
                204
            )
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# ----- TRAINING RUNS -----

# GET all training runs
@app.route("/api/integratedML/ml/trainings", methods=["GET"])
def getTrainingRuns():
    query = "SELECT MODEL_NAME, TRAINING_RUN_NAME, PROVIDER, START_TIMESTAMP, COMPLETED_TIMESTAMP, TRAINING_DURATION, RUN_STATUS, STATUS_CODE, SETTINGS, ML_CONFIGURATION_NAME, TRAINING_RUN_QUERY FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    # Same procedure than with getting all models
    payload['trainingRuns'] = camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    # TODO: if streams accepted, change the query actually done and add logs back
    payload['query'] = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    return jsonify(payload)

# POST new training
@app.route("/api/integratedML/ml/trainings", methods=["POST"])
def trainModel():
    trainingInfo = request.get_json()
    query = "TRAIN MODEL " + trainingInfo['modelName'] + " AS " + trainingInfo['trainingName'] + " FROM " + trainingInfo['fromTable']
    # Use of threading to train the model in background
    # We use the already implemented objecscript method executeQuery() in the IntegratedML.REST.impl.
    trainProcess = threading.Thread(target=iris.cls("IntegratedML.REST.impl").executeQuery, args=(query,))
    trainProcess.start()
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# GET the state of a training run
@app.route("/api/integratedML/ml/trainings/states", methods=["GET"])
def getStateTrainingRun():
    query = "SELECT RUN_STATUS FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME=? AND MODEL_NAME=?"
    rs = iris.sql.exec(query, request.args.get('trainingName'), request.args.get('modelName'))
    payload = {}
    try:
        payload['state'] = rs.__next__()[0]
    except:
        # Since the model is not listed at the beginning of its training, we return an empty string.
        # (That means no 204, Not Found)
        payload['state'] = ""
    payload['query'] = query
    return jsonify(payload)

# GET log for a training run
@app.route("/api/integratedML/ml/trainings/logs", methods=["GET"])
def getLogTrainingRun():
    query = "SELECT substring(LOG,1,CHAR_LENGTH(LOG)) FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME = ?"
    rs = iris.sql.exec(query, request.args.get('trainingName'))
    payload = {}
    payload['log'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

# ----- ML CONFIGURATION -----

# GET all configurations
@app.route("/api/integratedML/ml/trainings/configurations", methods=["GET"])
def getAllConfigurations():
    payload = {}
    payload['configs'] = iris.cls("%SYS.ML.Configuration")._GetListOfAllConfigNames()
    payload['defaultConfigName'] = iris.cls("%SYS.ML.Configuration")._GetSystemDefault()
    return jsonify(payload)

# PUT to change configuration
@app.route("/api/integratedML/ml/trainings/configurations", methods=["PUT"])
def changeConfiguration():
    configName = request.get_json()    
    # try:
    #     iris.cls("%SYS.ML.Configuration")._SetSystemDefault(configName['configName'])
    # except:
    #     return make_response(
    #         'Not Found',
    #         204
    #     )
    return jsonify()

# POST new DR configuration
@app.route("/api/integratedML/ml/trainings/configurations/datarobot", methods=["POST"])
def createDRConfiguration():
    configInfo = request.get_json()
    query = "CREATE ML CONFIGURATION DataRobotConfig PROVIDER DataRobot URL '" + configInfo['url'] + "' APITOKEN '" + configInfo['apiToken'] + "'"
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# PUT to change DR config
@app.route("/api/integratedML/ml/trainings/configurations/datarobot", methods=["PUT"])
def alterDRConfiguration():
    configInfo = request.get_json()
    query = "ALTER ML CONFIGURATION DataRobotConfig PROVIDER DataRobot URL '" + configInfo['url'] + "' APITOKEN '" + configInfo['apiToken'] + "'"
    iris.sql.exec(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# ----- VALIDATION RUNS -----

# GET all validation runs
@app.route("/api/integratedML/ml/validations", methods=["GET"])
def getValidationRuns():
    query = "SELECT MODEL_NAME, TRAINED_MODEL_NAME, VALIDATION_RUN_NAME, START_TIMESTAMP, COMPLETED_TIMESTAMP, VALIDATION_DURATION, RUN_STATUS, STATUS_CODE, SETTINGS, VALIDATION_RUN_QUERY FROM INFORMATION_SCHEMA.ML_VALIDATION_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    # Standard operational procedure 
    payload['validationRuns'] = camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    # TODO: same than training runs with the logs
    payload['query'] = "SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_RUNS"
    return jsonify(payload)

# POST new validation run
@app.route("/api/integratedML/ml/validations", methods=["POST"])
def validateModel():
    validationInfo = request.get_json()
    query = "VALIDATE MODEL " + validationInfo['modelName'] 
    if ('validationName' in validationInfo):
        query += " AS " + validationInfo['validationName'] 
    query += " USE " + validationInfo['trainedModelName'] + " FROM " + validationInfo['fromTable']
    try: 
        iris.sql.exec(query)
    except:
        return make_response(
            'Bad Request', 
            400
        )
    payload = {}
    payload['query'] = query
    return jsonify(payload)

# GET metrics for a validation run
@app.route("/api/integratedML/ml/validations/metrics", methods=["GET"])
def getMetrics():
    query = "SELECT METRIC_NAME, METRIC_VALUE, TARGET_VALUE FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS WHERE (VALIDATION_RUN_NAME='" + request.args.get('validationName') + "' AND MODEL_NAME='" + request.args.get('modelName') + "')"
    try:
        rs = iris.sql.exec(query)
    except:
        return make_response(
            'Not Found',
            204
        )
    payload = {}
    # Same as always
    payload['metrics'] = camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

# ----- TRAINED MODELS -----

# GET all trained models
@app.route("/api/integratedML/ml/predictions/models", methods=["GET"])
def getTrainedModels():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS"
    rs = iris.sql.exec(query)
    payload = {}
    payload['models'] = camelize(rs.dataframe().replace({float("Nan"): ""}).to_dict(orient="records"))
    payload['query'] = query
    return jsonify(payload)

# GET prediction for an id from a certain trained model and a certain table
@app.route("/api/integratedML/ml/predictions", methods=["GET"])
def predict():
    query = "SELECT PREDICT(" + request.args.get('model') + " USE " + request.args.get('trainedModel') + ") FROM " + request.args.get('fromTable') + " WHERE ID = ?"
    try:
        rs = iris.sql.exec(query, request.args.get('id'))
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {}
    payload['predictedValue'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

# GET probability
@app.route("/api/integratedML/ml/predictions/probabilities", methods=["GET"])
def probability():
    query = "SELECT PROBABILITY(" + request.args.get('model') + " USE " + request.args.get('trainedModel') + " FOR " + request.args.get('labelValue') + ") FROM " + request.args.get('fromTable') + " WHERE ID = ?"
    try:
        rs = iris.sql.exec(query, request.args.get('id'))
    except:
        return make_response(
            'Bad Request',
            400
        )
    payload = {}
    payload['probability'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)


# ----------------------------------------------------------------
### MAIN PROGRAM
# ----------------------------------------------------------------

if __name__ == '__main__':
    app.run('0.0.0.0', port = "8080")