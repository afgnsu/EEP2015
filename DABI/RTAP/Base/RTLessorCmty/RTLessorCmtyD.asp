<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
%>
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(100),aryKeyValue(100),numberOfField,aryKey,aryKeyNameDB(100)
  Dim dspKey(100),userDefineKey,userDefineData,extDBField,extDB(100),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  Dim aryParmKey
 '90/09/03 ADD-START
 '�W�[EXTDBFIELD2,EXTDBFILELD3(�h�ɺ��@)
  dim extDBField2,extDB2(100),extDBField3,extDB3(100),extDBField4,extDB4(100)
  extDBfield2=0
  extDBField3=0
  extDBField4=0
 '----90/09/03 add-end
  extDBField=0
  aryParmKey=Split(Request("Key") &";;;;;;;;;;;;;;;",";")
' -------------------------------------------------------------------------------------------- 
  Call SrEnvironment
  Call SrGetFormat
  Call SrProcessForm
' -------------------------------------------------------------------------------------------- 
  Sub SrGetFormat()
    Dim rs,i,conn
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    aryKeyName=Split(formatName,";")
    rs.Open sqlFormatDB,conn
    For i = 0 To rs.Fields.Count-1
      aryKeyNameDB(i)=rs.Fields(i).Name
      aryKeyType(i)=rs.Fields(i).Type
    Next
    numberOfField=rs.Fields.Count
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
  End Sub
' --------------------------------------------------------------------------------------------        
  Sub SrInit(accessMode,sw)
    Dim i
    aryKey=Split(";;;;;;;;;;",";")
    accessMode=Request.Form("accessMode")
    If accessMode="" Then
       accessMode=Request("accessMode")
       aryKey=Split(Request("key") &";;;;;;;;;;;;;;;;;;;;",";")
       For i = 0 To numberOfKey-1
           dspKey(i)=aryKey(i)
       Next
    End IF
    sw=Request("sw")
    reNew=Request("reNew")
    rwCnt=Request("rwCnt")
    if Not IsNumeric(rwCnt) Then rwCnt=0
  End Sub
' --------------------------------------------------------------------------------------------        
  Sub SrClearForm()
    Dim i,sType
    For i = 0 To Ubound(aryParmKey)
       If Len(Trim(aryParmKey(i))) > 0 Then
           dspKey(i)=aryParmKey(i)
        End If
    Next
'    For i = 0 To numberOfField-1
'        sType=Right("000" &Cstr(aryKeyType(i)),3) 
'        If Instr(cTypeChar,sType) > 0 Then
'           dspKey(i)=""
'        ElseIf Instr(cTypeNumeric,sType) > 0 Then
'           dspKey(i)=0
'        ElseIf Instr(cTypeDate,sType) > 0 Then
'           dspKey(i)=Now()
'        ElseIf Instr(cTypeBoolean,sType) > 0 Then
'           dspKey(i)=True
'        Else
'           dspKey(i)=""
'        End If
'    Next
  End Sub
' -------------------------------------------------------------------------------------------- 
  Sub SrReceiveForm
    Dim i
    For i = 0 To numberOfField-1
        dspKey(i)=Request.Form("key" &i)
    Next
    If extDBField > 0 Then
       For i = 0 To extDBField-1
           extDB(i)=Request.Form("ext" &i)
       Next
    End If
    If extDBField2 > 0 Then
       For i = 0 To extDBField2-1
           extDB2(i)=Request.Form("extA" &i)
       Next
    End If
    If extDBField3 > 0 Then
       For i = 0 To extDBField3-1
           extDB3(i)=Request.Form("extB" &i)
       Next
    End If        
    If extDBField4 > 0 Then
       For i = 0 To extDBField4-1
           extDB4(i)=Request.Form("extC" &i)
       Next
    End If            
  End Sub
' -------------------------------------------------------------------------------------------- 
  Sub SrCheckForm(message,formValid)
    formValid=True
    message=""
    Call SrCheckData(message,formValid)
  End Sub
' -------------------------------------------------------------------------------------------- 
  Function GetSql()
    Dim sql,i,sType
    sql=""
    For i = 0 To numberOfKey-1
      If i > 0 Then sql=sql &" AND "
      sType=Right("000" &Cstr(aryKeyType(i)),3)
      If Instr(cTypeChar,sType) > 0 Or dspKey(i)=Null Then  
         sql=sql &"[" &aryKeyNameDB(i) &"]='" &dspKey(i) &"'"
      'edson 2001/11/1 �W�[==>���F��������key�ϥ�..��������޸�
      elseIf Instr(cTypedate,sType) > 0 Or dspKey(i)=Null Then 
          sql=sql &"[" &aryKeyNameDB(i) &"]='" &dspKey(i) &"'"         
      Else
         sql=sql &"[" &aryKeyNameDB(i) &"]=" &dspKey(i)
      End If
    Next
    GetSql=sqlList &sql &";"
  '  response.write getsql
  End Function
' -------------------------------------------------------------------------------------------- 
  Sub SrSaveData(message)
    message=msgSaveOK
    Dim sql,i,sType
    sql=GetSql()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open sql,conn,3,3
    If rs.Eof Or rs.Bof Then
       If accessMode="A" Then
          rs.AddNew
          For i = 0 To numberOfField-1
              sType=Right("000" &Cstr(aryKeyType(i)),3)
              If Instr(cTypeDate,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=Null
              If Instr(cTypeAuto,sType) > 0 Or (dspKey(i)=-1 And i<numberOfKey) Then
              Else
              '   On Error Resume Next
                runpgm=Request.ServerVariables("PATH_INFO") 
                select case ucase(runpgm)   
                   ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                   case ucase("/webap/rtap/base/rtlessorcmty/RTLessorCmtyd.asp")
                       'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i<>0   then rs.Fields(i).Value=dspKey(i)          
                   case else
                        rs.Fields(i).Value=dspKey(i)      
                END SELECT
              End if
          Next
          rs.Update
          rwCnt=rwCnt+1
          If userDefineSave="Yes" Then Call SrSaveExtDB("A")
       Else
          message=msgErrorRec
       End If
    Else
       If accessMode="A" Then
          message=msgDupKey
          sw="E"
       Else
          For i = 0 To numberOfField-1
              sType=Right("000" &Cstr(aryKeyType(i)),3)
              If Instr(cTypeDate,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=Null
         '     On Error Resume Next
              runpgm=Request.ServerVariables("PATH_INFO") 
              select case ucase(runpgm)   

                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtlessorcmty/RTlessorCmtyd.asp")
                  '  response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     if i<>0 then rs.Fields(i).Value=dspKey(i)         
                 case else
                     rs.Fields(i).Value=dspKey(i)
                   '  response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
               end select
          Next
          rs.Update
          rwCnt=rwCnt+1
          If userDefineSave="Yes" Then Call SrSaveExtDB("U")
          sw=""
       End If
    End If
    rs.Close
    ' ��{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
    if accessmode ="A" then
       runpgm=Request.ServerVariables("PATH_INFO")
       if ucase(runpgm)=ucase("/webap/rtap/base/rtlessorcmty/RTlessorCmtyd.asp") then
          rs.open "select max(comq1) AS comq1 from RTLessorCmtyH",conn
          if not rs.eof then
            dspkey(0)=rs("comq1")
          end if
          rs.close
       end if
    end if
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
  End Sub
' -------------------------------------------------------------------------------------------- 
  Sub SrReadData(dataFound)
    dataFound=True
    Dim  sql,i
    sql=GetSql()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
   ' response.write "SQL=" & SQL
    rs.Open sql,conn
    If rs.Eof Then
       dataFound=False
    Else
       For i = 0 To numberOfField-1
           dspKey(i)=rs.Fields(i).Value
       Next
       If userDefineRead="Yes" Then Call SrReadExtDB()
    End If
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
  End Sub
' -------------------------------------------------------------------------------------------- 
  Sub SrSendForm(message)
      Dim s,i,t,sType
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="vbscript">
Sub Window_onLoad()
  window.Focus()
End Sub
Sub Window_onbeforeunload()
  dim rwCnt
  rwCnt=document.all("rwCnt").value
  If IsNumeric(rwCnt) Then
     If rwCnt > 0 Then Window.Opener.document.all("keyForm").Submit
  End If
  Window.Opener.Focus()
End Sub
Sub SrReNew()
  document.all("sw").Value="E"
  document.all("reNew").Value="Y"
  Window.form.Submit
End Sub
</script>
</head>
<% if userdefineactivex="Yes" then
      SrActiveX
      SrActiveXScript
   End if
%>
<body bgcolor="#FFFFFF" background="/WEBAP/IMAGE/bg.gif" text="#0000FF"  bgproperties="fixed">
<form method="post" id="form">
<input type="text" name="sw" value="<%=sw%>" style="display:none;" ID="Text17">
<input type="text" name="reNew" value="N" style="display:none;" ID="Text18">
<input type="text" name="rwCnt" value="<%=rwCnt%>" style="display:none;" ID="Text19">
<input type="text" name="accessMode" value="<%=accessMode%>" style="display:none;" ID="Text20">
<table width="100%" ID="Table1">
  <tr class=dataListTitle><td width="20%">&nbsp;</td><td width="60%" align=center>
<%=title%></td><td width="20%" align=right><%=dspMode%></td></tr>
</table>
<%
  s=""
  If userDefineKey="Yes" Then
     s=s &"<table width=""100%"" cellPadding=0 cellSpacing=0>" &vbCrLf _
         &"  <tr><td width=""70%"">" &vbCrLf 
     Response.Write s
     SrGetUserDefineKey()
     s=""
     s=s &"      </td>" &vbCrLf _
         &"      <td width=""30%"">" &vbCrLf _
         &"          <table width=""100%"" cellPadding=0 cellSpacing=0>" &vbCrLf _
         &"            <tr><td class=dataListMessage>" &message &"</td></tr>" &vbCrLf _
         &"            <tr align=""right""><td>&nbsp;</td><td align=""right"">" &strBotton &"</td></tr>" &vbCrLf _
         &"          </table></td></tr>" &vbCrLf _
         &"</table>" &vbCrLf
     Response.Write s
  Else 
     s=s &"<table width=""100%"">" &vbCrLf _
         &"  <tr><td width=""60%"">" &vbCrLf _
         &"      <table width=""100%"">" &vbCrLf 
     For i = 0 To numberOfKey-1
	 s=s &"       <tr><td width=""30%"" class=dataListHead>" &aryKeyName(i) &"</td>" _
          &"<td width=""70%"">" _
          &"<input class=dataListEntry type=""text"" name=""key" &i &""" " &keyProtect _
          &" size=""20"" value=""" &dspKey(i) &"""></td></tr>" &vbCrLf
     Next
     s=s &"      </table></td>" &vbCrLf _
         &"      <td width=""40%"">" &vbCrLf _
         &"          <table width=""100%"">" &vbCrLf _
         &"            <tr><td class=dataListMessage>" &message &"</td></tr>" &vbCrLf _
         &"            <tr><td>&nbsp;</td></tr>" &vbCrLf _
         &"            <tr><td>" &strBotton &"</td></tr>" &vbCrLf _
         &"          </table></td></tr>" &vbCrLf _ 
         &"</table>" &vbCrLf
     Response.Write s
  End If
  s=""
  If userDefineData="Yes" Then
     SrGetUserDefineData()
  Else
     s="<table width=""100%"">" &vbCrLf
     For i = numberOfKey To numberOfField-1
       sType=Right("000" &Cstr(aryKey(i)),3)
       s=s &"  <tr><td width=""20%"" class=dataListHead>" &aryKeyName(i) &"</td>" &vbCrLf _
           &"      <td width=""80%"">" &vbCrLf
       If Instr(cTypeVarChar,sType) > 0 Then
         s=s &"      <textarea class=dataListEntry name=""key" &i &""" rows=""4"" cols=""40"" istextedit " _
             &dataProtect &" style=""text-align:left;"">" &dspKey(i) &"</textarea></td></tr>" &vbCrLf 
       ElseIf Instr(cTypeFloat,sType) > 0 Then
         s=s &"      <input class=dataListEntry type=""text"" name=""key" &i &""" size=""40"" " _ 
             &dataProtect &" style=""text-align:right;"" " _
             &"value=""" &FormatNumber(dspKey(i)) &"""></td></tr>" &vbCrLf
       ElseIf Instr(cTypeInteger,sType) > 0 Then 
         s=s &"      <input class=dataListEntry type=""text"" name=""key" &i &""" size=""40"" " _ 
             &dataProtect &" style=""text-align:right;"" " _
             &"value=""" &FormatNumber(dspKey(i),0) &"""></td></tr>" &vbCrLf
       Else
         s=s &"      <input class=dataListEntry type=""text"" name=""key" &i &""" size=""40"" " _ 
             &dataProtect &" style=""text-align:left;"" " _
             &"value=""" &dspKey(i) &"""></td></tr>" &vbCrLf
       End If
     Next
     s=s &"</table>" &vbCrLf
     Response.Write s
  End If
%>
</form>
</body>
</html>
<%End Sub%>
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=1
  title="ET-CITY���ϰ򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1, COMN, CUTID, TOWNSHIP,RADDR,RZONE,CUTID2,TOWNSHIP2,RADDR2,CUTID3,TOWNSHIP3,RADDR3,CUTID4,TOWNSHIP4,RADDR4, " _
             &"COMCNT,BUILDTYPE,BUILDCNT,BUILDFLOOR,POWERJECT,POWERTYPE,POWERDISTANCE,SETUPTYPE,CABLELENGTH,AGREEDRILL,TELCOMROOM, " _
             &"SURVEYDAT,AGREEDAT,AGREE,UNAGREEDESC, UPDEBTCHKDAT, UPDEBTCHKUSR, " _
             &"UPDEBTDAT,TELCOMBOX,CONTACT,CONTACTTEL,eusr,edat,uusr,udat, " _
             &"REMITAGREE, COPYREMIT, REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
             &"FROM RTLessorCmtyH WHERE COMQ1=0 "
  sqlList="SELECT COMQ1, COMN, CUTID, TOWNSHIP,RADDR,RZONE,CUTID2,TOWNSHIP2,RADDR2,CUTID3,TOWNSHIP3,RADDR3,CUTID4,TOWNSHIP4,RADDR4, " _
             &"COMCNT,BUILDTYPE,BUILDCNT,BUILDFLOOR,POWERJECT,POWERTYPE,POWERDISTANCE,SETUPTYPE,CABLELENGTH,AGREEDRILL,TELCOMROOM, " _
             &"SURVEYDAT,AGREEDAT,AGREE,UNAGREEDESC, UPDEBTCHKDAT, UPDEBTCHKUSR, " _
             &"UPDEBTDAT,TELCOMBOX,CONTACT,CONTACTTEL,eusr,edat,uusr,udat, " _
             &"REMITAGREE, COPYREMIT, REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
             &"FROM RTLessorCmtyH WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(trim(DSPKEY(15))) = 0 THEN DSPKEY(15)=0
    if len(trim(DSPKEY(17))) = 0 THEN DSPKEY(17)=0    
    if len(trim(DSPKEY(18))) = 0 THEN DSPKEY(18)=0
    if len(trim(DSPKEY(19))) = 0 THEN DSPKEY(19)=""
    if len(trim(DSPKEY(20))) = 0 THEN DSPKEY(20)=""
    if len(trim(DSPKEY(21))) = 0 THEN DSPKEY(21)=0   
    if len(trim(DSPKEY(23))) = 0 THEN DSPKEY(23)=0   
    if len(trim(DSPKEY(24))) = 0 THEN DSPKEY(24)=""
    if len(trim(DSPKEY(25))) = 0 THEN DSPKEY(25)=""
    if len(trim(DSPKEY(27))) = 0 THEN DSPKEY(27)=""
    if len(trim(DSPKEY(28))) = 0 THEN DSPKEY(28)=""
    if len(trim(DSPKEY(32))) = 0 THEN DSPKEY(32)=""
    if len(trim(DSPKEY(33))) = 0 THEN DSPKEY(33)=""
    if len(trim(DSPKEY(40))) = 0 THEN dspkey(40)=""
    If len(dspKey(0)) <= 0 Then
       dspkey(0)=0
    ELSEif len(dspkey(1)) < 1 Then
       formValid=False
       message="�п�J���ϦW��"       
    ELSEif LEN(TRIM(dspkey(2))) = 0 OR LEN(TRIM(dspkey(3))) = 0 or LEN(TRIM(dspkey(4))) = 0  then
       formValid=False
       message="�п�J���Ϧa�}" 
    ELSEif len(trim(DSPKEY(15))) = 0  THEN
       formValid=False
       message="�п�J���ϳW�Ҥ��" 
    ELSEif len(trim(DSPKEY(17))) = 0  THEN
       formValid=False
       message="�п�J���ϴɼ�" 
    ELSEif  NOT ISNUMERIC(DSPKEY(17)) THEN
       formValid=False
       message="���ϴɼ����п�J(�Ʀr)���"        
    ELSEif  NOT ISNUMERIC(DSPKEY(18)) THEN
       formValid=False
       message="�Ӱ����п�J(�Ʀr)���"           
    ELSEif  NOT ISNUMERIC(DSPKEY(15)) THEN
       formValid=False
       message="�W�Ҥ�����п�J(�Ʀr)���"         
    ELSEif  NOT ISNUMERIC(DSPKEY(21)) THEN
       formValid=False
       message="�q���Z�D���Z�����п�J(�Ʀr)���"                             
    ELSEif NOT ISNUMERIC(DSPKEY(23))  THEN
       formValid=False
       message="�l�u�������п�J(�Ʀr)���"        
    END IF        
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(38)=V(0)
        dspkey(39)=datevalue(now())
    end if   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveXScript()%>
   <SCRIPT Language="VBScript">
   Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
   END SUB
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
       end if
   End Sub    
   
   Sub ImageIconOver()
       self.event.srcElement.style.borderBottom = "black 1px solid"
       self.event.srcElement.style.borderLeft="white 1px solid"
       self.event.srcElement.style.borderRight="black 1px solid"
       self.event.srcElement.style.borderTop="white 1px solid"   
   End Sub
   
   Sub ImageIconOut()
       self.event.srcElement.style.borderBottom = ""
       self.event.srcElement.style.borderLeft=""
       self.event.srcElement.style.borderRight=""
       self.event.srcElement.style.borderTop=""
   End Sub          
   Sub Srcounty3onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY2").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key3").value =  trim(Fusrid(0))
          document.all("key5").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub       
   Sub Srcounty7onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY6").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key7").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub       
   Sub Srcounty10onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key10").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub             
   Sub Srcounty13onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY12").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key13").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub

   Sub Srcounty4onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY48").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("KEY49").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub
   Sub SrBankOnClick()
       prog="RTGetBank.asp"
       prog=prog & "?KEY=" & document.all("KEY43").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("KEY43").value =  trim(Fusrid(0))
       End if
       end if
   End Sub
   Sub SrBankBranchOnClick()
       prog="RTGetBankBranch.asp"
       prog=prog & "?KEY=" & document.all("KEY43").VALUE & ";"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("KEY44").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub

   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"   codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()%>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="20%" class=dataListHead>���ϧǸ�</td><td width="80%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="20" value="<%=dspKey(0)%>" maxlength="8" class=dataListdata></td></tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(36))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(36)=V(0)
        End if  
       dspkey(37)=datevalue(now())
    else
        if len(trim(dspkey(38))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(38)=V(0)
        End if         
        dspkey(39)=datevalue(now())
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    If IsDate(dspKey(32)) Then
       fieldPa=" class=""dataListData"" readonly "
       fieldPb=""
    Else
       fieldPa=""
    End If
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <!--
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>           
  -->
  <span id="tags1" class="dataListTagsOn">�򥻸��</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>        
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr><td width="10%" class=dataListsearch>���ϦW��</td>
    <td width="35%" bgcolor="silver" COLSPAN=3>
        <input type="text" name="key1" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(1)%>" size="30" class=dataListEntry></td>
</tr>
<tr><td class=dataListsearch>���Ϧa�}</td>
    <td bgcolor="silver" >
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(2))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty3onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(2) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(2) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key2"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key3" size="8" value="<%=dspkey(3)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text4"><font size=2>(�m��)                 
         <input type="button" id="B3"  name="B3"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX3%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C3"  name="C3"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key4" size="32" value="<%=dspkey(4)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"></td>                                 
        <td width="7%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="10%" height="25" bgcolor="silver"><input type="text" name="key5" size="10" value="<%=dspkey(5)%>" maxlength="5" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly ID="Text6"></td>  

</tr>  

<tr><td class=dataListsearch>�ɹ���</td>
<td bgcolor="silver" >
<input type="text" name="key26" size="15" READONLY value="<%=dspKey(26)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" ID="Text7">
   <input type="button" id="B26"  name="B26" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
   <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C26"  name="C26"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
<td class=dataListsearch>�ؿv������</td> 
 <td  height="21" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' " 
       If len(trim(dspkey(16))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' AND CODE='" & dspkey(16) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(16) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key16" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                                                  
        <%=s%>
   </select><font size=2>
   </td>    
</tr>   
<tr>                                 
        <td  class="dataListsearch" height="23">���ϴɼ�</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key17" size="15" value="<%=dspKey(17)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text8">
        <font size=2>�ɡA�Ӱ�</font><input type="text" name="key18" size="5" value="<%=dspKey(18)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text16"><font size=2>��</font></td>                                 
        <td  class="dataListsearch" height="23">�W�Ҥ��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key15" size="5" value="<%=dspKey(15)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
 </tr>        
 <tr>
   <td class=dataListsearch>�����q�H��</td>          
    <td  bgcolor="silver">     
      <%  dim rdo1, rdo2
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo1=""
                 rdo2=""
              Else
                 rdo1=" disabled "
                 rdo2=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(25))="Y" Then 
                 rdo1=" checked "    
              elseIf trim(dspKey(25))="N" Then 
                 rdo2=" checked " 
              elseif trim(dspkey(25))="" then
                 dspkey(25)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo1%> name="key25" <%=fieldRole(1)%><%=dataProtect%> ><font size=2>��
        <input type="radio" value="N" <%=rdo2%>  name="key25" <%=fieldRole(1)%><%=dataProtect%>><font size=2>�L</TD>      
   <td class=dataListsearch>�����q�H�c</td>          
    <td  bgcolor="silver">     
      <%  dim rdo3, rdo4
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo3=""
                 rdo4=""
              Else
                 rdo3=" disabled "
                 rdo4=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(33))="Y" Then 
                 rdo3=" checked "    
              elseIf trim(dspKey(33))="N" Then 
                 rdo4=" checked " 
              elseif trim(dspkey(33))="" then
                 dspkey(33)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo3%> name="key33" <%=fieldRole(1)%><%=dataProtect%> ><font size=2>��
        <input type="radio" value="N" <%=rdo4%>  name="key33" <%=fieldRole(1)%><%=dataProtect%> ><font size=2>�L</TD>                                    

</tr>           
<tr><td class=dataListsearch>�q�H�c(��)��}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(6))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX7=" onclick=""Srcounty7onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(6) & "' " 
       SXX7=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(6) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key6"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select4"><%=s%></select>
        <input type="text" name="key7" size="8" value="<%=dspkey(7)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text10"><font size=2>(�m��)                 
         <input type="button" id="B7"  name="B7"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX7%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C7"  name="C7"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key8" size="32" value="<%=dspkey(8)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text11"></td>                                 
</tr>        
 <tr>
   <td class=dataListHead>���L�D�����y</td>          
    <td  bgcolor="silver">     
      <%  dim rdo5, rdo6
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo5=""
                 rdo6=""
              Else
                 rdo5=" disabled "
                 rdo6=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(19))="Y" Then 
                 rdo5=" checked "    
              elseIf trim(dspKey(19))="N" Then 
                 rdo6=" checked " 
              elseif trim(dspkey(19))="" then
                 dspkey(19)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo5%> name="key19" <%=fieldRole(1)%><%=dataProtect%> ID="Radio3"><font size=2>��
        <input type="radio" value="N" <%=rdo6%>  name="key19" <%=fieldRole(1)%><%=dataProtect%> ID="Radio4"><font size=2>�L</TD>      
   <td class=dataListHead>�q��</td>          
    <td  bgcolor="silver">     
      <%  dim rdo7, rdo8
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo7=""
                 rdo8=""
              Else
                 rdo7=" disabled "
                 rdo8=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(20))="110V" Then 
                 rdo7=" checked "    
              elseIf trim(dspKey(20))="220V" Then 
                 rdo8=" checked " 
              elseif trim(dspkey(20))="" then
                 dspkey(20)=""                 
              end if
             %>
        <input type="radio" value="110V" <%=rdo7%> name="key20" <%=fieldRole(1)%><%=dataProtect%> ID="Radio5"><font size=2>110V
        <input type="radio" value="220V" <%=rdo8%>  name="key20" <%=fieldRole(1)%><%=dataProtect%> ID="Radio6"><font size=2>220V</TD>                                    

</tr>           
 <tr>
   <td class=dataListHead>�q���Z�D���Z��(M)</td>          
    <td  bgcolor="silver">     
        <input type="text" name="key21" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="80"
               value="<%=dspKey(21)%>" size="5" class=dataListEntry ID="Text12"><FONT size=2>����</FONT></TD>      
   <td class=dataListHead>�D���ظm�覡</td>          
    <td  bgcolor="silver">     
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G4' " 
       If len(trim(dspkey(22))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G4' AND CODE='" & dspkey(22) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(22) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key22" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                                                  
        <%=s%>
   </select></TD>                                    

</tr>        
 <tr>
   <td class=dataListHead>���ϦP�N�p��</td>          
    <td  bgcolor="silver">     
      <%  dim rdo9, rdo10
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo9=""
                 rdo10=""
              Else
                 rdo9=" disabled "
                 rdo10=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(24))="Y" Then 
                 rdo9=" checked "    
              elseIf trim(dspKey(24))="N" Then 
                 rdo10=" checked " 
              elseif trim(dspkey(24))="" then
                 dspkey(24)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo9%> name="key24" <%=fieldRole(1)%><%=dataProtect%> ID="Radio7"><font size=2>�O
        <input type="radio" value="N" <%=rdo10%>  name="key24" <%=fieldRole(1)%><%=dataProtect%> ID="Radio8"><font size=2>�_</TD>  
<td  class="dataListHead">�P�N��ñ�q��</td>
          <td  bgcolor="silver"><input type="text" name="key27" size="10" READONLY value="<%=dspKey(27)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" ID="Text21">
                           <input type="button" id="B27"  name="B27" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C27"  name="C27"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>            
</tr>        
<tr style="display:none"><td class=dataListsearch >�D���ظm�a�I</td>
    <td bgcolor="silver" COLSPAN=3 >
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(12))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX13=" onclick=""Srcounty13onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(12) & "' " 
       SXX13=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(12) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key12"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>
        <input type="text" name="key13" size="8" value="<%=dspkey(7)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text2"><font size=2>(�m��)                 
         <input type="button" id="B13"  name="B13"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX13%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C13"  name="C13"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key14" size="32" value="<%=dspkey(14)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text3"></td>                                 
</tr>        
<tr><td class=dataListsearch>�i�Ѹ˽d��</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(9))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX10=" onclick=""Srcounty10onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(9) & "' " 
       SXX10=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(9) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key9"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select6"><%=s%></select>
        <input type="text" name="key10" size="8" value="<%=dspkey(10)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text13"><font size=2>(�m��)                 
         <input type="button" id="B10"  name="B10"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX10%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key11" size="32" value="<%=dspkey(11)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text14"></td>                                 
</tr>       
<tr> 
    <td class=dataListHead>10P�l�u����</td>
    <td  bgcolor="silver"> 
    <input type="text" name="key23" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="5"
               value="<%=dspKey(23)%>" size="5" class=dataListEntry ID="Text15"><font size=2>����</font></td>  
    <td class=dataListHead>�O�_�i�ظm</td>
    <td  bgcolor="silver">     
      <%  dim rdo11, rdo12
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo11=""
                 rdo12=""
              Else
                 rdo11=" disabled "
                 rdo12=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(28))="Y" Then 
                 rdo11=" checked "    
              elseIf trim(dspKey(28))="N" Then 
                 rdo12=" checked " 
              elseif trim(dspkey(28))="" then
                 dspkey(28)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo11%> name="key28" <%=fieldRole(1)%><%=dataProtect%> ID="Radio1"><font size=2>�i��
        <input type="radio" value="N" <%=rdo12%>  name="key28" <%=fieldRole(1)%><%=dataProtect%> ID="Radio2"><font size=2>���i��</TD>                              

</tr>   
<tr><td class=dataListHead>���i�ظm��]</td> 
    <td COLSPAN="3" bgcolor="silver"><input type="text" name="key29" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="80"
               value="<%=dspKey(29)%>" size="60" class=dataListEntry ID="Text1"></td>
</tr>   
<tr><td  class=dataListsearch>�����p���H</td>
    <td  bgcolor="silver" >
        <input type="text" name="key34" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="40"
               value="<%=dspKey(34)%>" size="40" class=dataListEntry ID="Text22"></td>
<td  class=dataListsearch>�����p���q��</td>
    <td  bgcolor="silver" >
        <input type="text" name="key35" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="40"
               value="<%=dspKey(35)%>" size="30" class=dataListEntry ID="Text23"></td>               
</tr>

      <tr><td width="21%" class="dataListHead">���q�ɧU�P�N��</td>
          <td width="20%" height="23" bgcolor="silver">
            <% 
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo5=""
                 rdo6=""
              Else
                 rdo5=" disabled "
                 rdo6=" disabled "
              End If            
                If DSPKEY(40)="Y" Then rdo5=" checked "    
                If DSPKEY(40)="N" Then rdo6=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO5%> name="key40" <%=fieldpg%><%=fieldpa%><%=dataProtec%>><font size=2>��</font>
               <input type="radio" value="N" <%=RDO6%> name="key40" <%=fieldpg%><%=fieldpa%><%=dataProtect%>><font size=2>�L</font>                         
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(DSPKEY(41))) < 1 Then
          sx=" selected " 
             s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & DSPKEY(41) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=DSPKEY(41) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="KEY41" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry">
                    <%=S%>
               </select>


           <td width="8%" height="23" class="dataListHead">���q�ɧU�P�N�ѽs��</td>
           <td width="8%" height="23" bgcolor="silver">
               <input  class="dataListEntry" type="text" name="KEY42" <%=fieldpa%><%=dataProtec%> value="<%=DSPKEY(42)%>"></td>
      </tr>

      <tr><td width="21%" class="dataListHead">�״ڻȦ�</td>
          <td width="26%" bgcolor="silver">
			<%
				name=""
				if DSPKEY(43) <> "" then
					sqlxx=" select headnc from rtbank where headno='" & DSPKEY(43) & "' order by headnc "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(�Ȧ�W��)"
					else
						name=rs("headnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="KEY43"value="<%=DSPKEY(43)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="3" maxlength="3" readonly class="dataListDATA">
			<input type="BUTTON" id="B43" name="B43" style="Z-INDEX: 1"  value="...." onclick="SrBankOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C43" name="C43" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>

			<td width="21%" class="dataListHead">�״ڤ���</td>
			<td width="26%" bgcolor="silver">
			<%
				name=""
				if DSPKEY(44) <> "" then
					sqlxx=" select branchnc from rtbankbranch where headno='" & DSPKEY(43) & "' and branchno='" & DSPKEY(44) & "' "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(����W��)"
					else
						name=rs("branchnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="KEY44"value="<%=DSPKEY(44)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="5" maxlength="4" readonly class="dataListDATA">
			<input type="BUTTON" id="B44" name="B44" style="Z-INDEX: 1"  value="...." onclick="SrBankBranchOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C44" name="C44" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>
      </tr>

	  <tr><td width="22%" class="dataListHead">�״ڱb��</td>
          <td width="31%" bgcolor="silver"><input type="text" name="KEY45" size="15" value="<%=DSPKEY(45)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="15" class="dataListEntry"></td>
		  <td width="21%" class="dataListHead">�״ڤ�W</td>
          <td width="26%" colspan="3" bgcolor="silver"><input type="text" name="KEY46" size="38" value="<%=DSPKEY(46)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </TR>

      <tr>
          <td width="22%" class="dataListHead">�䲼���Y</td>
          <td width="31%" bgcolor="silver" colspan=3><input type="text" name="KEY47" size="80" value="<%=DSPKEY(47)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="60" class="dataListEntry"></td>
      </TR>

<%
	s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(DSPKEY(48))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty4onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & DSPKEY(48) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=DSPKEY(48) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
	<tr><td class=dataListhead>�䲼�H�e�a�}</td>
    	<td colspan="3" bgcolor="silver">
			<select size="1" name="KEY48"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        	
        	<input type="text" name="KEY49" size="8" value="<%=DSPKEY(49)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m��)
			<input type="button" id="B49" name="B49" width="100%" style="Z-INDEX: 1" value="..." <%=SXX3%> >
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C49" name="C49" style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        	
        	<input type="text" name="key50" size="70" value="<%=DSPKEY(50)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>
	</tr>


<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(36) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(36) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key36" size="6" READONLY value="<%=dspKey(36)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key37" size="10" READONLY value="<%=dspKey(37)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(38) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(38) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key38" size="6" READONLY value="<%=dspKey(38)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key39" size="10" READONLY value="<%=dspKey(39)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>        
</table> 
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="lightblue" align="center">���ϰ򥻸�ƥӽФβ��ʪ��A</td></tr></table>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >

      <tr><td width="20%" class="dataListHead">���ϥӽФ�</td>
          <td width="35%" bgcolor="silver"><input type="text" name="key30" size="15" READONLY value="<%=dspKey(30)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input type="button" id="B30"  name="B30" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C30"  name="C30"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
          <td width="15%" class="dataListHead">���ϥӽФH</td>
          <td width="25%" bgcolor="silver">
          <input type="text" name="key31" size="15" READONLY value="<%=dspKey(31)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
          </td></tr>
      <tr><td width="20%" class="dataListHead">�������ɤ�</td>
          <td width="35%" bgcolor="silver" colspan=3><input type="text" name="key32" size="15" READONLY value="<%=dspKey(32)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListDATA">
                          </td>
   </table> 
  </div> 
<% 
    conn.Close   
    set rs=Nothing   
    set conn=Nothing 
End Sub 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/RTGetUserRight.asp" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->