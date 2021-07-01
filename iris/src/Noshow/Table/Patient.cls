Class Noshow.Table.Patient Extends (%Library.Persistent, %JSON.Adaptor) [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property appointmentId As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2 ];

Property gender As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 3 ];

Property scheduledDay As %TimeStamp [ SqlColumnNumber = 4 ];

Property appointmentDay As %TimeStamp [ SqlColumnNumber = 5 ];

Property age As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 6 ];

Property neighbourhood As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 7 ];

Property scholarship As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 8 ];

Property hypertension As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 9 ];

Property diabetes As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 10 ];

Property alcoholism As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 11 ];

Property handicap As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 12 ];

Property smsReceived As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 13 ];

Property noShow As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 14 ];

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
					set tMe.appointmentId = tImporter.%GetData(1)
					set tMe.gender = tImporter.%GetData(2)
					set tMe.scheduledDay = tImporter.%GetData(3)
					set tMe.appointmentDay = tImporter.%GetData(4)
					set tMe.age = tImporter.%GetData(5)
					set tMe.neighbourhood = tImporter.%GetData(6)
					set tMe.scholarship = tImporter.%GetData(7)
					set tMe.hypertension = tImporter.%GetData(8)
					set tMe.diabetes = tImporter.%GetData(9)
					set tMe.alcoholism = tImporter.%GetData(10)
					set tMe.handicap = tImporter.%GetData(11)
					set tMe.smsReceived = tImporter.%GetData(12)
					set tMe.noShow = tImporter.%GetData(13)
				}
				elseif pSelectMode = 1 {
					set tMe.appointmentId = $s('$system.CLS.IsMthd("appointmentIdOdbcToLogical"):tImporter.%GetData(1),1:tMe.appointmentIdOdbcToLogical(tImporter.%GetData(1)))
					set tMe.gender = $s('$system.CLS.IsMthd("genderOdbcToLogical"):tImporter.%GetData(2),1:tMe.genderOdbcToLogical(tImporter.%GetData(2)))
					set tMe.scheduledDay = $s('$system.CLS.IsMthd("scheduledDayOdbcToLogical"):tImporter.%GetData(3),1:tMe.scheduledDayOdbcToLogical(tImporter.%GetData(3)))
					set tMe.appointmentDay = $s('$system.CLS.IsMthd("appointmentDayOdbcToLogical"):tImporter.%GetData(4),1:tMe.appointmentDayOdbcToLogical(tImporter.%GetData(4)))
					set tMe.age = $s('$system.CLS.IsMthd("ageOdbcToLogical"):tImporter.%GetData(5),1:tMe.ageOdbcToLogical(tImporter.%GetData(5)))
					set tMe.neighbourhood = $s('$system.CLS.IsMthd("neighbourhoodOdbcToLogical"):tImporter.%GetData(6),1:tMe.neighbourhoodOdbcToLogical(tImporter.%GetData(6)))
					set tMe.scholarship = $s('$system.CLS.IsMthd("scholarshipOdbcToLogical"):tImporter.%GetData(7),1:tMe.scholarshipOdbcToLogical(tImporter.%GetData(7)))
					set tMe.hypertension = $s('$system.CLS.IsMthd("hypertensionOdbcToLogical"):tImporter.%GetData(8),1:tMe.hypertensionOdbcToLogical(tImporter.%GetData(8)))
					set tMe.diabetes = $s('$system.CLS.IsMthd("diabetesOdbcToLogical"):tImporter.%GetData(9),1:tMe.diabetesOdbcToLogical(tImporter.%GetData(9)))
					set tMe.alcoholism = $s('$system.CLS.IsMthd("alcoholismOdbcToLogical"):tImporter.%GetData(10),1:tMe.alcoholismOdbcToLogical(tImporter.%GetData(10)))
					set tMe.handicap = $s('$system.CLS.IsMthd("handicapOdbcToLogical"):tImporter.%GetData(11),1:tMe.handicapOdbcToLogical(tImporter.%GetData(11)))
					set tMe.smsReceived = $s('$system.CLS.IsMthd("smsReceivedOdbcToLogical"):tImporter.%GetData(12),1:tMe.smsReceivedOdbcToLogical(tImporter.%GetData(12)))
					set tMe.noShow = $s('$system.CLS.IsMthd("noShowOdbcToLogical"):tImporter.%GetData(13),1:tMe.noShowOdbcToLogical(tImporter.%GetData(13)))
				}
				elseif pSelectMode = 2 {
					set tMe.appointmentId = $s('$system.CLS.IsMthd("appointmentIdDisplayToLogical"):tImporter.%GetData(1),1:tMe.appointmentIdDisplayToLogical(tImporter.%GetData(1)))
					set tMe.gender = $s('$system.CLS.IsMthd("genderDisplayToLogical"):tImporter.%GetData(2),1:tMe.genderDisplayToLogical(tImporter.%GetData(2)))
					set tMe.scheduledDay = $s('$system.CLS.IsMthd("scheduledDayDisplayToLogical"):tImporter.%GetData(3),1:tMe.scheduledDayDisplayToLogical(tImporter.%GetData(3)))
					set tMe.appointmentDay = $s('$system.CLS.IsMthd("appointmentDayDisplayToLogical"):tImporter.%GetData(4),1:tMe.appointmentDayDisplayToLogical(tImporter.%GetData(4)))
					set tMe.age = $s('$system.CLS.IsMthd("ageDisplayToLogical"):tImporter.%GetData(5),1:tMe.ageDisplayToLogical(tImporter.%GetData(5)))
					set tMe.neighbourhood = $s('$system.CLS.IsMthd("neighbourhoodDisplayToLogical"):tImporter.%GetData(6),1:tMe.neighbourhoodDisplayToLogical(tImporter.%GetData(6)))
					set tMe.scholarship = $s('$system.CLS.IsMthd("scholarshipDisplayToLogical"):tImporter.%GetData(7),1:tMe.scholarshipDisplayToLogical(tImporter.%GetData(7)))
					set tMe.hypertension = $s('$system.CLS.IsMthd("hypertensionDisplayToLogical"):tImporter.%GetData(8),1:tMe.hypertensionDisplayToLogical(tImporter.%GetData(8)))
					set tMe.diabetes = $s('$system.CLS.IsMthd("diabetesDisplayToLogical"):tImporter.%GetData(9),1:tMe.diabetesDisplayToLogical(tImporter.%GetData(9)))
					set tMe.alcoholism = $s('$system.CLS.IsMthd("alcoholismDisplayToLogical"):tImporter.%GetData(10),1:tMe.alcoholismDisplayToLogical(tImporter.%GetData(10)))
					set tMe.handicap = $s('$system.CLS.IsMthd("handicapDisplayToLogical"):tImporter.%GetData(11),1:tMe.handicapDisplayToLogical(tImporter.%GetData(11)))
					set tMe.smsReceived = $s('$system.CLS.IsMthd("smsReceivedDisplayToLogical"):tImporter.%GetData(12),1:tMe.smsReceivedDisplayToLogical(tImporter.%GetData(12)))
					set tMe.noShow = $s('$system.CLS.IsMthd("noShowDisplayToLogical"):tImporter.%GetData(13),1:tMe.noShowDisplayToLogical(tImporter.%GetData(13)))
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

Parameter ROWTYPE = "appointmentId INTEGER,gender VARCHAR(250),scheduledDay DATE,appointmentDay DATE,age INTEGER,neighbourhood VARCHAR(250),scholarship INTEGER,hypertension INTEGER,diabetes INTEGER,alcoholism INTEGER,handicap INTEGER,smsReceived INTEGER,noShow VARCHAR(250)";

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>appointmentId</Value>
</Value>
<Value name="3">
<Value>gender</Value>
</Value>
<Value name="4">
<Value>scheduledDay</Value>
</Value>
<Value name="5">
<Value>appointmentDay</Value>
</Value>
<Value name="6">
<Value>age</Value>
</Value>
<Value name="7">
<Value>neighbourhood</Value>
</Value>
<Value name="8">
<Value>scholarship</Value>
</Value>
<Value name="9">
<Value>hypertension</Value>
</Value>
<Value name="10">
<Value>diabetes</Value>
</Value>
<Value name="11">
<Value>alcoholism</Value>
</Value>
<Value name="12">
<Value>handicap</Value>
</Value>
<Value name="13">
<Value>smsReceived</Value>
</Value>
<Value name="14">
<Value>noShow</Value>
</Value>
</Data>
<DataLocation>^Noshow.Table.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<IdLocation>^Noshow.Table.PatientD</IdLocation>
<IndexLocation>^Noshow.Table.PatientI</IndexLocation>
<StreamLocation>^Noshow.Table.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
