/// Rest API for the Integrated ML Demo on the Titanic database
/// Dispatch class defined by RESTSpec in Titanic.REST.spec
Class Titanic.REST.disp Extends %CSP.REST [ GeneratedBy = Titanic.REST.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "Titanic.REST.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// The default response charset is utf-8
Parameter CHARSET = "utf-8";

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

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
  <!-- Get all models -->
  <Route Url="/ml/models" Method="get" Call="getAllModels" />
  <!-- Create a Model -->
  <Route Url="/ml/models" Method="post" Call="createModel" />
  <!-- Delete a model -->
  <Route Url="/ml/models" Method="delete" Call="deleteModel" />
  <!-- Get all training runs -->
  <Route Url="/ml/trainings" Method="get" Call="getTrainingRuns" />
  <!-- Train a Model -->
  <Route Url="/ml/trainings" Method="post" Call="trainModel" />
  <!-- Get all validation runs -->
  <Route Url="/ml/validations" Method="get" Call="getValidationRuns" />
  <!-- Validate a Model -->
  <Route Url="/ml/validations" Method="post" Call="validateModel" />
  <!-- Get metrics from validation run -->
  <Route Url="/ml/validations/metrics" Method="get" Call="getMetrics" />
  <!-- Update configuration -->
  <Route Url="/ml/trainings/configurations" Method="put" Call="changeConfiguration" />
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
        Set response=##class(Titanic.REST.impl).getAllPassengers(.pcurrPage,.ppageSize,.pname)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create a passenger
ClassMethod createPassenger() As %Status
{
    Try {
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(Titanic.REST.impl).createPassenger(.ppayloadBody)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get passenger n°{id} info
ClassMethod getPassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(Titanic.REST.impl).getPassenger(pid)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Update passenger {id} info
ClassMethod updatePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(Titanic.REST.impl).updatePassenger(pid,.ppayloadBody)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Delete passenger {id}
ClassMethod deletePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(Titanic.REST.impl).deletePassenger(pid)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all models
ClassMethod getAllModels() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).getAllModels()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Create a Model
ClassMethod createModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"createInfo")) Quit
        Set pcreateInfo=%request.Content
        Set response=##class(Titanic.REST.impl).createModel(pcreateInfo)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
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
        Set response=##class(Titanic.REST.impl).deleteModel(pmodelName)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all training runs
ClassMethod getTrainingRuns() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).getTrainingRuns()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Train a Model
ClassMethod trainModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"trainingInfo")) Quit
        Set ptrainingInfo=%request.Content
        Set response=##class(Titanic.REST.impl).trainModel(ptrainingInfo)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all validation runs
ClassMethod getValidationRuns() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).getValidationRuns()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Validate a Model
ClassMethod validateModel() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"validationInfo")) Quit
        Set pvalidationInfo=%request.Content
        Set response=##class(Titanic.REST.impl).validateModel(pvalidationInfo)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get metrics from validation run
ClassMethod getMetrics() As %Status
{
    Try {
        If $data(%request.Data("validationName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"validationName")) Quit
        }
        If $data(%request.Data("validationName",1)) {
            Set pvalidationName=%request.Data("validationName",1)
        }
        Set response=##class(Titanic.REST.impl).getMetrics(.pvalidationName)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Update configuration
ClassMethod changeConfiguration() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"configName")) Quit
        Set pconfigName=%request.Content
        Set response=##class(Titanic.REST.impl).changeConfiguration(pconfigName)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

/// Get all trained models
ClassMethod getTrainedModels() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).getTrainedModels()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
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
        If '$data(%request.Data("passenger",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"passenger")) Quit
        If $data(%request.Data("passenger",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"passenger")) Quit
        }
        Set ppassenger=%request.Data("passenger",1)
        Set response=##class(Titanic.REST.impl).predict(pmodel,ptrainedModel,ppassenger)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
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
        If '$data(%request.Data("passenger",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"passenger")) Quit
        If $data(%request.Data("passenger",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"passenger")) Quit
        }
        Set ppassenger=%request.Data("passenger",1)
        Set response=##class(Titanic.REST.impl).probability(pmodel,ptrainedModel,plabelValue,ppassenger)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
