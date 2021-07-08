import connexion
import six
import iris
import json

from swagger_server.models.passenger import Passenger  # noqa: E501
from swagger_server.models.patient import Patient  # noqa: E501
from swagger_server import util


def alter_dr_configuration(payload):  # noqa: E501
    """Alter DataRobot configuration

    Alter DataRobot ml configuration # noqa: E501

    :param payload: URL to use
    :type payload: dict | bytes

    :rtype: object
    """
    
    return 'do some magic!'


def change_configuration(configName):  # noqa: E501
    """Update configuration

    Update ml configuration # noqa: E501

    :param configName: Configuration name to use
    :type configName: dict | bytes

    :rtype: None
    """
    
    return 'do some magic!'


def create_dr_configuration(payload):  # noqa: E501
    """Create DataRobot configuration

    Create a DataRobot configuration # noqa: E501

    :param payload: URL to use
    :type payload: dict | bytes

    :rtype: object
    """
    
    return 'do some magic!'


def create_model(createInfo):  # noqa: E501
    """Create a Model

    Create a model modelName that predicts predictValue from the table tableName using the variables in the array withVariables # noqa: E501

    :param createInfo: Information about model creation
    :type createInfo: dict | bytes

    :rtype: object
    """
    
    return 'do some magic!'


def create_passenger(payloadBody=None):  # noqa: E501
    """Create a passenger

    Create a new passenger to put in the table # noqa: E501

    :param payloadBody: Request body contents
    :type payloadBody: dict | bytes

    :rtype: object
    """
    query = "INSERT INTO Titanic_Table.Passenger (survived, class, name, sex, age, sibSp, parCh, ticket, fare, cabin, embarked) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    iris.sql.exec(query, payloadBody['survived'], payloadBody['class'], payloadBody['name'], payloadBody['sex'], payloadBody['age'], payloadBody['sibSp'], payloadBody['parCh'], payloadBody['ticket'], payloadBody['fare'], payloadBody['cabin'], payloadBody['embarked'])
    payload = {}
    payload['query'] = query
    return json.dumps(payload)


def create_patient(payloadBody=None):  # noqa: E501
    """Create a patient

    Create a new patient to put in the table # noqa: E501

    :param payloadBody: Request body contents
    :type payloadBody: dict | bytes

    :rtype: object
    """
    return "not yet"


def delete_model(modelName):  # noqa: E501
    """Delete a model

    Delete a model (along with all of its trained runs) # noqa: E501

    :param modelName: Name of the model to be deleted
    :type modelName: str

    :rtype: object
    """
    return 'do some magic!'


def delete_passenger(id):  # noqa: E501
    """Delete passenger {id}

    Delete existing passenger with {id} # noqa: E501

    :param id: 
    :type id: int

    :rtype: None
    """
    return 'do some magic!'


def delete_patient(id):  # noqa: E501
    """Delete patient {id}

    Delete existing patient with {id} # noqa: E501

    :param id: 
    :type id: int

    :rtype: None
    """
    return 'do some magic!'


def get_all_configurations():  # noqa: E501
    """Get configurations

    Get ml configurations # noqa: E501


    :rtype: object
    """
    return 'do some magic!'


def get_all_models():  # noqa: E501
    """Get all models

    Retreive all created models # noqa: E501


    :rtype: object
    """
    return 'do some magic!'


def get_all_passengers(currPage=None, pageSize=None, name=None):  # noqa: E501
    """Get passengers with pagination and search by name possible

    Retreive the total number of Passengers THEN the Passengers from currPage\\*(pageSize-1) to currPage\\*pageSize. Search by name possible too. # noqa: E501

    :param currPage: The current page at which the client is
    :type currPage: 
    :param pageSize: The number of passengers per page
    :type pageSize: 
    :param name: Search passenger by name
    :type name: str

    :rtype: object
    """
    query = "SELECT * FROM Titanic_Table.Passenger"
    rs = iris.sql.exec(query)
    payload = {}
    payload['data'] = rs.dataframe().to_dict(orient="records")
    payload['query'] = query
    return json.dumps(payload)


def get_all_patients(currPage=None, pageSize=None, id=None):  # noqa: E501
    """Get patients with pagination and search by name possible

    Retreive the total number of Patients THEN the Patients from currPage\\*(pageSize-1) to currPage\\*pageSize. Search by name possible too. # noqa: E501

    :param currPage: The current page at which the client is
    :type currPage: 
    :param pageSize: The number of patients per page
    :type pageSize: 
    :param id: Search patient by id
    :type id: str

    :rtype: object
    """
    return 'do some magic!'


def get_log_training_run(trainingName=None):  # noqa: E501
    """Get log of training run

    Get the log of a speecific training run # noqa: E501

    :param trainingName: Name of the training run
    :type trainingName: str

    :rtype: object
    """
    return 'do some magic!'


def get_metrics(modelName=None, validationName=None):  # noqa: E501
    """Get metrics from validation run

    Get all metrics for given validation run # noqa: E501

    :param modelName: The model from which we want to select a validation run
    :type modelName: str
    :param validationName: The validation run we want to retreive the metrics from
    :type validationName: str

    :rtype: object
    """
    return 'do some magic!'


def get_passenger(id):  # noqa: E501
    """Get passenger n°{id} info

    Return the saved informations of passenger n°{id} # noqa: E501

    :param id: 
    :type id: int

    :rtype: Passenger
    """
    query = "SELECT * FROM Titanic_Table.Passenger WHERE ID = " + str(id)
    rs = iris.sql.exec(query)
    payload = {}
    payload['data'] = rs.dataframe().to_dict(orient="records")
    payload['query'] = query
    return json.dumps(payload)


def get_patient(id):  # noqa: E501
    """Get patient n°{id} info

    Return the saved informations of patient n°{id} # noqa: E501

    :param id: 
    :type id: int

    :rtype: Patient
    """
    return 'do some magic!'


def get_state_training_run(modelName=None, trainingName=None):  # noqa: E501
    """Get state of training run

    Get the state of a speecific training run # noqa: E501

    :param modelName: Name of the model
    :type modelName: str
    :param trainingName: Name of the training run
    :type trainingName: str

    :rtype: object
    """
    return 'do some magic!'


def get_table_size(table=None):  # noqa: E501
    """Get nb of objects in table

    Retreive the total number of objects in a table # noqa: E501

    :param table: The table we need the max size from
    :type table: str

    :rtype: object
    """
    return 'do some magic!'


def get_trained_models():  # noqa: E501
    """Get all trained models

    Get all trained models # noqa: E501


    :rtype: object
    """
    return 'do some magic!'


def get_training_runs():  # noqa: E501
    """Get all training runs

    Get all training runs # noqa: E501


    :rtype: object
    """
    return 'do some magic!'


def get_validation_runs():  # noqa: E501
    """Get all validation runs

    Get all validation runs # noqa: E501


    :rtype: object
    """
    return 'do some magic!'


def predict(model, trainedModel, id, fromTable):  # noqa: E501
    """Predict with a model and an id

    Predict with a certain model, a certain trained model and a certain id from a certain table # noqa: E501

    :param model: Model to predict with
    :type model: str
    :param trainedModel: Trained Model to predict with
    :type trainedModel: str
    :param id: ID to predict with
    :type id: str
    :param fromTable: Table to predict from
    :type fromTable: str

    :rtype: object
    """
    return 'do some magic!'


def probability(model, trainedModel, labelValue, id, fromTable):  # noqa: E501
    """Probabilities of having labelValue value predicted

    Gives the probability of being predicted the labelValue with a certain model, a certain trained model and a certain id from a certain table # noqa: E501

    :param model: Model to predict with
    :type model: str
    :param trainedModel: Trained Model to predict with
    :type trainedModel: str
    :param labelValue: Label of the value for probability
    :type labelValue: str
    :param id: ID to predict with
    :type id: str
    :param fromTable: Table to predict from
    :type fromTable: str

    :rtype: object
    """
    return 'do some magic!'


def purge_model(modelName):  # noqa: E501
    """Purge runs from model

    Purge runs from a model # noqa: E501

    :param modelName: 
    :type modelName: str

    :rtype: object
    """
    return 'do some magic!'


def train_model(trainingInfo):  # noqa: E501
    """Train a Model

    Train the Model named modelName and gives the name trainingName to the training run # noqa: E501

    :param trainingInfo: Training informations
    :type trainingInfo: dict | bytes

    :rtype: object
    """
    
    return 'do some magic!'


def update_passenger(id, payloadBody=None):  # noqa: E501
    """Update passenger {id} info

    Update already existing passenger {id} with information in the payload # noqa: E501

    :param id: 
    :type id: int
    :param payloadBody: Request body contents
    :type payloadBody: dict | bytes

    :rtype: None
    """
    return "not yet"


def update_patient(id, payloadBody=None):  # noqa: E501
    """Update patient {id} info

    Update already existing patient {id} with information in the payload # noqa: E501

    :param id: 
    :type id: int
    :param payloadBody: Request body contents
    :type payloadBody: dict | bytes

    :rtype: None
    """
    
    return 'do some magic!'


def validate_model(validationInfo):  # noqa: E501
    """Validate a Model

    Validate the Model named modelName using trainedModelName trained model on the fromTable table and gives the name validationName to the validation run # noqa: E501

    :param validationInfo: Validation informations
    :type validationInfo: dict | bytes

    :rtype: object
    """
    
    return 'do some magic!'
