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
                   case ucase("/webap/rtap/base/rtEBTcmty/RTEBTCUSTd.asp")
                   ' response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 2 then rs.Fields(i).Value=dspKey(i)    
                       if i=2 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         cusidxx="A" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
                         rsc.open "select max(cusid) AS cusid from rtEBTcust where cusid like '" & cusidxx & "%' " ,conn
                         if len(rsc("cusid")) > 0 then
                            dspkey(2)=cusidxx & right("0000" & cstr(cint(right(rsc("cusid"),4)) + 1),4)
                         else
                            dspkey(2)=cusidxx & "0001"
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
                 case ucase("/webap/rtap/base/rtEBTcmty/RTEBTcustd.asp")
                    'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     if i<>0 and i <> 1 then rs.Fields(i).Value=dspKey(i)         
                 case else
                     rs.Fields(i).Value=dspKey(i)
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
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
       if ucase(runpgm)=ucase("/webap/rtap/base/rtEBTcmty/RTEBTCUSTD.asp") then
          cusidxx="A" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
          rsc.open "select max(cusid) AS cusid from rtEBTcust where cusid like '" & cusidxx & "%' " ,conn
          if not rsC.eof then
            dspkey(2)=rsC("CUSID")
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
  title="AVS�Τ��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1, LINEQ1, CUSID, CUSNC, SOCIALID, CUTID1, TOWNSHIP1, VILLAGE1, " _
             &"COD11, NEIGHBOR1, COD12, STREET1, COD13, SEC1, COD14, LANE1, COD15, " _
             &"ALLEYWAY1, COD16, NUM1, COD17, FLOOR1, COD18, ROOM1, " _
             &"COD19, CUTID2, TOWNSHIP2, VILLAGE2, COD21, NEIGHBOR2, COD22, " _
             &"STREET2, COD23, SEC2, COD24, LANE2, COD25, ALLEYWAY2, " _
             &"COD26, NUM2, COD27, FLOOR2, COD28, ROOM2, COD29, CUTID3, " _
             &"TOWNSHIP3, VILLAGE3, COD31, NEIGHBOR3, COD32, STREET3, COD33, SEC3, " _
             &"COD34, LANE3, COD35, ALLEYWAY3, COD36, NUM3, COD37, FLOOR3, " _
             &"COD38, ROOM3, COD39, BIRTHDAY, CONTACT, MOBILE, EMAIL, CONTACTTEL, " _
             &"PAYTYPE, AVSPMCODE, DIALERPMCODE, DIALERPAYTYPE, AGENTNAME, " _
             &"AGENTTEL, AGENTSOCIAL, CUTID4, TOWNSHIP4, VILLAGE4, NEIGHBOR4, " _
             &"STREET4, SEC4, LANE4, ALLEYWAY4, NUM4, FLOOR4, ROOM4, " _
             &"RCVD, APPLYDAT, APPLYTNSDAT, APPLYAGREE, PROGRESSID, FINISHDAT, " _
             &"DOCKETDAT, TRANSDAT, STRBILLINGDAT,rzone1,rzone2,rzone3,rzone4, " _
             &"areaid,groupid,salesid,cod41,cod42,cod43,cod44,cod45,cod46,cod47,cod48,cod49,custapplydat,OLDSERVICECUTDAT,AVSNO," _
             &"eusr,edat,uusr,udat,CASETYPE,DROPDAT,TRANSNOAPPLY,TRANSNODOCKET,memo,FREECODE,TNSCUSTCASE, " _
             &"MOVETOCOMQ1,MOVETOLINEQ1,MOVEFROMCOMQ1,MOVEFROMLINEQ1,MOVETODAT,MOVEFROMDAT,CANCELDAT,CANCELusr,ENDBILLINGDAT, " _
             &"contacttelzip,contacttelzip2,OVERDUE,CUSTLINEADJFLG,secondidtype,secondno,GTMONEY,GTVALID,GTSERIAL,idnumbertype, DEVELOPERID " _
             &"from RTEBTCUST WHERE COMQ1=0 "
  sqlList="SELECT COMQ1, LINEQ1, CUSID, CUSNC, SOCIALID, CUTID1, TOWNSHIP1, VILLAGE1,COD11, NEIGHBOR1, " _
             &"COD12, STREET1, COD13, SEC1, COD14, LANE1, COD15, ALLEYWAY1, COD16,NUM1,   " _
             &"COD17, FLOOR1, COD18, ROOM1,COD19, CUTID2, TOWNSHIP2, VILLAGE2, COD21,NEIGHBOR2,   " _
             &"COD22,STREET2, COD23, SEC2, COD24, LANE2, COD25, ALLEYWAY2,COD26, NUM2,   " _
             &"COD27, FLOOR2, COD28, ROOM2, COD29, CUTID3,TOWNSHIP3, VILLAGE3,COD31, NEIGHBOR3,   " _
             &"COD32, STREET3, COD33, SEC3,COD34, LANE3, COD35, ALLEYWAY3, COD36, NUM3,  " _
             &"COD37, FLOOR3,COD38, ROOM3, COD39, BIRTHDAY, CONTACT,MOBILE, EMAIL, CONTACTTEL,  " _
             &"PAYTYPE, AVSPMCODE, DIALERPMCODE, DIALERPAYTYPE, AGENTNAME,AGENTTEL, AGENTSOCIAL,CUTID4, TOWNSHIP4, VILLAGE4,    " _
             &"NEIGHBOR4,STREET4, SEC4, LANE4, ALLEYWAY4, NUM4,FLOOR4, ROOM4,RCVD, APPLYDAT,   " _
             &"APPLYTNSDAT, APPLYAGREE, PROGRESSID, FINISHDAT,DOCKETDAT, TRANSDAT, STRBILLINGDAT,rzone1,rzone2,rzone3, " _ 
             &"rzone4,areaid,groupid,salesid,cod41,cod42,cod43,cod44,cod45,cod46, " _
             &"cod47,cod48,cod49,custapplydat,OLDSERVICECUTDAT,AVSNO,eusr,edat,uusr,udat," _
             &"CASETYPE,DROPDAT,TRANSNOAPPLY,TRANSNODOCKET,memo,FREECODE,TNSCUSTCASE,MOVETOCOMQ1,MOVETOLINEQ1,MOVEFROMCOMQ1,MOVEFROMLINEQ1,MOVETODAT,MOVEFROMDAT, " _
             &"CANCELDAT,CANCELusr,ENDBILLINGDAT,contacttelzip,contacttelzip2,OVERDUE,CUSTLINEADJFLG,secondidtype,secondno,GTMONEY,GTVALID,GTSERIAL,idnumbertype, DEVELOPERID " _
             &"from RTEBTCUST WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=5
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
  'dialer��O��ק�Ѫ��[�A���ɰO���A���{���H�w�]���x�J�ɮ�
  if len(trim(dspkey(77)))=0 then dspkey(77)=""
  if len(trim(dspkey(126)))=0 then dspkey(126)=""
  if len(trim(dspkey(92)))=0 then dspkey(92)=""
  if len(trim(dspkey(127)))=0 then dspkey(127)=0
  if len(trim(dspkey(128)))=0 then dspkey(128)=0
  if len(trim(dspkey(129)))=0 then dspkey(129)=0
  if len(trim(dspkey(130)))=0 then dspkey(130)=0
  if len(trim(dspkey(142)))=0 then dspkey(142)=0
  if len(trim(dspkey(125)))=0 then dspkey(125)="N"  
  if len(trim(dspkey(136)))=0 then dspkey(136)=""
  if len(trim(dspkey(137)))=0 then dspkey(137)=""
  if len(trim(dspkey(139)))=0 then dspkey(139)=""
  if len(trim(dspkey(101)))=0 then dspkey(101)=""
  if len(trim(dspkey(102)))=0 then dspkey(102)=""
  if len(trim(dspkey(103)))=0 then dspkey(103)=""
  if len(trim(EXTDB(4)))=0 then EXTDB(4)=""
  dspkey(73)=""
  EXTDB(2)=1
  '�������ɡA���[�A�Ⱥ��������ť�
  IF DSPKEY(125)="Y" THEN
     EXTDB(3)=""
  ELSE
     EXTDB(3)="03"
  END IF
  '���������Ĥ@�X,�ΥH�P�O�O�ӤH�٬O���q,�Y�����q�h�X�ͤ�������ť�,�Ϥ��h���i�ť�
  LEADINGCHAR=LEFT(DSPKEY(4),1)
  IF LEADINGCHAR >="0" AND LEADINGCHAR <="9" THEN
     COMPANY="Y"
  ELSE
     COMPANT="N"
  END IF
  '�ˬdAVS�Τ�X���s�������Щ�(�������ư�)
  IF LEN(TRIM(DSPKEY(115))) > 0 AND LEFT(DSPKEY(115),4) = "AVS-" THEN
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx
      
	  '�ư��ثe�o����ƥ���
      sqlXX="SELECT count(*) AS CNT FROM RTEBTCust where AVSNO='" & trim(dspkey(115)) & "' and not (COMQ1=" & dspkey(0) & " and LINEQ1=" & dspkey(1) & " AND CUSID='" & DSPKEY(2) & "')"
      
      rsxx.Open sqlxx,connxx
      s=""
      'Response.Write "CNT=" & RSXX("CNT")
      If RSXX("CNT") > 0 Then
         message="AVS�Τ�X�����X�w�s�b�䥦�Ȥ��Ƥ��A���i���ƿ�J!"
         formvalid=false
      End If
      rsxx.Close
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing    
   end IF  
  '�����ҲĤ@�X�j�g
  DSPKEY(4)=UCASE(DSPKEY(4))
  IF DSPKEY(71)="" THEN
     IF DSPKEY(70)="Y" THEN 
        DSPKEY(71)="9201A3ALEP"
     ELSEIF DSPKEY(70)="H" THEN 
        DSPKEY(71)="9201A5ALEP"
     END IF  
  END IF
  'AVS+CBC���
  IF DSPKEY(120)="01" THEN
     DSPKEY(72)="9201A4ALEP"
  'AVS ONLY���
  ELSEIF  DSPKEY(120)="02" THEN
     DSPKEY(72)=""
  END IF
  'ú�O�覡:�~���~ú
  IF DSPKEY(70)="Y" THEN 
     DSPKEY(71)="9201A3ALEP"
  'ú�O�覡:�~����ú
  ELSEIF DSPKEY(70)="H" THEN 
     DSPKEY(71)="9201A5ALEP"
  'ú�O�覡:�L����ú
  ELSEIF DSPKEY(70)="M" THEN 
     DSPKEY(71)=""           
  END IF
'  IF instr(1,dspkey(67),"-",1) <> 0 THEN
'  RESPONSE.Write "AAA=" & instr(1,dspkey(67),"-",1) & "<BR>"
'  RESPONSE.Write "BBB=" & instr(1,dspkey(69),"-",1) 
'  RESPONSE.END
'  ELSE
'  RESPOSNE.WRITE "XXX"
'  RESPONSE.End
'  END IF
  IF LEN(TRIM(DSPKEY(91)))=0 THEN DSPKEY(91)=""
  If len(trim(dspkey(88)))=0 or Not Isdate(dspkey(88)) then
       formValid=False
       message="����餣�i�ťթή榡���~"    
  elseif len(trim(dspkey(113)))=0 then
       formValid=False
       message="�Τ�ӽФ餣�i�ť�"   
  elseif len(trim(dspkey(3)))=0 then
       formValid=False
       message="�Τ�W�٤��i�ť�"          
  '�������ɤ��ˬd������
  elseif ( len(trim(dspkey(4)))=0 or (len(trim(dspkey(4)))<>10 and len(trim(dspkey(4)))<>8 ) ) AND DSPKEY(125) <> "Y" then
       formValid=False
       message="�Τᨭ����(�νs)���i�ťթΪ��פ���"    
  elseif len(trim(dspkey(5)))=0 then
       formValid=False
       message="�˾��a�}(����)���i�ť�"   
  elseif len(trim(dspkey(6)))=0 and dspkey(5)<>"06" and dspkey(5)<>"15" then
       formValid=False
       message="�˾��a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(11)))=0 then
       formValid=False
       message="�˾��a�}(��/��)���i�ť�"          
  elseif len(trim(dspkey(19)))=0 then
       formValid=False
       message="�˾��a�}(��)���i�ť�"          
  elseif len(trim(dspkey(25)))=0 then
       formValid=False
       message="���y�a�}(����)���i�ť�"   
  elseif len(trim(dspkey(26)))=0 and dspkey(25)<>"06" and dspkey(25)<>"15" then
       formValid=False
       message="���y�a�}(�m��)���i�ť�"    
 '920224�����ˬd==>���Ǧa�}�T��s�b�S�����󪺲{�H
 ' elseif len(trim(dspkey(31)))=0 then
 '      formValid=False
 '      message="���y�a�}(��/��)���i�ť�"          
  elseif len(trim(dspkey(39)))=0 then
       formValid=False
       message="���y�a�}(��)���i�ť�"     
  elseif len(trim(dspkey(45)))=0 then
       formValid=False
       message="���y�a�}(����)���i�ť�"   
  elseif len(trim(dspkey(46)))=0 and dspkey(45)<>"06" and dspkey(45)<>"15" then
       formValid=False
       message="���y�a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(51)))=0 then
       formValid=False
       message="���y�a�}(��/��)���i�ť�"          
  elseif len(trim(dspkey(59)))=0 then
       formValid=False
       message="���y�a�}(��)���i�ť�"       
  elseif (len(trim(dspkey(65)))=0 or Not Isdate(dspkey(65))) AND COMPANY="N" then
       formValid=False
       message="�Τᬰ�ӤH�ɡA�X�ͤ�����i�ťթή榡���~"   
  elseif len(trim(dspkey(65)))<>0  AND COMPANY="Y" then
       formValid=False
       message="�Τᬰ�k�H�ɡA�X�ͤ�������ť�"          
  elseif len(trim(dspkey(66)))=0 then
       formValid=False
       message="�s���H���i�ť�"              
  elseif len(trim(dspkey(67)))=0 and ( len(trim(dspkey(69)))=0 or len(trim(dspkey(136)))=0 ) then
       formValid=False
       message="�s���q��(�դ�)�Φ�ʹq�ܦܤֶ���J�@��"   
  elseif instr(1,dspkey(67),"-",1) > 0 then
       formValid=False
       message="��ʹq�ܤ��i�]�t'-'�Ÿ�"          
  elseif instr(1,dspkey(69),"-",1) > 0 then
       formValid=False
       message="�s���q�ܤ��i�]�t'-'�Ÿ�"          
  elseif len(trim(dspkey(120)))= 0 then
       formValid=False
       message="��׺������i�ť�"   
  elseif dspkey(125)= "Y" AND DSPKEY(120) <> "02" then
       formValid=False
       message="�������ɡA��׺���������AVS ONLY"                   
  elseif len(trim(dspkey(70)))= 0 AND DSPKEY(125) <> "Y" then
       formValid=False
       message="AVSú�ڤ覡���i�ť�"      
  elseif len(trim(dspkey(70)))> 0 AND DSPKEY(125) = "Y" then
       formValid=False
       message="�������ɡAAVSú�ڤ覡�����ť�"           
  elseif dspkey(71)<> "9302S1ALEP" AND dspkey(71)<> "9302S3ALEP" AND dspkey(71)<> "9201A3ALEP" AND dspkey(71)<> "9201A5ALEP" AND dspkey(71)<> "" AND DSPKEY(125) <> "Y" then
       formValid=False
       message="AVS�u�f�N�X���~"       
  elseif dspkey(72)<> "9201A4ALEP" AND dspkey(72)<> "" AND DSPKEY(125) <> "Y" then
       formValid=False
       message="�y���u�f�N�X���~"              
'�]EM�w����,�G��O��פ��A����@�w�n��J(�B�e����w���`)
'  elseif len(trim(EXTDB(0)))= 0 AND DSPKEY(125) <> "Y"then
'       formValid=False
'       message="DIALER��O��פ��i�ť�"       
'  elseif len(trim(EXTDB(0)))> 0 AND DSPKEY(125) = "Y"then
'       formValid=False
'       message="�������ɡADIALER��O��ץ����ť�"              
  'elseif ( len(trim(EXTDB(1)))= 0  or len(trim(EXTDB(4)))= 0 ) AND DSPKEY(125) <> "Y" AND DSPKEY(120)="01" then
  '     formValid=False
  '     message="DIALER�q�ܸ��X���i�ť�"          
  elseif instr(1,EXTDB(1),"-",1) <> 0 AND DSPKEY(120)="01" then
       formValid=False
       message="DIALER�q�ܸ��X���i�]�t'-'�Ÿ�"
  elseif len(trim(EXTDB(1)))> 0 AND DSPKEY(125) = "Y" then
       formValid=False
       message="�������ɡADIALER�q�ܸ��X�����ť�"                  
  elseif len(trim(EXTDB(2)))= 0 then
       formValid=False
       message="���[�A��(DIALER)���ɶ������i��0"     
  elseif LEN(TRIM(DSPKEY(115))) > 0 AND LEN(TRIM(DSPKEY(115))) <> 15  and dspkey(125) <> "Y" THEN
       formValid=False
       message="�Τ�X���s�����ץ�����15�X"         
  elseif LEN(TRIM(DSPKEY(115))) > 0 AND LEN(TRIM(DSPKEY(115))) <> 3 and dspkey(125) = "Y" THEN
       formValid=False
       message="�������ɡA�Τ�X���s�����ץ�����3�X(PRF)"                  
  elseif left(dspkey(115),4) <> "AVS-" AND LEN(TRIM(DSPKEY(115))) > 0 and dspkey(125) <> "Y" THEN
       formValid=False
       message="�Τ�X���s��������'AVS-'�}�l�@15�X���W�h"         
  elseif dspkey(115) <> "PRF" AND LEN(TRIM(DSPKEY(115))) > 0 and dspkey(125) = "Y" THEN
       formValid=False
       message="�������ɡA�Τ�X���s��������'PRF'"                
  elseif len(trim(EXTDB(3)))= 0 AND DSPKEY(125) <> "Y" then
       formValid=False
       message="���[�A�Ȥ��i�ť�"             
  elseif DSPKEY(120)="01" AND DSPKEY(72) <> "9201A4ALEP" then
       formValid=False
       message="AVS+CBC��סA�y���u�f�N�X������9201A4ALEP"          
  elseif DSPKEY(120)="02" AND DSPKEY(72) <> "" then
       formValid=False
       message="AVS ONLY��סA���i��J�y���u�f�N�X9201A4ALEP"                
  elseif DSPKEY(70)="Y" AND DSPKEY(71)<> "9201A3ALEP" then
       formValid=False
       message="�~���~ú�̡AAVS�u�f�N�X������9201A3ALEP"           
  elseif DSPKEY(70)="H" AND DSPKEY(71)<> "9201A5ALEP" then
       formValid=False
       message="�~����ú�̡AAVS�u�f�N�X������9201A5ALEP"             
  elseif DSPKEY(70)="M" AND DSPKEY(71)<> "" then
       formValid=False
       message="�L����ú�̡AAVS�u�f�N�X�������ť�"                                           
  elseif len(trim(EXTDB(3)))> 0 AND DSPKEY(125) = "Y" then
       formValid=False
       message="�������ɡA���[�A�ȥ����ť�"                            
'  elseif len(trim(dspkey(73)))= 0 then
'       formValid=False
'       message="Dialer�p�O�覡���i�ť�"      
  elseif len(trim(dspkey(94)))<> 0 AND len(trim(dspkey(93)))= 0 then
       formValid=False
       message="���u������ťծɤ��i��J������"       
  end if
  IF formValid=TRUE THEN
    IF dspkey(4) <> "" and (dspkey(145)="01" or dspkey(145)="02") then
       idno=dspkey(4)
        if UCASE(left(idno,1)) >="A" AND UCASE(left(idno,1)) <="Z" THEN
          AAA=CheckID(idno)
          SELECT CASE AAA
             CASE "True"
             case "False"
                   message="�ӽХΤᨭ���Ҧr�����X�k"
                   formvalid=false 
             case "ERR-1"
                   message="�ӽХΤᨭ���Ҹ����i�d�ťթο�J��ƿ��~"
                   formvalid=false       
             case "ERR-2"
                   message="�ӽХΤᨭ���Ҧr�����Ĥ@�X���ݬO�X�k���^��r��"
                   formvalid=false    
             case "ERR-3"
                   message="�ӽХΤᨭ���Ҧr�����ĤG�X���ݬO�Ʀr 1 �� 2"
                   formvalid=false   
             case "ERR-4"
                   message="�ӽХΤᨭ���Ҧr������E�X���ݬO�Ʀr"
                   formvalid=false              
             case else
          end select  
       ELSE
          AAA=ValidBID(idno)
          if aaa = false then
              message="�ӽХΤ�Τ@�s�����X�k"
              formvalid=false   
          end if
       END IF
    END IF
  END IF
  IF formValid=TRUE THEN
   if len(trim(dspkey(74)))<> 0 AND DSPKEY(125)<> "Y" then
         if len(trim(dspkey(76)))= 0 then
            formValid=False
            message="�N�z�H�����Ҹ����i�ť�" 
         elseif len(trim(dspkey(75)))= 0 and len(trim(dspkey(137)))= 0  then    
            formValid=False
            message="�N�z�H�q�ܤ��i�ť�"    
         elseif instr(1,dspkey(75),"-",1) <> 0 then
            formValid=False
            message="�N�z�H�q�ܤ��i�]�t'-'�Ÿ�"                    
         elseif len(trim(dspkey(5)))=0 then
            formValid=False
            message="�N�z�H�a�}(����)���i�ť�"   
         elseif len(trim(dspkey(6)))=0 and dspkey(5)<>"06" and dspkey(5)<>"15" then
            formValid=False
            message="�N�z�H�a�}(�m��)���i�ť�"    
         elseif len(trim(dspkey(11)))=0 then
            formValid=False
            message="�N�z�H�a�}(��/��)���i�ť�"          
         elseif len(trim(dspkey(19)))=0 then
            formValid=False
            message="�N�z�H�a�}(��)���i�ť�"          
         end if
      END IF
  END IF
  '�ˬd�D�u�}�o�����P�θg�P==��g�P��,�h�Z���k�ݳ������ť�,�Ϥ��h������J
  IF formValid=TRUE THEN
   Set connxx=Server.CreateObject("ADODB.Connection")
   Set rsxx=Server.CreateObject("ADODB.Recordset")
   connxx.open DSN
   sqlxx="select * from rtebtcmtyline where comq1=" & aryparmkey(0) & " AND LINEQ1=" & ARYPARMKEY(1)
   rsxx.Open sqlxx,connxx
   if not rsxx.eof then
     IF ISNULL(RSXX("LOCKDAT")) THEN
      '�D�u�����q�̡A���i��Javs�ӽФ�
      if isnull(rsxx("adslapplydat")) and len(trim(dspkey(89))) <> 0 then
            formValid=False
            message="�D�u�����q�A���i��J�Τ�ӽФ�" 
      end if
     ELSE
        formValid=False
        message="�D�u�w�Q��w�A���i�s�W�β��ʥΤ���" 
     END IF
     IF NOT ISNULL(RSXX("DROPDAT")) OR NOT ISNULL(RSXX("CANCELDAT")) THEN
        formValid=False
        message="�D�u�w�@�o�κM�P�A���i�s�W�β��ʥΤ���" 
     END IF
   end if
   rsxx.close
   connxx.Close   
   set rsxx=Nothing   
   set connxx=Nothing 
 END IF
 IF formValid=TRUE AND LEN(TRIM(DSPKEY(89))) > 0 THEN
    Set connxx=Server.CreateObject("ADODB.Connection")
    Set rsxx=Server.CreateObject("ADODB.Recordset")
    connxx.open DSN
    sqlxx="select * from rtebtcmtyline where comq1=" & aryparmkey(0) & " AND LINEQ1=" & ARYPARMKEY(1)
    rsxx.Open sqlxx,connxx
    IF RSXX.EOF THEN
       formValid=False
       message="�䤣�즹�Τ᪺�D�u��ơA�L�k�����q�ˮ�!" 
    ELSE
       IF ISNULL(RSXX("EBTAPPLYOKRTN")) THEN
          formValid=False
          message="�D�u���q���EBT�|���T�{�A�G�L�k�ӽХΤ�!" 
       END IF 
    END IF
 END IF
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(118)=V(0)
        dspkey(119)=datevalue(now())
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
   Sub SrChangetelzip()
       ctyid=document.all("KEY5").VALUE
       if ctyid="" then
          document.all("key136").value=""
       else
          if ctyid="01" or ctyid="03" or ctyid="04" then
              document.all("key136").value="02"
              document.all("key137").value="02"
              document.all("ext4").value="02"
          elseif ctyid="02" or ctyid="05" or ctyid="06" or ctyid="07"or ctyid="21" then
              document.all("key136").value="03"
              document.all("key137").value="03"
              document.all("ext4").value="03"
          elseif ctyid="08"  then
              document.all("key136").value="037"
              document.all("key137").value="037"
              document.all("ext4").value="037"
          elseif ctyid="09" or ctyid="10" or ctyid="12" then
              document.all("key136").value="04"    
              document.all("key137").value="04"
              document.all("ext4").value="04"
          elseif ctyid="11" then
              document.all("key136").value="049"       
              document.all("key137").value="049"
              document.all("ext4").value="049"
          elseif ctyid="13" or ctyid="14" or ctyid="15" then
              document.all("key136").value="05"    
              document.all("key137").value="05"
              document.all("ext4").value="05"
          elseif ctyid="16" or ctyid="17" or ctyid="23" then
              document.all("key136").value="06"    
              document.all("key137").value="06"
              document.all("ext4").value="06"
          elseif ctyid="18" or ctyid="19" then
              document.all("key136").value="07" 
              document.all("key137").value="07"
              document.all("ext4").value="07"
          elseif ctyid="20" then
              document.all("key136").value="08"         
              document.all("key137").value="08"
              document.all("ext4").value="08"
          elseif ctyid="22" then
              document.all("key136").value="089"      
              document.all("key137").value="089"
              document.all("ext4").value="089"
          elseif ctyid="24" then
              document.all("key136").value="0823"     
              document.all("key137").value="0823"
              document.all("ext4").value="0823"
          elseif ctyid="25" then
              document.all("key136").value="0836"   
              document.all("key137").value="0836"
              document.all("ext4").value="0836"
          else
              document.all("key136").value=""       
              document.all("key137").value=""
              document.all("ext4").value=""
          end if                                  
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
   Sub Srcounty6onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY5").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key6").value =  trim(Fusrid(0))
          document.all("key97").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub       
   Sub Srcounty26onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY25").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key26").value =  trim(Fusrid(0))
          document.all("key98").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub Srcounty46onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY45").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key46").value =  trim(Fusrid(0))
          document.all("key99").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB    
   Sub Srcounty78onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY77").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key78").value =  trim(Fusrid(0))
          document.all("key100").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY146").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key146").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub
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
   Sub SrTAG4()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB4.style.display="" then
          window.SRTAB4.style.display="none"
       elseif window.SRTAB4.style.display="none" then
          window.SRTAB4.style.display=""
       end if
   End Sub       
   Sub SrTAG5()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB5.style.display="" then
          window.SRTAB5.style.display="none"
       elseif window.SRTAB5.style.display="none" then
          window.SRTAB5.style.display=""
       end if
   End Sub                   
   Sub SrTAG6()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB6.style.display="" then
          window.SRTAB6.style.display="none"
       elseif window.SRTAB6.style.display="none" then
          window.SRTAB6.style.display=""
       end if
   End Sub                  
   Sub SrTAG7()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB7.style.display="" then
          window.SRTAB7.style.display="none"
       elseif window.SRTAB7.style.display="none" then
          window.SRTAB7.style.display=""
       end if
   End Sub                  
Sub SrAddrEqual1()
  Dim i,j
  i=25
  j=5
  do while i < 45
     keyx="key" & i
     keyy="key" & j
     document.All(keyx).value=document.All(keyy).value
     i=i+1
     j=j+1
  loop
   document.All("key98").value=document.All("key97").value
End Sub 
Sub SrAddrEqual2()
  Dim i,j
  i=45
  j=5
  do while i < 65
     keyx="key" & i
     keyy="key" & j
     document.All(keyx).value=document.All(keyy).value
     i=i+1
     j=j+1
  loop
   document.All("key99").value=document.All("key97").value
End Sub         
Sub SrAddrEqual3()
  Dim i,j
  i=45
  j=25
  do while i < 65
     keyx="key" & i
     keyy="key" & j
     document.All(keyx).value=document.All(keyy).value
     i=i+1
     j=j+1
  loop
   document.All("key99").value=document.All("key98").value
End Sub         
Sub SrAddrEqual4()
   document.All("key66").value=document.All("key3").value
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
           <td width="25%" class=dataListHead>�Τ�Ǹ�</td>
           <td width="25%"  bgcolor="silver">
           <input type="text" name="key2"
                 <%=fieldRole(1)%> readonly size="15" value="<%=dspKey(2)%>" maxlength="15" class=dataListdata></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(116))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(116)=V(0)
        End if  
       dspkey(117)=now()
    else
        if len(trim(dspkey(118))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(118)=V(0)
        End if         
        dspkey(119)=now()
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '�Τ�ӽ����ɫ�,��� protect
    If len(trim(dspKey(90))) > 0 Then
       fieldPe=" class=""dataListData"" readonly "
        fieldpf=" disabled "
    Else
       fieldPe=""
        fieldpf=""
    End If    
    If len(trim(dspKey(94))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
    Else
       fieldPa=""
       fieldpb=""
    End If
        If len(trim(dspKey(95))) > 0 Then
       fieldPC=" class=""dataListData"" readonly "
       fieldpD=" disabled "
    Else
       fieldPC=""
       fieldpD=""
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
  <span id="tags1" class="dataListTagsOn">AVS�Τ��T</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td>
<td>     
    <DIV ID="SRTAG0" onclick="srtag0" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�򥻸��</td></tr></table></div>
 <DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr><td width="15%" class=dataListHEAD>�����</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key88" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(88)%>"  READONLY size="10" class=dataListEntry>
       <input  type="button" id="B88"  <%=fieldpb%> name="B88" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C88"  name="C88"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>
<td width="15%" class=dataListHEAD>�Τ�ӽФ�</td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key113" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(113)%>"  READONLY size="10" class=dataListEntry>
       <input  type="button" id="B113"  <%=fieldpb%> name="B113" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C113"  name="C113"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>      
</tr>
<tr><td width="15%" class=dataListHEAD>�Τ�(���q)�W��</td>
    <td  width="35%"  bgcolor="silver" >
        <input type="text" name="key3" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(3)%>"  size="30" class=dataListENTRY ID="Text22"></td>
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='J5' " 
       If len(trim(dspkey(145))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='J5' AND CODE='" & dspkey(145) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�Ĥ@�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(145) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
              
<td width="15%" class=dataListHEAD>������(�νs)</td>
    <td width="35%" bgcolor="silver" >
	<select size="1" name="key145"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>    
        <input type="password" name="key4" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(4)%>"   size="12" class=dataListENTRY ID="Text23"></td>               
</tr>
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L3' " 
       If len(trim(dspkey(140))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L3' AND CODE='" & dspkey(140) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�ĤG�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(140) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
    <tr>
        <td width="10%" class="dataListHead" height="25">�ĤG�ҷӧO�θ��X</td>
        <td width="18%" height="25" bgcolor="silver" colspan=3> 
		<select size="1" name="key140"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select16"><%=s%></select>	
        <input type="password" name="key141" size="15" maxlength="12" value="<%=dspkey(141)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text49"></td> 
     </tr>    
<tr><td class=dataListHEAD>ADSL�˾��a�}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(89))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(5))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX6=" onclick=""Srcounty6onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(5) & "' " 
       SXX6=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(5) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2" onchange="Srchangetelzip"><%=s%></select>
        <input type="text" name="key6" readonly  size="8" value="<%=dspkey(6)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B6" <%=fieldpb%> name="B6"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX6%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C6"  name="C6"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key7" <%=fieldpa%> size="10" value="<%=dspkey(7)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(8)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(8) &""">" &dspKey(8) &"</option>"
   End If%>                                  
       <select size="1" name="key8" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                            
        <%=s%></select>      
        <input type="text" name="key9"  size="6" value="<%=dspkey(9)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key10" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                            
        <%=s%></select>              
        <input type="text" name="key11" size="10" value="<%=dspkey(11)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key12" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text" name="key13"  size="6" value="<%=dspkey(13)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(14)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(14) &""">" &dspKey(14) &"</option>"
   End If%>                                  
       <select size="1" name="key14" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>
        <input type="text" name="key15" size="6" value="<%=dspkey(15)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text30"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(16)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(16) &""">" &dspKey(16) &"</option>"
   End If%>                                  
       <select size="1" name="key16" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select9">                                            
        <%=s%></select>     
                <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="text" name="key97"  readonly size="8" value="<%=dspkey(97)%>" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text12">
         (�l���ϸ�)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="key17" size="10" value="<%=dspkey(17)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(18)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(18) &""">" &dspKey(18) &"</option>"
   End If%>                                  
       <select size="1" name="key18" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>    
        <input type="text" name="key19" size="6" value="<%=dspkey(19)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(20)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(20) &""">" &dspKey(20) &"</option>"
   End If%>                                  
       <select size="1" name="key20" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>            
        <input type="text" name="key21" size="10" value="<%=dspkey(21)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(22)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(22) &""">" &dspKey(22) &"</option>"
   End If%>                                  
       <select size="1" name="key22" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>
        <input type="text" name="key23" size="6" value="<%=dspkey(23)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(24)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(24) &""">" &dspKey(24) &"</option>"
   End If%>                                  
       <select size="1" name="key24" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>       
        </td>                                 
</tr>  
<tr><td class=dataListHEAD>���y�a�}
    <br><input type="radio" name="rd1"  <%=fieldpb%> onClick="SrAddrEqual1()">�P�˾�</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(89))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(25))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX26=" onclick=""Srcounty26onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(25) & "' " 
       SXX26=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(25) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key25" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key26" readonly  size="8" value="<%=dspkey(26)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B26"  <%=fieldpb%>  name="B26"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX26%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%>  alt="�M��" id="C26"  name="C26"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key27" <%=fieldpa%> size="10" value="<%=dspkey(27)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(28)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(28) &""">" &dspKey(28) &"</option>"
   End If%>                                  
       <select size="1" name="key28" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                            
        <%=s%></select>      
        <input type="text" name="key29"  size="6" value="<%=dspkey(29)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(30)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(30) &""">" &dspKey(30) &"</option>"
   End If%>                                  
       <select size="1" name="key30" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                            
        <%=s%></select>              
        <input type="text" name="key31" size="10" value="<%=dspkey(31)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(32)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(32) &""">" &dspKey(32) &"</option>"
   End If%>                                  
       <select size="1" name="key32" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text" name="key33"  size="6" value="<%=dspkey(33)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(34)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(34) &""">" &dspKey(34) &"</option>"
   End If%>                                  
       <select size="1" name="key34" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>
        <input type="text" name="key35" size="6" value="<%=dspkey(35)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text30"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key36" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select9">                                            
        <%=s%></select>        
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="text" name="key98"  readonly size="8" value="<%=dspkey(98)%>" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text13">
		(�l���ϸ�)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="key37" size="10" value="<%=dspkey(37)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key38" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>    
        <input type="text" name="key39" size="6" value="<%=dspkey(39)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key40" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>            
        <input type="text" name="key41" size="10" value="<%=dspkey(41)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key42" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>
        <input type="text" name="key43" size="6" value="<%=dspkey(43)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key44" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>       
        </td>                                 
</tr>  
<tr><td class=dataListHEAD>�b��a�}
    <br><input type="radio" name="rd2" <%=fieldpb%>  onClick="SrAddrEqual2()"><font SIZE=2>�P�˾�</font><input type="radio"  <%=fieldpb%> name="rd2" onClick="SrAddrEqual3()"><font SIZE=2>�P���y</font>
    </td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(89))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(45))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX46=" onclick=""Srcounty46onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(45) & "' " 
       SXX46=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(45) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key45" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key46" readonly  size="8" value="<%=dspkey(46)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B46"   <%=fieldpb%> name="B46"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX46%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C46"  name="C46"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key47" <%=fieldpa%> size="10" value="<%=dspkey(47)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key48" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                            
        <%=s%></select>      
        <input type="text" name="key49"  size="6" value="<%=dspkey(49)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key50" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                            
        <%=s%></select>              
        <input type="text" name="key51" size="10" value="<%=dspkey(51)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
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
       <select size="1" name="key52" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text" name="key53"  size="6" value="<%=dspkey(53)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(54)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(54) &""">" &dspKey(54) &"</option>"
   End If%>                                  
       <select size="1" name="key54" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>
        <input type="text" name="key55" size="6" value="<%=dspkey(55)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text30"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(56)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(56) &""">" &dspKey(56) &"</option>"
   End If%>                                  
       <select size="1" name="key56" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select9">                                            
        <%=s%></select>        
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="text" name="key99"  readonly size="8" value="<%=dspkey(99)%>" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text14">
		(�l���ϸ�)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="key57" size="10" value="<%=dspkey(57)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(58)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(58) &""">" &dspKey(58) &"</option>"
   End If%>                                  
       <select size="1" name="key58" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>    
        <input type="text" name="key59" size="6" value="<%=dspkey(59)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(60)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(60) &""">" &dspKey(60) &"</option>"
   End If%>                                  
       <select size="1" name="key60" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>            
        <input type="text" name="key61" size="10" value="<%=dspkey(61)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(62)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(62) &""">" &dspKey(62) &"</option>"
   End If%>                                  
       <select size="1" name="key62" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>
        <input type="text" name="key63" size="6" value="<%=dspkey(63)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(64)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(64) &""">" &dspKey(64) &"</option>"
   End If%>                                  
       <select size="1" name="key64" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>       
        </td>                                 
</tr>
<tr>                                 
        <td  class="dataListHEAD" height="23">�X�ͤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key65" size="10"  value="<%=dspKey(65)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListentry" ID="Text8">  
        <input type="button" id="B65"  <%=fieldpb%>  name="B65" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C65"  name="C65"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> </td>           
        <td  class="dataListHEAD" height="23">�s���H</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key66" size="12" maxlength="12" value="<%=dspKey(66)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text7">
        <input type="radio" name="rd4"  <%=fieldpb%> onClick="SrAddrEqual4()"><font SIZE=2>�P�ӽФH</font></td>                                 
 
 </tr>        
<TR>        
        <td  class="dataListHEAD" height="23">��ʹq��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key67" size="15" maxlength="15" value="<%=dspKey(67)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
        <td  class="dataListHEAD" height="23">�s���q��(�դ�)</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key136" size="4" maxlength="4" value="<%=dspKey(136)%>" <%=fieldRole(1)%>  class="dataListentry" ID="Text45">
        <input type="text" name="key69" size="15" maxlength="15" value="<%=dspKey(69)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text16"></td>                                 
 </tr>
<TR>        
        <td  class="dataListHEAD" height="23">�s��EMAIL</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key68" size="30" maxlength="30" value="<%=dspKey(68)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
        <td  class="dataListSEARCH" height="23">�X���s��</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key115" size="17" maxlength="15" value="<%=dspKey(115)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text11"></td>                                 
 </tr> 
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(116) <> "" then
              sql=" select rtobj.cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(116) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key116" size="6" READONLY value="<%=dspKey(116)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key117" size="25" READONLY value="<%=dspKey(117)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(118) <> "" then
              sql=" select rtobj.cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(118) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key118" size="6" READONLY value="<%=dspKey(118)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key119" size="25" READONLY value="<%=dspKey(119)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>         
</table> </div>
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->
    <DIV ID="SRTAG1" onclick="srtag1" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�Z���k��</td></tr></table></div>
    
     <DIV ID=SRTAB1>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">
	<tr><td WIDTH="15%" class="dataListHEAD" height="23">�G�u�}�o�H��</td>
		<td WIDTH="35%"><input type="text" name="key146"value="<%=dspKey(146)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text50">
			<input type="BUTTON" id="B146" name="B146" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  alt="�M��" id="C146" name="C146" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
		    <font size=2><%=SrGetEmployeeName(dspKey(146))%></font>
		</td>
        <td width="15%" class="dataListHead">�O�Ҫ�</td>                    
        <td bgcolor="silver">
          <input type="text" name="key142" size="10" value="<%=dspKey(142)%>" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" ID="Text53">
        </td>
	</tr>

	<tr><td width="15%" class="dataListHead">�O�Ҫ��~��</td>                    
	<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L6' " 
       If len(trim(dspkey(143))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L6' AND CODE='" & dspkey(143) &"' " 
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(143) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
        <td bgcolor="silver">
			<select name="key143" <%=fieldRole(1)%><%=dataProtect%><%=fieldPg%> size="1"
                  maxlength="8" class="dataListEntry"><%=s%></select>
		</td>
        <td width="15%" class="dataListHead">�O�Ҫ��Ǹ�</td>
        <td bgcolor="silver">
          <input type="text" name="key144" size="15" value="<%=dspKey(144)%>" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>
	  </tr>      
  </table>     
  </DIV> 
  </DIV>   
      <DIV ID="SRTAG2" onclick="srtag2" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
    <tr><td bgcolor="BDB76B" align="LEFT">�P�P�N�X</td></tr></table></DIV>
    <DIV ID=SRTAB2 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
     <tr>   <td  WIDTH="15%"  class="dataListHEAD" height="23">������O</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver" >
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(89))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H5' " 
       If len(trim(dspkey(120))) < 1 Then
          sx=" selected " 
       end if     
       s=s & "<option value=""""" & sx & "></option>"  
       sx=""
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H5' AND CODE='" & dspkey(120) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If (rs("CODE")=dspkey(120)) or (len(trim(dspkey(120))) < 1 and rs("code")="03" )  Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key120" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select8">                                                                  
        <%=s%>
   </select>
        </td>
        <td  WIDTH="15%" class="dataLISTSEARCH" height="23">������</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver" >
<%  dim FREECODE1,FREECODE2
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       FREECODE1=""
       FREECODE2=""
    Else
      ' sexd1=" disabled "
      ' sexd2=" disabled "
    End If
    If dspKey(125)="Y" Then FREECODE1=" checked "    
    If dspKey(125)="N" Then FREECODE2=" checked " %>                          
        <input type="radio" value="Y" <%=FREECODE1%> name="key125" <%=fieldRole(1)%><%=dataProtect%> ID="Radio1">�O
        <input type="radio" name="key125" value="N" <%=FREECODE2%><%=fieldRole(1)%><%=dataProtect%> ID="Radio2">�_</td>
        </tr>
<tr>   <td  WIDTH="15%" class="dataListHEAD" height="23">AVS�u�f�N�X</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver" >
        <%
        IF DSPKEY(70)="Y" THEN 
           DSPKEY(71)="9201A3ALEP"
        ELSEIF DSPKEY(70)="H" THEN 
           DSPKEY(71)="9201A5ALEP"
        ELSEIF DSPKEY(70)="M" THEN 
           DSPKEY(71)=""           
        END IF
        %>
        <input type="text" name="key71" size="15" maxlength="10" value="<%=dspKey(71)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListdata" ID="Text15"></td>                                 
        </td>

        <td   WIDTH="15%" class="dataListHEAD" height="23">�y���u�f�N�X</td>                                 
        <td    WIDTH="35%" height="23" bgcolor="silver">
        <%
        'AVS+CBC���y���u�f200��(�YPROMOTION CODE=9201A4ALEP)
        IF DSPKEY(120)="01" THEN
           dspkey(72)="9201A4ALEP"
        'AVS ONLY�ɵL�y���u�f200��(�YPROMOTION CODE="")
        ELSEIF DSPKEY(120)="02" THEN
           dspkey(72)=""
        END IF
        %>
        <input type="text" name="key72" size="15" maxlength="10" value="<%=dspKey(72)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListdata" ID="Text21"></td>                                 
</td>                                 
                              
 </tr>        
 <tr>   <td  WIDTH="15%"  class="dataListHEAD" height="23">AVSú�ڤ覡</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver" >
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(89))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G6' and parm1 ='Y'" 
       If len(trim(dspkey(70))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G6' AND CODE='" & dspkey(70) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(70) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key70" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
        <%=s%>
   </select>
        </td>
        <td   width=15% class="dataListHEAD" height="23">�q�ܸ��X</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <%
        '��{���� "�ק��" �A�����\�ק�DIALER�q�ܸ��X==>�]��DIALER�q�ܬ�KEY��
        'RESPONSE.Write "SW=" & SW & ";ACCESSMODE=" & ACCESSMODE
    '    IF sw="E" THEN
    '       FIELDPX=" CLASS=""DATALISTDATA"" READONLY "
    '    ELSE
    '       FIELDPX=""
    '    END IF
    '    IF ACCESSMODE="U" THEN
    '       FIELDPY=" CLASS=""DATALISTDATA"" READONLY "
    '    ELSE
    '       FIELDPY=""
    '    END IF        
        %>
        <input type="text" name="ext4" size="4" maxlength="4" value="<%=extDB(4)%>"  <%=fieldpX%><%=fieldpY%><%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text47">
        <input type="text" name="ext1" size="15" maxlength="15" value="<%=extDB(1)%>"  <%=fieldpX%><%=fieldpY%><%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text3">
        <input STYLE="DISPLAY:NONE" type="text" name="ext2" size="10" maxlength="15" value="<%=extDB(2)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text10">
        <input STYLE="DISPLAY:NONE" type="text" name="ext3" size="2" maxlength="2" value="<%=extDB(3)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text25"></td>                                 
                  
        
        <td   STYLE="DISPLAY:NONE" WIDTH="15%" class="dataListHEAD" height="23">DIALER��O���</td>                                 
        <td  STYLE="DISPLAY:NONE" WIDTH="35%" height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(dspKey(89))) = 0 AND len(trim(DSPKEY(89))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G7' " 
       If len(trim(extDB(0))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G7' AND CODE='" & extDB(0) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=extDB(0) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="ext0" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select7">                                                                  
        <%=s%>
   </select></td>
   </tr>                       
 <tr>   <td  WIDTH="15%"  class="dataListSEARCH" height="23">�䥦��ײ�����O</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver">
<%  '920626--���䥦��ײ�����O�����I,��AVS�Τ�ӽФ�(DSPKEY89)�אּ������(DSPKEY94)(�D�]�b����쬰������T�PEBT�L��),�����j���C
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(94))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H8' " 
       If len(trim(dspkey(126))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H8' AND CODE='" & dspkey(126) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(126) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key126" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select14">                                                                  
        <%=s%>
   </select>
        </td>
       <td  WIDTH="15%" class="dataListHEAD" height="23">��A�Ȩ����</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver" >
         <input type="text" name="key114" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(114)%>"   readonly class="dataListEntry" ID="Text1">        
        <input type="button" id="B114"  name="B114" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C114"  name="C114"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> </td>           
         </td> </tr>
           
  </table>     
  </DIV>
      <DIV ID="SRTAG5" onclick="srtag5" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
    <tr><td bgcolor="BDB76B" align="LEFT">�N�z�H��T</td></tr></table></DIV>
    <DIV ID=SRTAB5 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3"> 
<TR>        
        <td   width=15% class="dataListHEAD" height="23">�N�z�H�m�W</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <input type="text" name="key74" size="10" maxlength="15" value="<%=dspKey(74)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
        <td   width=15% class="dataListHEAD" height="23">�N�z�H�����Ҹ�</td>                                 
        <td  width=35% height="23" bgcolor="silver" >
        <input type="password" name="key76" size="10" maxlength="10" value="<%=dspKey(76)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text16"></td>                                 
 </tr>
<TR>        
        <td  class="dataListHEAD" height="23">�N�z�H�q��</td>                                 
        <td  height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key137" size="4" maxlength="4" value="<%=dspKey(137)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text46">
        <input type="text" name="key75" size="15" maxlength="15" value="<%=dspKey(75)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
 </tr>     
<tr><td class=dataListHEAD>�N�z�H�a�}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(89))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(77))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX78=" onclick=""Srcounty78onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(77) & "' " 
       SXX78=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(77) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key77" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key78" readonly  size="8" value="<%=dspkey(78)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B78"  <%=fieldpb%>  name="B78"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX78%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C78"  name="C78"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key79" <%=fieldpa%> size="10" value="<%=dspkey(79)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(104)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(104) &""">" &dspKey(104) &"</option>"
   End If%>                                  
       <select size="1" name="key104" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                            
        <%=s%></select>      
        <input type="text" name="key80"  size="6" value="<%=dspkey(80)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(105)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(105) &""">" &dspKey(105) &"</option>"
   End If%>                                  
       <select size="1" name="key105" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                            
        <%=s%></select>              
        <input type="text" name="key81" size="10" value="<%=dspkey(81)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(106)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(106) &""">" &dspKey(106) &"</option>"
   End If%>                                  
       <select size="1" name="key106" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text" name="key82"  size="6" value="<%=dspkey(82)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(107)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(107) &""">" &dspKey(54) &"</option>"
   End If%>                                  
       <select size="1" name="key107" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>

        <input type="text" name="key83" size="6" value="<%=dspkey(83)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text35">
        <font size=2>
        <% 
        aryOption=Array("��")
		s=""
		If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
	      For i = 0 To Ubound(aryOption)
			If dspKey(108)=aryOption(i) Then
				 sx=" selected "
			Else
				 sx=""
			End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
		  Next
		Else
		  s="<option value=""" &dspKey(108) &""">" &dspKey(108) &"</option>"
		End If
		%>                                  
       <select size="1" name="key108" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select1">                                            
        <%=s%></select>

        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="key100"  readonly size="8" value="<%=dspkey(100)%>"  <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA">(�l���ϸ�)
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
        
	      <input type="text" name="key84" size="10" value="<%=dspkey(84)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(109)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(109) &""">" &dspKey(109) &"</option>"
   End If%>                                  
       <select size="1" name="key109" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>    
        <input type="text" name="key85" size="6" value="<%=dspkey(85)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(110)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(110) &""">" &dspKey(110) &"</option>"
   End If%>                                  
       <select size="1" name="key110" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>            
        <input type="text" name="key86" size="10" value="<%=dspkey(86)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(111)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(111) &""">" &dspKey(111) &"</option>"
   End If%>                                  
       <select size="1" name="key111" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>
        <input type="text" name="key87" size="6" value="<%=dspkey(87)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(89))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(112)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(112) &""">" &dspKey(112) &"</option>"
   End If%>                                  
       <select size="1" name="key112" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>       
        </td>                                 
</tr></TABLE>    
    </div> 
   <DIV ID="SRTAG4" onclick="srtag4" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="LEFT">�Τ�ӽФάI�u�i�ת��A</td></tr></table></DIV>
    <DIV ID=SRTAB4 >  
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr>
        <td  width=15% class="dataListHEAD" height="23">AVS�}�q�ӽФ�</td>                                 
        <td  width=35% height="23" bgcolor="silver">
        <input type="text" name="key89" size="10" value="<%=dspKey(89)%>"  <%=fieldpe%><%=fieldRole(1)%> readonly class="dataListentry" ID="Text51">     
       <input type="button" id="B89"  name="B89" height="100%" width="100%" style="Z-INDEX: 1" <%=fieldpf%> value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C89"  name="C89"  <%=fieldpf%>  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
        <td   width=15% class="dataListHEAD" height="23">AVS�ӽ����ɤ�</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <input type="text" name="key90" size="23" value="<%=dspKey(90)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text52">
</td>        
     </tr>             
        <tr>
        <td   class="dataListHEAD" height="23">���ɥӽЧ帹��</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key122" size="15" value="<%=dspKey(122)%>"  <%=fieldRole(1)%> class="dataListdata" ID="Text55"></td>     
         <td   class="dataListHEAD" height="23">EBT�ӽмf�ֽX</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key91" size="10" value="<%=dspKey(91)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListdata" ID="Text26">     
        </td></TR>
        <tr>
        <td   class="dataListHEAD" height="23">�h����</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key121" size="23" value="<%=dspKey(121)%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text24">
        <font size=2>��O�J</font> 
        <input type="text" name="key138" size="2" READONLY value="<%=dspKey(138)%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text48">  
        <% M2M3=""
           IF DSPKEY(138)="Y" THEN
              IF LEN(TRIM(DSPKEY(121))) > 0 THEN
                 M2M3="==>M3�j��"
              ELSE
                 M2M3="==>M2��O���"
              END IF
           END IF
        %>
        <font size=2><%=M2M3%></font>    
        </td>
        <td   class="dataListHEAD" height="23">�I�u�i��</td>                                 
        <td  height="23" bgcolor="silver">
        <% name=""
           if dspkey(92) <> "" then
              sqlxx=" select * from RTCODE where KIND='H3' and CODE='" & dspkey(92) & "' "
              rs.Open sqlxx,conn
              if rs.eof then
                 name=""
              else
                 name=rs("codenc")
              end if
              rs.close
           end if
        %>                   
        <input type="text" name="key92" size="10" value="<%=dspKey(92)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListdata" ID="Text56"><font size=2><%=name%></font>
      </tr>     
        <tr>
        <td   class="dataListHEAD" height="23">���u���</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key93" size="23" READONLY value="<%=dspKey(93)%>"  <%=fieldRole(1)%> class="dataListdata" ID="Text57">
          <!--
                <input type="button" id="B93"  name="B93" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C93"  name="C93"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
        -->
        </td>
        <td   class="dataListHEAD" height="23">�������</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key94" size="10" READONLY value="<%=dspKey(94)%>" <%=fieldpC%> <%=fieldRole(1)%> class="dataListentry" ID="Text56">
                <input type="button" id="B94"  name="B94" height="100%" width="100%" <%=fieldpD%>style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C94"  name="C94"   <%=fieldpD%>style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
        
</tr> 
        <tr>
        <td   class="dataListHEAD" height="23">�������ɤ�</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key95" size="23" value="<%=dspKey(95)%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text57">     
        </td>
        <td   class="dataListHEAD" height="23">EBT�X���ͮĤ�</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key96" size="23" value="<%=dspKey(96)%>"  <%=fieldRole(1)%> class="dataListdata" ID="Text56"></td>
</tr>        
</tr> 
        <tr>
        <td   class="dataListHEAD" height="23">���ɳ����帹��</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key123" size="15" value="<%=dspKey(123)%>"  <%=fieldRole(1)%> class="dataListdata" ID="Text28"></td>        
        <td   class="dataListHEAD" height="23">EBT�X���פ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key135" size="23" value="<%=dspKey(135)%>"  <%=fieldRole(1)%> class="dataListdata" ID="Text44"></td>

</tr>           
       <tr>
        <td  width=15% class="dataListHEAD" height="23">�@�o���</td>                                 
        <td  width=35% height="23" bgcolor="silver">
        <input type="text" name="key133" size="10" value="<%=dspKey(133)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListdata" ID="Text41">
         </td>
        <%  name="" 
           if dspkey(134) <> "" then
              sql=" select rtobj.cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(134) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>         
        <td   width=15% class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <input type="text" name="key134" size="10" value="<%=dspKey(134)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text43"><font size=2><%=name%></font>
        </td></tr>           

  </table> 
  </DIV>
   <DIV ID="SRTAG7" onclick="SRTAG7" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
    <tr><td bgcolor="BDB76B" align="LEFT">���ʪ��A</td></tr></table></DIV>
    <DIV ID="SRTAB7" >  
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table5">
       <tr>
        <td  width=15% class="dataListHEAD" height="23">���X���ϥD�u�Ǹ�</td>                                 
        <td  width=35% height="23" bgcolor="silver">
        <% comn=""
           if dspkey(127) <> 0 then
              sqlxx=" select * from RTebtcmtyh where comq1=" & dspkey(127) 
              rs.Open sqlxx,conn
              if rs.eof then
                 comn=""
              else
                 comn=rs("comn")
              end if
              rs.close
           end if
        %>                   
        <input type="text" name="key127" size="5" value="<%=dspKey(127)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListentry" ID="Text36">
        <input type="text" name="key128" size="5" value="<%=dspKey(128)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListentry" ID="Text38">
        <font size=2><%=comn%></font></td>
        <td   width=15% class="dataListHEAD" height="23">���J���ϥD�u�Ǹ�</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <% comn=""
           if dspkey(129) <> 0 then
              sqlxx=" select * from RTebtcmtyh where comq1=" & dspkey(129) 
              rs.Open sqlxx,conn
              if rs.eof then
                 comn=""
              else
                 comn=rs("comn")
              end if
              rs.close
           end if
        %>                   
        <input type="text" name="key129" size="5" value="<%=dspKey(129)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text37">
        <input type="text" name="key130" size="5" value="<%=dspKey(130)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text39">
        <font size=2><%=comn%></font></td>
     </tr>      
       <tr>
        <td  width=15% class="dataListHEAD" height="23">���X���ʵ��פ�</td>                                 
        <td  width=35% height="23" bgcolor="silver">
        <input type="text" name="key131" size="10" value="<%=dspKey(131)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListentry" ID="Text40">
         </td>
        <td   width=15% class="dataListHEAD" height="23">���J���ʵ��פ�</td>                                 
        <td   width=35% height="23" bgcolor="silver">
        <input type="text" name="key132" size="10" value="<%=dspKey(132)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text42">
        </td></tr>           
       
       <tr>
        <td  width=15% class="dataListHEAD" height="23">�Τ�̷s���ʪ��A</td>                                 
        <td  width=35% height="23" bgcolor="silver" >
        <% STS=""
           sqlxx=" select top 1 * from RTebtcustchg where comq1=" & dspkey(0) & " and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' and DROPDAT IS NULL ORDER BY ENTRYNO DESC " 
           rs.Open sqlxx,conn
           if rs.eof then
              STS="�L���ʸ��(�β��ʸ�Ƥw�@�o)"
           else
              sts=""
              if rs("chgcod1") = 1 then
                 sts=sts & "�ܧ�Τ���"
              end if
              if rs("chgcod2") = 1 then
                 if sts <> "" then 
                    sts=sts & "������"
                 else
                    sts="����"
                 end if
              end if
              if rs("chgcod3") = 1 then
                 if sts <> "" then 
                    sts=sts & "������"
                 else
                    sts="����"
                 end if
              end if             
              if rs("chgcod4") = 1 then
                 if sts <> "" then 
                    sts=sts & "���䥦--" & rs("CHGCOD4OPT")
                 else
                    sts="�䥦--" & rs("CHGCOD4OPT")
                 end if
              end if
              sts="���ʶ��ءJ" & sts & " ==> "     
         
              if isnull(rs("TRANSCHKDAT")) then
                 sts=sts & "��ƫ��ɤ�"                 
              elseif not isnull(rs("TRANSCHKDAT")) and isnull(rs("EBTREPLYDAT")) then
                 sts=sts & "���ʸ�ƥӽФ�" 
              elseif not isnull(rs("TRANSCHKDAT")) and not isnull(rs("TRANSDAT"))  and isnull(rs("EBTREPLYDAT"))  and rs("chgcod2") <> 1 then
                 sts=sts & "���ʸ�Ƥw���ɡA����EBT�^�Ф��Y����"
              elseif not isnull(rs("TRANSCHKDAT")) and not isnull(rs("TRANSDAT")) and not isnull(rs("EBTREPLYDAT")) and rs("chgcod2") <> 1 then
                 sts=sts & "���ʸ�Ƥw����"
              elseif not isnull(rs("TRANSCHKDAT")) and isnull(rs("FINISHCHKDAT")) and rs("chgcod2") = 1 then
                 sts=sts & "���ʸ�Ƭ��u��"           
              elseif not isnull(rs("TRANSCHKDAT")) and not isnull(rs("FINISHCHKDAT")) and isnull(rs("FINISHTNSDAT")) and rs("chgcod2") = 1 then
                 sts=sts & "���ʸ�Ƥw���u�A�^���@�~�B�z��"           
              elseif not isnull(rs("TRANSCHKDAT")) and not isnull(rs("FINISHCHKDAT")) and not isnull(rs("FINISHTNSDAT")) and rs("chgcod2") = 1 then
                 sts=sts & "���ʸ�Ƥw���u�A�^���@�~�w����"                                 
              end if
           end if
           rs.close
        %>                           
        <font size=2 color=#ff0000"><%=STS%></font>
         </td>
         <td  WIDTH="15%"  class="dataListSEARCH" height="23">�Ȥ�D�u�վ�Ƶ�</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver">
<%  
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1   Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='L2' " 
       If len(trim(dspkey(139))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='L2' AND CODE='" & dspkey(139) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(139) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key139" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select15">                                                                  
        <%=s%>
   </select>
        </td>
    </table> 
</div>
    <DIV ID="SRTAG6" onclick="SRTAG6" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
    <tr><td bgcolor="BDB76B" align="LEFT">�Ƶ�����</td></tr></table></DIV>
   <DIV ID="SRTAB6" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <TR><TD align="CENTER">
     <TEXTAREA  cols="100%"  name="key124" rows=8  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(124)%>" ID="Textarea1"><%=dspkey(124)%></TEXTAREA>
   </td></tr>
 </table> 
  </div> 
<%
    conn.Close   
    set rs=Nothing   
    set conn=Nothing 
End Sub 
' -------------------------------------------------------------------------------------------- 
Sub SrReadExtDB()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    'RESPONSE.Write "SELECT * FROM RTEBTcustext WHERE comq1=" &dspKey(0) &" and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' and dropdat is null "
    rs.Open "SELECT * FROM RTEBTcustext WHERE comq1=" &dspKey(0) &" and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' and dropdat is null ",conn
    if rs.eof then
       'dialer��O���
       extdb(0)=""
       '�q�ܸ��X
       extdb(1)=""
       '����
       extdb(2)=1
       EXTDB(3)="03"
    else
       extDB(0)=rs("DIALERPAYTYPE")
       extdb(1)=rs("telno")
       extdb(4)=rs("telzip")
       extDB(2)=RS("ENTRYNO")
       extDB(3)=RS("SRVTYPE")
    end if
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
'------RTEBTcustext ---------------------------------------------------
    sqlxx="SELECT * FROM RTEBTcustext WHERE comq1=" &dspKey(0) &" and lineq1=" & dspkey(1) & " and cusid='" & dspkey(2) & "' AND ENTRYNO=" & EXTDB(2) & " "
   '    RESPONSE.Write sqlxx
    rs.Open sqlxx,conn,3,3
   ' RESPONSE.Write RS.EOF
    If rs.Eof Or rs.Bof Then
      ' If Smode="A" Then
          rs.AddNew
          rs("COMQ1")=dspKey(0)
          rs("LINEQ1")=dspKey(1)
          rs("CUSID")=dspKey(2)
          rs("ENTRYNO")=EXTDB(2)
          rs("eusr")=dspkey(116)
          rs("edat")=dspkey(117)
     '  End If
    End If
    rs("TELNO")=EXTDB(1)
    rs("SRVTYPE")=extDB(3)
    rs("telzip")=EXTDB(4)
    IF extDB(0)="" THEN extDB(0)="M"
    rs("DIALERPAYTYPE")=extDB(0)
    RS("SDATE")=dspKey(113)
    rs("uusr")=dspkey(118)
    rs("udat")=dspkey(119)    
    rs.Update
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/checkid.inc" -->
<!-- #include virtual="/Webap/include/companyid.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->