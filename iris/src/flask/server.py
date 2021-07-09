from flask import Flask, jsonify, request, make_response
from flask_cors import CORS
from multiprocessing import Process

import iris

app = Flask(__name__)
CORS(app)

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
        # All passengers
        else:
            rs = iris.sql.exec(query)
    payload = {}
    payload['passengers'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
    rs = iris.sql.exec("SELECT MAX(ID) FROM Titanic_Table.Passenger")
    payload['maxId'] = rs.__next__()[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/passengers", methods=["POST"])
def createPassenger():
    passenger = request.get_json()
    query = "INSERT INTO Titanic_Table.Passenger (survived, class, name, sex, age, sibSp, parCh, ticket, fare, cabin, embarked, passengerId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    newId = int(iris.sql.exec("SELECT MAX(ID) FROM Titanic_Table.Passenger").__next__()[0]) + 1
    iris.sql.exec(query, passenger['survived'], passenger['class'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'], newId)
    payload = {
        'query': query,
        'passengerId': newId
    }
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["GET"])
def getPassenger(id):
    payload = {}
    query = "SELECT * FROM Titanic_Table.Passenger WHERE ID = " + str(id)
    rs = iris.sql.exec(query)
    passenger = rs.dataframe().replace({float("Nan"): None})
    if (passenger.empty):
        return make_response(
            'Not Found',
            204
        )
    else:
        payload['passenger'] = passenger.to_dict(orient="records")[0]
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["PUT"])
def updatePassenger(id):
    passenger = request.get_json()
    query = "UPDATE Titanic_Table.Passenger SET survived = ?, class = ?, name = ?, sex = ?, age = ?, sibSp = ?, parCh = ?, ticket = ?, fare = ?, cabin = ?, embarked = ? WHERE ID = ?"
    iris.sql.exec(query, passenger['survived'], passenger['class'], passenger['name'], passenger['sex'], passenger['age'], passenger['sibSp'], passenger['parCh'], passenger['ticket'], passenger['fare'], passenger['cabin'], passenger['embarked'], id)
    payload = {
        'query': query,
    }
    return jsonify(payload)

@app.route("/api/integratedML/passengers/<int:id>", methods=["DELETE"])
def deletePassenger(id):
    payload = {}
    query = "SELECT ID FROM Titanic_Table.Passenger WHERE ID = " + str(id)
    rs = iris.sql.exec(query)
    passenger = rs.dataframe().replace({float("Nan"): None})
    if (passenger.empty):
        return make_response(
            'Not Found',
            204
        )
    else:
        query = "DELETE FROM Titanic_Table.Passenger WHERE ID = " + str(id)
        iris.sql.exec(query)
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
    payload['models'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
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
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    print(rs)
    payload['trainingRuns'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings", methods=["POST"])
def trainModel():
    trainingInfo = request.get_json()
    query = "TRAIN MODEL " + trainingInfo['modelName'] + " AS " + trainingInfo['trainingName'] + " FROM " + trainingInfo['fromTable']
    # iris.sql.exec(query)
    # trainProcess = Process(target = (iris.cls("IntegratedML.REST.impl").executeQuery), args=(query,))
    # trainProcess.start()
    iris.cls("IntegratedML.REST.impl").executeQuery(query)
    payload = {}
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/trainings/states", methods=["GET"])
def getStateTrainingRun():
    query = "SELECT RUN_STATUS FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME=? AND MODEL_NAME=?"
    rs = iris.sql.exec(query, request.args.get('trainingName'), request.args.get('modelName'))
    payload = {}
    print(rs)
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
    return 

@app.route("/api/integratedML/ml/validations", methods=["GET"])
def getValidationRuns():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_RUNS"
    rs = iris.sql.exec(query)
    payload = {}
    print(rs)
    payload['validationRuns'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
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
    print(rs)
    payload['metrics'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
    payload['query'] = query
    return jsonify(payload)

@app.route("/api/integratedML/ml/predictions/models", methods=["GET"])
def getTrainedModels():
    query = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS"
    rs = iris.sql.exec(query)
    payload = {}
    print(rs)
    payload['models'] = rs.dataframe().replace({float("Nan"): None}).to_dict(orient="records")
    payload['query'] = query
    return jsonify(payload)

if __name__ == '__main__':
    app.run('0.0.0.0', 8080)