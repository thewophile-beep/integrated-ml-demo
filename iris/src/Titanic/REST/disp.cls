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
  <Route Url="/passengers" Method="get" Call="GetAllPassengers" Cors="true"/>
  <!--  Create a Passenger  -->
  <Route Url="/passengers" Method="post" Call="CreatePassenger" />
  <!--  GET method to return JSON for a given passenger id -->
  <Route Url="/passengers/:id" Method="get" Call="GetPassenger" />
  <!--  Update a passenger with id -->
  <Route Url="/passengers/:id" Method="put" Call="UpdatePassenger" />
  <!--  Delete a passenger with id -->
  <Route Url="/passengers/:id" Method="delete" Call="DeletePassenger" />
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
        Set response=##class(Titanic.REST.impl).GetAllPassengers()
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
        Set response=##class(Titanic.REST.impl).DeletePassenger(pid)
        Do ##class(Titanic.REST.impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("Titanic.REST.impl","ExposeServerExceptions"))
    }
    Quit $$$OK
}

}
