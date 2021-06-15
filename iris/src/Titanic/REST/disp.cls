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
  <!--  Server Info  -->
  <Route Url="/" Method="get" Call="GetInfo" />
  <!--  Get number of passengers + "pagesize" records of Passenger class to print in the "currpage" page  -->
  <Route Url="/passengers" Method="get" Call="GetAllPassengers" />
  <!--  Create a Passenger  -->
  <Route Url="/passengers" Method="post" Call="CreatePassenger" />
  <!--  GET method to return JSON for a given passenger id -->
  <Route Url="/passengers/:id" Method="get" Call="GetPassenger" />
  <!--  Update a passenger with id -->
  <Route Url="/passengers/:id" Method="put" Call="UpdatePassenger" />
  <!--  Delete a passenger with id -->
  <Route Url="/passengers/:id" Method="delete" Call="DeletePassenger" />
  <!--  Get all records of Passenger class with "name" in their name  -->
  <Route Url="/passengers/" Method="get" Call="SearchPassengers" />
  <!--  Get all Models  -->
  <Route Url="/ml/models" Method="get" Call="GetAllModels" />
  <!--  Create a Model  -->
  <Route Url="/ml/models" Method="post" Call="CreateModel" />
  <!--  Delete a Model -->
  <Route Url="/ml/models" Method="delete" Call="DeleteModel" />
  <!--  Get all trained models  -->
  <Route Url="/ml/trainedmodels" Method="get" Call="GetTrainedModels" />
  <!--  Train a Model  -->
  <Route Url="/ml/:modelName/:runName" Method="post" Call="TrainModel" />
  <!--  Get all training runs  -->
  <Route Url="/ml/trainingruns" Method="get" Call="GetTrainingRuns" />
  <!--  Predict one passenger value with model  -->
  <Route Url="/ml/predict" Method="post" Call="Predict" />
  <!--  Change ml configuration  -->
  <Route Url="/ml/configuration" Method="post" Call="ChangeConfiguration" />
</Routes>
}

///  Server Info 
ClassMethod GetInfo() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).GetInfo()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Get number of passengers + "pagesize" records of Passenger class to print in the "currpage" page 
ClassMethod GetAllPassengers() As %Status
{
    Try {
        If $data(%request.Data("currpage",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"currpage")) Quit
        }
        If $data(%request.Data("currpage",1)) {
            Set pcurrpage=%request.Data("currpage",1)
            If '$isvalidnum(pcurrpage) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"currpage",pcurrpage)) Quit
        }
        If $data(%request.Data("pagesize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pagesize")) Quit
        }
        If $data(%request.Data("pagesize",1)) {
            Set ppagesize=%request.Data("pagesize",1)
            If '$isvalidnum(ppagesize) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pagesize",ppagesize)) Quit
        }
        Set response=##class(Titanic.REST.impl).GetAllPassengers(.pcurrpage,.ppagesize)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Create a Passenger 
ClassMethod CreatePassenger() As %Status
{
    Try {
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(Titanic.REST.impl).CreatePassenger(.ppayloadBody)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  GET method to return JSON for a given passenger id
ClassMethod GetPassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(Titanic.REST.impl).GetPassenger(pid)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Update a passenger with id
ClassMethod UpdatePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        If $isobject(%request.Content) Set ppayloadBody=%request.Content
        Set response=##class(Titanic.REST.impl).UpdatePassenger(pid,.ppayloadBody)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Delete a passenger with id
ClassMethod DeletePassenger(pid As %String) As %Status
{
    Try {
        If ($number(pid,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"id",pid)) Quit
        Set response=##class(Titanic.REST.impl).DeletePassenger(pid)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Get all records of Passenger class with "name" in their name 
ClassMethod SearchPassengers() As %Status
{
    Try {
        If $data(%request.Data("name",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"name")) Quit
        }
        If $data(%request.Data("name",1)) {
            Set pname=%request.Data("name",1)
        }
        Set response=##class(Titanic.REST.impl).SearchPassengers(.pname)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Get all Models 
ClassMethod GetAllModels() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).GetAllModels()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Create a Model 
ClassMethod CreateModel() As %Status
{
    Try {
        If '$data(%request.Data("modelName",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"modelName")) Quit
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        Set pmodelName=%request.Data("modelName",1)
        If '$data(%request.Data("predicting",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"predicting")) Quit
        If $data(%request.Data("predicting",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"predicting")) Quit
        }
        Set ppredicting=%request.Data("predicting",1)
        Set response=##class(Titanic.REST.impl).CreateModel(pmodelName,ppredicting)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Delete a Model
ClassMethod DeleteModel() As %Status
{
    Try {
        If '$data(%request.Data("modelName",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"modelName")) Quit
        If $data(%request.Data("modelName",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"modelName")) Quit
        }
        Set pmodelName=%request.Data("modelName",1)
        Set response=##class(Titanic.REST.impl).DeleteModel(pmodelName)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Get all trained models 
ClassMethod GetTrainedModels() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).GetTrainedModels()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Train a Model 
ClassMethod TrainModel(pmodelName As %String, prunName As %String) As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).TrainModel(pmodelName,prunName)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Get all training runs 
ClassMethod GetTrainingRuns() As %Status
{
    Try {
        Set response=##class(Titanic.REST.impl).GetTrainingRuns()
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Predict one passenger value with model 
ClassMethod Predict() As %Status
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
        Set response=##class(Titanic.REST.impl).Predict(pmodel,ptrainedModel,ppassenger)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

///  Change ml configuration 
ClassMethod ChangeConfiguration() As %Status
{
    Try {
        If '$isobject(%request.Content) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"payloadBody")) Quit
        Set ppayloadBody=%request.Content
        Set response=##class(Titanic.REST.impl).ChangeConfiguration(ppayloadBody)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
