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
                   case ucase("/webap/rtap/base/EBT3G/EBT3GCUSTD.asp")
                 '      response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 0 then rs.Fields(i).Value=dspKey(i)    
                       if i=0 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         cusidxx="G" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
                         rsc.open "select max(cusid) AS cusid from EBT3GCUST where cusid like '" & cusidxx & "%' " ,conn
                         if len(rsc("cusid")) > 0 then
                            dspkey(0)=cusidxx & right("000" & cstr(cint(right(rsc("cusid"),3)) + 1),3)
                         else
                            dspkey(0)=cusidxx & "001"
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
                 case ucase("/webap/rtap/base/EBT3G/EBT3GCUSTD.asp")
                  ' response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     if i<>0  then rs.Fields(i).Value=dspKey(i)         
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
       if ucase(runpgm)=ucase("/webap/rtap/base/EBT3G/EBT3GCUSTD.asp") then
          cusidxx="G" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
          rsc.open "select max(cusid) AS cusid from EBT3Gcust where cusid like '" & cusidxx & "%' " ,conn
          if not rsC.eof then
            dspkey(0)=rsC("CUSID")
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
<input type="text" name="sw" value="<%=sw%>" style="display:none;" ID="Text17" size="20">
<input type="text" name="reNew" value="N" style="display:none;" ID="Text18" size="20">
<input type="text" name="rwCnt" value="<%=rwCnt%>" style="display:none;" ID="Text19" size="20">
<input type="text" name="accessMode" value="<%=accessMode%>" style="display:none;" ID="Text20" size="20">
<table width="100%" ID="Table1">
  <tr class=dataListTitle><td width="20%">�@</td><td width="60%" align=center>
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
  title="�F�˦�ʹq�ܥΤ��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT  CUSID, CUSNC, SOCIALID, CUSTTYPE, CUSNE, MOBILE, APFORMDAT, SEX, MACHINECODE, CUSBIRTHDAY, " _
             &"CUSSOCIALCARDDAT, COBOSS, COTEL11, COTEL12, COTEL13, BOSSSOCIALID, BOSSHOMETEL11, BOSSHOMETEL12, " _
             &"BOSSOTHERTEL2, CUTID1, TOWNSHIP1, VILLAGE1, COD11, NEIGHBOR1, COD12, STREET1, COD13, SEC1, " _
             &"COD14, LANE1, COD15, ALLEYWAY1, COD16,NUM1, COD17, FLOOR1, COD18, ROOM1, COD19, RZONE1, CUTID2, " _
             &"TOWNSHIP2, VILLAGE2, COD21, NEIGHBOR2, COD22, STREET2, COD23, SEC2, COD24, LANE2, COD25," _
             &"ALLEYWAY2, COD26, NUM2, COD27, FLOOR2, COD28, ROOM2, COD29, RZONE2, AGENTCUSNC," _
             &"AGENTSOCIALID, AGENTTEL11,AGENTTEL12, APPLYDAT, TRANSDAT, CANCELDAT, CANCELUSR, CONSIGNEE, " _
             &"AREAID, GROUPID, SALESID, VOICEPROMOTION, DATAPROMOTION, COSTSETUP, COSTPROMISE, COSTSELECTNO," _
             &"COSTOTHER, EBTPROJECTID,EBTPROJECTNAME, CPEPRODTYPE, EUSR, EDAT, UUSR, UDAT,CUSTPRODRCVDAT,MEMO " _
             &"from EBT3GCUST WHERE CUSID='' "
  sqlList="SELECT  CUSID, CUSNC, SOCIALID, CUSTTYPE, CUSNE, MOBILE, APFORMDAT, SEX, MACHINECODE, CUSBIRTHDAY, " _
             &"CUSSOCIALCARDDAT, COBOSS, COTEL11, COTEL12, COTEL13, BOSSSOCIALID, BOSSHOMETEL11, BOSSHOMETEL12, " _
             &"BOSSOTHERTEL2, CUTID1, TOWNSHIP1, VILLAGE1, COD11, NEIGHBOR1, COD12, STREET1, COD13, SEC1, " _
             &"COD14, LANE1, COD15, ALLEYWAY1, COD16,NUM1, COD17, FLOOR1, COD18, ROOM1, COD19, RZONE1, CUTID2, " _
             &"TOWNSHIP2, VILLAGE2, COD21, NEIGHBOR2, COD22, STREET2, COD23, SEC2, COD24, LANE2, COD25," _
             &"ALLEYWAY2, COD26, NUM2, COD27, FLOOR2, COD28, ROOM2, COD29, RZONE2, AGENTCUSNC," _
             &"AGENTSOCIALID, AGENTTEL11,AGENTTEL12, APPLYDAT, TRANSDAT, CANCELDAT, CANCELUSR, CONSIGNEE, " _
             &"AREAID, GROUPID, SALESID, VOICEPROMOTION, DATAPROMOTION, COSTSETUP, COSTPROMISE, COSTSELECTNO," _
             &"COSTOTHER, EBTPROJECTID,EBTPROJECTNAME, CPEPRODTYPE, EUSR, EDAT, UUSR, UDAT,CUSTPRODRCVDAT,MEMO " _
             &"from EBT3GCUST WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
  if len(trim(dspkey(75)))=0 then dspkey(75)=0
  if len(trim(dspkey(76)))=0 then dspkey(76)=0
  if len(trim(dspkey(77)))=0 then dspkey(77)=0
  if len(trim(dspkey(78)))=0 then dspkey(78)=0
  '�ˬd��ʹq�ܸ��X�����ЩʤάO�_�s�b�q�ܸ��X�M�椤(�άO�_�w�Q�ϥ�)
  IF LEN(TRIM(DSPKEY(5))) > 0 THEN
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx
      
	  '�ˬd�O�_��M�椤���ӹq��
      sqlXX="SELECT EBT3GMOBILELIST.EBT3GMOBILENO,EBT3GMOBILELIST.usedat,EBT3GMOBILELIST.usecusid,EBT3GCUST.cusnc,count(*) AS CNT FROM EBT3GMOBILELIST LEFT OUTER JOIN EBT3GCUST ON EBT3GMOBILELIST.USECUSID=EBT3GCUST.CUSID " _
           &"where EBT3GMOBILELIST.EBT3GMOBILENO='" & trim(dspkey(5)) & "' and EBT3GMOBILELIST.DROPMARKDAT is null group by EBT3GMOBILELIST.EBT3GMOBILENO,EBT3GMOBILELIST.usedat,EBT3GMOBILELIST.usecusid,EBT3GCUST.cusnc "
      rsxx.Open sqlxx,connxx
      s=""
      'Response.Write "CNT=" & RSXX("CNT")
      If RSXX("CNT") > 0 Then
         IF NOT ISNULL(RSXX("USEDAT")) OR LEN(TRIM(RSXX("USECUSID"))) > 0 THEN
            errflag="Y"
            message="����ʹq�ܤw�Q�Ȥ�J" & RSXX("CUSNC") & " �ϥΡA���i���ƿ�J!"
            formvalid=false
         ELSE
            errflag=""
         END IF
      ELSE
         ERRFLAG="Y"
         message="��ʹq�ܸ��X���s�b���Ĺq�ܲM�椤�A�Э��s��J!"
         formvalid=false
      End If
      rsxx.Close
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing    
   end IF  
IF ERRFLAG <> "Y" THEN
  If len(trim(dspkey(6)))=0 or Not Isdate(dspkey(6)) then
       formValid=False
       message="�Τ�AP form�ӽФ餣�i�ťթή榡���~"    
  elseif len(trim(dspkey(5)))=0 OR len(trim(dspkey(5))) <> 10 then
       formValid=False
       message="��ʹq�ܸ��X���i�ťթΪ��ץ�����10��Ʀr"   
  elseif len(trim(dspkey(3)))=0 then
       formValid=False
       message="�Τ����O���i�ť�"          
  elseif dspkey(3)="01" AND LEN(TRIM(DSPKEY(7))) = 0 then
       formValid=False
       message="�Τ����O���ӤH�ɡA�ʧO�椣�i�ť�"                
  elseif dspkey(3)<> "01" AND LEN(TRIM(DSPKEY(7))) <> 0 then
       formValid=False
       message="�Τ����O�D�ӤH�ɡA�ʧO�楲���ť�"             
  elseif LEN(TRIM(DSPKEY(1))) = 0 AND LEN(TRIM(DSPKEY(4))) = 0 then
       formValid=False
       message="�Τ�W��(���^��ܤֶ���J�@��"     
  elseif LEN(TRIM(DSPKEY(1))) = 0 AND ( DSPKEY(3) = "01" OR DSPKEY(3) = "02" ) then
       formValid=False
       message="�ӤH�Τ��q�Τᥲ����J����W��"     
  elseif LEN(TRIM(DSPKEY(4))) = 0 AND ( DSPKEY(3) = "03" ) then
       formValid=False
       message="�~�y�Τᥲ����J�^��W��"             
  elseif len(trim(dspkey(2)))=0 then
       formValid=False
       message="�ӽФH�����Ҧr�����i�ť�"               
  elseif len(trim(dspkey(9)))=0 then
       formValid=False
       message="�ӽФH�X�ͤ�����i�ť�"          
  elseif len(trim(dspkey(10)))=0 then
       formValid=False
       message="�ӽФH�ҥ󴫸ɤ�����i�ť�"       
  elseif len(trim(dspkey(11)))=0 AND DSPKEY(3)="02" then
       formValid=False
       message="���q�t�d�H�m�W���i�ť�"        
  elseif len(trim(dspkey(11)))=0 AND len(trim(dspkey(12)))=0 AND DSPKEY(3)="02" then
       formValid=False
       message="�Τ����O��[���q]�ɡA���q�q�ܤ��i�ť�"     
  elseif len(trim(dspkey(15)))=0 AND DSPKEY(3)="02" then
       formValid=False
       message="�Τ����O��[���q]�ɡA���q�t�d�H�����Ҧr�����i�ť�"                 
  elseif ( len(trim(dspkey(16)))=0 OR len(trim(dspkey(17)))=0 ) AND len(trim(dspkey(18)))=0  AND DSPKEY(3)="02" then
       formValid=False
       message="�Τ����O��[���q]�ɡA�t�d�H�q�ܦܤֶ���J�@��"                                    
  elseif len(trim(dspkey(19)))=0 then
       formValid=False
       message="���y/��~�a�}(����)���i�ť�"               
  elseif len(trim(dspkey(20)))=0 then
       formValid=False
       message="���y/��~�a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(25)))=0 then
       formValid=False
       message="���y/��~�a�}(��/��)���i�ť�"          
  elseif len(trim(dspkey(33)))=0 then
       formValid=False
       message="���y/��~�a�}(��)���i�ť�"         
  elseif len(trim(dspkey(39)))=0 then
       formValid=False
       message="�b��a�}(�l���ϸ�)���i�ť�"      
  elseif len(trim(dspkey(40)))=0 then
       formValid=False
       message="�b��a�}(����)���i�ť�"               
  elseif len(trim(dspkey(41)))=0 then
       formValid=False
       message="�b��a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(46)))=0 then
       formValid=False
       message="�b��a�}(��/��)���i�ť�"          
  elseif len(trim(dspkey(54)))=0 then
       formValid=False
       message="�b��a�}(��)���i�ť�"         
  elseif len(trim(dspkey(60)))=0 then
       formValid=False
       message="�b��a�}(�l���ϸ�)���i�ť�"   
  '�~�֤���20���̡A�����N�z�H���          
  elseif ( (DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) < 20 ) or ((DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) = 20 ) and ( DATEpart("y",dspkey(9)) > DATEpart("y",now)))  ) and len(trim(dspkey(61)))=0   then
       formValid=False
       message="�ӽФH���F20���A����J�N�z�H�m�W"    
  elseif ( (DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) < 20 ) or ((DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) = 20 ) and ( DATEpart("y",dspkey(9)) > DATEpart("y",now)))  ) and len(trim(dspkey(62)))=0  then
       formValid=False
       message="�ӽФH���F20���A����J�N�z�H�����Ҹ�"           
  elseif ( (DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) < 20 ) or ((DATEpart("yyyy",dspkey(9)) - DATEpart("yyyy",now()) = 20 ) and ( DATEpart("y",dspkey(9)) > DATEpart("y",now))) ) and ( len(trim(dspkey(63)))=0 or len(trim(dspkey(64)))=0 )  then
       formValid=False
       message="�ӽФH���F20���A����J�N�z�H�s���q��"         
  elseif len(trim(dspkey(73)))=0 then
       formValid=False
       message="�y����O��פ��i�ť�"        
  elseif len(trim(dspkey(74)))=0 then
       formValid=False
       message="�ƾڸ�O��פ��i�ť�"        
  elseif len(trim(dspkey(79)))=0 then
       formValid=False
       message="�M�ץN�X���i�ť�"           
  elseif len(trim(dspkey(80))) = 0 then
       formValid=False
       message="�M�צW�٤��i�ť�"      
  elseif len(trim(dspkey(69))) = 0 and ( len(trim(dspkey(70))) = 0 or len(trim(dspkey(71))) = 0 or len(trim(dspkey(72))) = 0 ) then
       formValid=False
       message="�}�o�g�P�Ӥζ}�o�~�ȲէO���i�P�ɪť�"      
  elseif len(trim(dspkey(69))) <> 0 and ( len(trim(dspkey(70))) <> 0 or len(trim(dspkey(71))) <> 0 or len(trim(dspkey(72))) <> 0 ) then
       formValid=False
       message="�}�o�g�P�Ӥζ}�o�~�ȲէO���i�P�ɿ�J"             
  end if
  IF formValid=TRUE THEN
    IF dspkey(2) <> "" then
       idno=dspkey(2)
        if dspkey(3) = "01" THEN
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
    IF dspkey(15) <> "" then
       idno=dspkey(15)
          AAA=CheckID(idno)
          SELECT CASE AAA
             CASE "True"
             case "False"
                   message="���q�t�d�H�����Ҧr�����X�k"
                   formvalid=false 
             case "ERR-1"
                   message="���q�t�d�H�����Ҹ����i�d�ťթο�J��ƿ��~"
                   formvalid=false       
             case "ERR-2"
                   message="���q�t�d�H�����Ҧr�����Ĥ@�X���ݬO�X�k���^��r��"
                   formvalid=false    
             case "ERR-3"
                   message="���q�t�d�H�����Ҧr�����ĤG�X���ݬO�Ʀr 1 �� 2"
                   formvalid=false   
             case "ERR-4"
                   message="���q�t�d�H�����Ҧr������E�X���ݬO�Ʀr"
                   formvalid=false              
             case else
          end select  
    END IF
  END IF  
  IF formValid=TRUE THEN
    IF dspkey(62) <> "" then
       idno=dspkey(62)
          AAA=CheckID(idno)
          SELECT CASE AAA
             CASE "True"
             case "False"
                   message="�N�z�H�����Ҧr�����X�k"
                   formvalid=false 
             case "ERR-1"
                   message="�N�z�H�����Ҹ����i�d�ťթο�J��ƿ��~"
                   formvalid=false       
             case "ERR-2"
                   message="�N�z�H�����Ҧr�����Ĥ@�X���ݬO�X�k���^��r��"
                   formvalid=false    
             case "ERR-3"
                   message="�N�z�H�����Ҧr�����ĤG�X���ݬO�Ʀr 1 �� 2"
                   formvalid=false   
             case "ERR-4"
                   message="�N�z�H�����Ҧr������E�X���ݬO�Ʀr"
                   formvalid=false              
             case else
          end select  
    END IF
  END IF  
END IF

'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(84)=V(0)
        dspkey(85)=datevalue(now())
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
   Sub Srcounty20onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY19").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key20").value =  trim(Fusrid(0))
          document.all("key39").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub       
   Sub Srcounty41onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY40").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key41").value =  trim(Fusrid(0))
          document.all("key60").value =  trim(Fusrid(1))
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

SUB SrSHOWTELLISTOnClick()
       IF window.SRTAR1.style.display="" THEN
          window.SRTAR1.style.display="none"
          document.all("STL").value="��ܹq�ܩ���"
       ELSE
          window.SRTAR1.style.display=""
          document.all("STL").value="���ùq�ܩ���"
       end if
 END SUB 
 sub SrAddrEqual1()
     Dim i,j
     i=40
     j=19
     do while i < 61
        keyx="key" & i
        keyy="key" & j
        document.All(keyx).value=document.All(keyy).value
        i=i+1
        j=j+1
     loop
 end sub
 Sub Srsalesgrouponclick()
       prog="RTGetsalesgroupD.asp"
       prog=prog & "?KEY=" & document.all("KEY70").VALUE 
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key71").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub        
   Sub Srsalesonclick()
       prog="RTGetsalesD.asp"
       prog=prog & "?KEY=" & document.all("KEY70").VALUE & ";" & document.all("KEY71").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key72").value =  trim(Fusrid(0))
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
Sub SrGetUserDefineKey()
%>
      <table width="30%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="5%" class=dataListHead>�Τ�N��</td>
           <td width="5%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="15" value="<%=dspKey(0)%>" maxlength="15" class=dataListdata></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(82))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(82)=V(0)
        End if  
       dspkey(83)=datevalue(now())
    else
        if len(trim(dspkey(84))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(84)=V(0)
        End if         
        dspkey(85)=datevalue(now())
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '�Τ�e��ӽЫ�,�򥻸�� protect
    If len(trim(dspKey(65))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
    Else
       fieldPa=""
       fieldpb=""
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
  <span id="tags1" class="dataListTagsOn">��ʹq�ܥΤ��T</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">�@</td><td width="96%">�@</td><td width="2%">�@</td></tr>
<tr><td>�@</td>
<td>     
    <DIV ID="SRTAG0" onclick="srtag0" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�Ȥ�򥻸��</td></tr></table></div>
 <DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr>
<td width="14%" class=dataListHEAD>�Τ�ӽФ�</td>
    <td width="20%" bgcolor="silver" >
        <input type="text" name="key6" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(6)%>"  READONLY size="10" class=dataListEntry ID="Text48">
       <input  type="button" id="B6"  <%=fieldpb%> name="B6" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C6"  name="C6"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>      
    <td width="14%" class=dataListHEAD>��ʹq�ܸ��X</td>       
    <td width="20%" bgcolor="silver" colspan=3>
    <% '�s�W�ɤ~�i��J��ʹq�ܡA�H�קK�q���ɨϥε��O�аO���~
       if accessmode = "A" THEN
          PROTECTXX=""
       ELSE
          PROTECTXX=" class=""dataListData"" readonly "
       END IF
    %>
        <input type="text" name="key5" <%=PROTECTXX%> <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(5)%>"   size="10" class=dataListENTRY ID="Text1">
      </td>         
      </tr>      
<td width="14%" class=dataListHEAD>�Τ����O</td>
    <td width="20%" bgcolor="silver" >
        <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(65))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K2'  ORDER BY CODENC" 
       If len(trim(dspkey(3))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K2' AND CODE='" & dspkey(3) & "' ORDER BY CODENC"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(3) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key3" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                                                  
        <%=s%>
   </select> 
   </td>      
    <td width="14%" class=dataListHEAD>�ʧO</td>       
    <td width="20%" bgcolor="silver" >
        <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(65))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K3'  ORDER BY CODENC" 
       If len(trim(dspkey(7))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K3' AND CODE='" & dspkey(7) & "' ORDER BY CODENC"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(7) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key7" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select2">                                                                  
        <%=s%>
   </select> 
      </td>         
    <td width="14%" class=dataListHEAD>�Ȥ��ѧO�d���X</td>       
    <td width="20%" bgcolor="silver">
        <input type="text" name="key8" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="20"
               value="<%=dspKey(8)%>"  size="20" class=dataListENTRY ID="Text30">
      </td>               
      </tr>            
<tr><td width="10%" class=dataListHEAD>�ӽФH(���q)�W��</td>
    <td  width="20%"  bgcolor="silver" colspan=5 >
       <font size=2>����J</font>
       <input type="text" name="key1" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="50"
               value="<%=dspKey(1)%>"  size="50" class=dataListENTRY ID="Text22"><br>
        <font size=2>�^��J</font>
        <input type="text" name="key4" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="50"
               value="<%=dspKey(4)%>"  size="50" class=dataListENTRY ID="Text31">
               <font size=2>(���~�y�H�h�ϥ�)</font>    
               </td>
 </tr>
 <tr>
     <td width="10%" class=dataListHEAD>�ӽФH������(�νs)</td>
    <td width="21%" bgcolor="silver" >
        <input type="password" name="key2" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(2)%>"   size="12" class=dataListENTRY ID="Text23"></td>      
     <td width="10%" class=dataListHEAD>�ӽФH�X�ͤ��</td>
    <td width="20%" bgcolor="silver" >
    <input type="text" name="key9" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(9)%>"  size="10" class=dataListEntry ID="Text3">
       <input  type="button" id="B9" name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C9"  name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>      
    <td width="10%" class=dataListHEAD>�ӽФH�ҥ󴫸ɤ��</td>
    <td width="20%" bgcolor="silver" >
    <input type="text" name="key10" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(10)%>"  READONLY size="10" class=dataListEntry ID="Text32">
       <input  type="button" id="B10" name="B10" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
      </td>                            
</tr>
<tr><td  class=dataListHEAD>���q�t�d�H�m�W</td>
    <td  bgcolor="silver" >
        <input type="text" name="key11" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="12"
               value="<%=dspKey(11)%>"  size="12" class=dataListENTRY ID="Text50">
    </td>
    <td  class=dataListHEAD>���q�q��</td>
    <td  bgcolor="silver" COLSPAN=3>
        <input type="text" name="key12" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="4"
               value="<%=dspKey(12)%>"   size="4" class=dataListENTRY ID="Text53"><font size=2>-</font>
               <input type="text" name="key13" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(13)%>"  size="8" class=dataListENTRY ID="Text59">
               <font size=2>����</font><input type="text" name="key14" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="5"
               value="<%=dspKey(14)%>"  size="5" class=dataListENTRY ID="Text33"></td>  
 </tr>
 <tr>    
     <td  class=dataListHEAD>�t�d�H�ҥ�r��</td>
    <td bgcolor="silver" >
        <input type="text" name="key15" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(15)%>"   size="10" class=dataListENTRY ID="Text54"></td>    
    <td  class=dataListHEAD>��v�q��</td>
    <td  bgcolor="silver" >  
     <input type="text" name="key16" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="4"
               value="<%=dspKey(16)%>"   size="4" class=dataListENTRY ID="Text34"><font size=2>-</font>
               <input type="text" name="key17" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(17)%>"  size="8" class=dataListENTRY ID="Text35"></td>   
    <td  class=dataListHEAD>��L�p���q��</td>
    <td  bgcolor="silver" >  
     <input type="text" name="key18" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(18)%>"   size="10" class=dataListENTRY ID="Text36">
     </td>                                    
</tr>
<tr><td class=dataListHEAD>���y����~�a�}</td>
    <td bgcolor="silver" COLSPAN=5>
      <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(65))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(19))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX20=" onclick=""Srcounty20onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(19) & "' " 
       SXX20=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(19) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key19" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select4" ><%=s%></select>
        <input type="text" name="key20" readonly  size="8" value="<%=dspkey(20)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text28"><font SIZE=2>(�m��)                 
         <input type="button" id="B20" <%=fieldpb%> name="B20"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX20%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C20"  name="C20"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key21" <%=fieldpa%> size="10" value="<%=dspkey(21)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0  Then
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
       <select size="1" name="key22" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>      
        <input type="text" name="key23"  size="6" value="<%=dspkey(23)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text37"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key24" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select7">                                            
        <%=s%></select>              
        <input type="text" name="key25" size="10" value="<%=dspkey(25)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text38"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(26)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(26) &""">" &dspKey(26) &"</option>"
   End If%>                                  
       <select size="1" name="key26" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select8">                                            
        <%=s%></select>                      
        <input type="text" name="key27"  size="6" value="<%=dspkey(27)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text39"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key28" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select9">                                            
        <%=s%></select>
        <input type="text" name="key29" size="6" value="<%=dspkey(29)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text40"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key30" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>     
                <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text" name="key39"  readonly size="5" value="<%=dspkey(39)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text41">
        <input type="text" name="key31" size="10" value="<%=dspkey(31)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text42"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key32" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>    
        <input type="text" name="key33" size="6" value="<%=dspkey(33)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text43"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key34" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>            
        <input type="text" name="key35" size="10" value="<%=dspkey(35)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text44"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0  Then
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
       <select size="1" name="key36" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>
        <input type="text" name="key37" size="6" value="<%=dspkey(37)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text45"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
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
       <select size="1" name="key38" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select14">                                            
        <%=s%></select>    
    </td>
</tr>  
<tr><td class=dataListHEAD>�b��a�}<br><input type="radio" name="rd1"  <%=fieldpb%> onClick="SrAddrEqual1()" ID="Radio1" VALUE="Radio1">�P���y</td>
    <td bgcolor="silver" COLSPAN=5>
          <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(DSPKEY(65))) = 0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(40))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX41=" onclick=""Srcounty41onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(40) & "' " 
       SXX41=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(40) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key40" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select15" ><%=s%></select>
        <input type="text" name="key41" readonly  size="8" value="<%=dspkey(41)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text46"><font SIZE=2>(�m��)                 
         <input type="button" id="B41" name="B41"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX41%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C41"  name="C41"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key42" <%=fieldpa%> size="10" value="<%=dspkey(42)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text47"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(43)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(43) &""">" &dspKey(43) &"</option>"
   End If%>                                  
       <select size="1" name="key43" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select16">                                            
        <%=s%></select>      
        <input type="text" name="key44"  size="6" value="<%=dspkey(44)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text49"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(45)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(45) &""">" &dspKey(45) &"</option>"
   End If%>                                  
       <select size="1" name="key45" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select17">                                            
        <%=s%></select>              
        <input type="text" name="key46" size="10" value="<%=dspkey(46)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text55"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(47)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(47) &""">" &dspKey(47) &"</option>"
   End If%>                                  
       <select size="1" name="key47" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select18">                                            
        <%=s%></select>                      
        <input type="text" name="key48"  size="6" value="<%=dspkey(48)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text56"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(49)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(49) &""">" &dspKey(49) &"</option>"
   End If%>                                  
       <select size="1" name="key49" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select19">                                            
        <%=s%></select>
        <input type="text" name="key50" size="6" value="<%=dspkey(50)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text57"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(51)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(51) &""">" &dspKey(51) &"</option>"
   End If%>                                  
       <select size="1" name="key51" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select20">                                            
        <%=s%></select>     
                <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <input type="text" name="key60"  readonly size="5" value="<%=dspkey(60)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text58">
        <input type="text" name="key52" size="10" value="<%=dspkey(52)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text60"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(53)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(53) &""">" &dspKey(53) &"</option>"
   End If%>                                  
       <select size="1" name="key53" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select21">                                            
        <%=s%></select>    
        <input type="text" name="key54" size="6" value="<%=dspkey(54)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text61"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(55)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(55) &""">" &dspKey(55) &"</option>"
   End If%>                                  
       <select size="1" name="key55" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select22">                                            
        <%=s%></select>            
        <input type="text" name="key56" size="10" value="<%=dspkey(56)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text62"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(57)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(57) &""">" &dspKey(57) &"</option>"
   End If%>                                  
       <select size="1" name="key57" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select23">                                            
        <%=s%></select>
        <input type="text" name="key58" size="6" value="<%=dspkey(58)%>" maxlength="6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text63"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 AND len(trim(DSPKEY(65))) = 0 Then
      For i = 0 To Ubound(aryOption)
          If dspKey(59)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(59) &""">" &dspKey(59) &"</option>"
   End If%>                                  
       <select size="1" name="key59" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select24">                                            
        <%=s%></select>    
    </td>
</tr>  
 <tr>
     <td width="10%" class=dataListHEAD>�N�z�H�m�W</td>
    <td width="21%" bgcolor="silver" >
        <input type="text" name="key61" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="12"
               value="<%=dspKey(61)%>"   size="12" class=dataListENTRY ID="Text4"></td>      
     <td width="10%" class=dataListHEAD>�N�z�H�����Ҹ�</td>
    <td width="20%" bgcolor="silver" >
    <input type="password" name="key62" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(62)%>"   size="10" class=dataListEntry ID="Text5">
      </td>      
    <td width="10%" class=dataListHEAD>�N�z�H�p���q��</td>
    <td width="20%" bgcolor="silver" >
    <input type="text" name="key63" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="4"
               value="<%=dspKey(63)%>"   size="4" class=dataListEntry ID="Text7">
    <font size=2>-</font>
    <input type="text" name="key64" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(64)%>"   size="8" class=dataListEntry ID="Text64">
      </td>                            
</tr>
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(82) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(82) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key82" size="6" READONLY value="<%=dspKey(82)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key83" size="10" READONLY value="<%=dspKey(83)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(84) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(84) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key84" size="6" READONLY value="<%=dspKey(84)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key85" size="10" READONLY value="<%=dspKey(85)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>         
</table> </div>
    <DIV ID="SRTAG1" onclick="srtag1" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table10">
    <tr><td bgcolor="BDB76B" align="LEFT">�ӽж���</td></tr></table></div>
     <DIV ID="SRTAB1" >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table11">
   <tr>
    <td width="13%" class=dataListHEAD>�y����O���</td>
    <td width="21%" bgcolor="silver" >
    <input type="text" name="key73" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="2"
               value="<%=dspKey(73)%>"   size="12" class=dataListENTRY ID="Text6">
    </td>
    <td width="13%" class=dataListHEAD>�ƾڸ�O���</td>
    <td width="17%" bgcolor="silver" COLSPAN=3>
    <input type="text" name="key74" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="2"
               value="<%=dspKey(74)%>"   size="12" class=dataListENTRY ID="Text8">
    </td>
    </tr>
   <tr>
    <td width="13%" class=dataListHEAD>�M�צW��</td>
    <td width="17%" bgcolor="silver" >
    <input type="text" name="key80" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="2"
               value="<%=dspKey(80)%>"  class=dataListENTRY ID="Text24">
    </td>
    <td  width="13%" class=dataListHEAD>�M�ץN�X</td>
    <td  width="19%" bgcolor="silver" >
    <input type="text" name="key79" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="2"
               value="<%=dspKey(79)%>"   class=dataListENTRY ID="Text25">
    </td>
    <td  width="13%" class=dataListHEAD>�׺ݰӫ~����</td>
    <td  width="17%" bgcolor="silver" >
    <input type="text" name="key81" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(81)%>"   size="12" class=dataListENTRY ID="Text27">
    </td>
    </tr>    
    <tr>
    <td  class=dataListHEAD>�Ӹ˶O��</td>
    <td  bgcolor="silver" COLSPAN=5>
    <font size=2>�]�w�O�J</font>
    <input type="text" name="key75" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="6"
               value="<%=dspKey(75)%>"   size="6" class=dataListENTRY ID="Text11">
    <font size=2>�O�Ҫ��J</font>
    <input type="text" name="key76" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="6"
               value="<%=dspKey(76)%>"   size="6" class=dataListENTRY ID="Text13">
    <font size=2>�︹�O�J</font>
    <input type="text" name="key77" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="6"
               value="<%=dspKey(77)%>"   size="6" class=dataListENTRY ID="Text14">
    <font size=2>�䥦�J</font>
    <input type="text" name="key78" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="6"
               value="<%=dspKey(78)%>"   size="6" class=dataListENTRY ID="Text16">
    <font size=2>�`���B�J</font>
    <%
    TOTAMT=0
    TOTAMT=CINT(DSPKEY(75))+CINT(DSPKEY(76))+CINT(DSPKEY(77))+CINT(DSPKEY(78))
    %>
    <input type="text"   style="text-align:left;" maxlength="10"
               value="<%=TOTAMT%>"  READONLY  size="12" class=dataListDATA ID="Text21">
    </td>
    </tr>
  </table>     
  </DIV>       
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->
    <DIV ID="SRTAG2" onclick="srtag2" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�Z���k��</td></tr></table></div>
     <DIV ID=SRTAB2 >
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">
    <tr><td id="tagT1" WIDTH="5%" class="dataListHEAD" height="23">�}�o�g�P��</td>               
        <td  WIDTH="8%" height="23" bgcolor="silver">
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(65))) = 0 Then 
       sql="SELECT RTConsignee.CUSID, RTObj.SHORTNC FROM RTConsignee INNER JOIN  RTConsigneeISP ON " _
          &"RTConsignee.CUSID = RTConsigneeISP.CUSID INNER JOIN RTObj ON RTConsignee.CUSID = RTObj.CUSID " _
          &"WHERE (RTConsigneeISP.ISP = '03') ORDER BY  RTObj.SHORTNC"
       s="<option value="""" >(�}�o�g�P��)</option>"
    Else
       sql="SELECT RTConsignee.CUSID, RTObj.SHORTNC FROM RTConsignee INNER JOIN  RTConsigneeISP ON " _
          &"RTConsignee.CUSID = RTConsigneeISP.CUSID INNER JOIN RTObj ON RTConsignee.CUSID = RTObj.CUSID " _
          &"WHERE (RTConsigneeISP.ISP = '03') AND RTConsignee.CUSID='" & DSPKEY(69) & "' ORDER BY RTObj.SHORTNC "
       
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�}�o�g�P��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CUSID")=dspkey(69) Then sx=" selected "
       s=s &"<option value=""" &rs("CUSID") &"""" &sx &">" &rs("SHORTNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>    
           <select size="1" name="key69" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select1">                                            
              <%=s%>
           </select>
        </td>
   <td id="tagT1" WIDTH="5%" class="dataListHEAD" height="23">�}�o�~��</td>               
        <td  WIDTH="19%" height="23" bgcolor="silver">
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(65))) = 0  Then 
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '1') "
       s="<option value="""" >(�~���Ұ�)</option>"
    Else
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '1') AND AREAID='" & DSPKEY(70) & "' "
       s="<option value="""" >(�~���Ұ�)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�~���Ұ�)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("areaid")=dspkey(70) Then sx=" selected "
       s=s &"<option value=""" &rs("areaid") &"""" &sx &">" &rs("areanc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>    
           <select size="1" name="key70" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select3">                                            
              <%=s%>
           </select>
    <input type="text" name="key71" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(71)%>"   readonly class="dataListEntry" ID="Text65">
         <input type="button" id="B71"  <%=fieldpb%>  name="B71"   width="100%" style="Z-INDEX: 1"  value="...." readonly onclick="SrsalesGrouponclick()"  >  
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C71"  name="C71"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">                               
    <input type="TEXT" name="key72" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(72)%>"  readonly class="dataListDATA" ID="Hidden1">
           <input type="BUTTON" id="B72"  <%=fieldpb%>  name="B72"  width="100%" style="Z-INDEX: 1"  value="...." onclick="Srsalesonclick()"  >   
           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C72"  name="C72"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">        
          <%  name="" 
           if dspkey(72) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(72) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
           %>    
           <%=name%>
        </td>        
 </tr>        
  </table>     
  </DIV>   
   <DIV ID="SRTAG3" onclick="srtag3" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="LEFT">�Τ�ӽжi�ת��A</td></tr></table></DIV>
    <DIV ID=SRTAB3 >  
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr>
        <td  width=13% class="dataListHEAD" height="23">�e��ӽФ�</td>                                 
        <td  width=23% height="23" bgcolor="silver">
        <input type="text" name="key65" size="10" value="<%=dspKey(65)%>"  <%=fieldpe%><%=fieldRole(1)%> readonly class="dataListentry" ID="Text51">     
       <input type="button" id="B65"  name="B65" height="100%" width="100%" style="Z-INDEX: 1" <%=fieldpf%> value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C65"  name="C65"  <%=fieldpf%>  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        </td>    
        <td   width=14% class="dataListHEAD" height="23">�ӽ����ɤ�</td>                                 
        <td   width=18% height="23" bgcolor="silver" >
        <input type="text" name="key66"  size="10" value="<%=dspKey(66)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text52">
        </td>  
        <td  WIDTH=13%  class="dataListHEAD" height="23">EBT�ӫ~�H�F��</td>                                 
        <td   WIDTH=20% height="23" bgcolor="silver">
        <input type="text" name="key86" size="10" READONLY value="<%=dspKey(86)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListentry" ID="Text26">     
        <input type="button" id="B86"  name="B86" height="100%" width="100%" style="Z-INDEX: 1" <%=fieldpf%> value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C86"  name="C86"  <%=fieldpf%>  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
        </td>
      
     </tr>         
     <tr>    
     <td  class="dataListHEAD" height="23">�@�o��</td>                                 
        <td  height="23" bgcolor="silver">
         <input type="text" name="key67" size="10" READONLY value="<%=dspKey(67)%>"  <%=fieldRole(1)%> class="dataListDATA" ID="Text10">
        </td>
         <td  class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td   height="23" bgcolor="silver" colspan=3>
        <%  name="" 
           if dspkey(68) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(68) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>            
        <input type="text" name="key68" size="10" value="<%=dspKey(68)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text15"><font size=2><%=name%></font>
        </td>
      </TR>

  </table> 
  </DIV>
    <DIV ID="SRTAG4" onclick="SRTAG4" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
    <tr><td bgcolor="BDB76B" align="LEFT">�Ƶ�����</td></tr></table></DIV>
   <DIV ID="SRTAB4" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <TR><TD align="CENTER">
     <TEXTAREA  cols="100%"  name="key87" rows=8  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(87)%>" ID="Textarea1"><%=dspkey(124)%></TEXTAREA>
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

End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
    Set connXX=Server.CreateObject("ADODB.Connection")
    Set rsXX=Server.CreateObject("ADODB.Recordset")
    connXX.open DSN
    SQLXX="select * FROM EBT3GMOBILELIST where EBT3GMOBILENO='" & dspkey(5) & "' "
    rsxx.open sqlxx,connxx,3,3 
    if not rsxx.eof then
       if ISNULL(rsxx("USEDAT")) THEN
          RSXX("USEDAT")=NOW()
       END IF
       if LEN(TRIM(rsxx("USECUSID"))) = 0 THEN
          RSXX("USECUSID")=DSPKEY(0)
       END IF
       RSXX.UPDATE
    end if
    RSXX.CLOSE
    CONNXX.CLOSE
    SET RSXX=NOTHING
    SET CONNXX=NOTHING
End Sub
' -------------------------------------------------------------------------------------------- 
' --------------------------------------------------------------------------------------------  
%><!-- #include virtual="/Webap/include/checkid.inc" --><!-- #include virtual="/Webap/include/companyid.inc" --><!-- #include file="RTGetUserRight.inc" --><!-- #include virtual="/Webap/include/employeeref.inc" -->