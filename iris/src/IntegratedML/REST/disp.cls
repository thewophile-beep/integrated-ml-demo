/// Rest API for the Integrated ML Demo
/// Dispatch class defined by RESTSpec in IntegratedML.REST.spec
Class IntegratedML.REST.disp Extends %CSP.REST [ GeneratedBy = IntegratedML.REST.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "IntegratedML.REST.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// The default response charset is utf-8
Parameter CHARSET = "utf-8";

Parameter CONTENTTYPE = "application/json";

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <!-- Get passengers with pagination and search by name possible -->
  <Route Url="/passengers" Method="get" Call="getAllPassengers" />
  <!-- Create a passenger -->
  <Route Url="/passengers" Method="post" Call="createPassenger" />
  <!-- Get passenger n°{id} info -->
  <Route Url="/passengers/:id" Method="get" Call="getPassenger" />
  <!-- Update passenger {id} info -->
  <Route Url="/passengers/:id" Method="put" Call="updatePassenger" />
  <!-- Delete passenger {id} -->
  <Route Url="/passengers/:id" Method="delete" Call="deletePassenger" />
  <!-- Get patients with pagination and search by name possible -->
  <Route Url="/patients" Method="get" Call="getAllPatients" />
  <!-- Create a patient -->
  <Route Url="/patients" Method="post" Call="createPatient" />
  <!-- Get patient n°{id} info -->
  <Route Url="/patients/:id" Method="get" Call="getPatient" />
  <!-- Update patient {id} info -->
  <Route Url="/patients/:id" Method="put" Call="updatePatient" />
  <!-- Delete patient {id} -->
  <Route Url="/patients/:id" Method="delete" Call="deletePatient" />
  <!-- Get nb of objects in table -->
  <Route Url="/ml/tablesize" Method="get" Call="getTableSize" />
  <!-- Get all models -->
  <Route Url="/ml/models" Method="get" Call="getAllModels" />
  <!-- Create a Model -->
  <Route Url="/ml/models" Method="post" Call="createModel" />
  <!-- Delete a model -->
  <Route Url="/ml/models" Method="delete" Call="deleteModel" />
  <!-- Purge runs from model -->
  <Route Url="/ml/models/purge" Method="delete" Call="purgeModel" />
  <!-- Get all training runs -->
  <Route Url="/ml/trainings" Method="get" Call="getTrainingRuns" />
  <!-- Train a Model -->
  <Route Url="/ml/trainings" Method="post" Call="trainModel" />
  <!-- Get state of training run -->
  <Route Url="/ml/trainings/states" Method="get" Call="getStateTrainingRun" />
  <!-- Get log of training run -->
  <Route Url="/ml/trainings/logs" Method="get" Call="getLogTrainingRun" />
  <!-- Get configurations -->
  <Route Url="/ml/trainings/configurations" Method="get" Call="getAllConfigurations" />
  <!-- Update configuration -->
  <Route Url="/ml/trainings/configurations" Method="put" Call="changeConfiguration" />
  <!-- Create DataRobot configuration -->
  <Route Url="/ml/trainings/configurations/datarobot" Method="post" Call="createDRConfiguration" />
  <!-- Alter DataRobot configuration -->
  <Route Url="/ml/trainings/configurations/datarobot" Method="put" Call="alterDRConfiguration" />
  <!-- Get all validation runs -->
  <Route Url="/ml/validations" Method="get" Call="getValidationRuns" />
  <!-- Validate a Model -->
  <Route Url="/ml/validations" Method="post" Call="validateModel" />
  <!-- Get metrics from validation run -->
  <Route Url="/ml/validations/metrics" Method="get" Call="getMetrics" />
  <!-- Get all trained models -->
  <Route Url="/ml/predictions/models" Method="get" Call="getTrainedModels" />
  <!-- Predict with a model and an id -->
  <Route Url="/ml/predictions" Method="get" Call="predict" />
  <!-- Probabilities of having labelValue value predicted -->
  <Route Url="/ml/predictions/probabilities" Method="get" Call="probability" />
</Routes>
}

/// Get passengers with pagination and search by name possible
ClassMethod getAllPassengers() As %Status
{
    Try {
        If $data(%request.Data("currPage",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"currPage")) Quit
        }
        If $data(%request.Data("currPage",1)) {
            Set pcurrPage=%request.Data("currPage",1)
            If '$isvalidnum(pcurrPage) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"currPage",pcurrPage)) Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If '$isvalidnum(ppageSize) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("name",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"name")) Quit
        }
        If $data(%request.Data("name",1)) {
            Set pname=%request.Data("name",1)
        }
        Set response=##class(IntegratedML.REST.impl).getAllPassengers(.pcurrPage,.ppageSize,.pname)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create a passenger
ClassMethod createPassenger() As %Status
{
    Try {
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(IntegratedML.REST.impl).createPassenger(.ppayloadBody)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get passenger n°{id} info
ClassMethod getPassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(IntegratedML.REST.impl).getPassenger(pid)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Update passenger {id} info
ClassMethod updatePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(IntegratedML.REST.impl).updatePassenger(pid,.ppayloadBody)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Delete passenger {id}
ClassMethod deletePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(IntegratedML.REST.impl).deletePassenger(pid)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get patients with pagination and search by name possible
ClassMethod getAllPatients() As %Status
{
    Try {
        If $data(%request.Data("currPage",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"currPage")) Quit
        }
        If $data(%request.Data("currPage",1)) {
            Set pcurrPage=%request.Data("currPage",1)
            If '$isvalidnum(pcurrPage) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"currPage",pcurrPage)) Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If '$isvalidnum(ppageSize) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("id",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"id")) Quit
        }
        If $data(%request.Data("id",1)) {
            Set pid=%request.Data("id",1)
        }
        Set response=##class(IntegratedML.REST.impl).getAllPatients(.pcurrPage,.ppageSize,.pid)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create a patient
ClassMethod createPatient() As %Status
{
    Try {
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(IntegratedML.REST.impl).createPatient(.ppayloadBody)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get patient n°{id} info
ClassMethod getPatient(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(IntegratedML.REST.impl).getPatient(pid)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Update patient {id} info
ClassMethod updatePatient(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(IntegratedML.REST.impl).updatePatient(pid,.ppayloadBody)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Delete patient {id}
ClassMethod deletePatient(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(IntegratedML.REST.impl).deletePatient(pid)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get nb of objects in table
ClassMethod getTableSize() As %Status
{
    Try {
        If $data(%request.Data("table",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"table")) Quit
        }
        If $data(%request.Data("table",1)) {
            Set ptable=%request.Data("table",1)
        }
        Set response=##class(IntegratedML.REST.impl).getTableSize(.ptable)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all models
ClassMethod getAllModels() As %Status
{
    Try {
        Set response=##class(IntegratedML.REST.impl).getAllModels()
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create a Model
ClassMethod createModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"createInfo")) Quit
        Set pcreateInfo=%request.Content
        Set response=##class(IntegratedML.REST.impl).createModel(pcreateInfo)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Delete a model
ClassMethod deleteModel() As %Status
{
    Try {
        If '$data(%request.Data("modelName",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"modelName")) Quit
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        Set pmodelName=%request.Data("modelName",1)
        Set response=##class(IntegratedML.REST.impl).deleteModel(pmodelName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Purge runs from model
ClassMethod purgeModel() As %Status
{
    Try {
        If '$data(%request.Data("modelName",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"modelName")) Quit
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        Set pmodelName=%request.Data("modelName",1)
        Set response=##class(IntegratedML.REST.impl).purgeModel(pmodelName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all training runs
ClassMethod getTrainingRuns() As %Status
{
    Try {
        Set response=##class(IntegratedML.REST.impl).getTrainingRuns()
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Train a Model
ClassMethod trainModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"trainingInfo")) Quit
        Set ptrainingInfo=%request.Content
        Set response=##class(IntegratedML.REST.impl).trainModel(ptrainingInfo)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get state of training run
ClassMethod getStateTrainingRun() As %Status
{
    Try {
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        If $data(%request.Data("modelName",1)) {
            Set pmodelName=%request.Data("modelName",1)
        }
        If $data(%request.Data("trainingName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"trainingName")) Quit
        }
        If $data(%request.Data("trainingName",1)) {
            Set ptrainingName=%request.Data("trainingName",1)
        }
        Set response=##class(IntegratedML.REST.impl).getStateTrainingRun(.pmodelName,.ptrainingName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get log of training run
ClassMethod getLogTrainingRun() As %Status
{
    Try {
        If $data(%request.Data("trainingName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"trainingName")) Quit
        }
        If $data(%request.Data("trainingName",1)) {
            Set ptrainingName=%request.Data("trainingName",1)
        }
        Set response=##class(IntegratedML.REST.impl).getLogTrainingRun(.ptrainingName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get configurations
ClassMethod getAllConfigurations() As %Status
{
    Try {
        Set response=##class(IntegratedML.REST.impl).getAllConfigurations()
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Update configuration
ClassMethod changeConfiguration() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"configName")) Quit
        Set pconfigName=%request.Content
        Set response=##class(IntegratedML.REST.impl).changeConfiguration(pconfigName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create DataRobot configuration
ClassMethod createDRConfiguration() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"payload")) Quit
        Set ppayload=%request.Content
        Set response=##class(IntegratedML.REST.impl).createDRConfiguration(ppayload)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Alter DataRobot configuration
ClassMethod alterDRConfiguration() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"payload")) Quit
        Set ppayload=%request.Content
        Set response=##class(IntegratedML.REST.impl).alterDRConfiguration(ppayload)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all validation runs
ClassMethod getValidationRuns() As %Status
{
    Try {
        Set response=##class(IntegratedML.REST.impl).getValidationRuns()
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Validate a Model
ClassMethod validateModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"validationInfo")) Quit
        Set pvalidationInfo=%request.Content
        Set response=##class(IntegratedML.REST.impl).validateModel(pvalidationInfo)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get metrics from validation run
ClassMethod getMetrics() As %Status
{
    Try {
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        If $data(%request.Data("modelName",1)) {
            Set pmodelName=%request.Data("modelName",1)
        }
        If $data(%request.Data("validationName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"validationName")) Quit
        }
        If $data(%request.Data("validationName",1)) {
            Set pvalidationName=%request.Data("validationName",1)
        }
        Set response=##class(IntegratedML.REST.impl).getMetrics(.pmodelName,.pvalidationName)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all trained models
ClassMethod getTrainedModels() As %Status
{
    Try {
        Set response=##class(IntegratedML.REST.impl).getTrainedModels()
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Predict with a model and an id
ClassMethod predict() As %Status
{
    Try {
        If '$data(%request.Data("model",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"model")) Quit
        If $data(%request.Data("model",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"model")) Quit
        }
        Set pmodel=%request.Data("model",1)
        If '$data(%request.Data("trainedModel",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"trainedModel")) Quit
        If $data(%request.Data("trainedModel",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"trainedModel")) Quit
        }
        Set ptrainedModel=%request.Data("trainedModel",1)
        If '$data(%request.Data("id",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"id")) Quit
        If $data(%request.Data("id",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"id")) Quit
        }
        Set pid=%request.Data("id",1)
        If '$data(%request.Data("fromTable",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"fromTable")) Quit
        If $data(%request.Data("fromTable",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"fromTable")) Quit
        }
        Set pfromTable=%request.Data("fromTable",1)
        Set response=##class(IntegratedML.REST.impl).predict(pmodel,ptrainedModel,pid,pfromTable)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Probabilities of having labelValue value predicted
ClassMethod probability() As %Status
{
    Try {
        If '$data(%request.Data("model",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"model")) Quit
        If $data(%request.Data("model",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"model")) Quit
        }
        Set pmodel=%request.Data("model",1)
        If '$data(%request.Data("trainedModel",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"trainedModel")) Quit
        If $data(%request.Data("trainedModel",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"trainedModel")) Quit
        }
        Set ptrainedModel=%request.Data("trainedModel",1)
        If '$data(%request.Data("labelValue",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"labelValue")) Quit
        If $data(%request.Data("labelValue",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"labelValue")) Quit
        }
        Set plabelValue=%request.Data("labelValue",1)
        If '$data(%request.Data("id",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"id")) Quit
        If $data(%request.Data("id",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"id")) Quit
        }
        Set pid=%request.Data("id",1)
        If '$data(%request.Data("fromTable",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"fromTable")) Quit
        If $data(%request.Data("fromTable",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"fromTable")) Quit
        }
        Set pfromTable=%request.Data("fromTable",1)
        Set response=##class(IntegratedML.REST.impl).probability(pmodel,ptrainedModel,plabelValue,pid,pfromTable)
        Do ##class(IntegratedML.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("IntegratedML.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
