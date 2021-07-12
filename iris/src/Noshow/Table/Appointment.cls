/// 
Class Noshow.Table.Appointment Extends (%Persistent, %JSON.Adaptor) [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = Appointment ]
{

Property gender As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 1, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 3 ];

Property "scheduled_day" As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 4 ];

Property "scheduled_hour" As %Library.String(JSONTYPE = "string") [ SqlColumnNumber = 5 ];

Property "appointment_day" As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 6 ];

Property age As %Library.Float(JSONTYPE = "number", XSDTYPE = "double") [ SqlColumnNumber = 7 ];

Property neighborhood As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 50, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 8 ];

Property scholarship As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 9 ];

Property hypertension As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 10 ];

Property diabetes As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 11 ];

Property alcoholism As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 12 ];

Property handicap As %Library.Integer(JSONTYPE = "number", MAXVAL = 2147483647, MINVAL = -2147483648, STRICT = 0, XSDTYPE = "long") [ SqlColumnNumber = 13 ];

Property "sms_received" As %Library.Boolean [ SqlColumnNumber = 14 ];

Property "no_show" As %Library.Boolean [ SqlColumnNumber = 15 ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="AppointmentDefaultData">
<Value name="1">
<Value>gender</Value>
</Value>
<Value name="2">
<Value>scheduled_day</Value>
</Value>
<Value name="3">
<Value>scheduled_hour</Value>
</Value>
<Value name="4">
<Value>appointment_day</Value>
</Value>
<Value name="5">
<Value>age</Value>
</Value>
<Value name="6">
<Value>neighborhood</Value>
</Value>
<Value name="7">
<Value>scholarship</Value>
</Value>
<Value name="8">
<Value>hypertension</Value>
</Value>
<Value name="9">
<Value>diabetes</Value>
</Value>
<Value name="10">
<Value>alcoholism</Value>
</Value>
<Value name="11">
<Value>handicap</Value>
</Value>
<Value name="12">
<Value>sms_received</Value>
</Value>
<Value name="13">
<Value>no_show</Value>
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
