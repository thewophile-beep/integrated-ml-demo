Class Titanic.Table.Passenger Extends (%Library.Persistent, %JSON.Adaptor) [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property survived As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2 ];

Property pclass As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3 ];

Property name As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 4 ];

Property sex As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5 ];

Property age As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 6 ];

Property sibSp As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 7 ];

Property parCh As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 8 ];

Property ticket As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 9 ];

Property fare As %Library.Currency [ SqlColumnNumber = 10 ];

Property cabin As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 11 ];

Property embarked As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 12 ];

ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
{
	set tStatementId = $SYSTEM.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	if $Isobject(tPreparedStatement) {
		set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		if $Isobject(tImporter) {
			do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			for tPtr = 1:1:pHeaders { do tImporter.%Next() }
			while tImporter.%Next() {
				set tMe = ..%New()
				if 'pSelectMode {
					set tMe.survived = tImporter.%GetData(1)
					set tMe.pclass = tImporter.%GetData(2)
					set tMe.name = tImporter.%GetData(3)
					set tMe.sex = tImporter.%GetData(4)
					set tMe.age = tImporter.%GetData(5)
					set tMe.sibSp = tImporter.%GetData(6)
					set tMe.parCh = tImporter.%GetData(7)
					set tMe.ticket = tImporter.%GetData(8)
					set tMe.fare = tImporter.%GetData(9)
					set tMe.cabin = tImporter.%GetData(10)
					set tMe.embarked = tImporter.%GetData(11)
				}
				elseif pSelectMode = 1 {
					set tMe.survived = $s('$system.CLS.IsMthd("survivedOdbcToLogical"):tImporter.%GetData(1),1:tMe.survivedOdbcToLogical(tImporter.%GetData(1)))
					set tMe.pclass = $s('$system.CLS.IsMthd("pclassOdbcToLogical"):tImporter.%GetData(2),1:tMe.pclassOdbcToLogical(tImporter.%GetData(2)))
					set tMe.name = $s('$system.CLS.IsMthd("nameOdbcToLogical"):tImporter.%GetData(3),1:tMe.nameOdbcToLogical(tImporter.%GetData(3)))
					set tMe.sex = $s('$system.CLS.IsMthd("sexOdbcToLogical"):tImporter.%GetData(4),1:tMe.sexOdbcToLogical(tImporter.%GetData(4)))
					set tMe.age = $s('$system.CLS.IsMthd("ageOdbcToLogical"):tImporter.%GetData(5),1:tMe.ageOdbcToLogical(tImporter.%GetData(5)))
					set tMe.sibSp = $s('$system.CLS.IsMthd("sibSpOdbcToLogical"):tImporter.%GetData(6),1:tMe.sibSpOdbcToLogical(tImporter.%GetData(6)))
					set tMe.parCh = $s('$system.CLS.IsMthd("parChOdbcToLogical"):tImporter.%GetData(7),1:tMe.parChOdbcToLogical(tImporter.%GetData(7)))
					set tMe.ticket = $s('$system.CLS.IsMthd("ticketOdbcToLogical"):tImporter.%GetData(8),1:tMe.ticketOdbcToLogical(tImporter.%GetData(8)))
					set tMe.fare = $s('$system.CLS.IsMthd("fareOdbcToLogical"):tImporter.%GetData(9),1:tMe.fareOdbcToLogical(tImporter.%GetData(9)))
					set tMe.cabin = $s('$system.CLS.IsMthd("cabinOdbcToLogical"):tImporter.%GetData(10),1:tMe.cabinOdbcToLogical(tImporter.%GetData(10)))
					set tMe.embarked = $s('$system.CLS.IsMthd("embarkedOdbcToLogical"):tImporter.%GetData(11),1:tMe.embarkedOdbcToLogical(tImporter.%GetData(11)))
				}
				elseif pSelectMode = 2 {
					set tMe.survived = $s('$system.CLS.IsMthd("survivedDisplayToLogical"):tImporter.%GetData(1),1:tMe.survivedDisplayToLogical(tImporter.%GetData(1)))
					set tMe.pclass = $s('$system.CLS.IsMthd("pclassDisplayToLogical"):tImporter.%GetData(2),1:tMe.pclassDisplayToLogical(tImporter.%GetData(2)))
					set tMe.name = $s('$system.CLS.IsMthd("nameDisplayToLogical"):tImporter.%GetData(3),1:tMe.nameDisplayToLogical(tImporter.%GetData(3)))
					set tMe.sex = $s('$system.CLS.IsMthd("sexDisplayToLogical"):tImporter.%GetData(4),1:tMe.sexDisplayToLogical(tImporter.%GetData(4)))
					set tMe.age = $s('$system.CLS.IsMthd("ageDisplayToLogical"):tImporter.%GetData(5),1:tMe.ageDisplayToLogical(tImporter.%GetData(5)))
					set tMe.sibSp = $s('$system.CLS.IsMthd("sibSpDisplayToLogical"):tImporter.%GetData(6),1:tMe.sibSpDisplayToLogical(tImporter.%GetData(6)))
					set tMe.parCh = $s('$system.CLS.IsMthd("parChDisplayToLogical"):tImporter.%GetData(7),1:tMe.parChDisplayToLogical(tImporter.%GetData(7)))
					set tMe.ticket = $s('$system.CLS.IsMthd("ticketDisplayToLogical"):tImporter.%GetData(8),1:tMe.ticketDisplayToLogical(tImporter.%GetData(8)))
					set tMe.fare = $s('$system.CLS.IsMthd("fareDisplayToLogical"):tImporter.%GetData(9),1:tMe.fareDisplayToLogical(tImporter.%GetData(9)))
					set tMe.cabin = $s('$system.CLS.IsMthd("cabinDisplayToLogical"):tImporter.%GetData(10),1:tMe.cabinDisplayToLogical(tImporter.%GetData(10)))
					set tMe.embarked = $s('$system.CLS.IsMthd("embarkedDisplayToLogical"):tImporter.%GetData(11),1:tMe.embarkedDisplayToLogical(tImporter.%GetData(11)))
				}
				set tStatus = tMe.%Save()
				if $$$ISOK(tStatus) { set tCounter = tCounter + 1 }
			}
		}
	}
	set %sqlcontext.%SQLCODE = 0
	set %sqlcontext.%ROWCOUNT = tCounter
	set pRecordCount = tCounter
	quit tCounter
}

Parameter ROWTYPE = "survived INTEGER,pclass INTEGER,name VARCHAR(250),sex VARCHAR(250),age INTEGER,sibSp INTEGER,parCh INTEGER,ticket VARCHAR(250),fare MONEY,cabin VARCHAR(250),embarked VARCHAR(250)";

Storage Default
{
<Data name="PassengerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>survived</Value>
</Value>
<Value name="3">
<Value>pclass</Value>
</Value>
<Value name="4">
<Value>name</Value>
</Value>
<Value name="5">
<Value>sex</Value>
</Value>
<Value name="6">
<Value>age</Value>
</Value>
<Value name="7">
<Value>sibSp</Value>
</Value>
<Value name="8">
<Value>parCh</Value>
</Value>
<Value name="9">
<Value>ticket</Value>
</Value>
<Value name="10">
<Value>fare</Value>
</Value>
<Value name="11">
<Value>cabin</Value>
</Value>
<Value name="12">
<Value>embarked</Value>
</Value>
</Data>
<DataLocation>^Titanic.Table.PassengerD</DataLocation>
<DefaultData>PassengerDefaultData</DefaultData>
<IdLocation>^Titanic.Table.PassengerD</IdLocation>
<IndexLocation>^Titanic.Table.PassengerI</IndexLocation>
<StreamLocation>^Titanic.Table.PassengerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
