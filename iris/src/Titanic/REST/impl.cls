/// Rest API for the Integrated ML Demo on the Titanic database<br/>
/// Business logic class defined by OpenAPI in Titanic.REST.spec<br/>
/// Updated Jun 9, 2021 13:23:06
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

/// Retreive all the records of Titanic.Table.Passenger
ClassMethod GetAllPassengers() As %Stream.Object
{
    set tRs = ##class(Titanic.Table.Passenger).ExtentFunc()
    set tDyna = []
    while tRs.%Next() {
        do ##class(Titanic.Table.Passenger).%OpenId(tRs.Id).%JSONExportToStream(.tStream)
        set tElement = {}.%FromJSON(tStream)
        set tElement.Id = tRs.Id
        do tDyna.%Push(tElement)
    }
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
ClassMethod GetPassenger(id As %String) As %Stream.Object
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
ClassMethod UpdatePassenger(id As %String, payloadBody As %Stream.Object) As %Stream.Object
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
ClassMethod DeletePassenger(id As %String) As %Stream.Object
{
    If ##class(Titanic.Table.Passenger).%ExistsId(id) {
        Quit ##class(Titanic.Table.Passenger).%DeleteId(id)
    } Else {
        Do ..%SetStatusCode(204)
        Quit 
    }
}

}
