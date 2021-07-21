/// Rest API for the Integrated ML Demo<br/>
/// Business logic class defined by OpenAPI in IntegratedML.REST.spec<br/>
/// Updated Jul 16, 2021 09:32:20
Class IntegratedML.REST.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// if ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

// ----------------------------------------------------------------

// CRUD FOR TITANIC_TABLE.PASSENGER

// ----------------------------------------------------------------

/// Retreive the Passengers from the current page with specific page length. Search by name possible too.<br/>
/// The method arguments hold values for:<br/>
///     currPage, The current page at which the client is<br/>
///     pageSize, The number of passengers per page<br/>
///     name, Search passenger by name<br/>
/// WARNING: This method's signature has changed.
ClassMethod getAllPassengers(currPage As %Float, pageSize As %Float, name As %String) As %Stream.Object
{
    set tDyna = {}
    set tPassengers = []
    // Query equivalent in case of no search by name
    set myquery = "SELECT Id FROM Titanic_Table.Passenger"
    if ($Data(name)) {
        // If search by name
        set myquery = "SELECT Id FROM Titanic_Table.Passenger WHERE name %STARTSWITH ?"
        set tStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(tStatement.%Prepare(myquery))
        set tRs = tStatement.%Execute(name)
        while tRs.%Next() {
            do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
            set tp = {}.%FromJSON(tStream)
            set tp."passengerId" = tRs.ID
            do tPassengers.%Push(tp)
        }
    } 
    else {
        if ($Data(pageSize) && $Data(currPage)) {
            // if pagination 
            set tStartRow = pageSize * (currPage - 1)
            set tEndRow = tStartRow + pageSize
            set tRow = 0
            set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
            while (tRs.%Next() && (tRow < tEndRow)) {
                set tRow = tRow + 1
                continue:(tRow<=tStartRow)
                do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
                set tp = {}.%FromJSON(tStream)
                set tp."passengerId" = tRs.ID
                do tPassengers.%Push(tp)
            }
        } else {
            // else return all passengers
            set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
            while (tRs.%Next()) {
                do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
                set tp = {}.%FromJSON(tStream)
                set tp."passengerId" = tRs.ID
                do tPassengers.%Push(tp)
            }
        }
    }
    set myquery = "SELECT COUNT(*) AS total FROM Titanic_Table.Passenger"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."total" = tRs."total"
    set tDyna."query" = myquery
    set tDyna."passengers" = tPassengers
    quit tDyna
}

/// Create a new passenger to put in the table<br/>
/// The method arguments hold values for:<br/>
///     payloadBody, Request body contents<br/>
/// WARNING: This method's signature has changed.
ClassMethod createPassenger(payloadBody As %Stream.Object) As %Stream.Object
{
    set tPassenger = ##class(Titanic.Table.Passenger).%New()
    set tDyna = {}
    try {
        $$$ThrowOnError(tPassenger.%JSONImport(payloadBody)) 
        do tPassenger.%Save()
        set tDyna.passengerId = tPassenger.%Id()
    } catch(ex) {
        do ##class(%REST.Impl).%ReportRESTError(400,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions")) 
    }
    // Query equivalent
    set tDyna."query" = "INSERT INTO Titanic_Table.Passenger (survived, pclass, name, sex, age, sibSp, parCh, ticket, fare, cabin, embarked) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    quit tDyna
}

/// Return the saved informations of passenger n°{id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
/// WARNING: This method's signature has changed.
ClassMethod getPassenger(id As %Integer) As %Stream.Object
{
    set tp = {}
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        do ##class(Titanic.Table.Passenger).%OpenId(id).%JSONExportToStream(.tStream)
        set tp = {}.%FromJSON(tStream)
        set tp."passengerId" = id
    } else {
        Do ..%SetStatusCode(204)
    }
    set tDyna = {}
    set tDyna."passenger" = tp
    // Query equivalent
    set tDyna."query" = "SELECT * FROM Titanic_Table.Passenger WHERE ID = ?"
    quit tDyna
}

/// Update already existing passenger {id} with information in the payload<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     payloadBody, Request body contents<br/>
/// WARNING: This method's signature has changed.
ClassMethod updatePassenger(id As %Integer, payloadBody As %Stream.Object) As %Stream.Object
{
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        set tPassenger = ##class(Titanic.Table.Passenger).%OpenId(id)
        do tPassenger.%JSONImport(payloadBody)
        do tPassenger.%Save()
    } else {
        do ..%SetStatusCode(204)
    }
    set tDyna = {}
    // Query equivalent
    set tDyna."query" = "UPDATE Titanic_Table.Passenger SET survived = ?, pclass = ?, name = ?, sex = ?, age = ?, sibSp = ?, parCh = ?, ticket = ?, fare = ?, cabin = ?, embarked = ? WHERE ID = ?"
    quit tDyna
}

/// Delete existing passenger with {id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
/// WARNING: This method's signature has changed.
ClassMethod deletePassenger(id As %Integer) As %Stream.Object
{
    if ##class(Titanic.Table.Passenger).%ExistsId(id) {
        do ##class(Titanic.Table.Passenger).%DeleteId(id)
    } else {
        do ..%SetStatusCode(204)
    }
    set tDyna = {}
    // Query equivalent
    set tDyna."query" = "DELETE FROM Titanic_Table.Passenger WHERE ID = ?"
    quit tDyna
}

// ----------------------------------------------------------------

// CRUD FOR NOSHO_TABLE.APPOINTMENT

// ----------------------------------------------------------------

/// Retreive the total number of Patients THEN the Patients from currPage\*(pageSize-1) to currPage\*pageSize. Search by name possible too.<br/>
/// The method arguments hold values for:<br/>
///     currPage, The current page at which the client is<br/>
///     pageSize, The number of patients per page<br/>
///     id, Search patient by id<br/>
/// WARNING: This method's signature has changed.
ClassMethod getAllPatients(currPage As %Float, pageSize As %Float, id As %String) As %Stream.Object
{
    set tDyna = {}
    set tPatients = []
    if ($Data(id)) {
        do ##class(Noshow.Table.Appointment).%OpenId(id).%JSONExportToStream(.tStream)
        set tp = {}.%FromJSON(tStream)
        set tp."patientId" = id
        do tPatients.%Push(tp)
    } 
    else {
        if ($Data(pageSize) && $Data(currPage)) {
            // if pagination 
            set tStartRow = pageSize * (currPage - 1)
            set tEndRow = tStartRow + pageSize
            set tRow = 0
            set tRs = ##class(Noshow.Table.Appointment).ExtentFunc()
            while (tRs.%Next() && (tRow < tEndRow)) {
                set tRow = tRow + 1
                continue:(tRow<=tStartRow)
                do ##class(Noshow.Table.Appointment).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
                set tp = {}.%FromJSON(tStream)
                set tp."patientId" = tRs.ID
                do tPatients.%Push(tp)
            }
        } else {
            // else return all patients
            set tRs = ##class(Noshow.Table.Appointment).ExtentFunc()
            while (tRs.%Next()) {
                do ##class(Noshow.Table.Appointment).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
                set tp = {}.%FromJSON(tStream)
                set tp."patientId" = tRs.ID
                do tPatients.%Push(tp)
            }
        }
    }
    set myquery = "SELECT COUNT(*) AS total FROM Noshow_Table.Appointment"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."total" = tRs."total"
    set tDyna."query" = "no SQL there; selected via objects"
    set tDyna."patients" = tPatients
    quit tDyna
}

/// Create a new patient to put in the table<br/>
/// The method arguments hold values for:<br/>
///     payloadBody, Request body contents<br/>
/// WARNING: This method's signature has changed.
ClassMethod createPatient(payloadBody As %Stream.Object) As %Stream.Object
{
    set tPatient = ##class(Noshow.Table.Appointment).%New()
    set tDyna = {}
    try {
        $$$ThrowOnError(tPatient.%JSONImport(payloadBody)) 
        do tPatient.%Save()
        set tDyna.patientId = tPatient.%Id()
    } catch(ex) {
        do ##class(%REST.Impl).%ReportRESTError(400,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions")) 
    }
    // Query equivalent
    set tDyna."query" = "INSERT INTO Noshow_Table.Appointment (gender, scheduledDay, scheduledHour, appointmentDay, age, neighborhood, scholarship, hypertension, diabetes, alcoholism, handicap, smsReceived, noShow) VALUES (?, DATE(?), ?, DATE(?), ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    quit tDyna
}

/// Return the saved informations of patient n°{id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
/// WARNING: This method's signature has changed.
ClassMethod getPatient(id As %Integer) As %Stream.Object
{
    set tp = {}
    if ##class(Noshow.Table.Appointment).%ExistsId(id) {
        do ##class(Noshow.Table.Appointment).%OpenId(id).%JSONExportToStream(.tStream)
        set tp = {}.%FromJSON(tStream)
        set tp.patientId = id
    } else {
        Do ..%SetStatusCode(204)
    }
    set tDyna = {}
    set tDyna."patient" = tp
    // Query equivalent
    set tDyna."query" = "SELECT * FROM Noshow_Table.Appointment WHERE ID = ?"
    quit tDyna
}

/// Update already existing patient {id} with information in the payload<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     payloadBody, Request body contents<br/>
/// WARNING: This method's signature has changed.
ClassMethod updatePatient(id As %Integer, payloadBody As %Stream.Object) As %Stream.Object
{
    if ##class(Noshow.Table.Appointment).%ExistsId(id) {
        set tPatient = ##class(Noshow.Table.Appointment).%OpenId(id)
        do tPatient.%JSONImport(payloadBody)
        do tPatient.%Save()
    } else {
        do ..%SetStatusCode(204)
    }
    set tDyna = {}
    // Query equivalent
    set tDyna."query" = "UPDATE Noshow_Table.Appointment SET gender = ?, scheduledDay = DATE(?), scheduledHour = ?, appointmentDay = DATE(?), age = ?, neighborhood = ?, scholarship = ?, hypertension = ?, diabetes = ?, alcoholism = ?, handicap = ?, smsReceived = ?, noShow = ? WHERE ID = ?"
    quit tDyna
}

/// Delete existing patient with {id}<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
/// WARNING: This method's signature has changed.
ClassMethod deletePatient(id As %Integer) As %Stream.Object
{
    if ##class(Noshow.Table.Appointment).%ExistsId(id) {
        do ##class(Noshow.Table.Appointment).%DeleteId(id)
    } else {
        do ..%SetStatusCode(204)
    }
    set tDyna = {}
    // Query equivalent
    set tDyna."query" = "DELETE FROM Titanic_Table.Passenger WHERE ID = ?"
    quit {}
}

// ----------------------------------------------------------------

// ADDITIONAL METHODS FOR ALL TABLES

// ----------------------------------------------------------------

/// Retreive the total number of objects in a table<br/>
/// The method arguments hold values for:<br/>
///     table, The table we need the max size from<br/>
/// WARNING: This method's signature has changed.
ClassMethod getTableSize(table As %String) As %Stream.Object
{
    set myquery = "SELECT COUNT(*) FROM "_table
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."total" = tRs.%Get("Aggregate_1") 
    quit tDyna
}

// ----------------------------------------------------------------

// MODEL MANAGEMENT

// ----------------------------------------------------------------

// ----- MODELS -----

/// Retreive all created models
/// WARNING: This method's signature has changed.
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
/// WARNING: This method's signature has changed.
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
/// WARNING: This method's signature has changed.
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

/// Purge runs from a model<br/>
/// The method arguments hold values for:<br/>
///     modelName<br/>
/// WARNING: This method's signature has changed.
ClassMethod purgeModel(modelName As %String) As %Stream.Object
{
    set myquery = "ALTER MODEL "_modelName_" PURGE ALL"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

// ----- TRAINING RUNS ----- 

/// Get all training runs
/// WARNING: This method's signature has changed.
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
/// WARNING: This method's signature has changed.
ClassMethod trainModel(trainingInfo As %Stream.Object) As %Stream.Object
{
    set tDyna = {}
    set tInfo = {}.%FromJSON(trainingInfo)
    set myquery = "TRAIN MODEL "_tInfo.modelName_" AS "_tInfo.trainingName_" FROM "_tInfo.fromTable
    job ..executeQuery(myquery)
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

/// Get the state of a specific training run<br/>
/// The method arguments hold values for:<br/>
///     modelName, Name of the model<br/>
///     trainingName, Name of the training run<br/>
/// WARNING: This method's signature has changed.
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

/// Get the log of a speecific training run<br/>
/// The method arguments hold values for:<br/>
///     trainingName, Name of the training run<br/>
/// WARNING: This method's signature has changed.
ClassMethod getLogTrainingRun(trainingName As %String) As %Stream.Object
{
    set myquery = "SELECT substring(LOG,1,CHAR_LENGTH(LOG)) FROM INFORMATION_SCHEMA.ML_TRAINING_RUNS WHERE TRAINING_RUN_NAME = ?"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute(trainingName)
    do tRs.%Next()
    set tDyna = {}
    set tDyna."log" = tRs.%Get("Expression_1")
    set tDyna."query" = myquery
    quit tDyna
}

// ----- ML CONFIGURATION -----

/// Get ml configurations
/// WARNING: This method's signature has changed.
ClassMethod getAllConfigurations() As %Stream.Object
{
    set tDyna = {}
    set tDyna.configs = ##class(%SYS.ML.Configuration).%GetListOfAllConfigNames()
    set tDyna.defaultConfigName = ##class(%SYS.ML.Configuration).%GetSystemDefault()
    quit tDyna
}

/// Update ml configuration<br/>
/// The method arguments hold values for:<br/>
///     configName, Configuration name to use<br/>
/// WARNING: This method's signature has changed.
ClassMethod changeConfiguration(configName As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(configName)
    set tSc = ##class(%SYS.ML.Configuration).%SetSystemDefault(tInfo.configName)
    quit tSc
}

/// Create a DataRobot configuration named DataRobotConfig<br/>
/// The method arguments hold values for:<br/>
///     payload, URL to use<br/>
/// WARNING: This method's signature has changed.
ClassMethod createDRConfiguration(payload As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(payload)
    set myquery = "CREATE ML CONFIGURATION DataRobotConfig PROVIDER DataRobot URL '"_tInfo.url_"' APITOKEN '"_tInfo.apiToken_"'"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

/// Alter DataRobot ml configuration<br/>
/// The method arguments hold values for:<br/>
///     payload, URL to use<br/>
/// WARNING: This method's signature has changed.
ClassMethod alterDRConfiguration(payload As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(payload)
    set myquery = "ALTER ML CONFIGURATION DataRobotConfig URL '"_tInfo.url_"' APITOKEN '"_tInfo.apiToken_"'"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    set tDyna = {}
    set tDyna."query" = myquery
    quit tDyna
}

// ----- VALIDATION RUNS -----

/// Get all validation runs
/// WARNING: This method's signature has changed.
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
    set tDyna."validationRuns" = tRuns
    set tDyna."query" = myquery
    quit tDyna
}

/// Validate the Model named modelName using trainedModelName trained model on the fromTable table and gives the name validationName to the validation run<br/>
/// The method arguments hold values for:<br/>
///     validationInfo, Validation informations<br/>
/// WARNING: This method's signature has changed.
ClassMethod validateModel(validationInfo As %Stream.Object) As %Stream.Object
{
    set tInfo = {}.%FromJSON(validationInfo)
    set myquery = "VALIDATE MODEL "_tInfo.modelName
    if (tInfo.%IsDefined("validationName")) {
        set myquery = myquery_" AS "_tInfo.validationName
    }
    set myquery = myquery_" USE "_tInfo.trainedModelName_" FROM "_tInfo.fromTable
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
/// WARNING: This method's signature has changed.
ClassMethod getMetrics(modelName As %String, validationName As %String) As %Stream.Object
{
    set tDyna = {}
    set tMetrics = []
    set tLine = ""
    set myquery = "SELECT METRIC_NAME, METRIC_VALUE, TARGET_VALUE FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS WHERE (VALIDATION_RUN_NAME='"_validationName_"' AND MODEL_NAME='"_modelName_"')"
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()	 	 
    while (tRs.%Next()) {
        set tm = {}
        set tm."metricName" = tRs."METRIC_NAME"
        set tm."metricValue" = tRs."METRIC_VALUE"
        set tm."targetValue" = tRs."TARGET_VALUE"
        do tMetrics.%Push(tm)
    }
    set tDyna."metrics" = tMetrics
    set tDyna."query" = myquery
    quit tDyna
}

// ----- TRAINED MODELS -----

/// Get all trained models
/// WARNING: This method's signature has changed.
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

/// Predict with a certain model, a certain trained model and a certain id from a certain table<br/>
/// The method arguments hold values for:<br/>
///     model, Model to predict with<br/>
///     trainedModel, Trained Model to predict with<br/>
///     id, ID to predict with<br/>
///     fromTable, Table to predict from<br/>
/// WARNING: This method's signature has changed.
ClassMethod predict(model As %String, trainedModel As %String, id As %String, fromTable As %String) As %Stream.Object
{
    set myquery = "SELECT PREDICT("_model_" USE "_trainedModel_") FROM "_fromTable_" WHERE ID="_id
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."predictedValue" = tRs.%Get("Expression_1") 
    set tDyna."query" = myquery
    quit tDyna
}

/// Gives the probability of being predicted the labelValue with a certain model, a certain trained model and a certain id from a certain table<br/>
/// The method arguments hold values for:<br/>
///     model, Model to predict with<br/>
///     trainedModel, Trained Model to predict with<br/>
///     labelValue, Label of the value for probability<br/>
///     id, ID to predict with<br/>
///     fromTable, Table to predict from<br/>
/// WARNING: This method's signature has changed.
ClassMethod probability(model As %String, trainedModel As %String, labelValue As %String, id As %String, fromTable As %String) As %Stream.Object
{
    set myquery = "SELECT PROBABILITY("_model_" USE "_trainedModel_" FOR '"_labelValue_"') FROM "_fromTable_" WHERE ID="_id
    set tStatement = ##class(%SQL.Statement).%New()
    $$$ThrowOnError(tStatement.%Prepare(myquery))
    set tRs = tStatement.%Execute()
    do tRs.%Next()
    set tDyna = {}
    set tDyna."probability" = tRs.%Get("Expression_1") 
    set tDyna."query" = myquery
    quit tDyna
}

}
