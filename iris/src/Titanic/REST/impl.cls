/// Rest API for the Integrated ML Demo on the Titanic database<br/>
/// Business logic class defined by OpenAPI in Titanic.REST.spec<br/>
/// Created Jun 15, 2021 10:29:46
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
    set tDyna = []
    if ($Data(name)) {
        set myquery = "SELECT Id FROM Titanic_Table.Passenger WHERE Titanic_Table.Passenger.name %STARTSWITH ?"
        set tStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(tStatement.%Prepare(myquery))
        set tRs = tStatement.%Execute(name)
        while tRs.%Next() {
            do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
            set tElement = {}.%FromJSON(tStream)
            #; set tElement.Id = tRs.Id
            do tDyna.%Push(tElement) 
        }
    } 
    else {
        set tStartRow = pageSize * (currPage - 1)
        set tEndRow = tStartRow + pageSize
        set tRow = 0
        set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
        do tDyna.%Push(0)
        while (tRs.%Next() && (tRow < tEndRow)) {
            set tRow = tRow + 1
            continue:(tRow<=tStartRow)
            do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
            set tElement = {}.%FromJSON(tStream)
            #; set tElement.Id = tRs.Id
            do tDyna.%Push(tElement)
        }
        while (tRs.%Next()) {}
        do tDyna.%Set(0, tRs.%ROWCOUNT)
    }
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
    set tDyna = []
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
        do tDyna.%Push(tModel)
    }
    quit tDyna
}

/// Create a model modelName that predicts predictValue from the table tableName using the variables in the array withVariables<br/>
/// The method arguments hold values for:<br/>
///     createInfo, Information about model creation<br/>
ClassMethod createModel(createInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(createInfo)
    set myquery = "CREATE MODEL "_tInfo.modelName_" PREDICTING("_tInfo.predictValue_") FROM (SELECT * FROM Titanic_Table.Passenger WHERE ID < 892)"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    quit {}
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
    quit {}
}

/// Get all training runs
ClassMethod getTrainingRuns() As %Stream.Object
{
    set tDyna = []
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
        do tDyna.%Push(tModel)
    }
    quit tDyna
}

/// Train the Model named modelName and gives the name runName to the training run<br/>
/// The method arguments hold values for:<br/>
///     trainingInfo, Training informations<br/>
ClassMethod trainModel(trainingInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(trainingInfo)
    set myquery = "TRAIN MODEL "_tInfo.modelName_" AS "_tInfo.trainingName
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    quit {}
}

/// Update ml configuration (H20 or AutoML, for now)<br/>
/// The method arguments hold values for:<br/>
///     configName, Configuration name to use<br/>
ClassMethod changeConfiguration(configName As %Stream.Object) As %Stream.Object
{
    set tConfig = configName.Read()
    set myquery = "set ML CONFIGURATION %"_tConfig
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    quit {}
}

/// Get all trained models
ClassMethod getTrainedModels() As %Stream.Object
{
    set tDyna = []
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
        do tDyna.%Push(tModel)
    }
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
    quit tDyna
}

}
