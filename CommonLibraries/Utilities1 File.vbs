
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
''Function ID - START

	''Purpose of the Function -	 If the file does not exist it will create the file and write the status in the file. If the file exist then it will update the status in the file. The File is located at the root of the QTPResults folder.
	''Input Parameters = Status,PropertyFileLocation
	''Return Value - None
	''Sample Function Call - WtiteExecutionTextFile "Passed","C:\QTPResults"
	''Created/Updated by: : Sunil
	
Public Function WriteExecutionTextFile(Status,PropertyFileLocation)
	Dim ExecutionStatus, myFSO, WriteStatus 'Variable Decleration
	WriteStatus = Status
	Set myFSO = CreateObject("Scripting.FileSystemObject")
	If (myFSO.FileExists(PropertyFileLocation&"\ExecutionStatus.txt")) Then
		myFSO.DeleteFile(PropertyFileLocation&"\ExecutionStatus.txt")
		Set ExecutionStatus = myFSO.CreateTextFile(PropertyFileLocation&"\ExecutionStatus.txt", True)
		ExecutionStatus.WriteLine(WriteStatus)
		ExecutionStatus.Close
	Else
		Set ExecutionStatus = myFSO.CreateTextFile(PropertyFileLocation&"\ExecutionStatus.txt", True)
		ExecutionStatus.WriteLine(WriteStatus)
		ExecutionStatus.Close
		
	End If
	Set myFSO = nothing
	Set ExecutionStatus =  nothing
End Function

'''Function ID - END
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Public Function GetRecordSet(DataSourcepath,SQL,RS)
	Dim Conn
	Set Conn = CreateObject("ADODB.Connection") ' create connection object
	'Create Connection 
		With Conn ' build connection string and open connection
			.Provider = "Microsoft.Jet.OLEDB.4.0"
			.ConnectionString = "Data Source=" & DataSourcepath & ";" & "Extended Properties=Excel 8.0;"
			.Open
		End With
	Set RS = CreateObject("ADODB.Recordset") ' create recordset object
	RS.open SQL, Conn ' open recordset using the connection object 
	Set Conn = Nothing
End Function



Function TIAOracleListSelect(TIAOracleList,SelectList)
   If Trim(SelectList) <> "" Then
	   TIAOracleList.Select Cstr(SelectList)
   End If
End Function

 Function TIAOracleTextFieldEnter(TIAOracleTextField,TextFieldValue)
   Dim sError
   If Trim(TextFieldValue) <> "" Then
	   'Calling Function To Check Object Enabled
		CheckObjEnabled TIAOracleTextField,sError
		If IsEmpty(sError) = True  Then
			'TIAOracleTextField.Click
			TIAOracleTextField.Enter TextFieldValue
		Else
			Reporter.ReportEvent micFail,"TIAOracleTextFieldEnter","Object Disabled. Cannot Enter Value"
		End If
   End If
End Function

Function TIAOracleCheckBoxSelect(TIAOracleCheckBox)
   Dim sError
   'Calling Function To Check Object Enabled
	CheckObjEnabled TIAOracleCheckBox,sError
	If IsEmpty(sError) = True  Then
		TIAOracleCheckBox.Select
	Else
		Reporter.ReportEvent micFail,"TIAOracleCheckBox","Object Disabled. Cannot Click."
	End If
End Function
'
'Function TIAOracleRadioGroupSelect(TIAOracleRadioGroup,SelectValue)
'   Dim sError
'   If Trim(SelectValue) <> "" Then
'	   'Calling Function To Check Object Enabled
'		CheckObjEnabled TIAOracleRadioGroup,sError
'		If IsEmpty(sError) = True Then
'			TIAOracleRadioGroup.Select SelectValue
'		Else
'			Reporter.ReportEvent micFail,"TIAOracleRadioGroup","Object Disabled. Cannot Click."
'		End If
'   End If
'End Function


'Function TIAOracleButtonClick(TIAOracleButton)
'   Dim sError
'   'Calling Function To Check Object Enabled
'	CheckObjEnabled TIAOracleButton,sError
'	If IsEmpty(sError) = True  Then
'		TIAOracleButton.Click
'	Else
'		Reporter.ReportEvent micFail,"TIAOracleButton","Object Disabled. Cannot Click."
'	End If
'End Function

Function CheckObjEnabled(OracleObject,sError)
   sError = "Object Not Enabled"
   For i=1 to 60
		If  OracleObject.GetROProperty("enabled") = True Then
			sError = Empty
			Exit For
		End If
		Wait(2)
   Next
End Function

Function CloseAllBrowser()
		Dim strSQL, oWMIService, ProcColl, oElem
		strSQL = "Select * From Win32_Process Where Name = 'iexplore.exe' OR Name = 'firefox.exe'"
		Set oWMIService = GetObject("winmgmts:\\.\root\cimv2")
		Set ProcColl = oWMIService.ExecQuery(strSQL)
		For Each oElem in ProcColl
		    oElem.Terminate
		Next
		Set oWMIService = Nothing
End function

Function WriteRecordSet (DataSourcePath,SQL)
	Set ConnToWrite = CreateObject("ADODB.Connection") ' create connection object
	'Create Connection 
	With ConnToWrite ' build connection string and open connection
	.Provider = "Microsoft.Jet.OLEDB.4.0"
	.ConnectionString = "Data Source=" & DataSourcepath & ";" & "Extended Properties=Excel 8.0;"
	.Open
	End With
	ConnToWrite.Execute Sql 'Execute the SQL recd as input param
	ConnToWrite.Close ' close connection
	Set ConnToWrite = Nothing ' release connection object
End Function

Function ConvertRecordsetToArray(rs,sData)
   Dim i
   For i = 0 to rs.fields.count-1
		If rs.Fields(i) <> "" Then
			sString = sString&"|"&rs.fields(i).Name &":=" &rs.fields(i)
		End If
   Next
   sData = Split(sString,"|",-1,1)
End Function

Sub Preference()
   Dim i
	Do 
		For i = 10 TO 0 Step -1
			If OracleFormWindow("index:="&i).Exist(1) Then
				If OracleFormWindow("index:="&i).GetROProperty("short title") <> "StartUp" Then
					OracleFormWindow("index:="&i).CloseWindow
				Else
					Exit Do
				End If
			End If
		Next
		If i = 0 Then
			Exit Do
		End If
	Loop
End Sub


'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
''Function ID - START

	''Purpose of the Function -	 If the file does not exist it will create the file and write the status in the file. If the file exist then it will update the status in the file. The File is located at the root of the QTPResults folder.
	''Input Parameters = Status,PropertyFileLocation
	''Return Value - None
	''Sample Function Call - WtiteExecutionTextFile "Passed","C:\QTPResults"
	''Created/Updated by: : Sunil
	
Public Function WriteExecutionTextFile(Status,PropertyFileLocation)
	Dim ExecutionStatus, myFSO, WriteStatus 'Variable Decleration
	WriteStatus = Status
	Set myFSO = CreateObject("Scripting.FileSystemObject")
	If (myFSO.FileExists(PropertyFileLocation&"\ExecutionStatus.txt")) Then
		myFSO.DeleteFile(PropertyFileLocation&"\ExecutionStatus.txt")
		Set ExecutionStatus = myFSO.CreateTextFile(PropertyFileLocation&"\ExecutionStatus.txt", True)
		ExecutionStatus.WriteLine(WriteStatus)
		ExecutionStatus.Close
	Else
		Set ExecutionStatus = myFSO.CreateTextFile(PropertyFileLocation&"\ExecutionStatus.txt", True)
		ExecutionStatus.WriteLine(WriteStatus)
		ExecutionStatus.Close
		
	End If
	Set myFSO = nothing
	Set ExecutionStatus =  nothing
End Function

'''Function ID - END
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Public Function GetRecordSet(DataSourcepath,SQL,RS)
	Dim Conn
	Set Conn = CreateObject("ADODB.Connection") ' create connection object
	'Create Connection 
		With Conn ' build connection string and open connection
			.Provider = "Microsoft.Jet.OLEDB.4.0"
			.ConnectionString = "Data Source=" & DataSourcepath & ";" & "Extended Properties=Excel 8.0;"
			.Open
		End With
	Set RS = CreateObject("ADODB.Recordset") ' create recordset object
	RS.open SQL, Conn ' open recordset using the connection object 
	Set Conn = Nothing
End Function



Function TIAOracleListSelect(TIAOracleList,SelectList)
   If Trim(SelectList) <> "" Then
	   TIAOracleList.Select Cstr(SelectList)
   End If
End Function

 Function TIAOracleTextFieldEnter(TIAOracleTextField,TextFieldValue)
   Dim sError
   If Trim(TextFieldValue) <> "" Then
	   'Calling Function To Check Object Enabled
		CheckObjEnabled TIAOracleTextField,sError
		If IsEmpty(sError) = True  Then
			'TIAOracleTextField.Click
			TIAOracleTextField.Enter TextFieldValue
		Else
			Reporter.ReportEvent micFail,"TIAOracleTextFieldEnter","Object Disabled. Cannot Enter Value"
		End If
   End If
End Function

Function TIAOracleCheckBoxSelect(TIAOracleCheckBox)
   Dim sError
   'Calling Function To Check Object Enabled
	CheckObjEnabled TIAOracleCheckBox,sError
	If IsEmpty(sError) = True  Then
		TIAOracleCheckBox.Select
	Else
		Reporter.ReportEvent micFail,"TIAOracleCheckBox","Object Disabled. Cannot Click."
	End If
End Function

Function TIAOracleRadioGroupSelect(TIAOracleRadioGroup,SelectValue)
   Dim sError
     strdevelopername=TIAOracleRadioGroup.gettoproperty("developer name")
 
  If strdevelopername<>"NAME_NAME_TYPE" Then
  			 strnewdevname=""
		     arrdevelopername=split(strdevelopername,"_")
		    For i = 0 To ubound(arrdevelopername)  
		    	If strnewdevname<>"" Then
		    		found=false
		    		arrnewdevelopername=split(strnewdevname,"_")
		    		For k=0 To ubound(arrnewdevelopername)
		    			If arrnewdevelopername(k)=arrdevelopername(i) Then
		    				found=true
		    				Exit for 
		    			End If
		    		Next
		    		If found = false Then
		    			strnewdevname=strnewdevname & arrdevelopername(i) &"_"
		    		End If
		    	else
		    		strnewdevname=strnewdevname & arrdevelopername(i) &"_"
		    	End If
			 	
		    Next
		    If right(strnewdevname,1)="_" Then
		    	newdevelopername=mid(strnewdevname,1,len(strnewdevname)-1)
		    else
		    	newdevelopername=strnewdevname
		    End If
		    TIAOracleRadioGroup.settoproperty "developer name",newdevelopername&".*"
	Else
			TIAOracleRadioGroup.settoproperty "developer name",strdevelopername&".*"
    End If
   If Trim(SelectValue) <> "" Then
	   'Calling Function To Check Object Enabled
		'CheckObjEnabled TIAOracleRadioGroup,sError
		If IsEmpty(sError) = True Then
			TIAOracleRadioGroup.Select SelectValue
		Else
			Reporter.ReportEvent micFail,"TIAOracleRadioGroup","Object Disabled. Cannot Click."
		End If
   End If
End Function


'Function TIAOracleButtonClick(TIAOracleButton)
'   Dim sError
'   'Calling Function To Check Object Enabled
'	CheckObjEnabled TIAOracleButton,sError
'	If IsEmpty(sError) = True  Then
'		TIAOracleButton.Click
'	Else
'		Reporter.ReportEvent micFail,"TIAOracleButton","Object Disabled. Cannot Click."
'	End If
'End Function

Function TIAOracleButtonClick(TIAOracleButton)
   Dim sError
   'Calling Function To Check Object Enabled
                CheckObjEnabled TIAOracleButton,sError
                If IsEmpty(sError) = True  Then
'                                SectionName = DataTable("Action")
'                                sFileName = Environment("SnapDir")&"\Snapshots\" &SectionName&"_"&Environment("PicNo")&".png"
'                                Environment("PicNo") = Environment("PicNo")+1
                                'OracleApplications("index:=0").CaptureBitmap sFileName,True
                                TIAOracleButton.Click
                Else
                                Reporter.ReportEvent micFail,"TIAOracleButton","Object Disabled. Cannot Click."
                End If
End Function


Function CheckObjEnabled(OracleObject,sError)
   sError = "Object Not Enabled"
   For i=1 to 60
		If  OracleObject.GetROProperty("enabled") = True Then
			sError = Empty
			Exit For
		End If
		Wait(2)
   Next
End Function

Function CloseAllBrowser()
		Dim strSQL, oWMIService, ProcColl, oElem
		strSQL = "Select * From Win32_Process Where Name = 'iexplore.exe' OR Name = 'firefox.exe'"
		Set oWMIService = GetObject("winmgmts:\\.\root\cimv2")
		Set ProcColl = oWMIService.ExecQuery(strSQL)
		For Each oElem in ProcColl
		    oElem.Terminate
		Next
		Set oWMIService = Nothing
End function

Function WriteRecordSet (DataSourcePath,SQL)
	Set ConnToWrite = CreateObject("ADODB.Connection") ' create connection object
	'Create Connection 
	With ConnToWrite ' build connection string and open connection
	.Provider = "Microsoft.Jet.OLEDB.4.0"
	.ConnectionString = "Data Source=" & DataSourcepath & ";" & "Extended Properties=Excel 8.0;"
	.Open
	End With
	ConnToWrite.Execute Sql 'Execute the SQL recd as input param
	ConnToWrite.Close ' close connection
	Set ConnToWrite = Nothing ' release connection object
End Function

Function ConvertRecordsetToArray(rs,sData)
   Dim i
   For i = 0 to rs.fields.count-1
		If rs.Fields(i) <> "" Then
			sString = sString&"|"&rs.fields(i).Name &":=" &rs.fields(i)
		End If
   Next
   sData = Split(sString,"|",-1,1)
End Function

Sub Preference()
   Dim i
	Do 
		For i = 10 TO 0 Step -1
			If OracleFormWindow("index:="&i).Exist(1) Then
				If OracleFormWindow("index:="&i).GetROProperty("short title") <> "StartUp" Then
					OracleFormWindow("index:="&i).CloseWindow
				Else
					Exit Do
				End If
			End If
		Next
		If i = 0 Then
			Exit Do
		End If
	Loop
End Sub


Function fnRandomNumberWithDateTimeStamp()
		'Find out the current date and time
		Dim sDate : sDate = Day(Now)&"-"
		'Dim sMonth : sMonth = Month(Now)
		Dim sMonth : sMonth = MonthName(Month(Now),True)&"-"
		Dim sYear : sYear = Year(Now)&"_"
		Dim sHour : sHour = Hour(Now)&":"
		Dim sMinute : sMinute = Minute(Now)&":"
		Dim sSecond : sSecond = Second(Now)
		'Create Random Number
		'fnRandomNumberWithDateTimeStamp = Int(sDate & sMonth & sYear & sHour & sMinute & sSecond)
		fnRandomNumberWithDateTimeStamp = sDate & sMonth & sYear & sHour & sMinute & sSecond
End Function

Function fnLongRandomNumber(LengthOfRandomNumber)

Dim sMaxVal : sMaxVal = ""
Dim iLength : iLength = LengthOfRandomNumber

'Find the maximum value for the given number of digits
For iL = 1 to iLength
sMaxVal = sMaxVal & "9"
Next
sMaxVal = Int(sMaxVal)

'Find Random Value
 iTmp = Int((sMaxVal * Rnd) + 1)
'Add Trailing Zeros if required
iLen = Len(iTmp)
fnRandomNumber = "5"& iTmp 

End Function

Function fnRandomNumber()

		Dim sHour : sHour = Hour(Now)
		Dim sMinute : sMinute = Minute(Now)
		Dim sSecond : sSecond = Second(Now)
		Dim rNum : rNum = Int((Rnd * 10)+1)
		Dim Num : Num = sHour & sMinute & sSecond &rNum
		fnRandomNumber = Num

End Function


Function FolderCreation()
	Set objNetwork = CreateObject("WScript.Network")
	SystemUserName=objNetwork.UserName
	Set fso = CreateObject("scripting.FileSystemObject")
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	strDate =Replace(Replace(Now(),"#",""),"/","_")
	strPathFolder="C:\QTPScripts\TIA Main Scripts\TIA_commecial reinsurance\Screenshot"
	strSubFolder=strPathFolder&strDate
	boolRC = fso.FolderExists(strPathFolder)
	boolRE=fso.FolderExists(strSubFolder)
	Set fso = Nothing 'release an object
	If Not boolRC Then
		Set objSubFolder=objFSO.CreateFolder(strPathFolder)
		Set objSubFolder=objFSO.CreateFolder(strSubFolder)
	Else
		If Not boolRE Then
			Set objSubFolder=objFSO.CreateFolder(strSubFolder)
		End if
	End If
End Function

Function ScreenCapture(Stepname)
	Dim strDate
	Dim strFileName
	'strPathFolder="C:\QTPScripts\TIA Main Scripts\TIA_commecial reinsurance\Screenshot"
    strDate =Replace(Replace(Now(),"#",""),"/","_")
	strFileName = Stepname &"_"&strDate&".png" 
	strFileName = Replace(strFileName,"/","") 
	strFileName = Replace(strFileName,":","")
	'Set objNetwork = CreateObject("WScript.Network")
	'SystemUserName=objNetwork.UserName
	strPath="C:\QTPScripts\TIA Main Scripts\TIA_commecial reinsurance\Screenshot\"
	strFileNamefin =strPath& strFileName 
	If Window("micclass:=Window","regexpwndtitle:=Internet Explorer").Exist(1)  Then
		Window("micclass:=Window","regexpwndtitle:=Internet Explorer").CaptureBitmap strFileNamefin,true 
	End If
	ScreenCapture=strFileNamefin
End Function
