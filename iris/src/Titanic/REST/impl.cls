/// Rest API for the Integrated ML Demo on the Titanic database<br/>
/// Business logic class defined by OpenAPI in Titanic.REST.spec<br/>
/// Updated Jun 25, 2021 07:48:12
Class Titanic.REST.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// if ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Retreive the total number of Passengers THEN the Passengers from currPage\*(pageSize-1) to currPage\*pageSize. Search by name possible too.<br/>
/// The method arguments hold values for:<br/>
///     currPage, The current page at which the client is<br/>
///     pageSize, The number of passengers per page<br/>
///     name, Search passenger by name<br/>
ClassMethod getAllPassengers(currPage As %Float, pageSize As %Float, name As %String) As %Stream.Object
{
    set tDyna = {}
    set tPassengers = []
    if ($Data(name)) {
        set myquery = "SELECT Id FROM Titanic_Table.Passenger WHERE Titanic_Table.Passenger.name %STARTSWITH ?"
        set tStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(tStatement.%Prepare(myquery))
        set tRs = tStatement.%Execute(name)
        while tRs.%Next() {
            do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
            do tPassengers.%Push({}.%FromJSON(tStream)) 
        }
        set tDyna."total" = tRs.%ROWCOUNT
    } 
    else {
        set tStartRow = pageSize * (currPage - 1)
        set tEndRow = tStartRow + pageSize
        set tRow = 0
        set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
        while (tRs.%Next() && (tRow < tEndRow)) {
            set tRow = tRow + 1
            continue:(tRow<=tStartRow)
            do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
            do tPassengers.%Push({}.%FromJSON(tStream))
        }
        while (tRs.%Next()) {}
        set tDyna."total" = tRs.%ROWCOUNT
    }
    set tDyna."passengers" = tPassengers
    quit tDyna
}

/// Create a new passenger to put in the table<br/>
/// The method arguments hold values for:<br/>
///     payloadBody, Request body contents<br/>
ClassMethod createPassenger(payloadBody As %Stream.Object) As %Stream.Object
{
    set tPassenger = ##class(Titanic.Table.Passenger).%New()
    set tDyna = {}
    try {
        $$$ThrowOnError(tPassenger.%JSONImport(payloadBody)) 
        do tPassenger.%Save()
        set tPassenger.passengerId = tPassenger.%Id()
        do tPassenger.%Save()
        set tDyna.passengerId = tPassenger.%Id()
    } catch(ex) {
        do ##class(%REST.Impl).%ReportRESTError(400,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions")) 
    }
    quit tDyna
}

/// Return the saved informations of passenger n°{id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod getPassenger(id As %Integer) As %Stream.Object
{
    set tDyna = {}
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        do ##class(Titanic.Table.Passenger).%OpenId(id).%JSONExportToStream(.tStream)
        set tDyna = {}.%FromJSON(tStream)
    } else {
        Do ..%SetStatusCode(204)
    }
    quit tDyna
}

/// Update already existing passenger {id} with information in the payload<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     payloadBody, Request body contents<br/>
ClassMethod updatePassenger(id As %Integer, payloadBody As %Stream.Object) As %Stream.Object
{
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        set tPassenger = ##class(Titanic.Table.Passenger).%OpenId(id)
        do tPassenger.%JSONImport(payloadBody)
        do tPassenger.%Save()
    } else {
        do ..%SetStatusCode(204)
    }
    quit {}
}

/// Delete existing passenger with {id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod deletePassenger(id As %Integer) As %Stream.Object
{
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        do ##class(Titanic.Table.Passenger).%DeleteId(id)
    } else {
        do ..%SetStatusCode(204)
    }
    quit {}
}

/// Retreive all created models
ClassMethod getAllModels() As %Stream.Object
{
    set tDyna = {}
    set tModels = []
    set myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_MODELS"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."modelName" = tRs."MODEL_NAME"
        set tModel."description" = tRs."DESCRIPTION"
        set tModel."predictingColumnName" = tRs."PREDICTING_COLUMN_NAME"
        set tModel."predictingColumnType" = tRs."PREDICTING_COLUMN_TYPE"
        set tModel."withColumns" = tRs."WITH_COLUMNS"
        set tModel."createTimestamp" = tRs."CREATE_TIMESTAMP"
        set tModel."defaultTrainedModelName" = tRs."DEFAULT_TRAINED_MODEL_NAME"
        set tModel."defaultSettings" = tRs."DEFAULT_SETTINGS"
        set tModel."defaultTrainingQuery" = tRs."DEFAULT_TRAINING_QUERY"
        do tModels.%Push(tModel)
    }
    set tDyna."models" = tModels
    set tDyna."query" = myquery
    quit tDyna
}

/// Create a model modelName that predicts predictValue from the table tableName using the variables in the array withVariables<br/>
/// The method arguments hold values for:<br/>
///     createInfo, Information about model creation<br/>
ClassMethod createModel(createInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(createInfo)
    set myquery = "CREATE MODEL "_tInfo.modelName_" PREDICTING("_tInfo.predictValue_")"
    if (tInfo.%IsDefined("withVariables")) {
        set myquery = myquery_" WITH("
        set titer = tInfo.withVariables.%GetIterator()
        do titer.%GetNext(, .value)
        set myquery = myquery_value
        while titer.%GetNext(, .value) {
            set myquery = myquery_", "
            set myquery = myquery_value
        }
        set myquery = myquery_")"
    }
    set myquery = myquery_" FROM "_tInfo.fromTable
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

/// Delete a model (along with all of its trained runs)<br/>
/// The method arguments hold values for:<br/>
///     modelName, Name of the model to be deleted<br/>
ClassMethod deleteModel(modelName As %String) As %Stream.Object
{
    set myquery = "DROP MODEL "_modelName
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

/// Get all training runs
ClassMethod getTrainingRuns() As %Stream.Object
{
    set tDyna = {}
    set tModels = []
    set myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."modelName" = tRs."MODEL_NAME"
        set tModel."trainingRunName" = tRs."TRAINING_RUN_NAME"
        set tModel."provider" = tRs."PROVIDER"
        set tModel."startTimestamp" = tRs."START_TIMESTAMP"
        set tModel."completedTimestamp" = tRs."COMPLETED_TIMESTAMP"
        set tModel."trainingDuration" = tRs."TRAINING_DURATION"
        set tModel."runStatus" = tRs."RUN_STATUS"
        set tModel."statusCode" = tRs."STATUS_CODE"
        set tModel."log" = tRs."LOG"
        set tModel."settings" = tRs."SETTINGS"
        set tModel."mlConfigurationName" = tRs."ML_CONFIGURATION_NAME"
        set tModel."trainingRunQuery" = tRs."TRAINING_RUN_QUERY"
        do tModels.%Push(tModel)
    }
    set tDyna."trainingRuns" = tModels
    set tDyna."query" = myquery
    quit tDyna
}

/// Train the Model named modelName and gives the name trainingName to the training run<br/>
/// The method arguments hold values for:<br/>
///     trainingInfo, Training informations<br/>
ClassMethod trainModel(trainingInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(trainingInfo)
    set myquery = "TRAIN MODEL "_tInfo.modelName_" AS "_tInfo.trainingName
    job ..executeQuery(myquery)
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

ClassMethod executeQuery(pQuery As %String) As %Status
{
    set sc = $$$OK
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(pQuery))
    set tRs = tStatement.%Execute()
    return sc
}

/// Update ml configuration (H20 or AutoML, for now)<br/>
/// The method arguments hold values for:<br/>
///     configName, Configuration name to use<br/>
ClassMethod changeConfiguration(configName As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(configName)    
    set myquery = "SET ML CONFIGURATION %"_tInfo.configName
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

/// Get all trained models
ClassMethod getTrainedModels() As %Stream.Object
{
    set tDyna = {}
    set tModels = []
    set myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()	 	 	
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."modelName" = tRs."MODEL_NAME"
        set tModel."trainedModelName" = tRs."TRAINED_MODEL_NAME"
        set tModel."provider" = tRs."PROVIDER"
        set tModel."trainedTimestamp" = tRs."TRAINED_TIMESTAMP"
        set tModel."modelType" = tRs."MODEL_TYPE"
        set tModel."modelInfo" = tRs."MODEL_INFO"
        do tModels.%Push(tModel)
    }
    set tDyna."models" = tModels
    set tDyna."query" = myquery
    quit tDyna
}

/// Predict with a certain model, a certain trained model and a certain passenger<br/>
/// The method arguments hold values for:<br/>
///     model, Model to predict with<br/>
///     trainedModel, Trained Model to predict with<br/>
///     passenger, Id of passenger to predict<br/>
ClassMethod predict(model As %String, trainedModel As %String, passenger As %String) As %Stream.Object
{
    set myquery = "SELECT PREDICT("_model_" USE "_trainedModel_") FROM Titanic_Table.Passenger WHERE ID="_passenger
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."predictedValue" = tRs.%Get("Expression_1") 
    set tDyna."query" = myquery
    quit tDyna
}

/// Get all validation runs
ClassMethod getValidationRuns() As %Stream.Object
{
    set tDyna = {}
    set tRuns = []
    set myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_RUNS"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()	 	 	
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."modelName" = tRs."MODEL_NAME"
        set tModel."trainedModelName" = tRs."TRAINED_MODEL_NAME"
        set tModel."validationRunName" = tRs."VALIDATION_RUN_NAME"
        set tModel."startTimestamp" = tRs."START_TIMESTAMP"
        set tModel."completedTimestamp" = tRs."COMPLETED_TIMESTAMP"
        set tModel."validationDuration" = tRs."VALIDATION_DURATION"
        set tModel."runStatus" = tRs."RUN_STATUS"
        set tModel."statusCode" = tRs."STATUS_CODE"
        set tModel."log" = tRs."LOG"
        set tModel."settings" = tRs."SETTINGS"
        set tModel."validationRunQuery" = tRs."VALIDATION_RUN_QUERY"
        do tRuns.%Push(tModel)
    }
    set tDyna."trainingRuns" = tRuns
    set tDyna."query" = myquery
    quit tDyna
}

/// Validate the Model named modelName using trainedModelName trained model on the fromTable table and gives the name validationName to the validation run<br/>
/// The method arguments hold values for:<br/>
///     validationInfo, Validation informations<br/>
ClassMethod validateModel(validationInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(validationInfo)
    set myquery = "VALIDATE MODEL "_tInfo.modelName_" AS "_tInfo.validationName_" USE "_tInfo.trainedModelName_" FROM "_tInfo.fromTable
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

/// Get all metrics for given validation run<br/>
/// The method arguments hold values for:<br/>
///     modelName, The model from which we want to select a validation run<br/>
///     validationName, The validation run we want to retreive the metrics from<br/>
ClassMethod getMetrics(modelName As %String, validationName As %String) As %Stream.Object
{
    set tDyna = {}
    set tMetrics = []
    set tLine = ""
    set myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS WHERE (VALIDATION_RUN_NAME='"_validationName_"' AND MODEL_NAME='"_modelName_"')"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()	 	 
    while (tRs.%Next()) {
        set tLine = tRs."METRIC_NAME"_" : "_tRs."METRIC_VALUE"
        if ($length(tRs."TARGET_VALUE")) {
            set tLine = tLine_"  - for target value: "_tRs."TARGET_VALUE"
        }
        do tMetrics.%Push(tLine)
    }
    set tDyna."metrics" = tMetrics
    set tDyna."query" = myquery
    quit tDyna
}

/// Gives the probability of being predicted the labelValue with a certain model, a certain trained model and a certain passenger<br/>
/// The method arguments hold values for:<br/>
///     model, Model to predict with<br/>
///     trainedModel, Trained Model to predict with<br/>
///     labelValue, Label of the value for probability<br/>
///     passenger, ID of the passenger<br/>
ClassMethod probability(model As %String, trainedModel As %String, labelValue As %String, passenger As %String) As %Stream.Object
{
    set myquery = "SELECT PROBABILITY("_model_" USE "_trainedModel_" FOR '"_labelValue_"') FROM Titanic_Table.Passenger WHERE ID="_passenger
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."probability" = tRs.%Get("Expression_1") 
    set tDyna."query" = myquery
    quit tDyna
}

/// Get the state of a specific training run<br/>
/// The method arguments hold values for:<br/>
///     modelName, Name of the model<br/>
///     trainingName, Name of the training run<br/>
ClassMethod getStateTrainingRun(modelName As %String, trainingName As %String) As %Stream.Object
{
    set myquery = "SELECT RUN_STATUS "
        _"FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS "
        _"WHERE TRAINING_RUN_NAME=? "
        _"AND MODEL_NAME=?"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute(trainingName, modelName)
    do tRs.%Next()
    set tDyna = {}
    set tDyna."state" = tRs.%Get("RUN_STATUS") 
    set tDyna."query" = myquery
    quit tDyna
}

}
