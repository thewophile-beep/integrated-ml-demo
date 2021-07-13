/// 
Class Noshow.Table.Appointment Extends (%Persistent, %JSON.Adaptor) [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = Appointment ]
{

Property gender As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 1, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 3 ];

Property scheduledDay As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 4 ];

Property scheduledHour As %Library.String(JSONTYPE = "string") [ SqlColumnNumber = 5 ];

Property appointmentDay As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 6 ];

Property age As %Library.Float(JSONTYPE = "number", XSDTYPE = "double") [ SqlColumnNumber = 7 ];

Property neighborhood As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 50, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 8 ];

Property scholarship As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 9 ];

Property hypertension As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 10 ];

Property diabetes As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 11 ];

Property alcoholism As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 12 ];

Property handicap As %Library.Integer(JSONTYPE = "number", MAXVAL = 2147483647, MINVAL = -2147483648, STRICT = 0, XSDTYPE = "long") [ SqlColumnNumber = 13 ];

Property smsReceived As %Library.Boolean [ SqlColumnNumber = 14 ];

Property noShow As %Library.Boolean [ SqlColumnNumber = 15 ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="AppointmentDefaultData">
<Value name="1">
<Value>gender</Value>
</Value>
<Value name="2">
<Value>scheduledDay</Value>
</Value>
<Value name="3">
<Value>appointmentDay</Value>
</Value>
<Value name="4">
<Value>age</Value>
</Value>
<Value name="5">
<Value>neighborhood</Value>
</Value>
<Value name="6">
<Value>scholarship</Value>
</Value>
<Value name="7">
<Value>hypertension</Value>
</Value>
<Value name="8">
<Value>diabetes</Value>
</Value>
<Value name="9">
<Value>alcoholism</Value>
</Value>
<Value name="10">
<Value>handicap</Value>
</Value>
<Value name="11">
<Value>smsReceived</Value>
</Value>
<Value name="12">
<Value>noShow</Value>
</Value>
<Value name="13">
<Value>scheduledHour</Value>
</Value>
</Data>
<DataLocation>^CB8u.CCyg.1</DataLocation>
<DefaultData>AppointmentDefaultData</DefaultData>
<ExtentLocation>^CB8u.CCyg</ExtentLocation>
<IdLocation>^CB8u.CCyg.1</IdLocation>
<Index name="IDKEY">
<Location>^CB8u.CCyg.1</Location>
</Index>
<IndexLocation>^CB8u.CCyg.I</IndexLocation>
<StreamLocation>^CB8u.CCyg.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
