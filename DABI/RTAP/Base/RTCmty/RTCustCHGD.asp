<%
  Dim fieldRole,fieldPa,fieldPb
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
%>
<!-- #include virtual="/WebUtilityV4/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4/DBAUDI/dataList.inc" -->
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
                 ' ��{�������ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)
                   '  response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"     
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtADSLcmty/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)                
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"     
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmtyADSL/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)                     
                 ' ��{�����ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmty/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)               
                 ' ��{����adsl�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtadslcmty/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                           
                 ' ��{����adsl�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustadslbranch/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                                                   
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSL/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)  
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSLBRANCH/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)                       
                 ' ��{����ADSL(��B�B-�W��)�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSL/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
               '      response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)     
               ' ��{�������ݥ�Ĺ��ƺ��@�@�~��,�]��dspkey(2)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/RTSS365/rtDELIVERCUST/RTTELVISITD.asp")
                     if i<>2 then rs.Fields(i).Value=dspKey(i)                                       
                 case else
'response.write "I=" & i & ";VALUE=" & rs.Fields(i).name &"___"& dspkey(i) & "<BR>"                 
                     rs.Fields(i).Value=dspKey(i)
               end select
          Next
          rs.Update
          rwCnt=rwCnt+1
          If userDefineSave="Yes" Then Call SrSaveExtDB("U")
          sw=""
       End If
    End If
    rs.Close
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
'  If IsNumeric(rwCnt) Then
'     If rwCnt > 0 Then Window.Opener.document.all("keyForm").Submit
'  End If
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
<body bgcolor="#FFFFFF" text="#0000FF"  background="backgroup.jpg" bgproperties="fixed">
<form method="post" id="form">
<input type="text" name="sw" value="<%=sw%>" style="display:none;">
<input type="text" name="reNew" value="N" style="display:none;">
<input type="text" name="rwCnt" value="<%=rwCnt%>" style="display:none;">
<input type="text" name="accessMode" value="<%=accessMode%>" style="display:none;">
<table width="100%">
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
  numberOfKey=3
  title="�Ȥ�򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  'sqlFormatDB="SELECT * FROM RTCust WHERE Comq1=0 "
  sqlFormatDB="SELECT COMQ1, CUSID, ENTRYNO, CUSNO, OFFICE, EXTENSION, HOME, MOBILE, EMAIL, " _
             &"BIRTHDAY, CUSTYPE, USEKIND, SPEED, LINETYPE, BUILDHIGH, SETFLOOR, " _
             &"SETROOM, PROFAC, RCVD, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR,  " _
             &"FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO,  " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, " _
             &"UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, " _
             &"ACCCFMUSR, ENDCOD, OPERENVID, NOTE, EUSR, EDAT, UUSR, UDAT, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, " _
             &"SETFEEDESC,rcvdtldat,sex,cutid2,township2,raddr2,rzone2,cutid1,township1,raddr1,rzone1,fax,contact,voucher,sndinfodat,idnumber,COTPORT,ANO,BNO, " _
             &"CUTID3,TOWNSHIP3,RADDR3,RZONE3,transdat,voucherid,holdemail,OVERDUE " _
             &"FROM RTCust where comq1=0"
  'sqlList="SELECT * FROM RTCust WHERE "
  sqllist    ="SELECT COMQ1, CUSID, ENTRYNO, CUSNO, OFFICE, EXTENSION, HOME, MOBILE, EMAIL, " _
             &"BIRTHDAY, CUSTYPE, USEKIND, SPEED, LINETYPE, BUILDHIGH, SETFLOOR, " _
             &"SETROOM, PROFAC, RCVD, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR,  " _
             &"FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO,  " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, " _
             &"UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, " _
             &"ACCCFMUSR, ENDCOD, OPERENVID, NOTE, EUSR, EDAT, UUSR, UDAT, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, " _
             &"SETFEEDESC,rcvdtldat,sex,cutid2,township2,raddr2,rzone2,cutid1,township1,raddr1,rzone1,fax,contact,voucher,sndinfodat,idnumber,COTPORT,ANO,BNO,   " _
             &"CUTID3,TOWNSHIP3,RADDR3,RZONE3,transdat,voucherid,holdemail,OVERDUE " _
             &"FROM RTCust where "
  'key(0)=���ϥN�� key(1)=�Ȥ�N�� key(2)=�榸 key(3)=���ʶ���
  keyxx=split(request("key"),";")
  on error resume next
  session("updateopt")=keyxx(3)
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userDefineRead="Yes"
  userDefineSave="Yes"
  userdefineactivex="Yes"  
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'-------�榸------------------------------
    If Not IsNumeric(dspKey(2)) Then dspKey(2)=0
'--------------- -------------------------
    If Not IsNumeric(dspKey(26)) Then dspKey(26)=0   '�������B
    If Not IsNumeric(dspKey(27)) Then dspKey(27)=0   '�ꦬ���B 
    If Not IsNumeric(dspKey(49)) Then dspKey(49)=3   '�w�����O
    If Not IsNumeric(dspKey(54)) Then dspKey(54)=0   '�зǬI�u�O
    If Not IsNumeric(dspKey(55)) Then dspKey(55)=0   '�I�u�ɧU�O   
    If Not IsNumeric(dspKey(52)) Then dspKey(52)=0   '�˾�(��)
    If Not IsNumeric(dspKey(53)) Then dspKey(53)=0   '�˾�(��)     
'-------�˾��Ӽh -------------------------
    if len(trim(dspkey(14))) = 0 then dspkey(14)=0
    if len(trim(dspkey(15))) = 0 then dspkey(15)=0
    if len(trim(dspkey(16))) = 0 then dspkey(16)=""
    If len(trim(dspkey(1))) < 1 then
       message="�ФJ�Ȥ�N�X"
       formValid=False
    elseIf Not (IsNumeric(dspKey(14)) Or IsNumeric(dspKey(15))) Then
       message="�ФJ�˾��Ӽh���"
       formValid=False       
'-------�M�P��] -------------------------
'    elseIf IsDate(dspKey(28)) and Len(dspKey(35)) < 1 Then
'          message="�п�J�M�P��]"
'          formValid=False
'-------�w�w�˾��ɶ�----------------------
'    elseIf (dspKey(49) = "1" Or dspKey(49) = "2") and _
'           Not (IsDate(dspKey(51)) And IsNumeric(dspKey(52)) _
'           And IsNumeric(dspKey(53))) Then
'              message="�п�J�w�w�˾��ɶ�"
'              formValid=False
    elseIf dspKey(52) > 24 Or dspKey(53) > 59 Then
       message="�п�J���T�w�w�˾��ɶ�"
       formValid=False
    elseif len(trim(extdb(0))) < 1 then
       message="�п�J�Ȥ�W��"
       formValid=False    
'    elseif len(trim(dspkey(58))) < 1 then
'       message="�п�J�Ȥ�ʧO"
'       formValid=False           
    elseif not Isdate(dspkey(9)) and len(dspkey(9)) > 0 then
       message="�X�ͤ�����~"
       formValid=False            
    elseif not Isdate(dspkey(18)) and len(dspkey(18))  > 0 then
       message="�ӽФ�����~"
       formValid=False            
    elseif not Isdate(dspkey(70)) and len(dspkey(70))  > 0 then
       message="�q���o�]������~"
       formValid=False     
    elseif not Isdate(dspkey(19)) and len(dspkey(19))  > 0 then
       message="�o�]������~"
       formValid=False            
    elseif not Isdate(dspkey(23)) and len(dspkey(23))  > 0 then
       message="���u������~"
       formValid=False     
    elseif not Isdate(dspkey(24)) and len(dspkey(24))  > 0 then
       message="����������~"
       formValid=False             
    elseif not IsNumeric(dspkey(26)) and len(dspkey(26))  > 0 then
       message="�������B���~"
       formValid=False           
    elseif not IsNumeric(dspkey(27)) and len(dspkey(27))  > 0 then
       message="�ꦬ���B���~"
       formValid=False             
    elseif not Isdate(dspkey(28)) and len(dspkey(28))  > 0 then
       message="�M�P������~"
       formValid=False             
    elseif not Isdate(dspkey(31)) and len(dspkey(31))  > 0 then
       message="���ڤ�����~"
       formValid=False          
    elseif not Isdate(dspkey(51)) and len(dspkey(51))  > 0 then
       message="�w�w�˾�������~"
       formValid=False          
    elseif not IsNumeric(dspkey(52)) and len(dspkey(52))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False          
    elseif not IsNumeric(dspkey(53)) and len(dspkey(53))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False              
    elseif not IsNumeric(dspkey(55)) and len(dspkey(55))  > 0 then
       message="�I�u�ɧU���B���~"
       formValid=False                     
    elseif (dspkey(49)="1" or dspkey(49)="2" ) and dspkey(17) <> "" then
       message="�w�ˤH����(�~��)��(�޳N��)��,�I�u�t�ӥ����ť�"
       formvalid=false
    elseif (dspkey(49)="3" ) and dspkey(17) = "" then
       message="�w�ˤH����(�t��)��,�I�u�t�Ӥ��o�ť�"
       formvalid=false       
    elseif (dspkey(49)="1" ) and dspkey(50) = "" then
       message="�w�ˤH����(�~��)��,�w�w�w�ˤH�����o�ť�"
       formvalid=false              
    End If
'-------�J�b���=�������--------------
'    dspkey(25)=dspkey(24)
    if dspkey(58) <> "F" and dspkey(58) <>"M" then dspkey(58)=""
'-------Not allowed Nulls fields-------------
'    Dim aryNull
'    aryNull=Array(0,3,4,5,6,7,8,10,11,12,13,16,17,20,22,29,30,33,35,36,37,39,41,42,43,44,45,47,50,56)
'    For i = 0  To Ubound(aryNull)
'        If Len(dspKey(aryNull(i)))<1 Then
'           formValid=False
'           message="Null string Not allowed"
'           Exit For
'        End If
'    Next
'    aryNull=Array(9,18,19,21,23,24,25,28,31,32,34,38,40,46,48,51)
'    For i = 0  To Ubound(aryNull)
'        If Len(dspKey(aryNull(i)))=0 Then
'        ElseIf IsDate(dspKey(aryNull(i))) Then
'        Else           
'           formValid=False
'           message="Date field Invalid"
'           Exit For
'        End If
'    Next
'�t�ӼзǬI�u�O(�I�u�t�Ӥ����ťաA�B�L�I�ڦC�L�帹�ɡA�l�i�ܧ�^
    if len(trim(dspkey(17))) > 0 and len(trim(dspkey(37))) = 0 then
       Dim Connsupp,Rssupp,sqlsupp,dsn
       Set connsupp=server.CreateObject("ADODB.Connection")
       Set rssupp=Server.CreateObject("ADODB.RecordSet")
       DSN="DSN=RTLIB"
       Sqlsupp="select * from RtSupp where cusid='" & dspkey(17) & "'"
       connsupp.open DSN
       rssupp.open sqlsupp,connsupp,1,1
       if rssupp.eof then
          dspkey(54) = 0
       else
          dspkey(54) = rssupp("STDFee")
       end if
    end if
    '--��O���
    if session("updateopt") = "9X" and len(trim(dspkey(28))) = 0 then 
       message="��O����ɡA�M�P������i�ť�!"
       formvalid=false       
    end if
    '--�_��
    if session("updateopt") = "9Y" and len(trim(dspkey(28))) > 0 then 
       message="�_�ˮɡA�M�P����ݬ��ť�!"
       formvalid=false           
    end if
    '--       
'-------�s���覡�P�t�v�ˬd--------------
    if trim(dspkey(12)) = "512KBPS" AND ( TRIM(DSPKEY(11)) <> "�p�q��" and TRIM(DSPKEY(11)) <> "�����p�q" ) then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if    
    if (trim(dspkey(12)) ="128KBPS") AND (TRIM(DSPKEY(11)) <> "�����" ) then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if        
    if (trim(dspkey(12)) ="2048KBPS") AND TRIM(DSPKEY(11)) <> "���֫�" and TRIM(DSPKEY(11)) <>"��������" and TRIM(DSPKEY(11)) <> "�p�q�����" then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if
    if (trim(dspkey(12)) ="2M/384K" or trim(dspkey(12)) ="2M/128K") AND TRIM(DSPKEY(11)) <> "ADSL" and TRIM(DSPKEY(11)) <>"�����ADSL" and TRIM(DSPKEY(11)) <> "�p�q��ADSL" and TRIM(DSPKEY(11)) <> "������ADSL" then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if        
 '���ڦW�٬��ťծɡA
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(47)=V(0)
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
   End Sub 
   Sub Srcounty60onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY59").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key60").value =  trim(Fusrid(0))
          document.all("key62").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub    
   Sub Srcounty64onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY63").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key64").value =  trim(Fusrid(0))
          document.all("key66").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub   
   Sub Srcounty76onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY75").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key76").value =  trim(Fusrid(0))
          document.all("key78").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub              
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
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
   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"    codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()
    s=FrGetCmtyDesc(aryParmKey(0))%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="15%" class=dataListHead>���ϫ��ɬy����</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key0" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(0)%>" class=dataListData></td>
    <td width="15%" class=dataListHead>�Ȥ�N��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="14"
               value="<%=dspKey(1)%>" class=dataListEntry></td>
    <td width="15%" class=dataListHead>�Ȥ�榸</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key2" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(2)%>" class=dataListdata></td>

<%  '--�����
    if session("updateopt") = "X1" OR session("updateopt") = "X2" or session("updateopt") = "X3" then dspkey(79)=null
%>
    <td width="15%" BGCOLOR=#BDB76B>�������ɤ�</td>
    <td width="10%" bgcolor=#DCDCDC>
        <input type="text" name="key79" readonly
               style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(79)%>" style="text-align:left;color:red" class=dataListData></td>
  </tr>
</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(45))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(45)=V(0)
                extdb(46)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(45))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(46)=datevalue(now())
    else
        if len(trim(dspkey(47))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(47)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(47))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(45))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(48)=datevalue(now())
    end if  
' -------------------------------------------------------------------------------------------- 
    
    Dim conn,rs,s,sx,sql,t
    '���׽X
    If dspKey(42)="Y" Then
       fieldPa=" class=""dataListData"" readonly "
    Else
       fieldPa=""
    End If
    '���w�]������� protect, �A�̲��ʶ��إN�X�U�O�}��
       fieldPc=""
       fieldpe=""      
       fieldpf=""         
       fieldPg=" class=""dataListData"" readonly "
   '--
       fieldP1=" class=""dataListData"" readonly "
       fieldP2=" class=""dataListData"" readonly "
       fieldP3=" class=""dataListData"" readonly "
       fieldP4=" class=""dataListData"" readonly "
       fieldP5=" class=""dataListData"" readonly "
       fieldP6=" class=""dataListData"" readonly "
       fieldP7=" class=""dataListData"" readonly "
       fieldP8=" class=""dataListData"" readonly "
       fieldP9=" class=""dataListData"" readonly "
       fieldP10=" class=""dataListData"" readonly "  
         
    if trim(dspkey(11)) = "�p�q��" or trim(dspkey(11)) = "�����p�q" then
       if len(trim(dspkey(83))) > 0 then
          FLG=""
       else
          FLG="Y"    
       end if 
    else
       if len(trim(dspkey(79))) > 0 then
          FLG=""
       else
          FLG="Y"  
       end if   
    end if
          
    '--
    select case session("updateopt")
           case "D6" '--���b�H�a�}
                fieldp1=""
           case "DE" '--��W
                fieldp2=""
           case "DU" '--���s���覡(�O�v�γt�v)
                fieldp3=""
           case "RI" '--�]�T���ݥ�Ĺ�h��
                fieldp4=""
           case "DS" '--�ӽШֱb
                fieldp5=""
           case "DR" '--�����ֱb
                fieldp6=""
           case "CR" '--�O�dHiNet����E-MAIL
                fieldp7=""
           case "RH" '--�]�T���ݥ�Ĺ�Ӹ�
                fieldp4=""
           case "DD" '--�ܧ󦬾ڦW�٤βνs
                fieldp9=""
           case "9X" '--��O���
                fieldp10=""       
                fieldpc=" onclick= ""srbtnonclick"" "
           case "9Y" '--�_��
                fieldp10=""    
                fieldpc=" onclick= ""srbtnonclick"" "      
           case "X1" '--���s���覡(�O�v�γt�v) <=== ��������
                fieldp3=""
           case "X2" '--���s���覡(�O�v�γt�v) <=== �p�q�����
                fieldp3=""                          
           case "X3" '--���s���覡(�O�v�γt�v) <=== �p�q�����
                fieldp3=""                          
           case else
    end select    
    '--��O���
    if session("updateopt") = "9X" then dspkey(82)="Y"
    '--�_��
    if session("updateopt") = "9Y" then dspkey(82)=""
    '--          
    '���ڪ�w�C�L�Φw�˭����O���o�](�Ϊť�)�ɡA���i���w�˭��u�s�A���i���w�ˤH����ơ]�Y�w�˭��u�sdisable)
    If Len(Trim(dspKey(29))) > 0  Then
       fieldPb=" class=""dataListData"" readonly "
    Else
       fieldPb=""
    End If
    if dspkey(42)="Y" or Len(Trim(dspKey(29))) > 0  then
       fieldPbx=""       
    else
       fieldPbx="SrAddusr()"
    end if        
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>                                      
  <div class=dataListTagOn> 
<table width="100%"><tr><td width="100%">&nbsp;</td></tr>                                                      
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag1" height="354">                                      
      <tr>                                      
        <td width="17%" class="dataListHead" height="32">�Ȥ�W��</td>                                      
        <td width="35%" height="32" bgcolor="silver"><!--webbot
          bot="Validation" B-Value-Required="TRUE" I-Maximum-Length="50" -->
          <input type="text" name="ext0" size="28" maxlength="50" value="<%=extDB(0)%>"<%=fieldp2%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                              
        <td width="10%" class="dataListHead" height="32">�ʧO</td>
<%  dim sexd1, sexd2
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       sexd1=""
       sexd2=""
    Else
      ' sexd1=" disabled "
      ' sexd2=" disabled "
    End If
    If dspKey(58)="M" Then sexd1=" checked "    
    If dspKey(58)="F" Then sexd2=" checked " %>                          
        <td width="16%" height="32" bgcolor="silver">
        <input type="radio" value="M" <%=sexd1%> name="key58" <%=fieldRole(1)%><%=dataProtec%>>�k
        <input type="radio" name="key58" value="F" <%=sexd2%><%=fieldRole(1)%><%=dataProtect%>>�k</td>                              
        <td width="8%" class="dataListHead" height="32">�X�ͤ��</td>                              
        <td width="16%" height="32" bgcolor="silver">
          <input type="text" name="key9" size="10" value="<%=dspkey(9)%>" maxlength="10" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class=dataListEntry>
          <input type="button" id="B9"  name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                              
      </tr>                              
      <tr>                              
        <td width="15%" class="dataListHead" height="25">�b��(�q�T)�a�}</td>                              
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(59))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX60=" onclick=""Srcounty60onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(59) &"' " 
       SXX60=""
    End If
    rs.Open sql,conn
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("cutid")=dspkey(59) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key59" <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        <input type="text" name="key60" size="8" value="<%=dspkey(60)%>" maxlength="10" readonly <%=fieldp1%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B60"  name="B60"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX60%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C60"  name="C60"   style="Z-INDEX: 1" <%=fieldpc%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key61" size="32" value="<%=dspkey(61)%>" maxlength="60" <%=fieldp1%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key62" size="10" value="<%=dspkey(62)%>" maxlength="5" <%=fieldp1%> <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="25">�˾��a�}</td>                                 
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
'    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  and flg = "Y" Then 
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(63))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX64=" onclick=""Srcounty64onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(63) &"' " 
       SXX64=""
    End If
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(63) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key63" <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1"  style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>
        <input type="text" name="key64" size="8" value="<%=dspkey(64)%>" maxlength="10" readonly <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B64"  name="B64"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX64%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C64"  name="C64"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    
        <input type="text" name="key65" size="32" value="<%=dspkey(65)%>" maxlength="60" <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key66" size="10" value="<%=dspkey(66)%>" maxlength="5" <%=fieldpg%> <%=fieldpa%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>
      <tr>                                 
        <td width="15%" class="dataListHead" height="25">���y�a�}</td>                                 
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
'    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  and flg = "Y" Then 
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(75))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX76=" onclick=""Srcounty76onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(75) &"' " 
       SXX76=""
    End If
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(75) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key75" <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>
        <input type="text" name="key76" size="8" value="<%=dspkey(76)%>" maxlength="10" readonly <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B76"  name="B76"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX76%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C76"  name="C76"  <%=fieldpc%> style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
        <input type="text" name="key77" size="32" value="<%=dspkey(77)%>" maxlength="60" <%=fieldp1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                     
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key78" size="10" value="<%=dspkey(78)%>" maxlength="5" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                
      <tr>          
<script language="vbscript">
Sub SrAddrEqual()
  Dim i,objOpt
  document.All("key63").value=document.All("key59").value
  document.All("key64").value=document.All("key60").value
  document.All("key65").value=document.All("key61").value
  document.All("key66").value=document.All("key62").value
End Sub 
Sub SrAddrEqual2()
  document.All("key75").value=document.All("key59").value
  document.All("key76").value=document.All("key60").value
  document.All("key77").value=document.All("key61").value
  document.All("key78").value=document.All("key62").value
End Sub 
Sub SrAddUsr()
  ExistUsr=document.all("key50").value
  InsType=cstr(document.all("key49").value)
  UsrStr=Window.showModalDialog("RTCustAddUsr.asp?parm=" & existusr & "@" & instype   ,"Dialog","dialogWidth:410px;dialogHeight:400px;")
  if UsrStr<>False then
     UsrStrAry=split(UsrStr,"@")
     document.all("key50").value=UsrStrAry(0)
     document.all("REF01").value=UsrStrAry(1)     
  end if
End Sub

Sub Srpay()
  if document.all("key49").value = "1" then
     document.all("key54").value = 200
' 90/01/19�t�ӬI�u�O���Ū���t����rtsupp(��checkdata�ɶ�J;�Y�ӫȤ��Ƥw�C�L�I�u�O�h���ܧ�
'  elseif document.all("key49").value = "3" then
'         document.all("key54").value = 600
  else
     document.all("key54").value = 0
  end if
End Sub
</script>                       
        <td width="50%" class="dataListHead" colspan="2" height="34" bgcolor="silver">
<%  dim seld1
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       seld1=""
    Else
       seld1=" disabled "
    End If%>
            <input type="radio" name="rdo1" value="1"<%=seld1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual()">�˾��a�}�P�b��a�}
            <input type="radio" name="rdo2" value="1"<%=seld1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual2()">���y�a�}�P�b��a�}</td>                           
        <td width="10%" class="dataListHead" height="34">&nbsp;HN�p�渹�X</td>                                 
        <td width="40%" colspan="3" height="34" bgcolor="silver"><input type="text" name="key3" size="10" value="<%=dspKey(3)%>" maxlength="10" <%=fieldRole(1)%><%=fieldpg%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                            
        <td width="17%" class="dataListHead" height="32">�}�o����</td>
<% aryOption=Array("�`�Ѥ�","�Ӹˤ�")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and len(trim(dspkey(79)))=0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(10)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(10) &""">" &dspKey(10) &"</option>"
   End If%>                                  
        <td width="35%" height="32" bgcolor="silver"><select size="1" name="key10" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                            
        <%=s%></select></td>                                     
        <td width="10%" class="dataListHead">�ӽФ��</td>                     
        <td width="16%" bgcolor="silver">
          <input type="text" name="key18" size="10" value="<%=dspKey(18)%>" <%=fieldpg%><%=fieldRole(1)%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B18"  name="B18" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td> 
        <td width="8%" class="dataListHead" height="32">�u������</td>
<% aryOption=Array("HIBUILDING","ADSL")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and len(trim(dspkey(79)))=0 Then   
      For i = 0 To Ubound(aryOption)
          If dspKey(13)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(13) &""">" &dspKey(13) &"</option>"
   End If%>                                  
        <td width="16%" height="32" bgcolor="silver"><select size="1" name="key13" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%></select></td>                                    
      </tr>                                    
      <tr>                                    
        <td width="17%" class="dataListHead" height="21">�˾��Ӽh</td>                                    
        <td width="35%"  height="21" bgcolor="silver">�Ӱ�<input type="text" name="key14" size="4" value="<%=dspKey(14)%>" maxlength="4" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry">�h�A�˩��<input type="text" name="key15" size="4" value="<%=dspKey(15)%>"<%=fieldpg%> <%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">�h�A��<input type="text" name="key16" size="4" value="<%=dspKey(16)%>" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> maxlength="4" class="dataListEntry">��</td>                                 
        <td width="10%"  height="21" bgcolor="orange">������(�νs)</td>
        <td width="48%"  colspan="3" height="21"><input type="password" name="key71" size="10" value="<%=dspKey(71)%>" maxlength="10" <%=fieldp9%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry"></td>
      </tr>         
      <tr>                                    
        <td width="17%" class="dataListHead" height="21">COT PORT</td>
         <td width="35%"  height="21" ><input type="text" name="key72" size="10" value="<%=dspKey(72)%>" maxlength="10" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry"></TD>
        <td width="10%"  height="21" class="dataListHead">MDF���X1</TD>
        <td width="16%"  height="21"><input type="text" name="key73" size="15" value="<%=dspKey(73)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%"  height="21" class="dataListHead">MDF���X2</td>
        <td width="16%" height="21"><input type="text" name="key74" size="15" value="<%=dspKey(74)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                       
      <tr>                                 
        <td width="17%" class="dataListHead" height="23">�Τ����</td>
<% aryOption=Array("�����","�p�q��","�����p�q","���֫�","��������","�p�q�����","ADSL","�����ADSL","�p�q��ADSL","������ADSL")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1  Then 
      For i = 0 To Ubound(aryOption)
          If dspKey(11)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(11) &""">" &dspKey(11) &"</option>"
   End If%>                                 
        <td width="35%" height="23" bgcolor="silver"><select size="1" name="key11" <%=fieldp3%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                 
        <%=s%></select></td>                                    
        <td width="10%" class="dataListHead" height="23">�ӽгt��</td>
<% aryOption=Array("128KBPS","512KBPS","2048KBPS","2M/384K","2M/128K")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1  Then 
      For i = 0 To Ubound(aryOption)
          If dspKey(12)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(12) &""">" &dspKey(12) &"</option>"
   End If%>                                      
        <td width="40%" colspan="3" height="23" bgcolor="silver"><select size="1" name="key12" <%=fieldp3%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                                             
        <%=s%></select></td>                                    
      </tr>                                    
      <tr>                                    
        <td width="17%" class="dataListHead" height="23">�p���q��</td>                                 
        <td width="35%" height="23"><input type="text" name="key6" size="15" value="<%=dspkey(6)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="10%" class="dataListHead" height="23">�ǯu�q��</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key67" size="15" value="<%=dspkey(67)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="23">�p���H</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key68" size="10" value="<%=dspkey(68)%>" maxlength="20" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="17%" class="dataListHead" height="23" bgcolor="silver">���q�q��</td>                                 
        <td width="35%" height="23"><input type="text" name="key4" size="15" value="<%=dspkey(4)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">����<input type="text" name="key5" size="5" value="<%=dspkey(5)%>" maxlength="5" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="10%" class="dataListHead" height="23">��ʹq��</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key7" size="15" value="<%=dspkey(7)%>" maxlength="15" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="17%" class="dataListHead" height="23">�q�l�l��H�c</td>                                 
        <td width="35%" height="32" bgcolor="silver"><input type="text" name="key8" size="30" value="<%=dspkey(8)%>" maxlength="30" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="10%" class="dataListHead" height="23">���ڦW��</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key69" size="15" value="<%=dspkey(69)%>" maxlength="50" <%=fieldp9%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                   
        <td width="8%" class="dataListHead" height="23">�����ҷӸ�</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key80" size="10" value="<%=dspkey(80)%>" maxlength="10" <%=fieldp9%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>       
      </tr>      
      <tr>
        <td width="17%" class="dataListHead" height="23">�O�d����email</td>                                 
        <td width="35%" height="32" bgcolor="silver"><input type="text" name="key81" size="8" value="<%=dspkey(81)%>" maxlength="8" <%=fieldp7%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                           
      <tr style="display:none">                                 
        <td width="17%" class="dataListHead" height="23">��J�H��</td>                                 
        <td width="35%" height="23" bgcolor="silver"><input type="text" name="key45" size="10" class="dataListData" value="<%=dspKey(45)%>" readonly><%=EusrNc%></td>                                 
        <td width="10%" class="dataListHead" height="23">��J���</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key46" size="15" class="dataListData" value="<%=dspKey(46)%>" readonly></td>                                 
      </tr>                                 
      <tr style="display:none">                                 
        <td width="17%" class="dataListHead" height="23">���ʤH��</td>                                 
        <td width="35%" height="23" bgcolor="silver"><input type="text" name="key47" size="10" class="dataListData" value="<%=dspKey(47)%>" readonly><%=UUsrNc%></td>                                 
        <td width="10%" class="dataListHead" height="23">���ʤ��</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key48" size="15" class="dataListData" value="<%=dspKey(48)%>" readonly></td>                                 
      </tr>                                 
    </table>                            
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none">                           
      <tr>                         
        <td width="20%" class="dataListHead">�I�u�t��</td>                     
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�G�I�u�t�Ӥ�fieldrole�쬰4(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
<%  s=""
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldPb &fieldRole(1) &dataProtect))<1 and len(trim(dspkey(79)))=0 Then 
       sql="SELECT RTSuppCty.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTSuppCty ON RTObj.CUSID = RTSuppCty.CUSID INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID RIGHT OUTER JOIN " _
          &"RTCmty ON RTSuppCty.CUTID = RTCmty.CUTID " _
          &"WHERE (RTObjLink.CUSTYID = '04') and rtcmty.comq1=" & dspkey(0)
       s="<option value="""">&nbsp;</option>" & vbcrlf      
    Else
       sql="SELECT RTObj.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN RTSupp ON RTObj.CUSID = RTSupp.CUSID " _
          &"WHERE RTSupp.CUSID='" &dspKey(17) &"' "
    End If
    rs.Open sql,conn
    If rs.Eof Then 
       s="<option value="""" selected>&nbsp;</option>"
    else
       sx=""
       Do While Not rs.Eof
          If rs("CusID")=dspKey(17) Then sx=" selected "
          s=s &"<option value=""" &rs("CusID") &"""" &sx &">" &rs("SHORTNC") &"</option>" & vbcrlf
          rs.MoveNext
          sx=""
       Loop
    end if
    rs.Close
%>
        <select name="key17" <%=fieldRole(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%><%=fieldPb%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select></td>       
        <td width="17%" class="dataListHead">�q���o�]���</td>                     
        <td width="17%" colspan="1" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(70)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->            
          <input type="text" name="key70" size="10" value="<%=dspKey(70)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%> class="dataListEntry" maxlength="10"></td>                                               
        
        <td width="14%" class="dataListHead">�o�]���</td>                     
        <td width="18%" colspan="1" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(19)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key19" size="10" value="<%=dspKey(19)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%> class="dataListEntry" maxlength="10">
          <input type="button" id="B19"  name="B19" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>          </td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�w�˪�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key20" size="10" class="dataListData" value="<%=dspKey(20)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�w�˪�C�L��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key21" size="10" class="dataListData" value="<%=dspKey(21)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�C�L�H��</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key22" size="10" class="dataListData" value="<%=dspKey(22)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">���u���</td>                    
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(230)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key23" size="10" value="<%=dspKey(23)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="17%" class="dataListHead">�������</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(24)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key24" size="10" value="<%=dspKey(24)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B24"  name="B24" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                     
        <td width="14%" class="dataListHead">�J�b���</td>                     
        <td width="18%">
          <input type="text" name="key25" size="10" value="<%=dspKey(25)%>"   class="dataListdata" readonly maxlength="10">
          <input type="button" id="B25"  name="B25" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�������B</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key26" size="10" value="<%=dspKey(26)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="17%" class="dataListHead">�ꦬ���B</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(27)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key27" size="10" value="<%=dspKey(27)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="14%" class="dataListHead">�M�P���</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key28" size="10" value="<%=dspKey(28)%>" <%=fieldp10%><%=fieldp11%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B28"  name="B28" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>
          ���J<input type="text" name="key82" size="1" maxlength="10" value="<%=dspkey(82)%>" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          </td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">���ڪ�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key29" size="10" class="dataListData" value="<%=dspKey(29)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�C�L�H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key30" size="10" class="dataListData" value="<%=dspKey(30)%>" readonly></td>                     
        <td width="14%" class="dataListHead">���ڤ��</td>                     
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(31)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key31" size="10" value="<%=dspKey(31)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%>  class="dataListEntry" maxlength="10">
          <input type="button" id="B31"  name="B31" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�]�Ȧ��ڽT�{��</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key32" size="10" class="dataListData" value="<%=dspKey(32)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�]�ȽT�{�H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key33" size="10" class="dataListData" value="<%=dspKey(33)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�����p����</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key34" size="10" value="<%=dspKey(34)%>" readonly  class="dataListdata" maxlength="10"></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�M�P��]����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(35)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key35" size="72" value="<%=dspKey(35)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="50">
          </td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�����u��]</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(36)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key36" size="72" value="<%=dspKey(36)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�ڪ�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key37" size="10" class="dataListData" value="<%=dspKey(37)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�I�ڪ���</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key38" size="10" class="dataListData" value="<%=dspKey(38)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�C�L�H��</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key39" size="10" class="dataListData" value="<%=dspKey(39)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�ڷ|�p�f�ֽT�{��</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key40" size="10" class="dataListData" value="<%=dspKey(40)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�|�p�f�֤H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key41" size="10" class="dataListData" value="<%=dspKey(41)%>" readonly></td>                     
        <td width="14%" class="dataListHead">���׽X</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key42" size="10" class="dataListData" value="<%=dspKey(42)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u�Ƶ�����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(44)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key44" size="72" value="<%=dspKey(44)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u���ҥN�X</td>                    
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gfieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
        <%
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa  &fieldRole(5) &dataProtect))<1 and len(trim(dspkey(79)))=0 Then 
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='A6' " 
    Else
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='A6' and code='" &dspKey(43) &"' "
    End If
    rs.Open sql,conn
    s=""
    If rs.Eof Then s="<option value="""" selected>&nbsp;</option>"
    sx=""
    Do While Not rs.Eof
       If rs("code")=dspKey(43) Then sx=" selected "
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(43)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->   
        <select name="key43" <%=fieldRole(5)%><%=dataProtect%><%=fieldpg%><%=fieldPa%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>

        <td width="17%" class="dataListHead">�w�˭����O</td>
<%' if userlevel=1 then
  '    aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��")      
  '    aryOptionV=Array("0","1","2")
  ' elseif userlevel=4 then
  '    aryOption=Array("","�޳N���w��","�o�]")
  '    aryOptionV=Array("0","2","3")
  ' elseif userlevel=31 then
      aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��","�o�]")
      aryOptionV=Array("0","1","2","3")   
  ' end if
   s=""
   If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldRole(1) &dataProtect)) < 1 and len(trim(dspkey(79)))=0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(49)=aryOptionV(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOptionV(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   else
      s="<option value=""" &dspKey(49) &""">" &aryOption(dspKey(49))&"</option>"
   End If%>                    
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(49)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->      
        <td width="17%" bgcolor="silver"><select size="1" onChange="Srpay()" name="key49" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry">
          <%=s%></select></td>                     
        <td width="14%" class="dataListHead">
        <input type="button" name="EMPLOY" <%=fieldpg%><%=fieldPa%><%=fieldPb%> class=keyListButton <%=fieldpf%> value="�˾����u"></td>                     
        <td width="18%" bgcolor="silver">
  <% 
    Usrary=split(dspkey(50),";")
    qrystrng=""
    s1=""
    existusr=""
    if Ubound(Usrary) >= 0 then
       existUsr="("
       for i=0 to Ubound(usrary)
           existUsr=existUsr & "'" & usrary(i) & "',"
       next
       existUsr=mid(existUsr,1,len(existUsr)-1)
       existUsr=existUsr & ")"
       qrystring=" and rtemployee.emply in " & existusr
    end if
    if len(trim(qrystring)) < 1 then
       qrystring=" and rtemployee.emply='*' "
    end if
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08'" _
          & qrystring
    rs.Open sql,conn
    Do While Not rs.Eof
       s1=s1 & rs("cusnc") & ";"
       rs.MoveNext
    Loop
    if trim(len(s1)) > 0 then 
       s1=mid(s1,1,len(s1)-1)
    else
       dspkey(50)=""
       s1=""
    end if 
    rs.Close
    conn.Close   
    set rs=Nothing   
    set conn=Nothing
   %>       
          <input type="text" name="key50" size="14" value="<%=dspKey(50)%>"  class="dataListData"  readonly maxlength="50" style="display:none">
          <input type="text" name="ref01" size="10" value="<%=S1%>"  class="dataListData"  readonly maxlength="50">
          </td>                   
      </tr>                                     
      <tr>            
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�G�w�w�˾���/��/����fieldrole�쬰6(�Y�~�ȻP�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
        <td width="20%" class="dataListHead">�w�w�˾����</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key51" size="10" value="<%=dspKey(51)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B51"  name="B51" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                     
        <td width="17%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="17%" bgcolor="silver">
          <input type="text" name="key52" size="10" value="<%=dspKey(52)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                     
        <td width="14%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key53" size="10" value="<%=dspKey(53)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�зǬI�u�O</td>                    
        <td width="18%" bgcolor="silver">
        <input type="text" name="key54" size="10" class="dataListData" value="<%=dspKey(54)%>" readonly ></td>                     
        <td width="17%" class="dataListHead">�I�u�ɧU�O</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(55)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key55" size="10" value="<%=dspKey(55)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>                     
        <td width="32%" colspan="2">�@</td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u�ɧU�O����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(56)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key56" size="50" value="<%=dspKey(56)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="25"></td>                     
      </tr>                                     
    </table>
<table width="100%"><tr><td width="100%">&nbsp;</td></tr>                                                                                                   
  </div>                               
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrReadExtDB()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn
    extDB(0)=rs("CusNC")
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
    Dim conn,rs
' Smode A:add U:update
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
'------ RTObj ---------------------------------------------------
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
       End If
    End If

    rs("CusNC")=extDB(0)
    rs("ShortNC")=Left(extDB(0),5)
    rs("Eusr")=dspKey(45)
    rs("Edat")=dspKey(46)
    rs("Uusr")=dspKey(47)
    rs("Udat")=dspKey(48)
    rs.Update
    rs.Close
'------ RTObjLink -----------------------------------------------
    rs.Open "SELECT * FROM RTObjLink WHERE CustYID='05' AND CusID='" &dspKey(1) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
          rs("CustYID")="05"
       End If
    End If
    rs("Eusr")=dspKey(45)
    rs("Edat")=dspKey(46)
    rs("Uusr")=dspKey(47)
    rs("Udat")=dspKey(48)
    rs.Update
    rs.Close
'------ RTCUSTADSLCHG(�ȤᲧ����) -----------------------------------------------
'-------RETRIVE EMPLY ID
    logonid=session("userid")
    Call SrGetEmployeeRef(Rtnvalue,1,logonid)
    V=split(rtnvalue,";")  
'---------------------------------------------------------------
    chgdate=datevalue(now())
    updsql="SELECT * FROM RTcustHBchg WHERE CusID='" &dspKey(1) &"' AND Entryno=" & dspkey(2)  _
          &" and modifycode='" & session("updateopt") & "' and modifydat ='" & chgdate & "' "
    rs.Open  updsql,conn,3,3
    If rs.Eof Or rs.Bof Then
          rs.AddNew
          rs("CusID")=dspKey(1)
          rs("entryno")=dspkey(2)
          rs("modifycode")=session("updateopt")
          rs("modifydat")=chgdate
          rs("comq1")=dspkey(0)
          rs("dropdat")=Null
          rs("docketdat")=null
          rs("transdat")=null
          rs("modifyusr")=V(0)
          rs.update
    else
       if len(trim(rs("transdat")))=0 then
          rs("CusID")=dspKey(1)
          rs("entryno")=dspkey(2)
          rs("modifycode")=session("updateopt")
          rs("modifydat")=chgdate
          rs("comq1")=dspkey(0)
          rs("dropdat")=Null
          rs("docketdat")=null
          rs("transdat")=null
          rs("modifyusr")=V(0)
          rs.update
       end if
    End If
    rs.Close    

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       