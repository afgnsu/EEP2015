<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
  
'For i = 0 To 32
'response.write "fieldRole("&i&")="& fieldRole(i) &"<BR>" 
'Next

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
              If Instr(cTypeNumeric,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=0
			  If Instr(cTypeChar,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=""
              If Instr(cTypeDate,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=Null				  
              If Instr(cTypeAuto,sType) > 0 Or (dspKey(i)=-1 And i<numberOfKey) Then
              Else
              '   On Error Resume Next
                runpgm=Request.ServerVariables("PATH_INFO") 
                select case ucase(runpgm)   
                   ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                   case ucase("/webap/rtap/base/RTLessorAVScmty/RTLessorAVSCUSTd.asp")
                       if i <> 2 then rs.Fields(i).Value=dspKey(i)
                       if i=2 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         cusidxx="E" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
                         rsc.open "select max(cusid) AS cusid from RTLessorAVSCust where cusid like '" & cusidxx & "%' " ,conn
                         if len(rsc("cusid")) > 0 then
                            dspkey(2)=cusidxx & right("000" & cstr(cint(right(rsc("cusid"),3)) + 1),3)
                         else
                            dspkey(2)=cusidxx & "001"
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
              If Instr(cTypeNumeric,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=0
			  If Instr(cTypeChar,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=""
              If Instr(cTypeDate,sType) > 0 And Len(Trim(dspKey(i))) = 0 Then dspKey(i)=Null
              'If Instr(cTypeAuto,sType) > 0 Or (dspKey(i)=-1 And i<numberOfKey) Then
			  'On Error Resume Next
 			  'response.write i&")�@<font color=red>"& rs.Fields(i).name & "</font>("& replace(replace(replace(replace(replace(sType,"200","Varchar"),"003","Int"),"135","Datetime"),"002","Smallint"),"202","nVarchar") & ") <font color=green>="& dspkey(i) & "</font><BR>"
              if i<>0 and i <> 1 then rs.Fields(i).Value=dspKey(i)         
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
       if ucase(runpgm)=ucase("/webap/rtap/base/RTLessorAVScmty/RTLessorAVSCustD.asp") then
          cusidxx="E" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
          rsc.open "select max(cusid) AS cusid from RTLessorAVSCust where cusid like '" & cusidxx & "%' " ,conn
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
<meta http-equiv="content-type" content="text/html; charset=big5" />
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
  title="AVS-City�Τ��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT  COMQ1, LINEQ1, CUSID, CUSNC, SOCIALID, CUTID1, TOWNSHIP1, RADDR1, RZONE1, CUTID2, TOWNSHIP2," _
             &"RADDR2, RZONE2, CUTID3, TOWNSHIP3,RADDR3, RZONE3, BIRTHDAY, CONTACTTEL, MOBILE, EMAIL, " _
             &"COCONTACT,COCONTACTTEL,COTELEXT,COCONTACTMOBILE,COBOSS,COBOSSID,COKIND,PAYTYPE, APPLYDAT, PROGRESSID, " _
             &"FINISHDAT,DOCKETDAT, STRBILLINGDAT, AREAID, GROUPID, SALESID,DROPDAT, FREECODE, OVERDUE, EUSR,   " _
             &"EDAT,UUSR, UDAT, MEMO, CANCELDAT, CANCELUSR, IP11, MAC, PERIOD, DUEDAT, " _
             &"IDNUMBERTYPE,SECONDIDTYPE,SECONDNO,GTMONEY,GTVALID,GTSERIAL,DEVELOPERID,PAYCYCLE,CREDITCARDTYPE,CREDITBANK, " _
             &"CREDITCARDNO,CREDITNAME,CREDITDUEM,CREDITDUEY,NEWBILLINGDAT,PORT,EQUIP,ADJUSTDAY,rcvmoney,BATCHNO,"_
             &"CDAT,SECONDCASE,ip12,ip13,ip14,CPEKIND,SETMONEY,CASEKIND, GTEQUIP, GTPRTDAT, " _
             &"GTPRTUSR, USERRATE, GTREPAYDAT, COTOUT, COTIN, STBIP, STBMAC, PPPOEID, PPPOEPW, RCVMONEYFLAG1 " _
             &"from RTLessorAVSCust WHERE COMQ1=0 "
  sqlList="SELECT  COMQ1, LINEQ1, CUSID, CUSNC, SOCIALID, CUTID1, TOWNSHIP1, RADDR1, RZONE1, CUTID2, TOWNSHIP2," _
             &"RADDR2, RZONE2, CUTID3, TOWNSHIP3,RADDR3, RZONE3, BIRTHDAY, CONTACTTEL, MOBILE, EMAIL, " _
             &"COCONTACT,COCONTACTTEL,COTELEXT,COCONTACTMOBILE,COBOSS,COBOSSID,COKIND,PAYTYPE, APPLYDAT, PROGRESSID, " _
             &"FINISHDAT,DOCKETDAT, STRBILLINGDAT, AREAID, GROUPID, SALESID,DROPDAT, FREECODE, OVERDUE, EUSR,   " _
             &"EDAT,UUSR, UDAT, MEMO, CANCELDAT, CANCELUSR, IP11, MAC, PERIOD, DUEDAT, " _
             &"IDNUMBERTYPE,SECONDIDTYPE,SECONDNO,GTMONEY,GTVALID,GTSERIAL,DEVELOPERID,PAYCYCLE,CREDITCARDTYPE,CREDITBANK, " _
             &"CREDITCARDNO,CREDITNAME,CREDITDUEM,CREDITDUEY,NEWBILLINGDAT,PORT,EQUIP,ADJUSTDAY,rcvmoney,BATCHNO,CDAT,SECONDCASE, " _
             &"ip12,ip13,ip14,CPEKIND,SETMONEY,CASEKIND, GTEQUIP, GTPRTDAT, GTPRTUSR, USERRATE, GTREPAYDAT, " _
             &"COTOUT, COTIN, STBIP, STBMAC, PPPOEID, PPPOEPW, RCVMONEYFLAG1 " _
             &"from RTLessorAVSCust WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=5
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
  '���������Ĥ@�X,�ΥH�P�O�O�ӤH�٬O���q,�Y�����q�h�X�ͤ�������ť�,�Ϥ��h���i�ť�
  LEADINGCHAR=LEFT(DSPKEY(4),1)
  IF LEADINGCHAR >="0" AND LEADINGCHAR <="9" THEN
     COMPANY="Y"
  ELSE
     COMPANY="N"
  END IF
  IF DSPKEY(33)="" then dspkey(50)=""

  '�����ҲĤ@�X�j�g
  DSPKEY(4)=UCASE(DSPKEY(4))
  if len(trim(dspkey(29)))=0 then
       formValid=False
       message="�Τ�ӽФ餣�i�ť�"   
  elseif len(trim(dspkey(3)))=0 then
       formValid=False
       message="�Τ�W�٤��i�ť�"          
  '�������ɤ��ˬd������
  elseif len(trim(dspkey(51)))=0 AND len(trim(dspkey(4)))<>0 then
       formValid=False
       message="�Ĥ@�ҷӧO���i�ť�"             
  elseif ( len(trim(dspkey(4)))<>0 and (len(trim(dspkey(4)))<>10 and len(trim(dspkey(4)))<>8 ) ) then
       formValid=False
       message="�Τᨭ����(�νs)���פ���"    
 ' elseif len(trim(dspkey(52)))=0 AND len(trim(dspkey(53)))<>0 then
 '      formValid=False
 '      message="�ĤG�ҷӧO���i�ť�"         
 ' elseif len(trim(dspkey(53)))=0  then
 '      formValid=False
 '      message="�ĤG�ҷӸ��X���i�ť�"                
 ' elseif len(trim(dspkey(17)))=0 AND COMPANY="N" then
 '      formValid=False
 '      message="�X�ͤ�����i�ť�"             
  elseif len(trim(dspkey(18)))=0 AND len(trim(dspkey(19)))=0 then
       formValid=False
       message="�Τ��p���q�ܩΦ�ʹq�ܦܤֻݿ�J�@��"      
  elseif instr(1,dspkey(18),"-",1) > 0 then
       formValid=False
       message="�Τ��p���q�ܤ��i�]�t'-'�Ÿ�"                     
  elseif instr(1,dspkey(19),"-",1) > 0 then
       formValid=False
       message="�Τ��ʹq�ܤ��i�]�t'-'�Ÿ�"                    
  elseif len(trim(dspkey(5)))=0 then
       formValid=False
       message="���y�a�}(����)���i�ť�"   
  elseif len(trim(dspkey(6)))=0 and dspkey(5)<>"06" and dspkey(5)<>"15" then
       formValid=False
       message="���y�a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(7)))=0 then
       formValid=False
       message="���y�a�}���i�ť�"          
  elseif len(trim(dspkey(9)))=0 then
       formValid=False
       message="�˾��a�}(����)���i�ť�"   
  elseif len(trim(dspkey(10)))=0 and dspkey(9)<>"06" and dspkey(9)<>"15" then
       formValid=False
       message="�˾��a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(11)))=0 then
       formValid=False
       message="�˾��a�}���i�ť�"     
  elseif len(trim(dspkey(13)))=0 and instr(dspkey(15),"�l�F")=0 then
       formValid=False
       message="�b��a�}(����)���i�ť�"   
  elseif len(trim(dspkey(14)))=0 and dspkey(13)<>"06" and dspkey(13)<>"15" and instr(dspkey(15),"�l�F")=0 then
       formValid=False
       message="�b��a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(15)))=0 then
       formValid=False
       message="�b��a�}���i�ť�"          
' elseif (len(trim(dspkey(17)))=0 or Not Isdate(dspkey(17))) AND COMPANY="N" then
'       formValid=False
'       message="�Τᬰ�ӤH�ɡA�X�ͤ�����i�ťթή榡���~"   
  elseif len(trim(dspkey(17)))<>0  AND COMPANY="Y" then
       'formValid=False
       message="�Τᬰ�k�H�ɡA�X�ͤ�������ť�"          
  elseif len(trim(dspkey(21)))=0 AND COMPANY="Y" then
       'formValid=False
       message="���~�s���H���i�ť�"              
  elseif len(trim(dspkey(22)))=0 and len(trim(dspkey(24)))=0 AND COMPANY="Y" then
       'formValid=False
       message="���~�s���q��(�դ�)�Φ�ʹq�ܦܤֶ���J�@��"   
  elseif instr(1,dspkey(24),"-",1) > 0 then
       'formValid=False
       message="���~��ʹq�ܤ��i�]�t'-'�Ÿ�"          
  elseif instr(1,dspkey(22),"-",1) > 0 then
       'formValid=False
       message="���~�s���q�ܤ��i�]�t'-'�Ÿ�"      
  elseif len(trim(dspkey(25)))=0 AND COMPANY="Y" then
       'formValid=False
       message="���~�t�d�H���i�ť�"                 
  elseif len(trim(dspkey(26)))=0 AND COMPANY="Y" then
       'formValid=False
       message="���~�t�d�H�����Ҧr�����i�ť�"                       
  elseif ( len(trim(dspkey(26)))=0 or (len(trim(dspkey(26)))<>10 and len(trim(dspkey(26)))<>8 ) ) AND COMPANY="Y"  then
       'formValid=False
       message="���~�t�d�H�����Ҥ��i�ťթΪ��פ���"           
 ' elseif (len(trim(dspkey(34)))=0 OR len(trim(dspkey(35)))=0 OR len(trim(dspkey(36)))=0 ) and len(trim(dspkey(57)))=0 then
 '      formValid=False
 '      message="�~���ҰϤη~�ȭ����i�ť�"    
  'elseif len(trim(dspkey(36)))=0  and len(trim(dspkey(57)))=0  then
  '     formValid=False
  '     message="�~�ȭ��ΤG�u�}�o�H�����i�ť�"           
 ' elseif len(trim(dspkey(47)))=0 AND len(trim(dspkey(33)))> 0 then
 '      formValid=False
 '      message="���u�p�O��A�Τ�IP���i�ť�"          
 '   elseif LEN(TRIM(dspkey(67))) > 0 and LEN(TRIM(dspkey(66)))=0 then
 '      formValid=False
 '      message="����]�ƺ����s�������ťծɡA������J�W�h�]�ƺ���port��"   
 '  elseif LEN(TRIM(dspkey(66))) > 0 and LEN(TRIM(dspkey(67)))=0 then
 '      formValid=False
 '      message="����]�ƺ���port�������ťծɡA������J�W�h�]�ƺ����s��"                  

  elseif len(trim(dspkey(78)))=0 and trim(dspkey(38))<>"Y" then
       formValid=False
       message="�D������ɡA����������i�ť�"               
  elseif len(trim(dspkey(58)))=0 and trim(dspkey(38))<>"Y" then
       formValid=False
       message="�D������ɡAú�O�g�����i�ť�"              
  elseif (len(trim(dspkey(49)))=0 or dspkey(49)=0) and trim(dspkey(38))<>"Y"  then
       formValid=False
       message="�D������ɡA���Ƥ��i�ťթ�0"             
  'elseif len(trim(dspkey(69)))=0 or dspkey(69)=0 AND dspKey(38)<> "Y" then
       'formValid=False
       'message="�D������ɡA������ڪ��B�����j��0"                         
  elseif len(trim(dspkey(28)))=0 and trim(dspkey(38))<>"Y" then
       formValid=False
       message="ú�O�覡���i�ť�"        

  '�H�Υdú�O�ɡA�H�Υd�����εo�d�Ȧ�B���X���i�ť�      
  elseif len(trim(dspkey(59)))=0 AND dspkey(28)="01" then
       formValid=False
       message="�H�Υd�������i�ť�"            
'  elseif len(trim(dspkey(60)))=0 AND dspkey(28)="01" then
'       formValid=False
'       message="�H�Υd�o�d�Ȧ椣�i�ť�"         
  elseif len(trim(dspkey(61)))=0 AND dspkey(28)="01" then
       formValid=False
       message="�H�Υd�d�����i�ť�"            
  elseif len(trim(dspkey(62)))=0 AND dspkey(28)="01" then
       formValid=False
       message="�H�Υd���d�H���i�ť�"            
  elseif (len(trim(dspkey(63)))=0 OR len(trim(dspkey(64)))=0 ) AND dspkey(28)="01" then
       formValid=False
       message="�H�Υd���Ħ~�뤣�i�ť�"                   
  elseif len(trim(dspkey(62)))<>0 and right("00" & dspkey(62),2)<="01" and right("00" & dspkey(62),2)>="12" then
       formValid=False
       message="�H�Υd���Ĥ�W�X�d��(01-12)"       
 ' elseif len(trim(dspkey(63)))<>0 and dspkey(63)< right(datepart("yyyy",now()),2) then
 '      formValid=False
 '      message="�H�Υd�w�L��(�p��t�Φ~)"    
 ' elseif len(trim(dspkey(63)))<>0 and dspkey(63)< right(datepart("yyyy",now()),2) and len(trim(dspkey(62)))<>0 and dspkey(62) < right("00" & datepart("m",now()),2) then
 '      formValid=False
 '      message="�H�Υd�w�L��(�p��t�Τ�)"                                    
  elseif len(trim(dspkey(49)))=0 AND len(trim(dspkey(33)))<>0 then
       formValid=False
       message="���u�p�O�ɡA�i�ϥ�[����]���i�ť�"                  
  'elseif len(trim(dspkey(31)))=0 AND len(trim(dspkey(33)))<>0 then
  '     formValid=False
  '     message="�������������u���סA�~�i��J�}�l�p�O��"                                                
  elseif len(trim(dspkey(37)))<> 0 AND len(trim(dspkey(31)))= 0 then
       formValid=False
       message="���u������ťծɤ��i��J�h����"       
 ' elseif len(trim(dspkey(76)))= 0 then
 '      formValid=False
 '      message="�Τ�CPE�]�ƺ������i�ť�"             
  end if
  IF formValid=TRUE THEN
    IF dspkey(4) <> "" and (dspkey(51)="01" or dspkey(51)="02") then
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

  '�ˬd�D�u�}�o�����P�θg�P==��g�P��,�h�Z���k�ݳ������ť�,�Ϥ��h������J
  IF formValid=TRUE THEN
   Set connxx=Server.CreateObject("ADODB.Connection")
   Set rsxx=Server.CreateObject("ADODB.Recordset")
   connxx.open DSN
   sqlxx="select * from RTLessorAVSCmtyLine where comq1=" & aryparmkey(0) & " AND LINEQ1=" & ARYPARMKEY(1)
   rsxx.Open sqlxx,connxx
   if not rsxx.eof then
      'if len(trim(rsxx("consignee"))) <> 0 then
      '   if (len(trim(dspkey(34))) <> 0 or len(trim(dspkey(35))) <> 0 or len(trim(dspkey(36))) <> 0 ) or len(trim(dspkey(57)))<> 0 then
      '      formValid=False
      '      message="�D�u�}�o���g�P��,�Z���k�ݥ����ť�" 
      '   end if
      'else
      '   if (len(trim(dspkey(34))) = 0 or len(trim(dspkey(35))) = 0 or len(trim(dspkey(36))) = 0) and len(trim(dspkey(57)))=0 then
      '      formValid=False
      '      message="�D�u�}�o�����P,�Z���k�ݤ��i�ť�" 
      '   end if
      'end if

      '�D�u�����q�̡A���i��J�Τ�p�O��
   '(�Ȯɮ����J���Ĥ@����Ƨ�s�����ΥD�u��Ƹɻ���A���ˬd)
   '   if isnull(rsxx("adslapplydat")) and len(trim(dspkey(33))) <> 0 then
   '         formValid=False
   '         message="�D�u�����q�A���i��J�Τ�}�l�p�O��" 
   '   end if
      '�D�u�����q�̡A���i��J�Τ�h����
      'if isnull(rsxx("adslapplydat")) and len(trim(dspkey(37))) <> 0 then
      '      formValid=False
      '      message="�D�u�����q�A���i��J�Τ�h����" 
      'end if      

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

'�ˬd�P�@�]�ƥN����PORT�O�_�w�Q�ϥ�
' IF formValid=TRUE and (dspkey(66) <> "" or dspkey(67) <> "" )THEN
'    Set connxx=Server.CreateObject("ADODB.Connection")
'    Set rsxx=Server.CreateObject("ADODB.Recordset")
'    connxx.open DSN
'    SQLXX="Select count(*) as cnt from RTLessorAVSCust where port<>'0' and comq1=" & dspkey(0) & " and lineq1=" & dspkey(1) & " and port='" & dspkey(66) & "' and equip='" & dspkey(67) & "' and cusid<>'" & dspkey(2) & "' " 
'    rsxx.open sqlxx,connxx
'    if rsxx("cnt") > 0 then
'       formValid=False
'        message="����]�ƥN����port�w���䥦�Τ�b�ϥΡA���୫��"
'    end if
'    rsxx.close
'    connxx.Close   
'    set rsxx=Nothing   
'    set connxx=Nothing 
' END IF

 '�s�W��(�ק�ɤ��ˬd)....�ˬd�O�_���ĤG��?
 '(1)��P�Τ�W�ٸ�Ƥw�s�b�A�B�Ӹ�Ƥw�h����(���P��@�o)�A�h���i�s�W�A�ȯ�δ_���C
 '   ==>�Y�_���ɱĩuú�B�b�~ú�ɭn�h���_���O500��(��J�����b��)
 '(2)���P�Τ�W�ٸ�Ƥw�s�b�A�B�Ӹ�ƥ��h��(���Ĥ�)�ɡA�h�����H"�ĤG��"���覡����(�Y�h�@����ܬ��ĤG��)
 '   �ĤG�᪺�����A�ȶO���C��100���A��������u��P�D����ƬۦP(�Y�Ĥ@��)�A�]�����ƭn�ѹq���۰ʭp��C
 IF formValid=TRUE THEN
    Set connxx=Server.CreateObject("ADODB.Connection")
    Set rsxx=Server.CreateObject("ADODB.Recordset")
    connxx.open DSN
    'Ū���P���ϦP�Τ�W�ٱư��@�o����ƤβĤG�᪺��ơA�u���D�����
    '(�s�W��)
    if accessmode ="A" then
       sqlxx="select * from RTLessorAVSCust where cusnc='" & dspkey(3) & "' AND COMQ1=" & DSPKEY(0) & " and canceldat is null and secondcase<>'Y' "
    '(�ק��--�ݱư��������)
    else
       sqlxx="select * from RTLessorAVSCust where cusnc='" & dspkey(3) & "' AND COMQ1=" & DSPKEY(0) & " and canceldat is null and secondcase<>'Y' and cusid<>'" & dspkey(2)& "'"
    end if
    rsxx.Open sqlxx,connxx
    '�P�_���L�D�����
    if rsxx.eof then
       IF DSPKEY(72)="Y" THEN
          formValid=False
          message="���Τ�L�D����ơA���i�ĲĤG��覡���ɡA�вM���ĤG��аO�C" 
       END IF
    '���D����ơA�A�P�_�Ĵ_���βĤG��覡����
    else
       '�D����ƥثe�����Ĥ�A�����ĲĤG��
       if isnull(rsxx("dropdat")) AND DSPKEY(72)<> "Y"  then
          'formValid=False
          message="���Τᤧ�D����Ƭ����Ĥ�A�����ĲĤG��覡���ɡA�Ю֨��ĤG��аO�C" 
       '�D����ƥثe���h����A�����Ĵ_���覡�A���i����
       elseIF NOT ISNULL(RSXX("DROPDAT")) THEN
          'formValid=False
          message="�D����ƥثe���h����A���i���ɡA�����Ĵ_���覡�C"    
      '��D����Ʀs�b�ɥB��H�ĤG��覡���ɡA������Y�j��D�������ɫh�����ץ���P�D���ۦP�A�]�����O���D�������A�A�Ӥϱ����Ƥνվ��ƩM�������B�C 
       elseif isnull(rsxx("duedat")) AND DSPKEY(72)= "Y" then
          'formValid=False
          message="�D����ƥثe�|�����u�p�O�A�L�k�o�������A�G�ĤG��|���i���ɡC"      
       ELSEIF isnull(rsxx("dropdat")) AND DSPKEY(72)= "Y"  then
          '�P�_�����O�_�|�j��D�������
          if len(trim(dspkey(33)))=0 and len(trim(dspkey(65)))=0 then
            ' dspkey(33)=datevalue(now())
          end if
          '(�L�}�l�p�O�������p�O��ɡA�H�t�Τ�N���}�l�p�O��)
          if len(trim(dspkey(65))) > 0 then
             dspkey(50)=dateadd("m",dspkey(49),dspkey(65))
          elseif len(trim(dspkey(33))) > 0 then
             dspkey(50)=dateadd("m",dspkey(49),dspkey(33))
          end if
          '�Y�����W�L�D�������ɡA�h�N�����אּ�D�������
          if dspkey(50) > RSXX("DUEDAT") then
             dspkey(50)=RSXX("DUEDAT")
            '�p�����
            if len(trim(dspkey(65))) > 0 then
               dspkey(49)=datediff("m",dspkey(65),dspkey(50))
          elseif len(trim(dspkey(33))) > 0 then
               dspkey(49)=datediff("m",dspkey(33),dspkey(50))
            end if
            '�Y��Ƥj�������ơA�h��ƴ�1�A�ñN�t�B����ন�վ���
            if len(trim(dspkey(65))) > 0 then
               if datepart("d",dspkey(65)) > datepart("d",dspkey(50)) then
                  dspkey(49)=dspkey(49) - 1
                  '�p��t�Τ�����
                  xxdate=datepart("yyyy",dspkey(65)) & "/" & datepart("m",dateadd("m",1,dspkey(65))) & "/1"
                  xxday=datepart("d",dateadd("d",-1,xxdate))
                  dspkey(68)=xxday - datepart("d",dspkey(65)) + datepart("d",dspkey(50))
                end if
            else
            	if len(trim(dspkey(33))) > 0 then
                	if datepart("d",dspkey(33)) > datepart("d",dspkey(50)) then
						dspkey(49)=dspkey(49) - 1
						'�p��t�Τ�����
						xxdate=datepart("yyyy",dspkey(33)) & "/" & datepart("m",dateadd("m",1,dspkey(33))) & "/1"
						xxday=datepart("d",dateadd("d",-1,xxdate))
						dspkey(68)=xxday - datepart("d",dspkey(33)) + datepart("d",dspkey(50))
                	end if
                end if
            end if
            '�p���������B(����*100)
            dspkey(69)=dspkey(49) * 100
            '�Y���Ƭ�0�A�Y1�Ӥ�H���A�h�H100�����H��ڤ�Ʀ��O
            if dspkey(49)=0 and dspkey(69) = 0 then
               dspkey(69)=dspkey(68) * 100 /30
            end if
          end if
       end IF
    end if
    rsxx.close
    connxx.Close   
    set rsxx=Nothing   
    set connxx=Nothing 
    
 END IF
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(42)=V(0)
        dspkey(43)=now()
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
   Sub Srbtn33onclick()
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
       srChangeMoney()
       srrecalulate()
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
   Sub Sr33Clear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid    
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
       end if
       srrecalulate()
   End Sub
	Sub SrIPTVarChange()
			iptvflag = 	document.all("KEY76").VALUE
			if  iptvflag = "01" then
				document.all("key90").value="Y"
			else
				document.all("key90").value=""
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
   Sub Srcounty6onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY5").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key6").value =  trim(Fusrid(0))
          document.all("key8").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub Srcounty10onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key10").value =  trim(Fusrid(0))
          document.all("key12").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB    
   Sub Srcounty14onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY13").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key14").value =  trim(Fusrid(0))
          document.all("key16").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY57").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key57").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub      
   'Sub Srsalesgrouponclick()
   '    prog="RTGetsalesgroupD.asp"
   '    prog=prog & "?KEY=" & document.all("KEY34").VALUE 
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key35").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub        
   'Sub Srsalesonclick()
   '    prog="RTGetsalesD.asp"
   '    prog=prog & "?KEY=" & document.all("KEY34").VALUE & ";" & document.all("KEY35").VALUE
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key36").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub      
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
      Sub SrTAG8()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB8.style.display="" then
          window.SRTAB8.style.display="none"
       elseif window.SRTAB8.style.display="none" then
          window.SRTAB8.style.display=""
       end if
   End Sub                  
      Sub SrTAG9()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB9.style.display="" then
          window.SRTAB9.style.display="none"
       elseif window.SRTAB9.style.display="none" then
          window.SRTAB9.style.display=""
       end if
   End Sub                    
      Sub SrTAG10()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB10.style.display="" then
          window.SRTAB10.style.display="none"
       elseif window.SRTAB10.style.display="none" then
          window.SRTAB10.style.display=""
       end if
   End Sub              
      Sub SrTAG11()
      ' msgbox window.SRTAB1.style.display
       if window.SRTAB11.style.display="" then
          window.SRTAB11.style.display="none"
       elseif window.SRTAB11.style.display="none" then
          window.SRTAB11.style.display=""
       end if
   End Sub                      
Sub SrAddrEqual1()
   document.All("key9").value=document.All("key5").value
   document.All("key10").value=document.All("key6").value
   document.All("key11").value=document.All("key7").value
   document.All("key12").value=document.All("key8").value
End Sub 
Sub SrAddrEqual2()
   document.All("key13").value=document.All("key5").value
   document.All("key14").value=document.All("key6").value
   document.All("key15").value=document.All("key7").value
   document.All("key16").value=document.All("key8").value
End Sub      
Sub SrAddrEqual3()   
   document.All("key13").value=document.All("key9").value
   document.All("key14").value=document.All("key10").value
   document.All("key15").value=document.All("key11").value
   document.All("key16").value=document.All("key12").value
End Sub         
Sub SrAddrEqual5()   
   document.All("key62").value=document.All("key3").value
End Sub

Sub srrecalulate()
  ' msgbox document.All("key68").value
   '�̪�����餣���ťծɡA�ϥκI���=�̪������+�i�ϥδ��ƪ����+�վ���
   if document.All("key65").value <> "" then
      document.All("key50").value = dateadd("m",document.All("key49").value,document.All("key65").value)
      '�����1
      document.All("key50").value = dateadd("d",-1,document.All("key50").value)
      document.All("key50").value = dateadd("d",document.All("key68").value,document.All("key50").value)
   '�̪�����鬰�ťծɡA�ϥκI���=�}�l�p�O��+�i�ϥδ��ƪ����+�վ���
   elseif document.All("key33").value <> "" then
      document.All("key50").value = dateadd("m",document.All("key49").value,document.All("key33").value)
      '�����1
      document.All("key50").value = dateadd("d",-1,document.All("key50").value)
      document.All("key50").value = dateadd("d",document.All("key68").value,document.All("key50").value)
   else
      '�L�}�l�p�O��ɡA�w�]���t�Τ�
     ' document.All("key33").value = datevalue(now())
      'document.All("key50").value = dateadd("m",document.All("key49").value,document.All("key33").value)
      '�����1
      document.All("key50").value = dateadd("d",-1,document.All("key50").value)
      document.All("key50").value = dateadd("d",document.All("key68").value,document.All("key50").value)      
   '   document.All("key50").value = ""
   end if
   '�ϥκI��餣���ťծɡA�i�ϥΤ��=�κI���-�t�Τ�
   if document.All("key50").value <> ""  then
      document.All("remain").value = DATEDIFF("d",DATEVALUE(now()),document.All("key50").value)
   '�ϥκI��鬰�ťծɡA�h�i�ϥΤ�Ƥ��i�p��
   else
      document.All("remain").value = 0
   end if
   '�h���餣���ťծɡA�p�G�h����j��t�Τ�A�i�ϥΤ��=�h����-�t�Τ�
   if document.All("key37").value <> "" then
      if datevalue(now()) <= document.All("key37").value then
         document.All("remain").value=DATEDIFF("d",DATEVALUE(now()),document.All("key37").value)
      else
      '�h����Y�p��t�Τ�A�h�i�ϥΤ�Ƭ�0
         document.All("remain").value=0
      end if
   end if
   if document.All("remain").value < 0 then document.All("remain").value = 0
end sub

   SUB SrSHOWcreditcardOnClick()
       s28=document.all("key28").value
       IF s28="01" THEN
          window.tab1.style.display=""
       ELSE
          window.tab1.style.display="none"
       end if
    END SUB    
    
   Sub srChangeMoney()
       S78=document.all("key78").value		'�������
       s58=document.all("key58").value		'ú�O�g��
		document.all("key69").value =0
		document.all("key49").value =0
		if document.all("key72x").CHECKED then	'�ĤG��
			document.all("key69").value = document.all("key"& S78 & S58 & "amt2").value
		else
			document.all("key69").value = document.all("key"& S78 & S58 & "amt").value
		end if
		document.all("key49").value = document.all("key"& S78 & S58 & "period").value
    END SUB
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
        if len(trim(dspkey(40))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(40)=V(0)
        End if  
       dspkey(41)=now()
    else
        if len(trim(dspkey(42))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(42)=V(0)
        End if         
        dspkey(43)=now()
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN

    '�~�U
	sql ="SELECT * FROM XXLib..UserGroup WHERE [GROUP] in('RTADMIN','�~�U') and userid ='" &logonid&"' "
    rs.Open sql,conn
    If rs.Eof Then
		basedata=False
    Else
		basedata=true
    End If
    rs.Close

    '�Τ�}�l�p�O��,���~�U�~��� protect
	If len(trim(dspKey(33))) > 0 and basedata=false Then
       fieldPm=" class=""dataListData"" readonly "
       fieldpn=" disabled "
    Else
       fieldPm=""
       fieldpn=""
    End If

	'������b�h����or�����, �~�U�i��
	If len(trim(dspKey(33))) = 0 then
       fieldPo=""
	elseif len(trim(dspKey(33))) > 0 and basedata=true and ( dspKey(37)<=now() or dspKey(50)<=now() ) then
       fieldPo=""		
	else
       fieldPo=" disabled "
	end if

    '�Τ᥼���u,��� protect
    If isnull(dspKey(31)) or len(trim(dspKey(31)))=0 Then
       fieldPh=" disabled "
    Else
       fieldPh=""
    End If

    '�Τ�}�l�p�O��,��� protect
    If len(trim(dspKey(33))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
    Else
       fieldPa=""
       fieldpb=""
    End If

    '�Τ�h����,�}�l�p�O���� protect
    If len(trim(dspKey(37))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
       fieldPC=" class=""dataListData"" readonly "
       fieldpD=" disabled "
    Else
       fieldPC=""
       fieldpD=""
    End If

    '�Τ�@�o��,�h�������� protect
    If len(trim(dspKey(45))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
       fieldPe=" class=""dataListData"" readonly "
    Else
       fieldPe=""
    End If

    '�O�Ҫ��C�L��, �O�Ҫ�������� protect
    If len(trim(dspKey(80))) > 0  Then
		fieldPg=" class=""dataListData"" readonly "
	Else
		fieldPg=""
	END IF

    %>
  <!--
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>           
  -->
  <span id="tags1" class="dataListTagsOn">AVS-City�Τ��T</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td>
<td>     
    <DIV ID="SRTAG0" onclick="srtag0" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="CENTER">�򥻸��</td></tr></table></div>
 <DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr>
    <td width="10%" class=dataListHEAD>�Τ�ӽФ�</td>
    <td width="23%" bgcolor="silver"  >
        <input type="text" name="key29" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(29)%>"  READONLY size="10" class=dataListEntry>
       <input  type="button" id="B29"  <%=fieldpb%> name="B29" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C29"  name="C29"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>    

    <td width="10%" class=dataLISTSEARCH>�ĤG��(�t)�H�W</td>
    <td width="23%" bgcolor="silver" >
		<%  
			'If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" and len(trim(dspkey(18)))=0 Then
			'FREECODE3=""
			'FREECODE4=""
			'Else
			' sexd1=" disabled "
			' sexd2=" disabled "
			'End If
		If dspKey(72)="Y" THEN
			FREECODE1=" checked "
			FREECODE2=""    
		ELSE
			FREECODE1=""
			FREECODE2=" checked "    
		END IF 
		%>
        <input type="radio" name="key72X" value="Y" <%=FREECODE1%> <%=fieldPb%> <%=fieldRole(1)%><%=dataProtect%> onCLICK="Srchangemoney()">�O
        <input type="radio" name="key72Y" value="N" <%=FREECODE2%> <%=fieldPb%> <%=fieldRole(1)%><%=dataProtect%> onCLICK="Srchangemoney()">�_
        <input type="hidden" name="key72" value="<%=dspKey(72)%>" class=dataListENTRY ID="Hidden1">
        </td>
        
        <td  WIDTH="10%" class="dataLISTSEARCH" height="23">������</td>                                 
		<%  
			If trim(dspKey(38))= "Y" THEN
				FREECODEX=" checked "    
				FREECODEY=""    
			ELSE
				FREECODEX=""    
				FREECODEY=" checked "    
			END IF 
		%>
        <td  WIDTH="23%" height="23" bgcolor="silver" colspan=3>
	        <input type="radio" name="key38" <%=FREECODEX%> value="Y" <%=fieldRole(1)%><%=dataProtect%> >�O
	        <input type="radio" name="key38" <%=FREECODEY%> value="N" <%=fieldRole(1)%><%=dataProtect%> >�_
		</td> </TR>   

<tr><td width="10%" class=dataListHEAD>�Τ�(���q)�W��</td>
    <td  width="23%"  bgcolor="silver" >
        <input type="text" name="key3" <%=fieldPm%><%=fieldRole(1)%><%=dataProtect%>
               style="ime-mode:active;" maxlength="30" value="<%=dspKey(3)%>" size="30" class=dataListENTRY></td>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='J5' " 
       If len(trim(dspkey(51))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='J5' AND CODE='" & dspkey(51) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�Ĥ@�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(51) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
              
<td width="10%" class=dataListHEAD>������(�νs)</td>
    <td width="23%" bgcolor="silver" >
	<select size="1" name="key51"<%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>    
        <input type="text" name="key4" <%=fieldRole(1)%><%=dataProtect%> maxlength="10"
               value="<%=dspKey(4)%>" size="12" class=dataListENTRY style="ime-mode:inactive;text-transform:uppercase;"></td>        
                    
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L3' " 
       If len(trim(dspkey(52))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L3' AND CODE='" & dspkey(52) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�ĤG�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(52) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <td width="10%" class="dataListHead" height="25">�ĤG�ҷӤθ��X</td>
        <td width="23%" height="25" bgcolor="silver" > 
		<select size="1" name="key52"<%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select16"><%=s%></select>	
        <input type="text" name="key53" size="15" maxlength="12" value="<%=dspkey(53)%>" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text49"></td> 
     </tr>    
<tr>                                 
        <td  class="dataListHEAD" height="23">�X�ͤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key17" size="10"  value="<%=dspKey(17)%>"  <%=fieldRole(1)%> class="dataListentry" ID="Text8">  
        <input type="button" id="B17"    name="B17" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"   alt="�M��" id="C17"  name="C17"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">          
        </td>                                 
        <td  class="dataListHEAD" height="23">�s���q��(�դ�)</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key18" size="30" maxlength="30" value="<%=dspKey(18)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text16"></td>                                 
        <td  class="dataListHEAD" height="23">��ʹq��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key19" size="30" maxlength="30" value="<%=dspKey(19)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
 </tr>     
 <tr> 
       <td width="10%" class=dataListHEAD>�p��Email</td>
    <td width="23%" bgcolor="silver" colspan=5  >
      <input type="text" name="key20" size="30" maxlength="50" value="<%=dspKey(20)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text9"> 
     </td>
</tr>

<tr><td class=dataListHEAD>���y(���q)�a�}</td>
    <td bgcolor="silver" COLSPAN=5>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then
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
         <select size="1" name="key5" <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2" onchange="Srchangetelzip"><%=s%></select>
        <input type="text" name="key6" readonly  size="8" value="<%=dspkey(6)%>" maxlength="10" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B6" <%=fieldPn%> name="B6"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX6%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldPn%> alt="�M��" id="C6"  name="C6"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key7"  size="50" value="<%=dspkey(7)%>" maxlength="60"  <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListENTRY" ID="Text4">
        <input type="text" name="key8" readonly  size="5" value="<%=dspkey(8)%>" maxlength="5" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4">
        </td>                                 
</tr>  
<tr><td class=dataListHEAD>�w�˦a�}</td>
    <td bgcolor="silver" COLSPAN=5>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(9))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
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
         <select size="1" name="key9" <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2" onchange="Srchangetelzip"><%=s%></select>
        <input type="text" name="key10" readonly  size="8" value="<%=dspkey(10)%>" maxlength="10" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B10" <%=fieldPn%> name="B10"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX10%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldPn%> alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key11"  size="50" value="<%=dspkey(11)%>" maxlength="60"  <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListENTRY" ID="Text4">
        <input type="text" name="key12" readonly  size="5" value="<%=dspkey(12)%>" maxlength="5" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4">
        <input type="radio" name="rd1"  <%=fieldPn%> onClick="SrAddrEqual1()"><font SIZE=2>�P���y(���q)�a�}</font></td>                                 
</tr>  
<tr><td class=dataListHEAD>�b��a�}</td>
    <td bgcolor="silver" COLSPAN=5>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(13))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX14=" onclick=""Srcounty14onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(13) & "' " 
       SXX14=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(13) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key13" <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2" onchange="Srchangetelzip"><%=s%></select>
        <input type="text" name="key14" readonly  size="8" value="<%=dspkey(14)%>" maxlength="10" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
         <input type="button" id="B14" <%=fieldPn%> name="B14"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX14%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldPn%> alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key15"  size="50" value="<%=dspkey(15)%>" maxlength="60"  <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListENTRY" ID="Text4">
        <input type="text" name="key16" readonly  size="5" value="<%=dspkey(16)%>" maxlength="5" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4">
        <input type="radio" name="rd2"  <%=fieldPn%> onClick="SrAddrEqual2()"><font SIZE=2>�P���y(���q)�a�}</font><input type="radio" name="rd2"  <%=fieldpb%> onClick="SrAddrEqual3()"><font SIZE=2>�P�˾��a�}</font></td>                                 
</tr>  
<tr>                                 
        <td  class="dataListHEAD" height="23">���~�s���H</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key21" size="12" maxlength="12" value="<%=dspKey(21)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text7">
       </td>                                 
        <td  class="dataListHEAD" height="23">���~�s���H�q��</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key22" size="15" maxlength="15" value="<%=dspKey(22)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text11">                                
        <FONT SIZE=2>�����J</FONT>
        <input type="text" name="key23" size="5" maxlength="5" value="<%=dspKey(23)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text11"></td>                                 
        <td  class="dataListHEAD" height="23">�s���H��ʹq��</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key24" size="17" maxlength="15" value="<%=dspKey(24)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text11"></td>                                 
        
 </tr>        
<TR>        
        <td  class="dataListHEAD" height="23">���~�t�d�H</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key25" size="12" maxlength="12" value="<%=dspKey(25)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text7">
        <td  class="dataListHEAD" height="23">�t�d�H������</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key26" size="10" maxlength="10" value="<%=dspKey(26)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text7">
        <td  class="dataListHEAD" height="23">��~�O</td>                                 
        <td  height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and len(trim(dspkey(33)))=0 Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='J8' " 
       If len(trim(dspkey(27))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='J8' AND CODE='" & dspkey(27) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(��~�O)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(27) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>               
        <select size="1" name="key27" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select16"><%=s%></select>
 </tr>
<TR>        
 </tr> 
	<tr>
			<td  class="dataListHEAD" height="23">���ɤH��</td>                                 
			<td  height="23" bgcolor="silver">
				<input type="text" name="key40" size="6" READONLY value="<%=dspKey(40)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA">
				<font size=2><%=SrGetEmployeeName(dspKey(40))%></font>
			</td>  
			<td  class="dataListHEAD" height="23">���ɤ��</td>                                 
			<td  height="23" bgcolor="silver" colspan=3>
				<input type="text" name="key41" size="25" READONLY value="<%=dspKey(41)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA">
			</td>       
	</tr>  
	<tr>
			<td  class="dataListHEAD" height="23">�ק�H��</td>                                 
			<td  height="23" bgcolor="silver">
				<input type="text" name="key42" size="6" READONLY value="<%=dspKey(42)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2">
				<font size=2><%=SrGetEmployeeName(dspKey(42))%></font>
			</td>  
			<td  class="dataListHEAD" height="23">�ק���</td>                                 
			<td  height="23" bgcolor="silver" colspan=3>
				<input type="text" name="key43" size="25" READONLY value="<%=dspKey(43)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
			</td>       
	</tr>         
 	<tr><td class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td height="23" bgcolor="silver">
			<input type="text" name="key46" size="6" value="<%=dspKey(46)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text43">
			<font size=2><%=SrGetEmployeeName(dspKey(46))%></font>
        </td>

 		<td class="dataListHEAD" height="23">�@�o���</td>                                 
        <td height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key45" size="25" value="<%=dspKey(45)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListdata" ID="Text41">
		</td>
	</tr>     

</table> </div>
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->

	<DIV ID="SRTAG3" onclick="srtag3" style="cursor:hand">
		<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
			<tr><td bgcolor="BDB76B" align="CENTER">��פ��e</td></tr>
		</table>
	</DIV>
    <DIV ID=SRTAB3 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
	<tr>
	<td WIDTH="10%"  class="dataListHEAD" height="23">�������</td>
	<%
		sql="select casekind, paycycle, amt, amt2, period from RTBillCharge where casetype ='07' and casekind not in ('06','07')"
	    rs.Open sql,conn
	    Do While Not rs.Eof
	       response.write "<input type=""hidden"" name=""key"& rs("casekind") & rs("paycycle") &"amt"" value="""& rs("amt") &""">" &_
	       				  "<input type=""hidden"" name=""key"& rs("casekind") & rs("paycycle") &"amt2"" value="""& rs("amt2") &""">" &_
	       				  "<input type=""hidden"" name=""key"& rs("casekind") & rs("paycycle") &"period"" value="""& rs("period") &""">"
	       rs.MoveNext
	    Loop
	    rs.Close

    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  and len(trim(dspkey(33)))=0 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='O9' and parm1 like '%AVS%' " 
       If len(trim(dspkey(78))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='O9' AND CODE='" & dspkey(78) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(78) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>
	<td  WIDTH="23%" height="23" bgcolor="silver">
   <select size="1" name="key78" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35" onCHANGE="Srchangemoney()">
        <%=s%>
   </select>
        </td>

    <td width="10%" class=dataListSEARCH>�Τ�t�v</td>
	<% 
	aryOption=Array("","1M","2M","3M","4M","5M","6M","7M","8M","10M","12M","15M","20M","40M","60M","70M","20M/20M")
	s=""
	'response.write "sw=" &sw& "<br>" & "accessMode=" &accessMode& "<br>" & "formvalid=" &formvalid& "<br>"
	If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
	  For i = 0 To Ubound(aryOption)
	      If dspKey(82)=aryOption(i) Then
	         sx=" selected "
	      Else
	         sx=""
	      End If
	      s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
	  Next
	Else
	  s="<option value=""" &dspKey(82) &""">" &dspKey(82) &"</option>"
	End If
	%>
    <td width="23%" bgcolor="silver" colspan=3>
        <select size="1" name="key82" class="dataListEntry">
        	<%=s%>
        </select>
	</td>
	</tr>
	
	<tr>
    <td width="10%" class=dataListSEARCH>IPTV�Τ�O</td>
    <td width="23%" bgcolor="silver">
      <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='Q8' " 
       If len(trim(dspkey(76))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='Q8' AND CODE='" & dspkey(76) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(76) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>               
        <select  size="1" name="key76" onchange="SrIPTVarChange" class="dataListEntry" ID="Select16" ><%=s%></select>
     </td>

    <td width="10%" class=dataListSEARCH>���T�ǴCIPTV���ک�b</td>
	<% 
	aryOption=Array("","Y")
	s=""
	If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
	  For i = 0 To Ubound(aryOption)
	      If dspKey(90)=aryOption(i) Then
	         sx=" selected "
	      Else
	         sx=""
	      End If
	      s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
	  Next
	Else
	  s="<option value=""" &dspKey(90) &""">" &dspKey(90) &"</option>"
	End If
	%>
    <td width="23%" bgcolor="silver" colspan=3>
        <select size="1" name="key90" class="dataListEntry">
        	<%=s%>
        </select>
	</td>

    </TR>
	 
     <tr>
  <td  WIDTH="10%"  class="dataListHEAD" height="23">ú�O�g��</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  and len(trim(dspkey(33)))=0 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M8' and code in ('01','02','03','05','06') " 
       If len(trim(dspkey(58))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M8' AND CODE='" & dspkey(58) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(58) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key58" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35" onCHANGE="Srchangemoney()">
        <%=s%>
   </select>
        </td>        
  <td  WIDTH="10%"  class="dataListHEAD" height="23">ú�O�覡</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  and len(trim(dspkey(33)))=0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M9' " 
       If len(trim(dspkey(28))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M9' AND CODE='" & dspkey(28) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(28) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key28" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35" onchange="SrSHOWcreditcardOnClick">                                                                  
        <%=s%>
   </select>
        </td>   
         <td  WIDTH="10%"  class="dataListHEAD" height="23">������ڪ��B</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >   
             <input type="text" name="key69"  size="8" value="<%=dspKey(69)%>" <%=fieldpa%><%=fieldpC%><%=fieldpE%> <%=fieldRole(1)%> class="dataListENTRY" ID="Text56">
        </TD>
  </tr>          
    <tr>
    <td colspan=6>
    <%
    if dspkey(28)<> "01" then 
       show=" style=""display:none"" "
    else
       show=""
    end if
    %>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tab1" <%=show%>><tr>
     <td  WIDTH="10%" class="dataListHEAD" height="23">�H�Υd����</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >   
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  and len(trim(dspkey(33)))=0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M6' " 
       If len(trim(dspkey(59))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='M6' AND CODE='" & dspkey(59) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(59) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key59" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
        <%=s%>
   </select>        
        </td>
   <td  WIDTH="10%"  class="dataListHEAD" height="23">�o�d�Ȧ�</td>               
        <td WIDTH="23%"  height="23" bgcolor="silver" >          
        <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  and len(trim(dspkey(33)))=0  Then  
       sql="SELECT * FROM RTBANK WHERE CREDITCARD='Y' ORDER BY HEADNC " 
       If len(trim(dspkey(60))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT * FROM RTBANK WHERE HEADNO='" & dspkey(60) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("HEADNO")=dspkey(60) Then sx=" selected "
       s=s &"<option value=""" &rs("HEADNO") &"""" &sx &">" &rs("HEADNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
        <%=s%>
   </select>        
        </TD> 
        <td WIDTH="10%"   class="dataListHEAD" height="23">�d��</td>               
        <td WIDTH="23%" height="23" bgcolor="silver" >
        <%IF ACCESSMODE="A" THEN
             XTYPE="text"
          else
             XTYPE="password"
          end if
        %>     
        <input type="<%=xtype%>" name="key61" size="20" value="<%=dspKey(61)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListEntry" maxlength="16">
        </TD>     
        </tr>    
   <TR>
           <td   class="dataListHEAD" height="23">���d�H�m�W</td>               
        <td   height="23" bgcolor="silver" >     
        <input type="text" name="key62" size="12" value="<%=dspKey(62)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListEntry" maxlength="30">
        <input type="radio" name="rd5"  <%=fieldpb%> onClick="SrAddrEqual5()"><font SIZE=2>�P�ӽФH</font>
        </TD>     
         <td    class="dataListHEAD" height="23">�H�Υd���Ĵ���</td>               
        <td   height="23" bgcolor="silver" COLSPAN=3>     
        <input type="text" name="key63" size="2" value="<%=dspKey(63)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListEntry" maxlength="2">
        <FONT SIZE=2>���</FONT>
        <input type="text" name="key64" size="2" value="<%=dspKey(64)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListEntry" maxlength="2">
        <FONT SIZE=2>�~(�褸�~��G�X�A�p2005�h��J05)</FONT>
        </TD>     
        </tr></table></td>
   </TR>                 
   <TR>
           <td   class="dataListHEAD" height="23">�����b�ڽs��</td>               
        <td   height="23" bgcolor="silver" >     
        <input type="text" name="key70" size="15" READONLY value="<%=dspKey(70)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListDATA" maxlength="30">
        </TD>     
         <td    class="dataListHEAD" height="23">�������b�ڤ�</td>               
        <td   height="23" bgcolor="silver" >     
        <input type="text" name="key71" size="25" value="<%=dspKey(71)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListDATA" maxlength="10">
        </TD>     
<td  WIDTH="10%"  class="dataListSEARCH" height="23">�˾��O</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >   
        <input type="text" name="key77"  size="8" <%=fieldpa%> <%=fieldpc%><%=fieldpe%> value="<%=dspKey(77)%>"  <%=fieldRole(1)%> class="datalistentry" ID="Text56">
        </TD>
   </TR>                 
  </table>     
  </DIV>


    <DIV ID="SRTAG1" onclick="srtag1" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="CENTER">�O�Ҫ�����</td></tr></table></div>
    
     <DIV ID=SRTAB1>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">
<!--	 
 	<tr>
		<td WIDTH="10%" class="dataListHEAD" height="23">�G�u�}�o�H��</td>
		<td width="23%" colspan=5>
			<input type="text" name="key57" value="<%=dspKey(57)%>" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListentry" ID="Text50">
			<input type="BUTTON" id="B57" name="B57" style="Z-INDEX: 1" <%=fieldpb%> value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  alt="�M��" id="C57" <%=fieldpb%> name="C57" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=SrGetEmployeeName(dspKey(57))%></font>
		</td>
	</tr>
-->

<!--
 	<tr><td width="10%" class="dataListHead">�O�Ҫ��~��</td>                    
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L6' " 
			If len(trim(dspkey(55))) < 1 Then
				sx=" selected " 
			else
				sx=""
			end if     
			Else
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L6' AND CODE='" & dspkey(55) &"' " 
			End If
			rs.Open sql,conn
			s=""
			s=s &"<option value=""" &"""" &sx &"></option>"
			sx=""
			Do While Not rs.Eof
			If rs("CODE")=dspkey(55) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
        <td width="23%" bgcolor="silver">
          <select name="key55" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> size="1"
                  maxlength="8" class="dataListEntry" ID="Select3"><%=s%></select>
		</td>
-->
        <td width="10%" class="dataListHead">�O�Ҫ��Ǹ�</td>
        <td width="23%" bgcolor="silver">
		  <!--
          <input type="text" name="key56" size="13" Readonly value="<%=dspKey(56)%>" <%=fieldRole(1)%><%=fieldPg%><%=dataProtect%> class="dataListData">
			 -->
			 <input type="text" name="key56" size="13" value="<%=dspKey(56)%>"  class="dataListEntry">
		</td>
		
		<td  class="dataListHEAD" height="23">�O�Ҫ����ڦC�L�H</td>                                 
			<td  height="23" bgcolor="silver">
				<input type="text" name="key81" size="10" READONLY value="<%=dspKey(81)%>" class="dataListDATA" ID="Text1">
				<font size=2>
				<%
					if trim(len(dspKey(81))) =6 then
						response.Write SrGetEmployeeName(dspKey(81))
					else 
						sql="SELECT shortnc FROM RTObj where cusid ='" &dspKey(81)&"' "
						rs.Open sql,conn
						Do While Not rs.Eof
							response.Write rs("shortnc")
							rs.MoveNext
						Loop
						rs.Close
					end if
				%>
				</font>
		</td>
			
        <td  class="dataListHEAD" height="23">�O�Ҫ����ڦC�L��</td>                                 
        <td  height="23" bgcolor="silver">
			<input type="text" name="key80" size="25" READONLY value="<%=dspKey(80)%>" <%=fieldPg%><%=fieldRole(1)%> class="dataListDATA">
        </td>       
	</tr>

       <tr>
        <td width="10%" class="dataListHead">�O�Ҫ�</td>                    
        <td width="23%" bgcolor="silver">
          <input type="text" name="key54" size="10" value="<%=dspKey(54)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="10">
		</td>

        <td width="10%" class="dataListHead">�Τ�O��CPE</td>                    
	<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='P2' " 
       If len(trim(dspkey(79))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='P2' AND CODE='" & dspkey(79) &"' " 
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(79) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
        <td width="23%" bgcolor="silver" >
          <select name="key79" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>
		</td>

	  <td  WIDTH="10%"  class="dataListHEAD" height="23">�Τ�O��STB</td>
	  <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='Q9' " 
       If len(trim(dspkey(67))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='Q9' AND CODE='" & dspkey(67) &"' " 
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(67) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
        <td width="23%" bgcolor="silver" >
          <select name="key67" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>
		</td>
	  </tr>
	  
       <tr><td  WIDTH="10%" class="dataListHEAD" height="23">�O�Ҫ��h�٤�</td>
        <td  WIDTH="23%" height="23" bgcolor="silver"  colspan=5>
			<input type="text" name="key83" size="12" READONLY value="<%=dspKey(83)%>" <%=fieldpC%> <%=fieldRole(1)%> class="dataListentry" ID="Text56" >
			<input type="button" id="B83"  name="B83" height="100%" width="100%" <%=fieldpD%> style="Z-INDEX: 1" value="...." onclick="SrBtn33OnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C83"  name="C83"   <%=fieldpD%> style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Sr33Clear">
		</td
	  </tr>
  </table>

  </DIV> 
    </DIV>   
 <DIV ID="SRTAG2" onclick="srtag2" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
    <tr>    <td bgcolor="BDB76B" align="CENTER">������T</td></tr></table></DIV>
    <DIV ID=SRTAB2 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
     <tr>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">COT Out</td>
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key84" size="12" value="<%=dspKey(84)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="10">
        </td>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">COT In</td>
        <td  WIDTH="23%" height="23" bgcolor="silver">
			<input type="text" name="key85" size="12" value="<%=dspKey(85)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="12">
        </td>
	<td  WIDTH="10%"  class="dataListHEAD" height="23">MDF</td>               
    <td  WIDTH="23%" height="23" bgcolor="silver" >
		<input type="text" name="key66" size="12"  value="<%=dspKey(66)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="10">
    </td>
	</tr>
    <tr>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">�Τ�IP</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			  <input type="text" name="key47" size="3" value="<%=dspKey(47)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3">.
			  <input type="text" name="key73" size="3" value="<%=dspKey(73)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3">.
			  <input type="text" name="key74" size="3" value="<%=dspKey(74)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3">.
			  <input type="text" name="key75" size="3" value="<%=dspKey(75)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3">
        </TD>                        
		<td  WIDTH="10%"  class="dataListHEAD" height="23">�Τ�CPE Mac</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key48" size="15" value="<%=ucase(dspKey(48))%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="12">
        </TD>
    </TR>
     <tr>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">�Τ�STB IP</td>
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key86" size="18" value="<%=dspKey(86)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="15">
        </td>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">�Τ�STB Mac</td>
        <td  WIDTH="23%" height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key87" size="15" value="<%=dspKey(87)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="12">
        </td>
	</tr>
     <tr>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">PPPoE �b��</td>
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key88" size="18" value="<%=dspKey(88)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="15">
        </td>
		<td  WIDTH="10%"  class="dataListHEAD" height="23">PPPoE �K�X</td>
        <td  WIDTH="23%" height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key89" size="18" value="<%=dspKey(89)%>" <%=fieldRole(1)%> class="dataListEntry" maxlength="15">
        </td>
	</tr>
	</TABLE>
  </DIV>   

<DIV ID="SRTAG4" onclick="srtag4" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="CENTER">�Τ�ӽСB���ʤάI�u�i�ת��A</td></tr></table>
   </DIV>

    <DIV ID=SRTAB4 >  
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
	<tr><td  WIDTH="10%" class="dataListHEAD" height="23">���u���</td>                                 
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key31" size="12" READONLY value="<%=dspKey(31)%>" class="dataListdata" ID="Text57">
        </td>

        <td  WIDTH="10%" class="dataListHEAD" height="23">�������</td>                                 
        <td  WIDTH="23%" height="23" bgcolor="silver">
	        <input type="text" name="key32" size="12" READONLY value="<%=dspKey(32)%>" class="dataListdata" ID="Text57">
			<input type="button" height="100%" width="100%" id="B32" name="B32" onclick="SrBtnOnClick" <%=fieldPh%> style="Z-INDEX: 1" value="....">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C32" name="C32" onclick="SrClear" <%=fieldPh%> style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut">
        </td>

        <td  WIDTH="10%" class="dataListHEAD" height="23">�}�l�p�O��</td>                                 
        <td  WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key33" size="12" READONLY value="<%=dspKey(33)%>" <%=fieldpC%> <%=fieldRole(1)%> class="dataListentry" ID="Text56" >
			<input type="button" id="B33"  name="B33" height="100%" width="100%" <%=fieldpD%> style="Z-INDEX: 1" value="...." onclick="SrBtn33OnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C33"  name="C33"   <%=fieldpD%> style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Sr33Clear">
		</td
	</TR>
	
	<tr><td  WIDTH="10%" class="dataListHEAD" height="23">�̪�����p�O��</td>                                 
        <td  WIDTH="23%" height="23" bgcolor="silver">
			<input type="text" name="key65" size="12" READONLY value="<%=dspKey(65)%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text3">
			<!-- <input type="button" id="B65"  name="B65" height="100%" width="100%" <%=fieldpD%>style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C65"  name="C65"   <%=fieldpD%>style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
			-->
        </TD>

		<td  WIDTH="10%"  class="dataListHEAD" height="23">�i�ϥδ���</td>               
        <td  WIDTH="23%" height="23" bgcolor="silver" >   
			<input type="text" name="key49" size="3" readonly value="<%=dspKey(49)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListDATA" maxlength="3" onchange="srrecalulate()">
			<FONT SIZE=2>�@�վ���</FONT>
			<input type="text" name="key68" size="3" readonly value="<%=dspKey(68)%>" <%=fieldRole(1)%><%=fieldpa%><%=dataProtect%> class="dataListdata" maxlength="3" onchange="srrecalulate()">
        </td>
 
		<td  WIDTH="10%" class="dataListHEAD" height="23">�ϥκI���</td>                                 
		<td  WIDTH="23%" height="23" bgcolor="silver">
			<input type="text" name="key50" size="12" READONLY value="<%=dspKey(50)%>" <%=fieldRole(1)%> class="dataListDATA" ID="Text56">
		</TD>
	</tr> 
	
	<tr><td WIDTH="10%"  class="dataListHEAD" height="23">�h����</td>                                 
		<td WIDTH="23%"  height="23" bgcolor="silver" >
			<input type="text" name="key37" size="12" READONLY value="<%=dspKey(37)%>" <%=fieldpe%> <%=fieldRole(1)%> class="dataListdata" ID="Text6">
			<!--  
			<input type="button" id="B37"  name="B37" height="100%" width="100%" <%=fieldpf%>style="Z-INDEX: 1" value="...." onclick="SrBtn33OnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C37"  name="C37"   <%=fieldpf%>style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Sr33Clear">     
			<font size=2>��O�J</font> 
			<input type="text" name="key39" size="2" value="<%=dspKey(39)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text10">
			-->
       </td>
		
		<td  WIDTH="10%" class="dataListSEARCH" height="23">�Ѿl�i�ϥΤ��</td>
		<td  WIDTH="23%" height="23" bgcolor="silver" colspan=3 >
			<%   if dspkey(65) <> "" then
					dspkey(50) = dateadd("m",dspkey(49),dspkey(65))
				elseif dspkey(33) <> "" then
					dspkey(50) = dateadd("m",dspkey(49),dspkey(33))
				else
					dspkey(50) = ""
				end if
				if dspkey(50) <> ""  then
					REMAINDAY = DATEDIFF("d",DATEVALUE(now()),dspkey(50))
				else
					REMAINDAY = 0
				end if
				if dspkey(37) <> "" then
					if datevalue(now()) <= dspkey(37) then
					REMAINDAY=DATEDIFF("d",DATEVALUE(now()),DSPKEY(37))
					else
					remainday=0
					end if
				end if
				if remainday < 0 then remainday=0
			%>
          <input type="text" name="remain" size="5" READONLY value="<%=remainday%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text5">
          <FONT SIZE=2> ��</FONT>
		</TD>
		<!--
		<td class="dataListHEAD" height="23">�I�u�i��</td>                                 
        <td height="23" bgcolor="silver">
			<% name=""
			if dspkey(30) <> "" then
				sqlxx=" select * from RTCODE where KIND='H3' and CODE='" & dspkey(30) & "' "
				rs.Open sqlxx,conn
				if rs.eof then
					name=""
				else
					name=rs("codenc")
				end if
				rs.close
			end if
			%>                   
			<input type="text" name="key30" size="3" value="<%=dspKey(30)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListdata" READONLY ID="Text12">
			<font size=2><%=name%></font>
        </td>
		-->
	</tr>
	


	</table> 
	</DIV>

    <DIV ID="SRTAG5" onclick="SRTAG5" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
    <tr><td bgcolor="BDB76B" align="CENTER">�Ƶ�����</td></tr></table></DIV>
   <DIV ID="SRTAB5" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <TR><TD align="CENTER">
     <TEXTAREA  cols="100%"  name="key44" rows=8  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(44)%>" ID="Textarea1"><%=dspkey(44)%></TEXTAREA>
   </td></tr>
 </table> 
</div>
  <% Set rsxx=Server.CreateObject("ADODB.Recordset")
     sqlfaqlist="SELECT COUNT(*) AS CNT FROM RTLessorAVSCustFaqH WHERE CUSID='" & DSPKEY(2) & "' AND CANCELDAT IS NULL "
     rsxx.open sqlfaqlist,conn
     IF RSXX("CNT") > 0 THEN
        XXFAQFLAG="Y"
     ELSE
        XXFAQFLAG=""
     END IF
     RSXX.CLOSE
     SET RSXX=NOTHING
   %>
    <% if XXFAQFLAG = "Y" then %>
  <DIV ID="SRTAG6" onclick="SRTAG6" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
    <tr><td bgcolor="BDB76B" align="CENTER">�Ȥ�A�ȳ�</td></tr></table></DIV>
    <DIV ID="SRTAB6" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr class="dataListsearch"><td colspan=15 align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustFaqK.asp?V=<%=XRND%>&accessMode=U&key=<%=DSPKEY(0)%>;<%=DSPKEY(1)%>;<%=DSPKEY(2)%>;" TARGET="NEWWINDOW" ><FONT COLOR=WHITE>�Ȥ�A�ȳ����</FONT></A></td></tr>
    <tr class="dataListHEAD" align=center><td>�ȪA�渹</td><td>�ӹq��</td><td>����</td><td>�K�n</td><td>�s���q��</td><td>��ʹq��</td><td>���u��</td><td>���u��</td><td>���u�渹</td><td>���u����</td><td>�ȪA�^��</td><td>�^�Э�</td><td>�ȪA����</td><td>���׭�</td><td>�B�z<br>�Ѽ�</td></tr>
    <%
           Set rsxx=Server.CreateObject("ADODB.Recordset")
           sqlfaqlist="SELECT RTLessorAVSCustFaqH.CUSID,RTLessorAVSCustFaqH.FAQNO,RTLessorAVSCustFaqH.RCVDAT, RTCode.CODENC, " _
                     &"LEFT(RTLessorAVSCustFaqH.MEMO, 15) AS memo15,RTLessorAVSCustFaqH.CONTACTTEL, RTLessorAVSCustFaqH.MOBILE, " _
                     &"RTLessorAVSCustFaqH.SNDWORK, RTObj_4.CUSNC AS CUSNC1, RTLessorAVSCustFaqH.SNDPRTNO, " _
                     &"RTLessorAVSCustFaqH.SNDCLOSEDAT, RTLessorAVSCustFaqH.CALLBACKDAT, " _
                     &"RTObj_5.CUSNC AS CUSNC2, RTLessorAVSCustFaqH.FINISHDAT, RTObj_6.CUSNC AS CUSNC3, " _
                     &"RTObj_1.CUSNC AS CUSNC4, RTObj_2.CUSNC AS CUSNC5, " _
                     &"RTObj_3.CUSNC AS CUSNC6, CASE WHEN RTLessorAVSCustFaqH.finishdat IS NULL THEN " _
                     &"datediff(dd, RTLessorAVSCustFaqH.rcvdat, getdate()) + 1 ELSE " _
                     &"datediff(dd, RTLessorAVSCustFaqH.rcvdat, RTLessorAVSCustFaqH.finishdat) + 1 END AS PROCESSDAT " _
                     &"FROM RTEmployee RTEmployee_5 INNER JOIN RTObj RTObj_5 ON RTEmployee_5.CUSID = RTObj_5.CUSID " _
                     &"RIGHT OUTER JOIN RTLessorAVSCustFaqH ON RTEmployee_5.EMPLY = RTLessorAVSCustFaqH.CALLBACKUSR " _
                     &"LEFT OUTER JOIN RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_4 ON RTEmployee_4.CUSID = " _
                     &"RTObj_4.CUSID ON RTLessorAVSCustFaqH.SNDUSR = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
                     &"RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON " _
                     &"RTLessorAVSCustFaqH.UUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN " _
                     &"RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON RTLessorAVSCustFaqH.EUSR = RTEmployee_2.EMPLY " _
                     &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                     &"RTObj_1.CUSID ON RTLessorAVSCustFaqH.CANCELUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                     &"RTObj RTObj_6 INNER JOIN RTEmployee RTEmployee_6 ON RTObj_6.CUSID = RTEmployee_6.CUSID ON " _
                     &"RTLessorAVSCustFaqH.FUSR = RTEmployee_6.EMPLY LEFT OUTER JOIN RTCode ON " _
                     &"RTLessorAVSCustFaqH.SERVICETYPE = RTCode.CODE AND RTCode.KIND = 'N4' " _
                     &"WHERE    RTLessorAVSCustFaqH.cusid = '" & DSPKEY(2) & "' AND RTLessorAVSCustFaqH.canceldat IS NULL " 
           rsxx.open sqlfaqlist,conn
           Randomize
           XRND=RND()
           do until rsxx.eof %>
           <tr class="dataListentry" >
           <td><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustFaqD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("FAQNO")%>;" TARGET="NEWWINDOW" ><%=RSXX("FAQNO")%></A></td>
           <td align=center><%=rsxx("RCVDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("CODENC")%>&nbsp;</td>
           <td><%=rsxx("memo15")%>&nbsp;</td>
           <td><%=rsxx("CONTACTTEL")%>&nbsp;</td>
           <td><%=rsxx("MOBILE")%>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("SNDWORK")) then
              xxSNDWORK=""
           else
              xxSNDWORK=datevalue(rsxx("SNDWORK"))
           end if
           %>
           <%=xxSNDWORK%>&nbsp;</td>
           <td align=center><%=rsxx("CUSNC1")%>&nbsp;</td>
           <td>
           <% if len(trim(RSXX("SNDPRTNO"))) > 0 then %>
           <A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustfaqsndworkD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("faqno")%>;<%=RSXX("SNDPRTNO")%>" TARGET="NEWWINDOW" ><%=rsxx("SNDPRTNO")%>&nbsp;</a>
           <% else %>
           &nbsp;
           <%end if %>
           </td>
           <td align=center>
           <%
           if isnull(rsxx("SNDclosedat")) then
              xxsndclosedat=""
           else
              xxsndclosedat=datevalue(rsxx("SNDclosedat"))
           end if
           %>
           <%=xxsndclosedat%>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("CALLBACKDAT")) then
              xxcallbackdat=""
           else
              xxcallbackdat=datevalue(rsxx("CALLBACKDAT"))
           end if
           %>
           <%=xxcallbackdat%>&nbsp;</td>
           <td align=center><%=rsxx("CUSNC2")%>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("FINISHDAT")) then
              xxFINISHDAT=""
           else
              xxFINISHDAT=datevalue(rsxx("FINISHDAT"))
           end if
           %>
           <%=xxFINISHDAT%>&nbsp;</td>
           <td align=center><%=rsxx("CUSNC3")%>&nbsp;</td>
           <td align=right><%=rsxx("PROCESSDAT")%>&nbsp;</td>
           </tr>           
        <% rsxx.MoveNext
           loop    
           rsxx.close
           set rsxx=nothing
      %>
      </table>
  </div>   
 <%END IF %>
  <% Set rsxx=Server.CreateObject("ADODB.Recordset")
     sqlfaqlist="SELECT COUNT(*) AS CNT FROM RTLessorAVSCustCont WHERE CUSID='" & DSPKEY(2) & "' AND CANCELDAT IS NULL "
     rsxx.open sqlfaqlist,conn
     IF RSXX("CNT") > 0 THEN
        XXCONTFLAG="Y"
     ELSE
        XXCONTFLAG=""
     END IF
     RSXX.CLOSE
     SET RSXX=NOTHING
   %>
   <% if XXCONTFLAG = "Y" then %>
  <DIV ID="SRTAG7" onclick="SRTAG7" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="CENTER">�Ȥ������</td></tr></table></DIV>
    <DIV ID="SRTAB7" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr class="dataListsearch"><td colspan=13 align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustCONTK.asp?V=<%=XRND%>&accessMode=U&key=<%=DSPKEY(0)%>;<%=DSPKEY(1)%>;<%=DSPKEY(2)%>;" TARGET="NEWWINDOW" ><FONT COLOR=WHITE>�Ȥ���������</FONT></A></td></tr>
    <tr class="dataListHEAD" align=center><td>�Ȥ�N��+����</td><td>����ӽФ�</td><td>�}�l�p�O��</td><td>ú�O<br>�g��</td><td>ú�O<br>�覡</td><td>�i��<br>����</td><td>�ĤG��</td><td>����<br>���B</td><td>�ꦬ<br>���B</td><td>������<br>�b�ڤ�</td><td>�b�ڽs��</td><td>���<br>���פ�</td><td>�B�z<br>�Ѽ�</td></tr>
    <%
           Set rsxx=Server.CreateObject("ADODB.Recordset")
           sqlfaqlist="SELECT RTLessorAVSCustCont.CUSID, RTLessorAVSCustCont.ENTRYNO,RTLessorAVSCust.CUSNC, " _
                     &"RTLessorAVSCustCont.ENTRYNO AS ENTRYNO, RTLessorAVSCustCont.APPLYDAT, RTLessorAVSCustCont.STRBILLINGDAT, " _
                     &"RTCode_2.CODENC AS PAYCYCLE, RTCode_1.CODENC AS PAYTYPE, RTLessorAVSCustCont.PERIOD, RTLessorAVSCustCont.SECONDCASE, " _
                     &"RTLessorAVSCustCont.AMT, RTLessorAVSCustCont.REALAMT, RTLessorAVSCustCont.TARDAT, RTLessorAVSCustCont.BATCHNO, " _
                     &"RTLessorAVSCustCont.FINISHDAT, " _
                     &"CASE WHEN RTLessorAVSCustCont.FINISHDAT IS NULL THEN DATEDIFF(dd,RTLessorAVSCustCont.APPLYDAT,getdate())+1 ELSE DATEDIFF(dd,RTLessorAVSCustCont.APPLYDAT,RTLessorAVSCustCont.finishdat)+1  END AS PROCESSDAT " _ 
                     &"FROM RTLessorAVSCustCont LEFT OUTER JOIN RTCode RTCode_1 ON RTLessorAVSCustCont.PAYTYPE = RTCode_1.CODE " _
                     &"AND RTCode_1.KIND = 'M9' LEFT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCustCont.CUSID = " _
                     &"RTLessorAVSCust.CUSID LEFT OUTER JOIN RTCode RTCode_2 ON RTLessorAVSCustCont.PAYCYCLE = RTCode_2.CODE " _
                     &"AND RTCode_2.KIND = 'M8' " _
                     &"WHERE    RTLessorAVSCustCont.cusid = '" & DSPKEY(2) & "' AND RTLessorAVSCustCont.canceldat IS NULL " 
           rsxx.open sqlfaqlist,conn
           Randomize
           XRND=RND()
           do until rsxx.eof %>
           <tr class="dataListentry">
           <td align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustContD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("ENTRYNO")%>;" TARGET="NEWWINDOW" ><%=RSXX("CUSID")%>-<%=RSXX("ENTRYNO")%></A></td>
           <td align=center><%=rsxx("APPLYDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("STRBILLINGDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("PAYCYCLE")%>&nbsp;</td>
           <td align=center><%=rsxx("PAYTYPE")%>&nbsp;</td>
           <td align=right><%=rsxx("PERIOD")%>&nbsp;</td>
           <td align=center><%=rsxx("SECONDCASE")%>&nbsp;</td>
           <td align=right><%=rsxx("AMT")%>&nbsp;</td>
           <td align=right><%=rsxx("REALAMT")%>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("TARDAT")) then
              xxTARDAT=""
           else
              xxTARDAT=datevalue(rsxx("TARDAT"))
           end if
           %>
           <%=xxTARDAT%>&nbsp;</td>
           <td align=center>
           <%if len(trim(RSXX("BATCHNO"))) > 0 then %>
           <A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustARDTLK.ASP?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("BATCHNO")%>;" TARGET="NEWWINDOW" ><%=rsxx("BATCHNO")%>&nbsp;</td>
           <% else %>
           &nbsp;
           <%end if %>
           <td align=center>
           <%
           if isnull(rsxx("FINISHDAT")) then
              xxFINISHDAT=""
           else
              xxFINISHDAT=datevalue(rsxx("FINISHDAT"))
           end if
           %>
           <%=xxFINISHDAT%>&nbsp;</td>
           <td align=right><%=rsxx("processdat")%>&nbsp;</td>
           </tr>           
        <% rsxx.MoveNext
           loop    
           rsxx.close
           set rsxx=nothing
      %>
      </table>
  </div>   
 <%END IF %> 
  <% Set rsxx=Server.CreateObject("ADODB.Recordset")
     sqlfaqlist="SELECT COUNT(*) AS CNT FROM RTLessorAVSCustDrop WHERE CUSID='" & DSPKEY(2) & "' AND CANCELDAT IS NULL "
     rsxx.open sqlfaqlist,conn
     IF RSXX("CNT") > 0 THEN
        XXdropFLAG="Y"
     ELSE
        XXdropFLAG=""
     END IF
     RSXX.CLOSE
     SET RSXX=NOTHING
   %>
   <% if XXdropFLAG = "Y" then %>
  <DIV ID="SRTAG10" onclick="SRTAG10" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="CENTER">�Ȥ�h����</td></tr></table></DIV>
    <DIV ID="SRTAB10" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr class="dataListsearch"><td colspan=13 align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustdropK.asp?V=<%=XRND%>&accessMode=U&key=<%=DSPKEY(0)%>;<%=DSPKEY(1)%>;<%=DSPKEY(2)%>" TARGET="NEWWINDOW" ><FONT COLOR=WHITE>�Ȥ�h�������</FONT></A></td></tr>
    <tr class="dataListHEAD" align=center><td>�Ȥ�N��+����</td><td>�h������</td><td>�h���ӽФ�</td><td>�w�w�h����</td><td>�h�����פ�</td><td>���פH��</td><td>����u��</td><td>�������</td><td>������פ�</td><td>�B�z<br>�Ѽ�</td></tr>
    <%
           Set rsxx=Server.CreateObject("ADODB.Recordset")
           sqlfaqlist="SELECT  RTLessorAVSCustDrop.CUSID,RTLessorAVSCustDrop.ENTRYNO,RTCODE.CODENC,RTLessorAVSCustDrop.APPLYDAT," _
                   &"RTLessorAVSCustDrop.ENDDAT,RTLessorAVSCustDrop.FINISHDAT, RTObj.CUSNC as cusnc1, RTLessorAVSCustDrop.SNDPRTNO, " _
                   &"RTLessorAVSCustDrop.SNDWORK,RTLessorAVSCustDrop.SNDWORKCLOSE,RTLessorAVSCustDrop.tardat," _
                   &"RTLessorAVSCustDrop.batchno, RTLessorAVSCustDrop.CANCELDAT, " _
                   &"RTObj_1.CUSNC  as cusnc2, RTObj_2.CUSNC  as cusnc3, RTObj_3.CUSNC  as cusnc4, " _
                   &"case when RTLessorAVSCustDrop.FINISHDAT is null then DATEDIFF(dd,RTLessorAVSCustDrop.APPLYDAT,getdate())+1 else DATEDIFF(dd,RTLessorAVSCustDrop.APPLYDAT,RTLessorAVSCustDrop.FINISHDAT)+1 end as processdat " _
                   &"FROM RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID RIGHT OUTER JOIN " _
                   &"RTLessorAVSCustDrop ON RTEmployee_3.EMPLY = RTLessorAVSCustDrop.UUSR LEFT OUTER JOIN " _
                   &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON " _
                   &"RTLessorAVSCustDrop.EUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
                   &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorAVSCustDrop.CANCELUSR = " _
                   &"RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
                   &"RTLessorAVSCustDrop.FUSR = RTEmployee.EMPLY  LEFT OUTER JOIN RTCODE ON RTLessorAVSCustDrop.DROPKIND=RTCODE.CODE AND RTCODE.KIND='N7' " _
                   &"where RTLessorAVSCustDrop.cusid='" & dspkey(2) & "' AND RTLessorAVSCustDrop.canceldat is null "
           rsxx.open sqlfaqlist,conn
           Randomize
           XRND=RND()
           do until rsxx.eof %>
           <tr class="dataListentry">
           <td align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustdropD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("ENTRYNO")%>;" TARGET="NEWWINDOW" ><%=RSXX("CUSID")%>-<%=RSXX("ENTRYNO")%></A></td>
           <td align=center><%=rsxx("CODENC")%>&nbsp;</td>
           <td align=center><%=rsxx("APPLYDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("ENDDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("FINISHDAT")%>&nbsp;</td>
           <td align=right><%=rsxx("cusnc1")%>&nbsp;</td>
           <td align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustdropsndworkD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("ENTRYNO")%>;<%=RSXX("SNDPRTNO")%>" TARGET="NEWWINDOW" ><%=rsxx("SNDPRTNO")%>&nbsp;</A></td>
           <td align=right>
           <%
           if isnull(rsxx("SNDWORK")) then
              xxSNDWORK=""
           else
              xxSNDWORK=datevalue(rsxx("SNDWORK"))
           end if
           %>
           <%=xxSNDWORK%>&nbsp;</td>
           <td align=right>
           <%
           if isnull(rsxx("SNDWORKCLOSE")) then
              xxSNDWORKCLOSE=""
           else
              xxSNDWORKCLOSE=datevalue(rsxx("SNDWORKCLOSE"))
           end if
           %>
           <%=xxSNDWORKCLOSE%>&nbsp;</td>
           <td align=right><%=rsxx("processdat")%>&nbsp;</td>
           </tr>           
        <% rsxx.MoveNext
           loop    
           rsxx.close
           set rsxx=nothing
      %>
      </table>
  </div>   
 <%END IF %>  
  <% Set rsxx=Server.CreateObject("ADODB.Recordset")
     sqlfaqlist="SELECT COUNT(*) AS CNT FROM RTLessorAVSCustReturn WHERE CUSID='" & DSPKEY(2) & "' AND CANCELDAT IS NULL "
     rsxx.open sqlfaqlist,conn
     IF RSXX("CNT") > 0 THEN
        XXreturnFLAG="Y"
     ELSE
        XXreturnFLAG=""
     END IF
     RSXX.CLOSE
     SET RSXX=NOTHING
   %>
   <% if XXreturnFLAG = "Y" then %>
  <DIV ID="SRTAG8" onclick="SRTAG8" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="CENTER">�Ȥ�_����</td></tr></table></DIV>
    <DIV ID="SRTAB8" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr class="dataListsearch"><td colspan=13 align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustRETURNK.asp?V=<%=XRND%>&accessMode=U&key=<%=DSPKEY(0)%>;<%=DSPKEY(1)%>;<%=DSPKEY(2)%>;" TARGET="NEWWINDOW" ><FONT COLOR=WHITE>�Ȥ�_�������</FONT></A></td></tr>
    <tr class="dataListHEAD" align=center><td>�Ȥ�N��+����</td><td>�_��<br>�ӽФ�</td><td>�}�l<br>�p�O��</td><td>ú�O<br>�g��</td><td>ú�O<br>�覡</td><td>�i��<br>����</td><td>�ĤG��</td><td>����<br>���B</td><td>�ꦬ<br>���B</td><td>������<br>�b�ڤ�</td><td>�b�ڽs��</td><td>�_��<br>���פ�</td><td>�B�z<br>�Ѽ�</td></tr>
    <%
           Set rsxx=Server.CreateObject("ADODB.Recordset")
           sqlfaqlist="SELECT RTLessorAVSCustReturn.CUSID, RTLessorAVSCustReturn.ENTRYNO,RTLessorAVSCust.CUSNC, " _
                     &"RTLessorAVSCustReturn.ENTRYNO AS ENTRYNO, RTLessorAVSCustReturn.APPLYDAT, RTLessorAVSCustReturn.STRBILLINGDAT, " _
                     &"RTCode_2.CODENC AS PAYCYCLE, RTCode_1.CODENC AS PAYTYPE, RTLessorAVSCustReturn.PERIOD, RTLessorAVSCustReturn.SECONDCASE, " _
                     &"RTLessorAVSCustReturn.AMT, RTLessorAVSCustReturn.REALAMT, RTLessorAVSCustReturn.TARDAT, RTLessorAVSCustReturn.BATCHNO, " _
                     &"RTLessorAVSCustReturn.FINISHDAT, " _
                     &"CASE WHEN RTLessorAVSCustReturn.FINISHDAT IS NULL THEN DATEDIFF(dd,RTLessorAVSCustReturn.APPLYDAT,getdate())+1 ELSE DATEDIFF(dd,RTLessorAVSCustReturn.APPLYDAT,RTLessorAVSCustReturn.finishdat)+1  END AS PROCESSDAT " _ 
                     &"FROM RTLessorAVSCustReturn LEFT OUTER JOIN RTCode RTCode_1 ON RTLessorAVSCustReturn.PAYTYPE = RTCode_1.CODE " _
                     &"AND RTCode_1.KIND = 'M9' LEFT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCustReturn.CUSID = " _
                     &"RTLessorAVSCust.CUSID LEFT OUTER JOIN RTCode RTCode_2 ON RTLessorAVSCustReturn.PAYCYCLE = RTCode_2.CODE " _
                     &"AND RTCode_2.KIND = 'M8' " _
                     &"WHERE    RTLessorAVSCustReturn.cusid = '" & DSPKEY(2) & "' AND RTLessorAVSCustReturn.canceldat IS NULL " 
           rsxx.open sqlfaqlist,conn
           Randomize
           XRND=RND()
           do until rsxx.eof %>
           <tr class="dataListentry">
           <td align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustContD.asp?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("ENTRYNO")%>;" TARGET="NEWWINDOW" ><%=RSXX("CUSID")%>-<%=RSXX("ENTRYNO")%></A></td>
           <td align=center><%=rsxx("APPLYDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("STRBILLINGDAT")%>&nbsp;</td>
           <td align=center><%=rsxx("PAYCYCLE")%>&nbsp;</td>
           <td align=center><%=rsxx("PAYTYPE")%>&nbsp;</td>
           <td align=right><%=rsxx("PERIOD")%>&nbsp;</td>
           <td align=center><%=rsxx("SECONDCASE")%>&nbsp;</td>
           <td align=right><%=rsxx("AMT")%>&nbsp;</td>
           <td align=right><%=rsxx("REALAMT")%>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("TARDAT")) then
              xxTARDAT=""
           else
              xxTARDAT=datevalue(rsxx("TARDAT"))
           end if
           %>
           <%=xxTARDAT%>&nbsp;</td>
           <td align=center>
           <%if len(trim(RSXX("BATCHNO"))) > 0 then %>
           <A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustARDTLK.ASP?V=<%=XRND%>&accessMode=U&key=<%=RSXX("CUSID")%>;<%=RSXX("BATCHNO")%>;" TARGET="NEWWINDOW" ><%=rsxx("BATCHNO")%>&nbsp;</td>
           <% else %>
           &nbsp;
           <%end if %>&nbsp;</td>
           <td align=center>
           <%
           if isnull(rsxx("FINISHDAT")) then
              xxFINISHDAT=""
           else
              xxFINISHDAT=datevalue(rsxx("FINISHDAT"))
           end if
           %>
           <%=xxFINISHDAT%>&nbsp;</td>
           <td align=right><%=rsxx("processdat")%>&nbsp;</td>
           </tr>           
        <% rsxx.MoveNext
           loop    
           rsxx.close
           set rsxx=nothing
      %>
      </table>
  </div>   
 <%END IF %> 
  <% Set rsxx=Server.CreateObject("ADODB.Recordset")
     sqlfaqlist="SELECT COUNT(*) AS CNT FROM RTLessorAVSCustAR WHERE CUSID='" & DSPKEY(2) & "' AND CANCELDAT IS NULL "
     rsxx.open sqlfaqlist,conn
     IF RSXX("CNT") > 0 THEN
        XXarLAG="Y"
     ELSE
        XXarLAG=""
     END IF
     RSXX.CLOSE
     SET RSXX=NOTHING
   %>
   <% if XXarLAG = "Y" then %>
  <DIV ID="SRTAG9" onclick="SRTAG9" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="CENTER">�Ȥ������I�b��</td></tr></table></DIV>
    <DIV ID="SRTAB9" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr class="dataListsearch"><td colspan=11 align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustARK.asp?V=<%=XRND%>&accessMode=U&key=<%=DSPKEY(0)%>;<%=DSPKEY(1)%>;<%=DSPKEY(2)%>;" TARGET="NEWWINDOW" ><FONT COLOR=WHITE>�������I�b�ک���</FONT></A></td></tr>
    <tr class="dataListHEAD" align=center><td>�b�ڽs��</td><td>���ͤ��</td><td>AR/AP</td><td>���Ӽ�</td><td colspan=3>���R/�w�R/���R���B</td><td>�R�߶��@</td><td>�R�߶��G</td><td>�R�b��</td></tr>
    <%
           Set rsxx=Server.CreateObject("ADODB.Recordset")
           sqlfaqlist="SELECT RTLessorAVSCustAR.CUSID, RTLessorAVSCustAR.BATCHNO, RTCode.CODENC, RTLessorAVSCustAR.PERIOD, " _
                     &"RTLessorAVSCustAR.AMT, RTLessorAVSCustAR.REALAMT, " _
                     &"CASE WHEN RTLessorAVSCustAR.CANCELDAT IS NOT NULL THEN 0 ELSE RTLessorAVSCustAR.AMT - RTLessorAVSCustAR.REALAMT END AS DIFFAMT, " _ 
                     &"RTLessorAVSCustAR.COD1, RTLessorAVSCustAR.COD2, RTLessorAVSCustAR.COD3, RTLessorAVSCustAR.COD4, RTLessorAVSCustAR.COD5," _
                     &"RTLessorAVSCustAR.CDAT, RTLessorAVSCustAR.MDAT, RTLessorAVSCustAR.CANCELDAT " _
                     &"FROM RTLessorAVSCustAR LEFT OUTER JOIN RTCode ON RTLessorAVSCustAR.ARTYPE = RTCode.CODE AND " _
                     &"RTCode.KIND = 'N2' " _
                     &"WHERE    RTLessorAVSCustAR.cusid = '" & DSPKEY(2) & "' AND RTLessorAVSCustAR.canceldat IS NULL "  _
                     &"ORDER BY RTLessorAVSCustAR.CDAT "
           rsxx.open sqlfaqlist,conn
           Randomize
           XRND=RND()
           do until rsxx.eof %>
           <tr class="dataListentry">
           <td align=center><A HREF="/webap/rtap/BASE/RTLessorAVSCMTY/RTLessorAVSCustARDTLK.ASP?V=<%=XRND%>&key=<%=RSXX("CUSID")%>;<%=RSXX("BATCHNO")%>;" TARGET="NEWWINDOW" ><%=RSXX("BATCHNO")%></A></td>
           <td align=center>
           <%
           if isnull(rsxx("CDAT")) then
              xxCDAT=""
           else
              xxCDAT=datevalue(rsxx("CDAT"))
           end if
           %>
           <%=xxCDAT%>&nbsp;</td>
           <td align=center><%=rsxx("CODENC")%>&nbsp;</td>
           <td align=right><%=rsxx("PERIOD")%>&nbsp;</td>
           <td align=right><%=rsxx("AMT")%>&nbsp;</td>
           <td align=right><%=rsxx("REALAMT")%>&nbsp;</td>
           <td align=right><%=rsxx("DIFFAMT")%>&nbsp;</td>
           <td><%=rsxx("COD1")%>&nbsp;</td>
           <td><%=rsxx("COD2")%>&nbsp;</td>
            <td align=center>
            <%
           if isnull(rsxx("mDAT")) then
              xxmDAT=""
           else
              xxmDAT=datevalue(rsxx("mDAT"))
           end if
           %>
           <%=xxmDAT%>&nbsp;</td>
           </tr>           
        <% rsxx.MoveNext
           loop    
           rsxx.close
           set rsxx=nothing
      %>
      </table>
  </div>   
 <%END IF %> 
<%
    conn.Close   
    set rs=Nothing   
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
<!-- #include virtual="/Webap/include/checkid.inc" -->
<!-- #include virtual="/Webap/include/companyid.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->