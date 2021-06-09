Class Titanic.Definition.Passenger Extends (%RegisteredObject, %JSON.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Parameter %JSONREFERENCE = "ID";

/// Class of travel
Property Class As %Integer [ Required ];

/// Survived or not
Property Survived As %Boolean;

/// Passenger name
Property Name As %String(MAXLEN = 100);

/// Passenger gender
Property Sex As %String(VALUELIST = ",male,female");

Property Age As %Decimal(SCALE = 4);

/// Number of Siblings/Spouse aboard
Property Sibsp As %Integer;

/// Number of Parent/Chila abroad
Property Parch As %Integer;

/// Ticket number
Property Ticket As %String;

/// Ticket fare
Property Fare As %Decimal(SCALE = 4);

/// %Decimal(SCALE = 4);
Property Cabin As %String;

/// The port of embarkment
/// C - Cherbourg
/// S - Southampton
/// Q - Queenstown
Property Embarked As %String(VALUELIST = ",C,S,Q");

/// Boat umber or designation
Property Boat As %String;

/// Body number
Property Body As %Integer;

/// travel destination
Property Destination As %String;

}
