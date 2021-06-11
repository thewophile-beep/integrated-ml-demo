/// Rest API for the Integrated ML Demo on the Titanic database<br/>
/// Business logic class defined by OpenAPI in Titanic.REST.spec<br/>
/// Updated Jun 11, 2021 13:57:06
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

/// Retreive all the records of Titanic.Table.Passenger<br/>
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

}
