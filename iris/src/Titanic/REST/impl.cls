/// Rest API for the Integrated ML Demo on the Titanic database<br/>
/// Business logic class defined by OpenAPI in Titanic.REST.spec<br/>
/// Updated Jun 15, 2021 07:50:06
Class Titanic.REST.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// IntegratedMLDemo general information
ClassMethod GetInfo() As %Stream.Object
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
}

/// Retreive the total number of Passengers THEN the Passengers from currpage\*(pagesize-1) to currpage\*pagesize<br/>
/// The method arguments hold values for:<br/>
///     currpage, The current page at which the client is<br/>
///     pagesize, The number of passengers per page<br/>
ClassMethod GetAllPassengers(currpage As %Float, pagesize As %Float) As %Stream.Object
{
    set tStartRow = pagesize * (currpage - 1)
	set tEndRow = tStartRow + pagesize
    set tRow = 0
    set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
    set tDyna = []
    do tDyna.%Push(0)
    while (tRs.%Next() && (tRow < tEndRow)) {
        set tRow = tRow + 1
        continue:(tRow<=tStartRow)
        do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
        set tElement = {}.%FromJSON(tStream)
        set tElement.Id = tRs.Id
        do tDyna.%Push(tElement)
    }
    while (tRs.%Next()) {}
    do tDyna.%Set(0, tRs.%ROWCOUNT)
    Quit tDyna
}

/// Create a new Titanic.Table.Passenger record<br/>
/// The method arguments hold values for:<br/>
///     payloadBody, Request body contents<br/>
ClassMethod CreatePassenger(payloadBody As %Stream.Object) As %Stream.Object
{
    set tPassenger = ##class(Titanic.Table.Passenger).%New()
    set tDyna = ""
    try {
        $$$ThrowOnError(tPassenger.%JSONImport(payloadBody)) 
        do tPassenger.%Save()
        do tPassenger.%JSONExportToStream(.tStream)
        set tDyna = {}.%FromJSON(tStream)
        set tDyna.Id = tPassenger.%Id()
    } catch(ex) {
        Do ##class(%REST.Impl).%ReportRESTError(400,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions")) 
    }
    Quit tDyna
}

/// Return one record of Titanic.Table.Passenger<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod GetPassenger(id As %Integer) As %Stream.Object
{
    set tDyna = ""
    If ##class(Titanic.Table.Passenger).%ExistsId(id) {
        do ##class(Titanic.Table.Passenger).%OpenId(id).%JSONExportToStream(.tStream)
        set tDyna = {}.%FromJSON(tStream)
        set tDyna.Id = id
    } Else {
        Do ..%SetStatusCode(204)
    }
    Quit tDyna
}

/// Update a record of Titanic.Table.Passenger with id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     payloadBody, Request body contents<br/>
ClassMethod UpdatePassenger(id As %Integer, payloadBody As %Stream.Object) As %Stream.Object
{
    If ##class(Titanic.Table.Passenger).%ExistsId(id) {
        set tPassenger = ##class(Titanic.Table.Passenger).%OpenId(id)
        do tPassenger.%JSONImport(payloadBody)
        do tPassenger.%Save()
        do tPassenger.%JSONExportToStream(.tStream)
        set tDyna = {}.%FromJSON(tStream)
        set tDyna.Id = tPassenger.%Id()
        Quit tDyna
    } Else {
        Do ..%SetStatusCode(204)
        Quit 
    }
}

/// Delete a record of Titanic.Table.Passenger with id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod DeletePassenger(id As %Integer) As %Stream.Object
{
    If ##class(Titanic.Table.Passenger).%ExistsId(id) {
        Quit ##class(Titanic.Table.Passenger).%DeleteId(id)
    } Else {
        Do ..%SetStatusCode(204)
        Quit 
    }
}

/// Retreive all the records of Titanic.Table.Passenger with "name" in their name<br/>
/// The method arguments hold values for:<br/>
///     name, Search passenger by name<br/>
ClassMethod SearchPassengers(name As %String) As %Stream.Object
{
    set tDyna = []
    SET myquery = "SELECT Id FROM Titanic_Table.Passenger WHERE Titanic_Table.Passenger.Name %STARTSWITH ?"
    SET tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    SET tRs = tStatement.%Execute(name)
    while tRs.%Next() {
        do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
        set tElement = {}.%FromJSON(tStream)
        set tElement.Id = tRs.Id
        do tDyna.%Push(tElement)
    }
    Quit tDyna
}

/// Retreive all created Models
ClassMethod GetAllModels() As %Stream.Object
{
    set tDyna = []
    SET myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_MODELS"
    SET tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    SET tRs = tStatement.%Execute()
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."MODEL_NAME" = tRs."MODEL_NAME"
        set tModel."DESCRIPTION" = tRs."DESCRIPTION"
        set tModel."PREDICTING_COLUMN_NAME" = tRs."PREDICTING_COLUMN_NAME"
        set tModel."PREDICTING_COLUMN_TYPE" = tRs."PREDICTING_COLUMN_TYPE"
        set tModel."WITH_COLUMNS" = tRs."WITH_COLUMNS"
        set tModel."CREATE_TIMESTAMP" = tRs."CREATE_TIMESTAMP"
        set tModel."DEFAULT_TRAINED_MODEL_NAME" = tRs."DEFAULT_TRAINED_MODEL_NAME"
        set tModel."DEFAULT_SETTINGS" = tRs."DEFAULT_SETTINGS"
        set tModel."DEFAULT_TRAINING_QUERY" = tRs."DEFAULT_TRAINING_QUERY"
        do tDyna.%Push(tModel)
    }
    Quit tDyna
}

/// Create a Model named "modelName" and predicting "predicting"<br/>
/// The method arguments hold values for:<br/>
///     modelName, The name of the Model to be created<br/>
///     predicting, The name of the value to predict<br/>
ClassMethod CreateModel(modelName As %String, predicting As %String) As %Stream.Object
{
    set myquery = "CREATE MODEL "_modelName_" PREDICTING("_predicting_") FROM Titanic_Table.Passenger"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    Quit {}
}

/// Delete a Model (along with all of its trained runs)<br/>
/// The method arguments hold values for:<br/>
///     modelName, Name of the model to be deleted<br/>
ClassMethod DeleteModel(modelName As %String) As %Stream.Object
{
    set myquery = "DROP MODEL "_modelName
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    Quit {}
}

/// Retreive all training runs
ClassMethod GetTrainingRuns() As %Stream.Object
{
    set tDyna = []
    SET myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS"
    SET tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    SET tRs = tStatement.%Execute()
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."MODEL_NAME" = tRs."MODEL_NAME"
        set tModel."TRAINING_RUN_NAME" = tRs."TRAINING_RUN_NAME"
        set tModel."PROVIDER" = tRs."PROVIDER"
        set tModel."START_TIMESTAMP" = tRs."START_TIMESTAMP"
        set tModel."COMPLETED_TIMESTAMP" = tRs."COMPLETED_TIMESTAMP"
        set tModel."TRAINING_DURATION" = tRs."TRAINING_DURATION"
        set tModel."RUN_STATUS" = tRs."RUN_STATUS"
        set tModel."STATUS_CODE" = tRs."STATUS_CODE"
        set tModel."LOG" = tRs."LOG"
        set tModel."SETTINGS" = tRs."SETTINGS"
        set tModel."ML_CONFIGURATION_NAME" = tRs."ML_CONFIGURATION_NAME"
        set tModel."TRAINING_RUN_QUERY" = tRs."TRAINING_RUN_QUERY"
        do tDyna.%Push(tModel)
    }
    Quit tDyna
}

/// Train the Model named "modelName" and gives the name "runName" to the training run<br/>
/// The method arguments hold values for:<br/>
///     modelName, The name of the Model to be trained<br/>
///     runName, The name of the training run<br/>
ClassMethod TrainModel(modelName As %String, runName As %String) As %Stream.Object
{
    set myquery = "TRAIN MODEL "_modelName_" AS "_runName
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    Quit {}
}

/// Retreive all trained models
ClassMethod GetTrainedModels() As %Stream.Object
{
    set tDyna = []
    SET myquery = "SELECT * FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS"
    SET tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    SET tRs = tStatement.%Execute()	 	 	
    while (tRs.%Next()) {
        set tModel = {}
        set tModel."MODEL_NAME" = tRs."MODEL_NAME"
        set tModel."TRAINED_MODEL_NAME" = tRs."TRAINED_MODEL_NAME"
        set tModel."PROVIDER" = tRs."PROVIDER"
        set tModel."TRAINED_TIMESTAMP" = tRs."TRAINED_TIMESTAMP"
        set tModel."MODEL_TYPE" = tRs."MODEL_TYPE"
        set tModel."MODEL_INFO" = tRs."MODEL_INFO"
        do tDyna.%Push(tModel)
    }
    Quit tDyna
}

/// Predict<br/>
/// The method arguments hold values for:<br/>
///     model, Model to predict with<br/>
///     trainedModel, Trained Model to predict with<br/>
///     passenger, Id of passenger to predict<br/>
/// WARNING: This method's signature has changed.
ClassMethod Predict(model As %String, trainedModel As %String, passenger As %String) As %Stream.Object
{
    set myquery = "SELECT PREDICT("_model_" USE "_trainedModel_") AS Result FROM Titanic_Table.Passenger WHERE ID="_passenger
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    Quit tRs."Result"
}

/// Change ml configuration (H20 or AutoML)<br/>
/// The method arguments hold values for:<br/>
///     payloadBody, Request body contents<br/>
ClassMethod ChangeConfiguration(payloadBody As %Stream.Object) As %Stream.Object
{
    set tConfig = payloadBody.Read()
    SET myquery = "SET ML CONFIGURATION %"_tConfig
    SET tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    SET tRs = tStatement.%Execute()
    Quit {}
}

}
