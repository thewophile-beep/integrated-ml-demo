Class Titanic.Table.Passenger Extends (%Library.Persistent, %JSON.Adaptor) [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property PassengerId As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2 ];

Property Survived As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3 ];

Property Pclass As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4 ];

Property Name As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5 ];

Property Sex As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 6 ];

Property Age As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 7 ];

Property SibSp As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 8 ];

Property Parch As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 9 ];

Property Ticket As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 10 ];

Property Fare As %Library.Currency [ SqlColumnNumber = 11 ];

Property Cabin As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 12 ];

Property Embarked As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 13 ];

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
					set tMe.PassengerId = tImporter.%GetData(1)
					set tMe.Survived = tImporter.%GetData(2)
					set tMe.Pclass = tImporter.%GetData(3)
					set tMe.Name = tImporter.%GetData(4)
					set tMe.Sex = tImporter.%GetData(5)
					set tMe.Age = tImporter.%GetData(6)
					set tMe.SibSp = tImporter.%GetData(7)
					set tMe.Parch = tImporter.%GetData(8)
					set tMe.Ticket = tImporter.%GetData(9)
					set tMe.Fare = tImporter.%GetData(10)
					set tMe.Cabin = tImporter.%GetData(11)
					set tMe.Embarked = tImporter.%GetData(12)
				}
				elseif pSelectMode = 1 {
					set tMe.PassengerId = $s('$system.CLS.IsMthd("PassengerIdOdbcToLogical"):tImporter.%GetData(1),1:tMe.PassengerIdOdbcToLogical(tImporter.%GetData(1)))
					set tMe.Survived = $s('$system.CLS.IsMthd("SurvivedOdbcToLogical"):tImporter.%GetData(2),1:tMe.SurvivedOdbcToLogical(tImporter.%GetData(2)))
					set tMe.Pclass = $s('$system.CLS.IsMthd("PclassOdbcToLogical"):tImporter.%GetData(3),1:tMe.PclassOdbcToLogical(tImporter.%GetData(3)))
					set tMe.Name = $s('$system.CLS.IsMthd("NameOdbcToLogical"):tImporter.%GetData(4),1:tMe.NameOdbcToLogical(tImporter.%GetData(4)))
					set tMe.Sex = $s('$system.CLS.IsMthd("SexOdbcToLogical"):tImporter.%GetData(5),1:tMe.SexOdbcToLogical(tImporter.%GetData(5)))
					set tMe.Age = $s('$system.CLS.IsMthd("AgeOdbcToLogical"):tImporter.%GetData(6),1:tMe.AgeOdbcToLogical(tImporter.%GetData(6)))
					set tMe.SibSp = $s('$system.CLS.IsMthd("SibSpOdbcToLogical"):tImporter.%GetData(7),1:tMe.SibSpOdbcToLogical(tImporter.%GetData(7)))
					set tMe.Parch = $s('$system.CLS.IsMthd("ParchOdbcToLogical"):tImporter.%GetData(8),1:tMe.ParchOdbcToLogical(tImporter.%GetData(8)))
					set tMe.Ticket = $s('$system.CLS.IsMthd("TicketOdbcToLogical"):tImporter.%GetData(9),1:tMe.TicketOdbcToLogical(tImporter.%GetData(9)))
					set tMe.Fare = $s('$system.CLS.IsMthd("FareOdbcToLogical"):tImporter.%GetData(10),1:tMe.FareOdbcToLogical(tImporter.%GetData(10)))
					set tMe.Cabin = $s('$system.CLS.IsMthd("CabinOdbcToLogical"):tImporter.%GetData(11),1:tMe.CabinOdbcToLogical(tImporter.%GetData(11)))
					set tMe.Embarked = $s('$system.CLS.IsMthd("EmbarkedOdbcToLogical"):tImporter.%GetData(12),1:tMe.EmbarkedOdbcToLogical(tImporter.%GetData(12)))
				}
				elseif pSelectMode = 2 {
					set tMe.PassengerId = $s('$system.CLS.IsMthd("PassengerIdDisplayToLogical"):tImporter.%GetData(1),1:tMe.PassengerIdDisplayToLogical(tImporter.%GetData(1)))
					set tMe.Survived = $s('$system.CLS.IsMthd("SurvivedDisplayToLogical"):tImporter.%GetData(2),1:tMe.SurvivedDisplayToLogical(tImporter.%GetData(2)))
					set tMe.Pclass = $s('$system.CLS.IsMthd("PclassDisplayToLogical"):tImporter.%GetData(3),1:tMe.PclassDisplayToLogical(tImporter.%GetData(3)))
					set tMe.Name = $s('$system.CLS.IsMthd("NameDisplayToLogical"):tImporter.%GetData(4),1:tMe.NameDisplayToLogical(tImporter.%GetData(4)))
					set tMe.Sex = $s('$system.CLS.IsMthd("SexDisplayToLogical"):tImporter.%GetData(5),1:tMe.SexDisplayToLogical(tImporter.%GetData(5)))
					set tMe.Age = $s('$system.CLS.IsMthd("AgeDisplayToLogical"):tImporter.%GetData(6),1:tMe.AgeDisplayToLogical(tImporter.%GetData(6)))
					set tMe.SibSp = $s('$system.CLS.IsMthd("SibSpDisplayToLogical"):tImporter.%GetData(7),1:tMe.SibSpDisplayToLogical(tImporter.%GetData(7)))
					set tMe.Parch = $s('$system.CLS.IsMthd("ParchDisplayToLogical"):tImporter.%GetData(8),1:tMe.ParchDisplayToLogical(tImporter.%GetData(8)))
					set tMe.Ticket = $s('$system.CLS.IsMthd("TicketDisplayToLogical"):tImporter.%GetData(9),1:tMe.TicketDisplayToLogical(tImporter.%GetData(9)))
					set tMe.Fare = $s('$system.CLS.IsMthd("FareDisplayToLogical"):tImporter.%GetData(10),1:tMe.FareDisplayToLogical(tImporter.%GetData(10)))
					set tMe.Cabin = $s('$system.CLS.IsMthd("CabinDisplayToLogical"):tImporter.%GetData(11),1:tMe.CabinDisplayToLogical(tImporter.%GetData(11)))
					set tMe.Embarked = $s('$system.CLS.IsMthd("EmbarkedDisplayToLogical"):tImporter.%GetData(12),1:tMe.EmbarkedDisplayToLogical(tImporter.%GetData(12)))
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

Parameter ROWTYPE = "PassengerId INTEGER,Survived INTEGER,Pclass INTEGER,Name VARCHAR(250),Sex VARCHAR(250),Age INTEGER,SibSp INTEGER,Parch INTEGER,Ticket VARCHAR(250),Fare MONEY,Cabin VARCHAR(250),Embarked VARCHAR(250)";

Storage Default
{
<Data name="PassengerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PassengerId</Value>
</Value>
<Value name="3">
<Value>Survived</Value>
</Value>
<Value name="4">
<Value>Pclass</Value>
</Value>
<Value name="5">
<Value>Name</Value>
</Value>
<Value name="6">
<Value>Sex</Value>
</Value>
<Value name="7">
<Value>Age</Value>
</Value>
<Value name="8">
<Value>SibSp</Value>
</Value>
<Value name="9">
<Value>Parch</Value>
</Value>
<Value name="10">
<Value>Ticket</Value>
</Value>
<Value name="11">
<Value>Fare</Value>
</Value>
<Value name="12">
<Value>Cabin</Value>
</Value>
<Value name="13">
<Value>Embarked</Value>
</Value>
<Value name="14">
<Value>Id</Value>
</Value>
<Value name="15">
<Value>ID</Value>
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
