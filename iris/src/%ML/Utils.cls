/* Copyright (c) 2021 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

/// 
/// %ML Utilities
/// 
Class %ML.Utils [ System = 4 ]
{

/// 
/// Invoke a method and capture it's output to the specified stream
/// 
ClassMethod %RunMethodWithCapture(%oref As %ObjectHandle, %method As %String, %log As %GlobalCharacterStream = {$$$NULLOREF}, ByRef %result, %args...) As %Status [ Internal, ProcedureBlock = 0 ]
{
	New %text, %lastsave, capture, oldrtn, signalstate, status

	#dim status As %Status = $$$OK
	#dim %text As %String = ""
	#dim %lastsave As %Integer = $ZH
	#dim capture As %Boolean = 1
	#dim oldrtn As %String = $ZU(96,12)
	#dim signalstate As %Integer
	Kill result



	// Enable stdio redirection / signal handling
	Set signalstate = ##class(%SYS.Python).ChangeSignalState(0)
	
	Try {
		// Set up I/O redirection so we can capture output
		#; Use 0::("^"_$ZNAME)
		#; Do $ZU(82,12,1)
                
		Set %result = $METHOD(%oref,%method,%args...)

	} Catch (ex) {
		set status = ex.AsStatus()
	}

	// Restore I/O capture to it's previous setting
	#; Do $ZU(82,12,capture)
	#; Use 0::("^"_oldrtn)

	// And restore signal/stdio capture
	Do ##class(%SYS.Python).ChangeSignalState(signalstate)

	If $IsObject($G(%log)) && ($G(%text)'="") {
		Do %log.WriteLine(%text)
	}

	Quit status

	#dim s
	
wchr(s)	;
	If $IsObject($G(%log)) {
		Set %text = %text _ $CHAR(s)
		If %text[$C(13,10) {
			Do %log.WriteLine($P(%text,$C(13,10)))
			Set %text = $P(%text,$C(13,10),2,*)
		}
		Do checksave()
	}
	Quit
wff()	;
	If $IsObject($G(%log)) {
		Set %text = %text _ $CHAR(12)
	}
	Quit
wnl()	;
	If $IsObject($G(%log)) {
		Do %log.WriteLine(%text)
		Do checksave()
		Set %text = ""
	}
	Quit
wstr(s)	;
	If $IsObject($G(%log)) {
		Set %text = %text_s
		While %text[$C(13,10) {
			Do %log.WriteLine($P(%text,$C(13,10)))
			Set %text = $P(%text,$C(13,10),2,*)
		}
		Do checksave()
	}
	Quit
wtab(s)	;
	If $IsObject($G(%log)) {
		Set:s>$L(%text) %text = %text _ $J("",s-$L(%text))
	}
	Quit
	;
checksave()	;
	If $ZH-$G(%lastsave)>10 {
		Do %log.%Save()
		Set %lastsave = $ZH
	}
	Quit
}

/// 
/// Kills ALL data: models, trained models and training runs
/// 
/// !!! WARNING: Do not use without knowing what this does !!!
/// 
ClassMethod %KillAllData() As %Status
{
	Do ##class(%ML.Settings).%KillExtent()
	Do ##class(%ML.TrainingRun).%KillExtent()
	Do ##class(%ML.TrainedModel).%KillExtent()
	Do ##class(%ML.Model).%KillExtent()

	Quit $$$OK
}

}
