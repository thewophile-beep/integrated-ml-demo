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
  <!--  Get all records of Passenger class  -->
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

///  Get all records of Passenger class 
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

}
