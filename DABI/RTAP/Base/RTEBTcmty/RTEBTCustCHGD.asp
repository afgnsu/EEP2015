<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
%>
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(150),aryKeyValue(150),numberOfField,aryKey,aryKeyNameDB(150)
  Dim dspKey(150),userDefineKey,userDefineData,extDBField,extDB(150),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  Dim aryParmKey
 '90/09/03 ADD-START
 '�W�[EXTDBFIELD2,EXTDBFILELD3(�h�ɺ��@)
  dim extDBField2,extDB2(150),extDBField3,extDB3(150),extDBField4,extDB4(150)
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
  '  response.Write sql
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
                   case ucase("/webap/rtap/base/rtEBTcmty/RTEBTCUSTCHGd.asp")
                       'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 3 then rs.Fields(i).Value=dspKey(i)    
                       if i=3 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         rsc.open "select max(entryno) AS entryno from RTEBTCUSTCHG where comq1=" & dspkey(0) & " and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' " ,conn
                         if len(rsc("entryno")) > 0 then
                            dspkey(3)=rsc("entryno") + 1
                         else
                            dspkey(3)=1
                         end if
                         rsc.close
                         rs.Fields(i).Value=dspKey(i) 
                       end if      
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
                 case ucase("/webap/rtap/base/rtEBTcmty/RTEBTCUSTCHGd.asp")
                   ' response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                    ' if i<>0 and i <> 1 then rs.Fields(i).Value=dspKey(i)      
                      rs.Fields(i).Value=dspKey(i)        
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
       if ucase(runpgm)=ucase("/webap/rtap/base/rtEBTcmty/RTEBTCUSTCHGD.asp") then
          rsc.open "select max(entryno) AS ENTRYNO from RTEBTCUSTCHG where comq1=" & dspkey(0) & " and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' " ,conn
          if not rsC.eof then
            dspkey(3)=rsC("entryno")
          end if
          rsC.close
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
    'response.write "SQL=" & SQL
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
<link REL="stylesheet" HREF="/WebUtilityV4EBT/DBAUDI/dataList.css" TYPE="text/css">
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
<body bgcolor="#FFFFFF" text="#0000FF"  background="backgroup.jpg" bgproperties="fixed">
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
       sType=Right("000" & Cstr(aryKey(i)),3)
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
  numberOfKey=4
  title="AVS�Τ�A�Ȳ��ʧ@�~��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="select COMQ1, LINEQ1, CUSID, ENTRYNO, CHGCOD1, CHGCOD2, CHGCOD3, CHGCOD4, CHGCOD4OPT, APPLYDAT, NCUSNC, NSOCIALID, " _
             &"NCUTID2, NTOWNSHIP2, NVILLAGE2, NCOD21, NNEIGHBOR2, NCOD22, NSTREET2, NCOD23, NSEC2, NCOD24, NLANE2, NCOD25, " _
             &"NALLEYWAY2, NCOD26, NNUM2, NCOD27, NFLOOR2, NCOD28, NROOM2, NCOD29, NBIRTHDAY, NCUTID3, NTOWNSHIP3, " _
             &"NVILLAGE3, NCOD31, NNEIGHBOR3, NCOD32, NSTREET3, NCOD33, NSEC3, NCOD34, NLANE3, NCOD35, " _
             &"NALLEYWAY3, NCOD36, NNUM3, NCOD37, NFLOOR3, NCOD38, NROOM3, NCOD39, NEMAIL, NCONTACT, NCONTACTTEL, NMOBILE, DROPDAT, " _
             &"DROPUSR, TRANSCHKDAT, TRANSDAT, TRANSNO, EBTREPLYDAT, EBTREPLYCOD, EUSR, EDAT, UUSR, UDAT, FINISHDAT, FINISHCHKDAT, " _
             &"FINISHTNSDAT, FINISHTNSNO, NCOMQ1, NLINEQ1,NCUTID1, NTOWNSHIP1, NVILLAGE1, NCOD11, NNEIGHBOR1, NCOD12, NSTREET1, NCOD13, " _
             &"NSEC1, NCOD14, NLANE1, NCOD15, " _
             &"NALLEYWAY1, NCOD16, NNUM1, NCOD17, NFLOOR1, NCOD18, NROOM1, NCOD19,NRZONE1,NRZONE2,NRZONE3,NTELNO " _
             &"from RTEBTCUSTCHG WHERE COMQ1=0 "
  sqlList="select COMQ1, LINEQ1, CUSID, ENTRYNO, CHGCOD1, CHGCOD2, CHGCOD3, CHGCOD4, CHGCOD4OPT, APPLYDAT, " _
             &"NCUSNC, NSOCIALID,NCUTID2, NTOWNSHIP2, NVILLAGE2, NCOD21, NNEIGHBOR2, NCOD22, NSTREET2, NCOD23, " _
             &"NSEC2, NCOD24, NLANE2, NCOD25, NALLEYWAY2, NCOD26, NNUM2, NCOD27, NFLOOR2, NCOD28, " _
             &"NROOM2, NCOD29, NBIRTHDAY, NCUTID3, NTOWNSHIP3, NVILLAGE3, NCOD31, NNEIGHBOR3, NCOD32, NSTREET3, " _
             &"NCOD33, NSEC3, NCOD34, NLANE3, NCOD35, NALLEYWAY3, NCOD36, NNUM3, NCOD37, NFLOOR3, " _
             &"NCOD38, NROOM3, NCOD39, NEMAIL, NCONTACT, NCONTACTTEL, NMOBILE, DROPDAT,DROPUSR, TRANSCHKDAT,  " _
             &"TRANSDAT, TRANSNO, EBTREPLYDAT, EBTREPLYCOD, EUSR, EDAT, UUSR, UDAT, FINISHDAT, FINISHCHKDAT, " _
             &"FINISHTNSDAT, FINISHTNSNO, NCOMQ1, NLINEQ1,NCUTID1, NTOWNSHIP1, NVILLAGE1, NCOD11, NNEIGHBOR1, NCOD12, " _
             &"NSTREET1, NCOD13, NSEC1, NCOD14, NLANE1, NCOD15,NALLEYWAY1, NCOD16, NNUM1, NCOD17,  " _
             &"NFLOOR1, NCOD18, NROOM1, NCOD19,NRZONE1,NRZONE2,NRZONE3,NTELNO " _
             &"from RTEBTCUSTCHG WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=0
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
  if len(trim(dspkey(3)))=0 then dspkey(3)=0
   if len(trim(dspkey(12)))=0 then dspkey(12)=""
    if len(trim(dspkey(33)))=0 then dspkey(33)=""
     if len(trim(dspkey(74)))=0 then dspkey(74)=""
     if len(trim(dspkey(72)))=0 then dspkey(72)=0
     if len(trim(dspkey(73)))=0 then dspkey(73)=0
  '�h����]initial value
  i=4
  DROPFLAG=""
  Do while I < 8
     IF LEN(TRIM(DSPKEY(i))) = 0 THEN
        DSPKEY(i)=0
     ELSE
        DROPFLAG="Y"      
     END iF
     I=I+1
  LOOP
  Set connXX=Server.CreateObject("ADODB.Connection")
  Set rsXX=Server.CreateObject("ADODB.Recordset")
  Set rsyy=Server.CreateObject("ADODB.Recordset")
  Set rszz=Server.CreateObject("ADODB.Recordset")
  connXX.open DSN
  SQLxx="SELECT * FROM RTEBTCUST WHERE COMQ1=" &DSPKEY(0) & " AND LINEQ1=" & DSPKEY(1) & " AND CUSID='" & DSPKEY(2) & "' "
  RSXX.OPEN sqlxx,CONNXX
  if isnull(RSxx("DOCKETDAT")) then
       formValid=False
       message="���Τ�|�������A���i�إߥΤ�A�Ȳ��ʸ��"    
  ELSEif NOT isnull(RSxx("DROPDAT")) then
       formValid=False
       message="���Τ��Ƥw�h���A���i�إߥΤ�A�Ȳ��ʸ��"           
  ELSE
     sqlxx=" select max(entryno) as entryno from rtebtcustchg where  COMQ1=" &DSPKEY(0) & " AND LINEQ1=" & DSPKEY(1) & " AND CUSID='" & DSPKEY(2) & "' and (((CHGCOD1=1 OR CHGCOD3=1 ) AND TRANSCHKDAT IS NULL) OR ((CHGCOD2=1 ) AND FINISHCHKDAT IS NULL) ) AND DROPDAT IS NULL "
     rsyy.Open sqlxx,connxx
     if accessMode="A" and rsyy("entryno") > 0 then
        formValid=False
        message="���Τ�e�@�����ʩ|�����סA���i�A�s�W�ĤG������"    
     else
       If len(trim(dspkey(9)))=0  then
         formValid=False
         message="���ʥӽФ餣�i�ťթή榡���~"    
       ELSEIf dspkey(4) < 1 AND dspkey(5) < 1 AND dspkey(6) < 1  AND dspkey(7) < 1 then
         formValid=False
         message="�ܤֶ��Ŀ�@�ز��ʶ���"        
       ELSEIf dspkey(7)> 0 AND len(trim(dspkey(8))) =0   then
         formValid=False
         message="���ʶ��ج��䥦�̡A������J����"               
       ELSEIf len(trim(dspkey(11)))> 0  and ( len(trim(dspkey(11))) <> 8 AND len(trim(dspkey(11))) <> 10 )    then
         formValid=False
         message="�����ҩβνs���׿��~(�u�ର8�X��10�X)"                        
       ELSE
           If dspkey(4) > 0  then
             IF len(trim(dspkey(10))) =0 THEN
                formValid=False
                message="���ʥΤ�򥻸�ơA�Τ�W�٤��i�ť�"            
             ELSEIF len(trim(dspkey(11))) =0 THEN
                formValid=False
                message="���ʥΤ�򥻸�ơA�����Ҹ����i�ť�"            
             END IF
           end if
           If dspkey(4) < 1  then
              ADDERR=""
              J=14
              Do WHILE J <= 31
                 IF LEN(TRIM(DSPKEY(J))) <> 0 THEN
                    ADDERR="Y"      
                 END iF
                 J=J+2
              LOOP
              J=35
              Do WHILE J <= 52
                 IF LEN(TRIM(DSPKEY(J))) <> 0 THEN
                    ADDERR="Y"      
                 END iF
                 J=J+2
               LOOP
              IF len(trim(dspkey(10))) <>0 OR len(trim(dspkey(11))) <>0 OR len(trim(dspkey(32))) <>0 OR len(trim(dspkey(53))) <>0 OR len(trim(dspkey(54))) <>0 OR len(trim(dspkey(55))) <>0 OR len(trim(dspkey(56))) <>0 THEN
                 ADDERR="Y"     
              END IF
              IF ADDERR="Y" or len(trim(dspkey(12)))<>0  or len(trim(dspkey(13))) <> 0 or len(trim(dspkey(33))) <> 0  or len(trim(dspkey(34))) <> 0 THEN
                 formValid=False
                 message="���ʶ��ثD�Τ�򥻸�ƮɡA�򥻸�ƥ��������ť�"                 
              END IF
           end if
           If dspkey(5) < 1 then
              ADDERR=""
              J=76
              Do WHILE J <= 93
                 IF LEN(TRIM(DSPKEY(J))) <> 0 THEN
                    ADDERR="Y"      
                 END iF
                 J=J+2
              LOOP 
              IF ADDERR="Y" or len(trim(dspkey(74))) > 0 or len(trim(dspkey(75))) > 0 or len(trim(dspkey(96))) > 0 THEN
                 formValid=False
                 message="���ʶ��ثD�����ɡA�˾��a�}���������ť�"    
              END IF   
           end if          
          If dspkey(5) > 0  then  
             IF len(trim(dspkey(74))) = 0 OR len(trim(dspkey(75))) = 0 OR len(trim(dspkey(80))) = 0 OR len(trim(dspkey(88))) = 0 THEN
                formValid=False
                message="���ʶ��ج������ɡA�˾��a�}(����/�m��/��/��)���i�ť�"    
             END IF
          end if
          If dspkey(5) <> 1 and ( dspkey(72) > 0 or dspkey(73) > 0 ) then  
             formValid=False
             message="���ʶ��إ��Ŀ�[����]�ɡA�s���ϧǸ�/�D�u�Ǹ������ť�"     
          end if
          If  dspkey(5) > 0 AND ( len(trim(dspkey(72)))=0 or len(trim(dspkey(73)))=0 )  then  
             formValid=False
             message="[����]�ɡA���ϧǸ�/�D�u�Ǹ����i�ť�"     
          end if
          if dspkey(72) > 0 or dspkey(73) > 0 then
             sqlzz="select * FROM RTEBTCMTYLINE WHERE COMQ1=" & DSPKEY(72) & " AND LINEQ1=" & DSPKEY(73) 
             RSZZ.Open SQLZZ,CONNXX
             IF RSZZ.EOF THEN
                formValid=False
                message="�s����/�D�u���s�b�D�u����ɡC"
             ELSE
                if isnull(rszz("ADSLAPPLYDAT")) then
                   formValid=False
                   message="�s����/�D�u�|���}�q�A���i���J�ӥD�u�C"
                end if
             END IF  
             rszz.close
          end if
          If dspkey(6) < 1 AND len(trim(dspkey(97))) <> 0 then
             formValid=False
             message="���ʶ��ثD[����]�ɡA�s���ܸ��X�����ť�"         
          END IF              
          If dspkey(6) > 0 AND len(trim(dspkey(97))) = 0 then
             formValid=False
             message="���ʶ��ج�[����]�ɡA�s���ܸ��X���i�ť�"                       
          end if
        end if
     end if
'-------UserInformation----------------------       
     logonid=session("userid")
     if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(66)=V(0)
        dspkey(67)=datevalue(now())
     end if    
     RSYY.CLOSE
     SET RSYY=NOTHING
   END IF 
   RSXX.CLOSE
   SET RSXX=NOTHING
   CONNXX.Close
   SET CONNXX=NOTHING
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

   Sub SrGETCOMLINEonclick()
       Dim ClickID,RTN,srcElementid
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
       srcElementid=window.event.srcElement.id
       if strfeature="" then
          Scrxx=window.screen.width -7 
          Scryy=window.screen.height - 74
          StrFeature="top=0,left=0,scrollbars=yes,status=yes," _
                 &"location=no,menubar=no,width=" & scrxx & "px" _
                 &",height=" & scryy & "px" 
       end if       
       prog="RTEBTCMTYLINEK3.ASP"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")
       if  fusr <> "" then
           keyxx=split(fusr,"-")
           document.all("key72").value=keyxx(0)
           document.all("key73").value=keyxx(1)
           document.all("comn").value=keyxx(2)
       end if
   END SUB   
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid    
       IF CLICKID="73" THEN
         if len(trim(document.all(clearkey).value)) <> 0 then
            document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
         end if
         if len(trim(document.all("KEY72").value)) <> 0 then
            document.all("KEY72").value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
         end if         
       ELSE
         if len(trim(document.all(clearkey).value)) <> 0 then
            document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
         end if
       END IF
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
   Sub Srcounty13onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY12").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key13").value =  trim(Fusrid(0))
          document.all("key95").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub Srcounty34onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY33").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key34").value =  trim(Fusrid(0))
          document.all("key94").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB   
   Sub Srcounty75onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY74").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key75").value =  trim(Fusrid(0))
          document.all("key96").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB       
   Sub SrTAG0()
       'msgbox window.SRTAB1.style.display
       if window.SRTAB0.style.display="" then
          window.SRTAB0.style.display="none"
       elseif window.SRTAB0.style.display="none" then
          window.SRTAB0.style.display=""
       end if
   End Sub               
   Sub SrTAG1()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB1.style.display="" then
          window.SRTAB1.style.display="none"
       elseif window.SRTAB1.style.display="none" then
          window.SRTAB1.style.display=""
       end if
   End Sub        
   Sub SrTAG2()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB2.style.display="" then
          window.SRTAB2.style.display="none"
       elseif window.SRTAB2.style.display="none" then
          window.SRTAB2.style.display=""
       end if
   End Sub          
   Sub SrTAG3()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB3.style.display="" then
          window.SRTAB3.style.display="none"
       elseif window.SRTAB3.style.display="none" then
          window.SRTAB3.style.display=""
       end if
   End Sub             
Sub SrAddrEqual1()
  Dim i,j
  i=74
  j=12
  do while i < 94
     keyx="key" & i
     keyy="key" & j
     document.All(keyY).value=document.All(keyX).value
     i=i+1
     j=j+1
  loop
   document.All("key95").value=document.All("key96").value
End Sub    
Sub SrAddrEqual2()
  Dim i,j
  i=74
  j=33
  do while i < 94
     keyx="key" & i
     keyy="key" & j
     document.All(keyY).value=document.All(keyX).value
     i=i+1
     j=j+1
  loop
   document.All("key94").value=document.All("key96").value
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
       <tr><td width="15%" class=dataListHead>���ϧǸ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(0)%>" maxlength="8" class=dataListdata></td>
           <td width="15%" class=dataListHead>�D�u�Ǹ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key1"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(1)%>" maxlength="8" class=dataListdata></td>                 
           <td width="15%" class=dataListHead>�Τ�Ǹ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key2"
                 <%=fieldRole(1)%> readonly size="15" value="<%=dspKey(2)%>" maxlength="15" class=dataListdata></td>
           <td width="15%" class=dataListHead>����</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key3"
                 <%=fieldRole(1)%> readonly size="4" value="<%=dspKey(3)%>" maxlength="4" class=dataListdata ID="Text37"></td>                 
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(64))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(64)=V(0)
        End if  
       dspkey(65)=datevalue(now())
    else
        if len(trim(dspkey(66))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(66)=V(0)
        End if         
        dspkey(67)=datevalue(now())
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '���ɼf�֤�s�b(�Τw�@�o)��,��� protect
    If len(trim(dspKey(59))) > 0 OR len(trim(dspKey(57))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
    Else
       fieldPa=""
       fieldpb=""
    End If
    If len(trim(dspKey(69))) > 0 OR len(trim(dspKey(68))) > 0 OR len(trim(dspKey(57))) > 0 Then
       fieldpc=" disabled "
       fieldPE=" class=""dataListData"" readonly "
    Else
       fieldpc=""
       fieldpE=""
    End If
    If len(trim(dspKey(70))) > 0 Then
       fieldpd=" disabled "
       fieldPf=" class=""dataListData"" readonly "
    Else
       fieldpd=""
       fieldpf=""
    End If
     
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    Set rsXX=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <!--
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>           
  -->
  <span id="tags1" class="dataListTagsOn">AVS�Τ�A�Ȳ��ʸ�T</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td>
<td>     
    <DIV ID="SRTAG0" onclick="srtag0" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">���ʫe�򥻸��</td></tr></table></div>
 <DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">

<tr><td width="10%" class=dataListHEAD>�Τ�(���q)�W��</td>
    <td  width="40%"  bgcolor="silver" >
<% sql="SELECT * FROM RTebtcust where comq1=" & DSPkey(0) & " and lineq1=" & DSPKEY(1) & " and cusid='" & DSPKEY(2) & "' "
   rs.open sql,conn
   if not rs.eof then
      cusnc=rs("cusnc")
   else
      cusnc=""
   end if
%>  
        <input type="text"   style="text-align:left;" maxlength="30"
               value="<%=cusnc%>"  size="30"  READONLY class=dataListDATA ID="Text22"></td>
<td width="10%" class=dataListHEAD>������(�νs)</td>
    <td width="40%" bgcolor="silver" >
 <%  if not rs.eof then
      socialid=rs("socialid")
   else
      socialid=""
   end if    
   %>
        <input type="password" style="text-align:left;" maxlength="10"
               value="<%=socialid%>"   size="12"  READONLY class=dataListDATA ID="Text23"></td>               
</tr>
<tr><td class=dataListHEAD>ADSL�˾��a�}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & RS("CUTID1") & "' " 
    sx=""    
    rsXX.Open sql,conn
    IF NOT RSXX.EOF THEN
       CUTNC=RSXX("CUTNC")
    ELSE
       CUTNC=""
    END IF
    RSXX.CLOSE
   %>
       <input type="text"  readonly  size="6" value="<%=CUTNC%>" maxlength="10" readonly  class="dataListDATA" ID="Text38" NAME="Text38">
        <input type="text"  readonly  size="8" value="<%=RS("TOWNSHIP1")%>" maxlength="10" readonly  class="dataListDATA" ID="Text4">              
        
        <input type="text"  size="10" value="<%=RS("VILLAGE1")%>" maxlength="10" class="dataListDATA" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
      s=""
      s="<option value=""" &RS("COD11") &""">" &RS("COD11") &"</option>"
        %>                                  
       <select size="1"  class="dataListDATA" ID="Select3">                                            
        <%=s%></select>       
        <input type="text"  size="6"  READONLY value="<%=RS("NEIGHBOR1")%>" maxlength="6" class="dataListDATA" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
        s=""
        s="<option value=""" &RS("COD12") &""">" &RS("COD12")&"</option>"
        %>                                  
       <select size="1"   class="dataListDATA" ID="Select4">                                            
        <%=s%></select>              
        <input type="text"  size="10"  READONLY value="<%=RS("STREET1")%>" maxlength="10"  class="dataListDATA" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
      s="<option value=""" &RS("COD13") &""">" &RS("COD13") &"</option>"
%>                                  
       <select size="1" class="dataListDATA" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text"  size="6"  READONLY value="<%=RS("SEC1")%>" maxlength="6"  class="dataListDATA" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
      s="<option value=""" &RS("COD14") &""">" &RS("COD14") &"</option>"
%>                                  
       <select size="1"  class="dataListDATA" ID="Select6">                                            
        <%=s%></select>
        <input type="text"  size="6"  READONLY value="<%=RS("LANE1")%>" maxlength="6"  class="dataListDATA" ID="Text30"><font size=2>
        <% aryOption=Array("��")
   s=""
      s="<option value=""" &RS("COD15") &""">" &RS("COD15") &"</option>"
%>                                  
       <select size="1"  class="dataListDATA" ID="Select9">                                            
        <%=s%></select>     
                <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text"  readonly size="5" value="<%=RS("RZONE1")%>" maxlength="5"  class="dataListDATA" ID="Text12">
        <input type="text"  size="10"  READONLY value="<%=RS("ALLEYWAY1")%>" maxlength="6" class="dataListDATA" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
      s="<option value=""" &RS("COD16")  &""">" &RS("COD16")  &"</option>"
%>                                  
       <select size="1"  class="dataListDATA" ID="Select10">                                            
        <%=s%></select>    
        <input type="text"  size="6"  READONLY value="<%=RS("NUM1")%>" maxlength="6"  class="dataListDATA" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
      s="<option value=""" &RS("COD17") &""">" &RS("COD17") &"</option>"
%>                                  
       <select size="1"  class="dataListDATA" ID="Select11">                                            
        <%=s%></select>            
        <input type="text"  size="10"  READONLY value="<%=RS("FLOOR1")%>" maxlength="6"  class="dataListDATA" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
      s="<option value=""" &RS("COD18") &""">" &RS("COD18") &"</option>"
%>                                  
       <select size="1" class="dataListDATA" ID="Select12">                                            
        <%=s%></select>
        <input type="text"  size="6"  READONLY value="<%=RS("ROOM1")%>" maxlength="6"  class="dataListDATA" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
      s="<option value=""" &RS("COD19") &""">" &RS("COD19") &"</option>"
%>                                  
       <select size="1" READONLY  class="dataListDATA" ID="Select13">                                            
        <%=s%></select>       
        </td>                                 
</tr>  
<tr>                                 
        <td  class="dataListHEAD" height="23">���ܹq�ܸ��X</td>                                 
        <td  height="23" bgcolor="silver">
<%    sql=" select TELNO from rtEBTCUSTEXT where COMQ1=" & DSPKEY(0) & " AND LINEQ1=" & DSPKEY(1) & " AND CUSID='" & DSPKEY(2) & "' AND DROPDAT IS NULL "
      rsXX.Open sql,conn
      if rsXX.eof then
         TELNO=""
      else
         TELNO=rsXX("TELNO")
      end if
      rsXX.close
%>        
        <input type="text"  size="15" READONLY value="<%=TELNO%>"   class="dataListDATA" ID="Text8">  
        <td  class="dataListHEAD" height="23">�p��E-MAIL</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text"  size="50" READONLY maxlength="50" value="<%=RS("EMAIL")%>"   class="dataListDATA" ID="Text7">
        </td>                                 
 
 </tr>        
<TR>        
        <td  class="dataListHEAD" height="23">�p���H�m�W</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text"  size="15"  READONLY maxlength="15" value="<%=RS("CONTACT")%>"   class="dataListDATA" ID="Text9">
        <td  class="dataListHEAD" height="23">�p���q��(�դ�)</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" size="15"  READONLY maxlength="15" value="<%=RS("CONTACTTEL")%>"  class="dataListDATA" ID="Text16"></td>                                 
 </tr>
<TR>        
       <td  class="dataListhead" height="23">��ʹq��</td>                                 
        <td  height="23" bgcolor="silver" COLSPAN=3>
        <input type="text"  size="17"  READONLY maxlength="15" value="<%=RS("MOBILE")%>"   class="dataListDATA" ID="Text11"></td>                                 
 </tr> 
</table> </div>
<%RS.CLOSE%>
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->
    <DIV ID="SRTAG1" onclick="srtag1" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">���ʫ�򥻸��</td></tr></table></div>
     <DIV ID=SRTAB1 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">
<tr><td width="10%" class=dataListHEAD>���ʥӽФ�</td>
    <td width="40%" bgcolor="silver" >
        <input type="text" name="key9" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(9)%>"  READONLY size="10" class=dataListEntry ID="Text1">
       <input  type="button" id="B9"  <%=fieldpb%> name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C9"  name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>
        <td  class="dataListHEAD" height="23">���ʶ���</td>                                 
        <td  height="23" bgcolor="silver" >
<%   IF DSPKEY(4)=1 THEN CHECK4=" CHECKED "%>
<INPUT type="checkbox" name="key4" value=1 <%=CHECK4%>   <%=fieldpa%>   <%=fieldRole(1)%> bgcolor="silver" ID="Checkbox16" ><font size=2>�ܧ�Τ���</font>
<%   IF DSPKEY(5)=1 THEN CHECK5=" CHECKED "%>
<INPUT type="checkbox" name="key5" value=1 <%=CHECK5%>   <%=fieldpa%> <%=fieldRole(1)%> bgcolor="silver" ID="Checkbox17" ><font size=2>����</font>
<%   IF DSPKEY(6)=1 THEN CHECK6=" CHECKED "%>
<INPUT type="checkbox" name="key6" value=1 <%=CHECK6%>   <%=fieldpa%>  <%=fieldRole(1)%> bgcolor="silver" ID="Checkbox18" ><font size=2>����</font>
<%   IF DSPKEY(7)=1 THEN CHECK7=" CHECKED "%>
<INPUT type="checkbox" name="key7" value=1 <%=CHECK7%>   <%=fieldpa%>  <%=fieldRole(1)%> bgcolor="silver" ID="Checkbox19" ><font size=2>�䥦</font>
        
    <input type="text" name="key8" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(8)%>"   size="10" class=dataListEntry ID="Text83">
   </td>       
</tr>    
<tr><td width="10%" class=dataListHEAD>�Τ�(���q)�W��</td>
    <td  width="40%"  bgcolor="silver" >
                <input type="text" name="key10" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(10)%>"  size="30" class=dataListENTRY ID="Text15"></td>
<td width="10%" class=dataListHEAD>������(�νs)</td>
    <td width="40%" bgcolor="silver" >
        <input type="password" name="key11" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(11)%>"   size="12" class=dataListENTRY ID="Text53"></td>               
</tr>
<tr><td class=dataListHEAD>���y�a�}
<br><input type="radio" name="rd1"  <%=fieldpA%> onClick="SrAddrEqual1()" ID="Radio1" VALUE="Radio1">�P�s�˾�</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(59))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(12))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
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
         <select size="1" name="key12" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select8"><%=s%></select>
        <input type="text" name="key13" readonly  size="8" value="<%=dspkey(13)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text54"><font SIZE=2>(�m��)                 
         <input type="button" id="B13"  <%=fieldpb%>  name="B13"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX13%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%>  alt="�M��" id="C13"  name="C13"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key14" <%=fieldpa%> size="10" value="<%=dspkey(14)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text55"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(15)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(15) &""">" &dspKey(15) &"</option>"
   End If%>                                  
       <select size="1" name="key15" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select14">                                            
        <%=s%></select>      
        <input type="text" name="key16"  size="6" value="<%=dspkey(16)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text56"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(17)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(17) &""">" &dspKey(17) &"</option>"
   End If%>                                  
       <select size="1" name="key17" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select15">                                            
        <%=s%></select>              
        <input type="text" name="key18" size="10" value="<%=dspkey(18)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text57"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(19)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(19) &""">" &dspKey(19) &"</option>"
   End If%>                                  
       <select size="1" name="key19" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select16">                                            
        <%=s%></select>                      
        <input type="text" name="key20"  size="6" value="<%=dspkey(20)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text58"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(21)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(21) &""">" &dspKey(21) &"</option>"
   End If%>                                  
       <select size="1" name="key21" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select17">                                            
        <%=s%></select>
        <input type="text" name="key22" size="6" value="<%=dspkey(22)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text59"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(23)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(23) &""">" &dspKey(23) &"</option>"
   End If%>                                  
       <select size="1" name="key23" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select18">                                            
        <%=s%></select>        
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text" name="key95"  readonly size="5" value="<%=dspkey(95)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text60">
        <input type="text" name="key24" size="10" value="<%=dspkey(24)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text61"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(25)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(25) &""">" &dspKey(25) &"</option>"
   End If%>                                  
       <select size="1" name="key25" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select19">                                            
        <%=s%></select>    
        <input type="text" name="key26" size="6" value="<%=dspkey(26)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text62"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(27)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(27) &""">" &dspKey(27) &"</option>"
   End If%>                                  
       <select size="1" name="key27" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select20">                                            
        <%=s%></select>            
        <input type="text" name="key28" size="10" value="<%=dspkey(28)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text63"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(29)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(29) &""">" &dspKey(29) &"</option>"
   End If%>                                  
       <select size="1" name="key29" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select21">                                            
        <%=s%></select>
        <input type="text" name="key30" size="6" value="<%=dspkey(30)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text64"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(31)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(31) &""">" &dspKey(31) &"</option>"
   End If%>                                  
       <select size="1" name="key31" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select37">                                            
        <%=s%></select>  
        </td>                                 
</tr>  
<tr><td class=dataListHEAD>�b��a�}
<br><input type="radio" name="rd2"  <%=fieldpA%> onClick="SrAddrEqual2()" ID="Radio2" VALUE="Radio1">�P�s�˾�</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(59))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(33))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX34=" onclick=""Srcounty34onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(33) & "' " 
       SXX34=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(33) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key33" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select22"><%=s%></select>
        <input type="text" name="key34" readonly  size="8" value="<%=dspkey(34)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text2"><font SIZE=2>(�m��)                 
         <input type="button" id="B34"   <%=fieldpb%> name="B34"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX34%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C34"  name="C34"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key35" <%=fieldpa%> size="10" value="<%=dspkey(35)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text46"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(36)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(36) &""">" &dspKey(36) &"</option>"
   End If%>                                  
       <select size="1" name="key36" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select23">                                            
        <%=s%></select>      
        <input type="text" name="key37"  size="6" value="<%=dspkey(37)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text47"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(38)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(38) &""">" &dspKey(38) &"</option>"
   End If%>                                  
       <select size="1" name="key38" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select24">                                            
        <%=s%></select>              
        <input type="text" name="key39" size="10" value="<%=dspkey(39)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text48"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(40)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(40) &""">" &dspKey(40) &"</option>"
   End If%>                                  
       <select size="1" name="key40" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select25">                                            
        <%=s%></select>                      
        <input type="text" name="key41"  size="6" value="<%=dspkey(41)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text65"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(42)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(42) &""">" &dspKey(42) &"</option>"
   End If%>                                  
       <select size="1" name="key42" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select26">                                            
        <%=s%></select>
        <input type="text" name="key43" size="6" value="<%=dspkey(43)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text75"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(44)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(44) &""">" &dspKey(44) &"</option>"
   End If%>                                  
       <select size="1" name="key44" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select27">                                            
        <%=s%></select>        
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text" name="key94"  readonly size="5" value="<%=dspkey(94)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text76">
        <input type="text" name="key45" size="10" value="<%=dspkey(45)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text77"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(46)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(46) &""">" &dspKey(46) &"</option>"
   End If%>                                  
       <select size="1" name="key46" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select28">                                            
        <%=s%></select>    
        <input type="text" name="key47" size="6" value="<%=dspkey(47)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text78"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(48)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(48) &""">" &dspKey(48) &"</option>"
   End If%>                                  
       <select size="1" name="key48" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select29">                                            
        <%=s%></select>            
        <input type="text" name="key49" size="10" value="<%=dspkey(49)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text79"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(50)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(50) &""">" &dspKey(50) &"</option>"
   End If%>                                  
       <select size="1" name="key50" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select30">                                            
        <%=s%></select>
        <input type="text" name="key51" size="6" value="<%=dspkey(51)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text80"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(52)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(52) &""">" &dspKey(52) &"</option>"
   End If%>                                  
       <select size="1" name="key52" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select38">                                            
        <%=s%></select>            
        </td>                                 
</tr>  

<tr>                                 
        <td  class="dataListHEAD" height="23">�X�ͦ~���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text"  size="10" NAME="KEY32" MAXLENGTH="10" value="<%=DSPKEY(32)%>"  <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListENTRY" ID="Text66" NAME="Text66">  
       <input  type="button" id="B32" name="B32" <%=fieldpb%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C32"  name="C32"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
        <td  class="dataListHEAD" height="23">�p��E-MAIL</td>                                 
        <td  height="23" bgcolor="silver">
                <input type="text" name="key53" size="30" maxlength="30" value="<%=dspKey(53)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text67">
        </td>                                 
 
 </tr>        
<TR>        
        <td  class="dataListHEAD" height="23">�p���H�m�W</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key54" size="12" maxlength="12" value="<%=dspKey(54)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text68">
         <td  class="dataListHEAD" height="23">�p���q��(�դ�)</td>                                 
        <td  height="23" bgcolor="silver" >
         <input type="text" name="key55" size="15" maxlength="15" value="<%=dspKey(55)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text69"></td>                                 
 </tr>
<TR>
       <td  class="dataListhead" height="23">��ʹq��</td>                                 
        <td  height="23" bgcolor="silver" COLSPAN=3>
        <input type="text" name="key56" size="15" maxlength="15" value="<%=dspKey(56)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text70"></td>                                 
 </tr> 
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(64) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(64) & "' "
              rsXX.Open sql,conn
              if rsXX.eof then
                 name=""
              else
                 name=rsXX("cusnc")
              end if
              rsXX.close
           end if
  %>    <input type="text" name="key64" size="6" READONLY value="<%=dspKey(64)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text71"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key65" size="10" READONLY value="<%=dspKey(65)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text72">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(66) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(66) & "' "
              rsXX.Open sql,conn
              if rsXX.eof then
                 name=""
              else
                 name=rsXX("cusnc")
              end if
              rsXX.close
           end if
  %>    <input type="text" name="key66" size="6" READONLY value="<%=dspKey(66)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text73"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key67" size="10" READONLY value="<%=dspKey(67)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text74">
        </td>       
 </tr>   
  </table>     
  </DIV> 
  </DIV>   
      <DIV ID="SRTAG2" onclick="srtag2" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
    <tr><td bgcolor="BDB76B" align="LEFT">�����δ���</td></tr></table></DIV>
    <DIV ID=SRTAB2 >
<table border=1 cellpadding=0 cellspacing=0 width="100%"  ID="Table3">
<tr>
        <td  class="dataListHEAD" height="23">�s���ϥD�u</td>                                 
        <td  height="23" bgcolor="silver" colspan=3>
       <input type="text" name="key72" size="4"  value="<%=dspKey(72)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListentry" ID="Text3"><font size=2>��</font>
       <input type="text" name="key73" size="4"  value="<%=dspKey(73)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListentry" ID="Text10">
       <!--               <input  type="button" id="B73" name="B73" <%=fieldpb%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrGETCOMLINEOnClick"> -->
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C73"  name="C73"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
<%
       if dspkey(72) > 0 then
          sql="SELECT * FROM RTebtcmtyh where comq1=" & dspkey(72) 
          rs.open sql,conn
          if rs.eof then
             comn=""
          else
             comn=rs("comn")
          end if
          rs.close
       else
          comn=""
       end if
%>       
       <input type="text" name="comn" size="30" READONLY value="<%=comn%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text84">
</td>  
 </tr>   
<tr><td class=dataListHEAD>�s�˾��a�}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(59))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(74))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX75=" onclick=""Srcounty75onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(74) & "' " 
       SXX75=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(74) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key74" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key75" readonly  size="8" value="<%=dspkey(75)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text13"><font SIZE=2>(�m��)                 
         <input type="button" id="B75" <%=fieldpb%> name="B75"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX75%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C75"  name="C75"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key76" <%=fieldpa%> size="10" value="<%=dspkey(76)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text14"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(77)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(77) &""">" &dspKey(77) &"</option>"
   End If%>                                  
       <select size="1" name="key77" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select1">                                            
        <%=s%></select>      
        <input type="text" name="key78"  size="6" value="<%=dspkey(78)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text21"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(79)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(79) &""">" &dspKey(79) &"</option>"
   End If%>                                  
       <select size="1" name="key79" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select7">                                            
        <%=s%></select>              
        <input type="text" name="key80" size="10" value="<%=dspkey(80)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text25"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(81)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(81) &""">" &dspKey(81) &"</option>"
   End If%>                                  
       <select size="1" name="key81" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select31">                                            
        <%=s%></select>                      
        <input type="text" name="key82"  size="6" value="<%=dspkey(82)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text26"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(83)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(83) &""">" &dspKey(83) &"</option>"
   End If%>                                  
       <select size="1" name="key83" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select32">                                            
        <%=s%></select>
        <input type="text" name="key84" size="6" value="<%=dspkey(84)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text28"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(85)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(85) &""">" &dspKey(85) &"</option>"
   End If%>                                  
       <select size="1" name="key85" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select33">                                            
        <%=s%></select>     
                <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text" name="key96"  readonly size="5" value="<%=dspkey(96)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text35">
        <input type="text" name="key86" size="10" value="<%=dspkey(86)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text36"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(87)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(87) &""">" &dspKey(87) &"</option>"
   End If%>                                  
       <select size="1" name="key87" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select34">                                            
        <%=s%></select>    
        <input type="text" name="key88" size="6" value="<%=dspkey(88)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text39"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(89)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(89) &""">" &dspKey(89) &"</option>"
   End If%>                                  
       <select size="1" name="key89" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                            
        <%=s%></select>            
        <input type="text" name="key90" size="10" value="<%=dspkey(90)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text81"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(91)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(91) &""">" &dspKey(91) &"</option>"
   End If%>                                  
       <select size="1" name="key91" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select36">                                            
        <%=s%></select>
        <input type="text" name="key92" size="6" value="<%=dspkey(92)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text82"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(59))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(93)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(93) &""">" &dspKey(93) &"</option>"
   End If%>                                  
       <select size="1" name="key93" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select39">                                            
        <%=s%></select>           
        </td>                                 
</tr>  
<tr>
        <td  class="dataListHEAD" height="23">�s���ܸ��X</td>                                 
        <td  height="23" bgcolor="silver" colspan=3>
       <input type="text" name="key97" size="15"  value="<%=dspKey(97)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListENTRY" ID="Text86">
        </td>  
 </tr>   
</table>
    <DIV ID="SRTAG3" onclick="srtag3" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
    <tr><td bgcolor="BDB76B" align="LEFT">�@�~�i��</td></tr></table></div>
 <DIV ID="SRTAB3" >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="Table5">
<tr><td width="10%" class=dataListHEAD>�@�o��</td>
    <td width="40%" bgcolor="silver" >
        <input type="text" name="key57" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(57)%>"  READONLY size="10" class=dataListdata ID="Text24">
      </td>
        <td  class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td  height="23" bgcolor="silver" >
        <%  name="" 
           if dspkey(58) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(58) & "' "
              rsXX.Open sql,conn
              if rsXX.eof then
                 name=""
              else
                 name=rsXX("cusnc")
              end if
              rsXX.close
           end if
  %>           
        <input type="text" name="key58" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(58)%>"  READONLY size="10" class=dataListdata ID="Text40"><font size=2><%=name%></font>
</tr>
<tr><td width="10%" class=dataListHEAD>���ʥӽ����ɼf�֤�</td>
    <td width="40%" bgcolor="silver" >
        <input type="text" name="key59" <%=fieldpe%> <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(59)%>"  READONLY size="10" class=dataListENTRY ID="Text41">
       <input  type="button" id="B59" name="B59" <%=fieldpb%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  alt="�M��" <%=fieldpc%> id="C59"  name="C59"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>
        <td  class="dataListHEAD" height="23">���ʥӽ����ɤ�</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key60" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(60)%>"  READONLY size="10" class=dataListdata ID="Text42">
</tr>
<tr><td width="15%" class=dataListHEAD>���ɧǸ�</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key61" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(61)%>"  READONLY size="10" class=dataListdata ID="Text43">
      </td>
        <td  class="dataListHEAD" height="23">EBT�^�Ф�</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key62" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(62)%>"  READONLY size="10" class=dataListdata ID="Text44">
</tr>
<tr><td width="15%" class=dataListHEAD>EBT�^�е��G</td>
    <td width="35%" bgcolor="silver" COLSPAN=3>
        <input type="text" name="key63" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(63)%>"  READONLY size="10" class=dataListdata ID="Text45">
      </td>
</tr>
<tr><td width="15%" class=dataListHEAD>���������I�u������</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key68" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(68)%>"  READONLY size="10" class=dataListDATA ID="Text51">
      </td>
    <td width="15%" class=dataListHEAD>���u�^���f�֤�</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key69" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(69)%>"  <%=fieldpf%>  READONLY size="10" class=dataListENTRY ID="Text49">
       <input  type="button" id="B69" name="B69" <%=fieldpD%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  alt="�M��" <%=fieldpd%>  id="C69"  name="C69"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>
</TR>
<TR>
    <td  class="dataListHEAD" height="23">���u�^�����ɤ�</td>                                 
    <td  height="23" bgcolor="silver" >
    <input type="text" name="key70" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(70)%>"  READONLY size="10" class=dataListdata ID="Text50"></td>
    <td width="15%" class=dataListHEAD>���u�^�����ɧǸ�</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key71" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(71)%>"  READONLY size="15" class=dataListdata ID="Text52">
      </td>               
</tr>
</table></div>
  </DIV>

<%
    conn.Close   
    set rs=Nothing   
    set rsXX=Nothing   
    set conn=Nothing 
End Sub 
' -------------------------------------------------------------------------------------------- 
Sub SrReadExtDB()
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
End Sub
' -------------------------------------------------------------------------------------------- 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->