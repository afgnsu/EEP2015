<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
%>
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(200),aryKeyValue(200),numberOfField,aryKey,aryKeyNameDB(200)
  Dim dspKey(200),userDefineKey,userDefineData,extDBField,extDB(200),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  Dim aryParmKey
 '90/09/03 ADD-START
 '�W�[EXTDBFIELD2,EXTDBFILELD3(�h�ɺ��@)
  dim extDBField2,extDB2(200),extDBField3,extDB3(200),extDBField4,extDB4(200)
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
'response.Write sql    
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
                   case ucase("/webap/rtap/base/rtEBTcmty/RTEBTCmtylined.asp")
  'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 1 then rs.Fields(i).Value=dspKey(i)    
                       if i=1 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         rsc.open "select max(lineq1) AS lineq1 from rtEBTcmtyline where comq1=" & dspkey(0) ,conn
                         if len(rsc("lineq1")) > 0 then
                            dspkey(1)=rsc("lineq1") + 1
                         else
                            dspkey(1)=1
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
                 case ucase("/webap/rtap/base/rtEBTcmty/RTEBTCmtyLINEd.asp")
                  '  response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     if i<>0 and i <> 1 then rs.Fields(i).Value=dspKey(i)         
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
       if ucase(runpgm)=ucase("/webap/rtap/base/rtEBTcmty/RTEBTCmtyLINEd.asp") then
          rs.open "select max(lineq1) AS lineq1 from rtEBTcmtyline where comq1=" & dspkey(0) ,conn
          if not rs.eof then
            dspkey(1)=rs("lineq1")
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
  numberOfKey=2
  title="AVS�D�u��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT  COMQ1, LINEQ1, CONSIGNEE, AREAID, GROUPID, SALESID, LINEIP, GATEWAY, SUBNET, DNSIP, PPPOEACCOUNT, PPPOEPASSWORD, " _
         &"LINETEL, LINERATE, CUTID, TOWNSHIP, VILLAGE, COD1, NEIGHBOR, COD2, STREET, COD3, SEC, COD4, LANE, COD5, ALLEYWAY, COD7, " _
         &"NUM, COD8, FLOOR, COD9, ROOM, COD10, ADDROTHER, RZONE, CUTID1, TOWNSHIP1, RADDR1, RZONE1, CUTID2, TOWNSHIP2, RADDR2, " _
         &"RZONE2, RCVDAT, INSPECTDAT, AGREE, UNAGREEREASON, TECHCONTACT, TECHENGNAME, CONTACT1, CONTACT2, CONTACTMOBILE, CONTACTTEL, " _
         &"CONTACTEMAIL, CONTACTTIME1, CONTACTTIME2, UPDEBTCHKDAT, UPDEBTCHKUSR, UPDEBTDAT, EBTREPLYDAT, EBTREPLAYCODE, PROGRESSID, HINETNOTIFYDAT, " _
         &"ADSLAPPLYDAT, APPLYUPLOADDAT, APPLYUPLOADUSR, APPLYUPLOADTNS,EBTERRORCODE, SUPPLYRANGE,COBOSS,COBOSSENG,COID,COBOSSID,APPLYNAMEC, " _
         &"APPLYNAMEE,ENGADDR,CONTACTSTRTIME,CONTACTENDTIME,ADSLAPPLYUSR,APPLYPRTNO,MEMO,APPLYNO,SCHAPPLYDAT,CHTRCVD,SUGGESTTYPE,REPEATREASON,TELCOMROOM,eusr,edat,uusr,udat,LOANNAME,LOANSOCIAL,DROPDAT,CANCELDAT, " _
         &"MOVETOCOMQ1,movetolineq1,movetodat,movefromcomq1,movefromlineq1,movefromdat,CONTRACTNO,COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC,EBTAPPLYOKRTN, DEVELOPERID " _
         &"FROM RTEBTCmtyLINE WHERE COMQ1=0 "
  sqlList="SELECT  COMQ1, LINEQ1, CONSIGNEE, AREAID, GROUPID, SALESID, LINEIP, GATEWAY, SUBNET, DNSIP, PPPOEACCOUNT, PPPOEPASSWORD, " _
         &"LINETEL, LINERATE, CUTID, TOWNSHIP, VILLAGE, COD1, NEIGHBOR, COD2, STREET, COD3, SEC, COD4, LANE, COD5, ALLEYWAY, COD7, " _
         &"NUM, COD8, FLOOR, COD9, ROOM, COD10, ADDROTHER, RZONE, CUTID1, TOWNSHIP1, RADDR1, RZONE1, CUTID2, TOWNSHIP2, RADDR2, " _
         &"RZONE2, RCVDAT, INSPECTDAT, AGREE, UNAGREEREASON, TECHCONTACT, TECHENGNAME, CONTACT1, CONTACT2, CONTACTMOBILE, CONTACTTEL, " _
         &"CONTACTEMAIL, CONTACTTIME1, CONTACTTIME2, UPDEBTCHKDAT, UPDEBTCHKUSR, UPDEBTDAT, EBTREPLYDAT, EBTREPLAYCODE, PROGRESSID, HINETNOTIFYDAT, " _
         &"ADSLAPPLYDAT, APPLYUPLOADDAT, APPLYUPLOADUSR, APPLYUPLOADTNS,EBTERRORCODE, SUPPLYRANGE,COBOSS,COBOSSENG,COID,COBOSSID,APPLYNAMEC, " _
         &"APPLYNAMEE,ENGADDR,CONTACTSTRTIME,CONTACTENDTIME, ADSLAPPLYUSR,APPLYPRTNO,MEMO,APPLYNO,SCHAPPLYDAT,CHTRCVD,SUGGESTTYPE,REPEATREASON,TELCOMROOM,eusr,edat,uusr,udat,LOANNAME,LOANSOCIAL,DROPDAT,CANCELDAT,   " _
         &"MOVETOCOMQ1,movetolineq1,movetodat,movefromcomq1,movefromlineq1,movefromdat,CONTRACTNO,COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC,EBTAPPLYOKRTN, DEVELOPERID " _
         &"FROM RTEBTCmtyLINE WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    '�ˬd�ӥD�u�����ݤ����ϬO�_��"�i�ظm"����==>�Y���i�ظm,�h�~�i�ӽХD�u
    Set connXX=Server.CreateObject("ADODB.Connection")
    Set rsXX=Server.CreateObject("ADODB.Recordset")
    connXX.open DSN
    SQLXX="SELECT * FROM RTEBTCMTYH WHERE COMQ1=" & DSPKEY(0)
    RSXX.Open sqlXX,CONNXX
    errcode=""
    IF RSXX.EOF THEN
       ERRCODE="1"
    ELSE
       IF RSXX("AGREE") <> "Y" then
          ERRCODE="2"
       ELSE
          ERRcode=""
       END IF
    END  IF
    RSXX.Close
    CONNXX.Close
    SET RSXX=NOTHING
    SET CONNXX=NOTHING
    
    if len(trim(DSPKEY(1))) = 0 THEN DSPKEY(1)=0
    if len(trim(DSPKEY(4))) = 0 THEN DSPKEY(4)=""
    if dspkey(55) <> "01" and dspkey(55) <>"02" then dspkey(55)=""
    if dspkey(56) <> "01" and dspkey(56) <>"02" then dspkey(56)=""       
    if dspkey(46) <> "Y" and dspkey(46) <>"N" then dspkey(46)=""         
    IF LEN(TRIM(DSPKEY(96))) = 0 OR DSPKEY(96) = "" THEN DSPKEY(96)=0
    IF LEN(TRIM(DSPKEY(97))) = 0 OR DSPKEY(97) = "" THEN DSPKEY(97)=0
    IF LEN(TRIM(DSPKEY(99))) = 0 OR DSPKEY(99) = "" THEN DSPKEY(99)=0
    IF LEN(TRIM(DSPKEY(100))) = 0 OR DSPKEY(100) = "" THEN DSPKEY(100)=0
    If len(trim(dspKey(0))) <= 0 Then
       dspkey(0)=0
    END IF       
    If len(trim(dspkey(44)))=0 or Not Isdate(dspkey(44)) then
       formValid=False
       message="����餣�i�ťթή榡���~"    
    elseif len(trim(dspkey(2))) >0 and len(trim(dspkey(5))) > 0 then
       formValid=False
       message="[�g�P��]��[���P�~��]���ФŦP�ɶ�J���"
    elseif len(trim(dspkey(2))) =0 and len(trim(dspkey(5))) = 0 then   
       formValid=False
       message="[�g�P��]��[���P�~��]���оܤ@��J���"
    elseif len(trim(dspkey(70)))=0 then
       formValid=False
       message="���q�t�d�H����m�W���i�ť�"    
    elseif len(trim(dspkey(72)))=0 then
       formValid=False
       message="�ӽвΤ@�s�����i�ť�"    
    elseif len(trim(dspkey(71)))=0 then
       formValid=False
       message="���q�t�d�H�^��m�W���i�ť�"      
    elseif len(trim(dspkey(73)))=0 then
       formValid=False
       message="���q�t�d�H�����Ҹ����i�ť�"       
    elseif len(trim(dspkey(74)))=0 then
       formValid=False
       message="�ӽФH�Τ��q����W�٤��i�ť�"   
    elseif len(trim(dspkey(75)))=0 then
       formValid=False
       message="�ӽФH�Τ��q�^��W�٤��i�ť�"       
    elseif len(trim(dspkey(14)))=0 then
       formValid=False
       message="�˾��a�}(����)���i�ť�"   
    elseif len(trim(dspkey(15)))=0 and dspkey(14)<>"06" and dspkey(14)<>"15" then
       formValid=False
       message="�˾��a�}(�m��)���i�ť�"    
    elseif len(trim(dspkey(21)))=0 then
       formValid=False
       message="�˾��a�}(��/��)���i�ť�"          
    elseif len(trim(dspkey(22))) > 0 AND DSPKEY(22) <="�@" AND DSPKEY(22) >= "�E" then
       formValid=False
       message="�˾��a�}(�q)����������Ʀr(�@~�E)"                 
    elseif len(trim(dspkey(29)))=0 then
       formValid=False
       message="�˾��a�}(��)���i�ť�"           
    elseif len(trim(dspkey(69)))=0 then
       formValid=False
       message="�D�u�i�Ѹ˽d�򤣥i�ť�"       
    elseif len(trim(dspkey(36)))=0 or len(trim(dspkey(37)))=0 or len(trim(dspkey(38)))=0 or len(trim(dspkey(39)))=0 then
       formValid=False
       message="���y�a�}/��~����a�}���i�ťթΤ�����"     
    elseif len(trim(dspkey(76)))=0 then
       formValid=False
       message="���y�a�}/��~�^��a�}���i�ť�"      
    elseif len(trim(dspkey(40)))=0 or len(trim(dspkey(41)))=0 or len(trim(dspkey(42)))=0 or len(trim(dspkey(43)))=0 then
       formValid=False
       message="�b��a�}���i�ťթΤ�����"   
    elseif len(trim(dspkey(50)))=0 then
       formValid=False
       message="�s���H���i�ť�"     
    elseif len(trim(dspkey(53)))=0 and len(trim(dspkey(52)))=0 then
       formValid=False
       message="�s���H�q�ܩΦ�ʹq�ܤ��i�Ҫť�"   
    elseif len(trim(dspkey(48)))=0 then
       formValid=False
       message="�޳N�s���H���i�ť�"               
    elseif len(trim(dspkey(55)))=0 or len(trim(dspkey(56)))=0 or len(trim(dspkey(77)))=0 or len(trim(dspkey(78)))=0 then
       formValid=False
       message="��K�p���ɶ����i�ťթΤ�����"   
    elseif len(trim(dspkey(13)))=0 then
       formValid=False
       message="�D�u�t�v���i�ť�"    
    elseif (len(trim(dspkey(92))) <> 0 and len(trim(dspkey(93))) = 0 ) or   (len(trim(dspkey(92))) = 0 and len(trim(dspkey(93))) <> 0 ) then
       formValid=False
       message="�ǦW�˾��ɡA�Τ�W�٤Ψ����Ҹ������P�ɦs�b"    
    elseif len(trim(DSPKEY(85))) = 0  THEN
       formValid=False
       message="�п�ܫ�ĳ�e��覡"        
    elseif len(trim(DSPKEY(93)))  <> 0 AND  len(trim(DSPKEY(93)))  <> 10 AND  len(trim(DSPKEY(93)))  <> 8 THEN
       formValid=False
       message="�����Ҧr�����פ���(������10�X)"                             
    elseif DSPKEY(46)<> "" AND LEN(TRIM(DSPKEY(45)))=0 THEN
       formValid=False
       message="�п�J�ɬd���"                                                                                                                                                            
    elseif DSPKEY(46)="N" AND LEN(TRIM(DSPKEY(47)))=0 THEN
       formValid=False
       message="�ɹ���i�ظm�ɥ�����J��]"  
    elseif len(trim(DSPKEY(57))) > 0 and dspkey(46)<>"Y" THEN
       formValid=False
       message="�D�u�ӽХ������ɬd��[�i�ظm]���A"    
    elseif len(trim(DSPKEY(57))) > 0 and errcode="1" THEN
       formValid=False
       message="�D�u���ݤ����ϰ��ɤ��s�b�A���ˬd!"     
    elseif len(trim(DSPKEY(57))) > 0 and errcode="2" THEN
       formValid=False
       message="�D�u���ݤ����ϰ��ɥ�����(�i�ظm)�~�i�ӽ�"    
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(9)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA�D�u[�����q��]���i�ť�"                   
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(6)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA(�D�u����IP)���i�ť�"     
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(8)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA(�D�u����subnet)���i�ť�"         
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(7)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA(�D�u����Gateway IP)���i�ť�"     
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(9)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA(�D�u����DNS IP)���i�ť�"     
    elseif len(trim(DSPKEY(83))) > 0 and len(trim(dspkey(82)))=0 THEN
       formValid=False
       message="�D�u(CHT�w�w�I�u��)��J�ɡA(���عq�H�����p��s��)���i�ť�"            
    elseif len(trim(DSPKEY(64))) > 0 and len(trim(dspkey(83)))=0 THEN
       formValid=False
       message="�D�u���q��A(CHT�w�w�I�u��)���i�ť�"          
    elseif len(trim(DSPKEY(92))) = 0  THEN
       formValid=False
       message="�ǦW�Τ�W�٤��i�ť�"            
    elseif len(trim(DSPKEY(93))) = 0 OR (len(trim(dspkey(93))) <> 8 AND len(trim(dspkey(93))) <> 10) THEN
       formValid=False
       message="�ǦW�Τᨭ���Ҹ����i�ťթΪ��פ��ŦX8�X��10�X"                      
   ' elseif len(trim(DSPKEY(64))) > 0 and len(trim(dspkey(79)))=0 and dspkey(2) = "" THEN
   '    formValid=False
   '    message="�D�u���q��D�g�P�Ӷ}�o�̥�����J�D�u���q�H��"      
    elseif len(trim(DSPKEY(64))) > 0 and len(trim(dspkey(79)))<>0 and dspkey(2) <> "" THEN
       formValid=False
       message="�D�u���q��g�P�Ӷ}�o�̥D�u���q�H�������ť�"    
    'elseif len(trim(DSPKEY(82))) > 0 and len(trim(dspkey(82)))<>12 and len(trim(dspkey(82)))<>7 and len(trim(dspkey(82)))<>16 THEN
    '   formValid=False
    '   message="�D�u�p��s�����ץ�����7��12��16�X"
    elseif len(trim(DSPKEY(65))) > 0 and len(trim(dspkey(102)))=0 THEN
       formValid=False
       message="�D�u���q�^���ɡA�D�u�X���s�����i�ť�"                 
    end if
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(90)=V(0)
        dspkey(91)=datevalue(now())
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
   Sub Srcounty15onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY14").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key15").value =  trim(Fusrid(0))
          document.all("key35").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub       
   Sub Srcounty37onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY36").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key37").value =  trim(Fusrid(0))
          document.all("key39").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB
   Sub Srcounty41onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY40").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key41").value =  trim(Fusrid(0))
          document.all("key43").value =  trim(Fusrid(1))
       End if       
       end if
    END SUB    
   'Sub Srsalesgrouponclick()
   '    prog="RTGetsalesgroupD.asp"
   '    prog=prog & "?KEY=" & document.all("KEY3").VALUE 
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key4").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub
   Sub Srsalesonclick()
       prog="RTGetsalesD.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE & ";"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key5").value =  trim(Fusrid(0))
          document.all("key48").value = trim(Fusrid(1))
       End if       
       end if
   End Sub      
   Sub Srsales79onclick()
       prog="RTGetsalesD2.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE 
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key79").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY110").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key110").value =  trim(Fusrid(0))
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
   'Sub SrTAG2()
   '   ' msgbox window.SRTAB1.style.display
   '    if window.SRTAB2.style.display="" then
   '       window.SRTAB2.style.display="none"
   '    elseif window.SRTAB2.style.display="none" then
   '       window.SRTAB2.style.display=""
   '    end if
   'End Sub          
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
   Sub SrOPT1CLICK()
      ' msgbox window.SRTAB1.style.display
       if document.all("OPT1").checked=true then
          optvalue="Y"
       ELSE
          optvalue="N"
       END IF
       IF OPTVALUE="Y" THEN
          document.all("KEY92").VALUE="�Ȥӽu�W�A�Ȫѥ��������q"
          document.all("KEY93").VALUE="70454686"
          document.all("KEY41").VALUE="�n���"
          document.all("KEY42").VALUE="�T����19-5��8��(�Ȥӽu�W�u�ȳ�)"
          document.all("KEY43").VALUE="115"
          document.all("OPT2").checked=false
          document.all("KEY92").CLASSNAME="dataListDATA"
          document.all("KEY92").READONLY=TRUE
          document.all("KEY93").CLASSNAME="dataListDATA"
          document.all("KEY93").READONLY=TRUE
       END IF
   End Sub                   
   Sub SrOPT2CLICK()
      ' msgbox window.SRTAB1.style.display
       if document.all("OPT2").checked=true then
          optvalue="Y"
       ELSE
          optvalue="N"
       END IF
       IF OPTVALUE="Y" THEN
          document.all("KEY92").VALUE=""
          document.all("KEY93").VALUE=""
          document.all("KEY41").VALUE="�n���"
          document.all("KEY42").VALUE="�T����19-8��6��(�֤��q�H�ѥ������q)"
          document.all("KEY43").VALUE="115"
          document.all("OPT1").checked=false
          document.all("KEY92").CLASSNAME="dataListENTRY"
          document.all("KEY92").READONLY=FALSE
          document.all("KEY93").CLASSNAME="dataListENTRY"
          document.all("KEY93").READONLY=FALSE
       END IF
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
       <tr><td width="20%" class=dataListHead>���ϧǸ�</td><td width="25%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(0)%>" maxlength="8" class=dataListdata></td>
<td width="20%" class=dataListHead>�D�u�Ǹ�</td><td width="25%"  bgcolor="silver">
           <input type="text" name="key1"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(1)%>" maxlength="8" class=dataListdata></td>                 </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(88))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(88)=V(0)
				dspKey(46)="Y"						'�i�_�ظm
                dspkey(48)=SrGetEmployeeName(V(0))	
                dspkey(50)=SrGetEmployeeName(V(0))
                dspkey(52)="0913-055173"
                dspkey(53)="02-26552888"
                dspkey(54)="internal@cbbn.com.tw"
				dspkey(55)="01"
				dspkey(56)="02"
				dspkey(77)="9"
				dspkey(78)="18"
        End if  
       dspkey(89)=now()
    else
        if len(trim(dspkey(90))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(90)=V(0)
        End if         
        dspkey(91)=now()
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '�D�u�ӽ����ɫ�(DSPKEY59),�򥻸�� protect
    '920218�אּ�H�D�u�ӽаe��渹�������IDSPKEY(80)
    If len(trim(dspKey(80))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       FIELDPC=" DISABLED "
    Else
       fieldPa=""
       FIELDPC=""
    End If
    
    '�D�u�}�q�^�����ɫ�(DSPKEY(67)),�����άI�u�i����� protect   
    '920218�אּ�D�u�ӽг�C�L��,�����άI�u���PROTECT 
    If len(trim(dspKey(65))) > 0 Then
       fieldPb=" class=""dataListData"" readonly "
       fieldPa=" class=""dataListData"" readonly "
       FIELDPD=" DISABLED "
    Else
       fieldPb=""
       FIELDPD=""
    End If
    
    If len(trim(dspKey(65))) > 0 Then
       fieldPE=" class=""dataListData"" readonly "
       fieldPa=" class=""dataListData"" readonly "
       FIELDPF=" DISABLED "
    Else
       fieldPE=""
       FIELDPF=""
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
  <span id="tags1" class="dataListTagsOn">AVS�D�u��T</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>     
    <DIV ID="SRTAG0" onclick="srtag0" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�򥻸��</td></tr></table></div>
 <DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">

<tr><td width="15%" class=dataListSearch>�����</td>
    <td bgcolor="silver" colspan=3>
        <input type="text" name="key44" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(44)%>"  READONLY size="10" class=dataListEntry>
       <input  type="button" id="B44"  <%=FIELDPC%>  <%=FIELDPF%>  name="B44" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPC%>  <%=FIELDPF%>  alt="�M��" id="C44"  name="C44"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
                             </td>
</tr>

<tr><td class=dataListSearch>�˾��a�}</td>
    <td bgcolor="silver" COLSPAN=3>
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND len(trim(dspKey(59))) = 0   AND FIELDPA = "" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(14))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(����)</option>"       
       SXX15=" onclick=""Srcounty15onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(14) & "' " 
       SXX15=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(14) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key14" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="key15" readonly  size="8" value="<%=dspkey(15)%>" readonly <%=fieldpA%><%=fieldpB%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font size=2>(�m��)                 
         <input type="button" id="B15"   <%=FIELDPC%>  <%=FIELDPF%>  name="B15"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX15%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPC%>  <%=FIELDPF%>  alt="�M��" id="C15"  name="C15"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        
        <input type="text" name="key16" <%=fieldpA%> size="10" value="<%=dspkey(16)%>" maxlength="10" <%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key17" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                            
        <%=s%></select>      
        <input type="text" name="key18"  size="6" value="<%=dspkey(18)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text6"><font size=2>
        <% aryOption=Array("�F")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key19" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                            
        <%=s%></select>              
        <input type="text" name="key20" size="10" value="<%=dspkey(20)%>" maxlength="10" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text27"><font size=2>
        <% aryOption=Array("��","��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key21" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                            
        <%=s%></select>                      
        <input type="text" name="key22"  size="6" value="<%=dspkey(22)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text29"><font size=2>
        <% aryOption=Array("�q")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1   AND FIELDPA = ""  Then
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
       <select size="1" name="key23" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select6">                                            
        <%=s%></select>
        <input type="text" name="key24" size="6" value="<%=dspkey(24)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text30"><font size=2>
        <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1   AND FIELDPA = ""  Then
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
		<select size="1" name="key25" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select9">                                            
			<%=s%>
		</select>        
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="text" name="key35"  readonly size="8" value="<%=dspkey(35)%>"
			<%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text35">
		(�l���ϸ�)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
        <input type="text" name="key26" size="10" value="<%=dspkey(26)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text31"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key27" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select10">                                            
        <%=s%></select>    
        <input type="text" name="key28" size="6" value="<%=dspkey(28)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text32"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key29" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select11">                                            
        <%=s%></select>            
        <input type="text" name="key30" size="10" value="<%=dspkey(30)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text33"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1    AND FIELDPA = "" Then
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
       <select size="1" name="key31" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select12">                                            
        <%=s%></select>
        <input type="text" name="key32" size="6" value="<%=dspkey(32)%>" maxlength="6" <%=fieldpA%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34"><font size=2>
                <% aryOption=Array("��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1   AND FIELDPA = ""  Then
      For i = 0 To Ubound(aryOption)
          If dspKey(33)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(33) &""">" &dspKey(33) &"</option>"
   End If%>                                  
       <select size="1" name="key33" <%=fieldpA%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select13">                                            
        <%=s%></select>

        </td>                                 
</tr>

<tr><td class=dataListHEAD >�]�Ʀ�m</td>
	<td bgcolor="silver" COLSPAN=3>
		<input type="text" name="key34" size="90" value="<%=dspkey(34)%>" maxlength="30" <%=fieldpb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text64">             
</tr>

<tr><td class=dataListHEAD >�q�H��/�c��m</td>
	<td bgcolor="silver" COLSPAN=3>
		<input type="text" name="key87" size="90" value="<%=dspkey(87)%>" maxlength="60" <%=fieldpb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text68">             
</tr>
<tr><td class=dataListSearch >�i�Ѹ˽d��</td>
<td bgcolor="silver" COLSPAN=3>
<input type="text" name="key69" size="90" value="<%=dspkey(69)%>" maxlength="90" <%=fieldpB%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text62">
</tr>

<tr>                                 
        <td  class="dataListHEAD" height="23">�s���H�m�W</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key50" size="15" value="<%=dspKey(50)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text8"></td>        
        <input type="text" name="key51" STYLE="DISPLAY:NONE" size="15" value="<%=dspKey(51)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text36"></td>           
        <td  class="dataListHEAD" height="23">�s���q��(�դ�)</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key53" size="15" maxlength="15" value="<%=dspKey(53)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text7"></td>                                 
 
 </tr>        
<TR>        
        <td  class="dataListHEAD" height="23">��ʹq��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key52" size="20" maxlength="20" value="<%=dspKey(52)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text9"></td>                                 
        <td  class="dataListHEAD" height="23">�s��EMAIL</td>        
        <td  height="23" bgcolor="silver" ><input type="text" name="key54" size="30" maxlength="30" value="<%=dspKey(54)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text16"></td>                                 
 </tr>
 <tr>                               
        <td  rowspan=2 class="dataListHEAD" height="23">�޳N�s���H</td>                                 
        <td  height="23" bgcolor="silver"><font size=2>����J</font>
        <input type="text" name="key48" size="15" value="<%=dspKey(48)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text1"></td>
        <td  rowspan=2 class="dataListHEAD" height="23">��K�p���ɶ�</td>                                 
		<%  
			dim sexd1, sexd2
			If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
				sexd1=""
				sexd2=""
			Else
				' sexd1=" disabled "
				' sexd2=" disabled "
			End If
			If dspKey(55)="01" Then sexd1=" checked "    
			If dspKey(55)="02" Then sexd2=" checked " 
		%>            
        <td  height="23" bgcolor="silver">
			<input type="RADIO" <%=sexd1%> name="key55" size="1" value="01" <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" >�g�@~�g��
			<input type="RADIO" <%=sexd2%> name="key55" size="1" value="02" <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Checkbox1">�g��~�g��</td>
	</tr>
	<tr>        
        <td  height="23" bgcolor="silver"><font size=2>�^��J</font>
        <input type="text" name="key49" size="15" value="<%=dspKey(49)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text3"></td>           
        <td  height="23" bgcolor="silver">
<%  dim sexd3, sexd4
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       sexd3=""
       sexd4=""
    Else
      ' sexd1=" disabled "
      ' sexd2=" disabled "
    End If
    If dspKey(56)="01" Then sexd3=" checked "    
    If dspKey(56)="02" Then sexd4=" checked " %>         
        <input type="text" name="key77" size="2" value="<%=dspKey(77)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text49">�I��
        <input type="text" name="key78" size="2" value="<%=dspKey(78)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text50">�I(
        <input type="RADIO" <%=sexd3%> name="key56" size="1" value="01"     <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Checkbox2">�W��
        <input type="RADIO" <%=sexd4%> name="key56" size="1" value="02"    <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Checkbox3">�U��)
        </td>                     
 </tr> 
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
	    <input type="text" name="key88" size="6" READONLY value="<%=dspKey(88)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2">
	    <font size=2><%=SrGetEmployeeName(dspKey(88))%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key89" size="25" READONLY value="<%=dspKey(89)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
		    <input type="text" name="key90" size="6" READONLY value="<%=dspKey(90)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2">
		    <font size=2><%=SrGetEmployeeName(dspKey(90))%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key91" size="25" READONLY value="<%=dspKey(91)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>                
</table> </div>
<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
    -->
    <DIV ID="srtag6" onclick="srtag6" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table10">
    <tr><td bgcolor="BDB76B" align="LEFT">�ǦW�˾�</td></tr></table></div>
     <DIV ID="srtab6" >
     <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table11">    
     <tr><td colspan=4>
     <% '��D�u���ӽЫe�~�i�ܧ�ɦW�˾����
     IF LEN(TRIM(DSPKEY(57))) > 0 THEN
        SROPT1=""
        SROPT2=""
        OPT1=" DISABLED "
        OPT2=" DISABLED "
     ELSE
        SROPT1=" ONCLICK=""SROPT1CLICK()"" "
        SROPT2=" ONCLICK=""SROPT2CLICK()"" "
        OPT1=""
        opt2=""
     END IF
     %>
     <input type="checkbox" <%=OPT1%> name="OPT1" ID="OPT1" size="1" VALUE="1" <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" <%=SROPT1%>><FONT size=2>�w�]��</FONT>
     <input type="checkbox" <%=OPT2%> name="OPT2" ID="OPT2" size="1" VALUE="2" <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry"  <%=SROPT2%>><FONT size=2>�ǦW�ӽ�</FONT>     
     </td></tr>
     <tr>
     <td  WIDTH="15%" class="dataListHead" height="23">�ɦW�Τ�W��</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
<%if DSPKEY(92)="" THEN DSPKEY(92)="�Ȥӽu�W�A�Ȫѥ��������q" %>             
        <input type="text" name="key92" size="30"  maxlength="10" value="<%=dspKey(92)%>"  <%=fieldpb%><%=fieldRole(1)%>  readonly class="dataListDATA" ID="Text69"></td>        
      <td  WIDTH="15%" class="dataListHead" height="23">�ɦW�Τᨭ���Ҹ�</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
<%if DSPKEY(93)="" THEN DSPKEY(93)="70454686" %>             
        <input type="password" name="key93" size="20"  maxlength="10" value="<%=dspKey(93)%>"  <%=fieldpb%><%=fieldRole(1)%>  readonly class="dataListDATA" ID="Text70"></td>        
   </tr>
<tr><td rowspan=2 class=dataListHEAD>���q�t�d�H<br>(�ӤH�ӽЧK��)</td>
    <td  bgcolor="silver" ><font size=2>����J</font>
    <%if dspkey(70)="" then dspkey(70)="��K��" %>
        <input type="text" name="key70" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(70)%>"  readonly size="10" class=dataListdata ID="Text22"></td>
<td width="15%" class=dataListHEAD>�ӽФH�Τ@�s��</td>
    <td width="35%" bgcolor="silver" >
    <%if dspkey(72)="" then dspkey(72)="70454686" %>    
        <input type="text" name="key72" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(72)%>"  readonly  size="10" class=dataListDATA ID="Text23"></td>               
</tr>
<tr>
    <td  bgcolor="silver" ><font size=2>�^��J</font>
    <%if dspkey(71)="" then dspkey(71)="LAI-CHUN-TIAN" %>        
        <input type="text" name="key71" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(71)%>"  readonly  size="30" class=dataListDATA ID="Text24"></td>
<td  class=dataListHEAD>�t�d�H�����Ҧr��</td>
    <td  bgcolor="silver" >
    <%if dspkey(73)="" then dspkey(73)="B101362010" %>            
        <input type="password" name="key73" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(73)%>"  readonly  size="10" class=dataListDATA ID="Text25"></td>               
</tr>
<tr><td rowspan=2 class=dataListHEAD>�ӽФH�m�W<br>/���q�W��</td>
    <td  bgcolor="silver" colspan=3><font size=2>����J</font>
	<%
    Set connXX=Server.CreateObject("ADODB.Connection")
    Set rsXX=Server.CreateObject("ADODB.Recordset")
    connXX.open DSN
    SQLXX="SELECT * FROM  RTCounty RIGHT OUTER JOIN RTEBTCMTYH ON RTCounty.CUTID = RTEBTCMTYH.CUTID WHERE COMQ1=" & DSPKEY(0)
    RSXX.Open sqlXX,CONNXX
    errcode=""
    IF RSXX.EOF THEN
       comn=""
    '   areanc=""
    ELSE
       comn=rsxx("comn")
    '   if rsxx("ebtarea")="N" THEN
    '      AREANC="�_��"
    '   ELSEIF rsxx("ebtarea")="M" THEN
    '      AREANC="����"
    '   ELSEIF rsxx("ebtarea")="S" THEN
    '      AREANC="�n��"
    '   ELSE
    '      AREANC=""
    '   END IF   
    END  IF
    RSXX.Close
    CONNXX.Close
    SET RSXX=NOTHING
    SET CONNXX=NOTHING    
    'if dspkey(74)="" then dspkey(74)="�F�˼e�W�q�H�ѥ��������q-�ӤH����" & AREANC & "�~�ȳB-" & comn & "����" 
             
	if dspkey(74)="" then dspkey(74)="�Ȥӽu�W�A�Ȫѥ��������q-���T�e�W-" & comn & "����" 
	%>         
        <input type="text" name="key74" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="80"
               value="<%=dspKey(74)%>"  readonly  size="80" class=dataListDATA ID="Text26"></td>
</tr>
<tr>
    <td  bgcolor="silver" colspan=3><font size=2>�^��J</font>
    <%if dspkey(75)="" then dspkey(75)="Eastern Broadband Telecom Co., Ltd" %>         
        <input type="text" name="key75" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="50"
               value="<%=dspKey(75)%>"  readonly  size="50" class=dataListDATA ID="Text28"></td>
</tr>

<tr><td class=dataListHEAD rowspan=2>���y�a�}<br>/��~�a�}</td>
    <td bgcolor="silver" COLSPAN=3><font size=2>����J</font>
  <%s=""
    sx=" selected "
    IF DSPKEY(36)="" THEN 
       DSPKEY(36)="04"
    end if
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  AND len(trim(dspKey(59))) = 0   AND FIELDPA = "" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='04' " 
       If len(trim(dspkey(36))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
  '    SXX37=" onclick=""Srcounty37onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(36) & "' and cutid='04' " 
       SXX37=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(36) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>
         <select size="1" name="key36"   <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListDATA" ID="Select7"><%=s%></select>
<%if DSPKEY(37)="" THEN DSPKEY(37)="�H�q��" %>        
        <input type="text" name="key37" size="8" value="<%=dspkey(37)%>" maxlength="10"  readonly <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text10"><font size=2>(�m��)                 
         <input type="button" id="B37"  <%=FIELDPC%>  <%=FIELDPF%>   name="B37"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX37%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=FIELDPC%> <%=FIELDPF%> alt="�M��" id="C37"  name="C37"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
<%if DSPKEY(38)="" THEN DSPKEY(38)="�Q����277��10��(�ӤH�����~�ȳ�)" %>        
        <input type="text" name="key38"  readonly size="40" value="<%=dspkey(38)%>" maxlength="60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text11"><font size=2>�l���ϸ�</font>  
<% IF DSPKEY(39)="" THEN DSPKEY(39)="110" %>
<input type="text" name="key39" size="5"   READONLY value="<%=dspKey(39)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text15">               
        </td>                                            
    </TR>
    <TR>
    <td bgcolor="silver" COLSPAN=3><font size=2>�^��J</font>
<% IF DSPKEY(76)="" THEN DSPKEY(76)="277 Sung Jen Rd., Taipei 110, Taiwan, R.O.C. " %>       
        <input type="text" name="key76" readonly size="60" value="<%=dspkey(76)%>" maxlength="60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text45"><font size=2>        
      </td>                                         
</tr>  
<tr><td class=dataListHEAD>ADSL�b�H�a�}</td>
    <td bgcolor="silver" COLSPAN=3><font size=2>����J</font>
  <%s=""
    sx=" selected "
    IF DSPKEY(40)="" THEN 
       DSPKEY(40)="04"
    end if
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  AND len(trim(dspKey(59))) = 0   AND FIELDPA = "" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='04'" 
       If len(trim(dspkey(40))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
   '    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
    '   SXX41=" onclick=""Srcounty41onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(40) & "' and cutid='04'" 
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
         <select size="1" name="key40"  <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListDATA" ID="Select8"><%=s%></select>
<%if DSPKEY(41)="" THEN DSPKEY(41)="�n���" %>          
        <input type="text" name="key41" size="8" value="<%=dspkey(41)%>" maxlength="10"   readonly <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text12"><font size=2>(�m��)                 
         <input type="button" id="B41"  <%=FIELDPC%>  <%=FIELDPF%>   name="B41"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX41%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPC%>  <%=FIELDPF%>  alt="�M��" id="C41"  name="C41"   style="Z-INDEX: 1" <%=fieldpC%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
<%if DSPKEY(42)="" THEN DSPKEY(42)="�T����19-5��8��(�Ȥӽu�W�u�ȳ�)" %>             
        <input type="text" name="key42"   readonly size="40" value="<%=dspkey(42)%>" maxlength="60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text13"><font size=2>�l���ϸ�</font>  
<% IF DSPKEY(43)="" THEN DSPKEY(43)="115" %>
<input type="text" name="key43" size="5"   READONLY value="<%=dspKey(43)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text14">               
                     
</tr>        


   </table>
   </div></div>
   <DIV ID="SRTAG1" onclick="srtag1" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="LEFT">�Z���k��</td></tr></table></div>
     <DIV ID=SRTAB1>

    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">

<tr><td id="tagT1" WIDTH="15%" class="dataListSearch" height="23">���P�~��</td>               
	<%  
	If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(dspKey(59))) = 0  Then 
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '3') "
       s="<option value="""" >(���P)</option>"
    Else
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '3') "
       s="<option value="""" >(���P)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(���P�~��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("areaid")=dspkey(3) Then sx=" selected "
       s=s &"<option value=""" &rs("areaid") &"""" &sx &">" &rs("areanc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>
	<td  WIDTH="85%" height="23" bgcolor="silver" colspan=3>
           <select size="1" name="key3" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select1">
              <%=s%>
           </select>

        <input type="TEXT" name="key5" <%=fieldRole(1)%><%=dataProtect%> 
               size="7" value="<%=dspKey(5)%>"  readonly class="dataListDATA" >
           <input type="BUTTON" id="B5" name="B5" <%=fieldRole(1)%> width="100%" style="Z-INDEX: 1"  value="...." onclick="Srsalesonclick()"  >   
           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldRole(1)%> alt="�M��" id="C5"  name="C5"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
           <font size=2><%=SrGetEmployeeName(dspKey(5))%></font>
        </td></tr>

	<tr><td width="15%" class=dataListSearch>�g�P��</td>
	<%
	If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 AND len(trim(dspKey(59))) = 0   AND FIELDPA = "" Then 
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '02') order by RTObj.SHORTNC "
       s="<option value="""" >(�g�P��)</option>"
    Else
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID,RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '02')  and rtobj.cusid='" & dspkey(2) & "' "
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�g�P��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CUSID")=dspkey(2) Then sx=" selected "
       s=s &"<option value=""" &rs("CUSID") &"""" &sx &">" &rs("SHORTNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>
		<td width="35%" bgcolor="silver" >
           <select size="1" name="key2" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select34">                                            
              <%=s%>
           </select></td>               

		<td WIDTH="15%" class="dataListHEAD" height="23">�G�u�t�d�H</td>
		<td width="35%"><input type="text" name="key110"value="<%=dspKey(110)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text82">
			<input type="BUTTON" id="B110" name="B110" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldRole(1)%> alt="�M��" id="C110" name="C110" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
           <font size=2><%=SrGetEmployeeName(dspKey(110))%></font>
		</td>
	</tr>

  </DIV> 
  </DIV>   

<!--
	<DIV ID="SRTAG2" onclick="srtag2" style="cursor:hand">
	 <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
		<tr><td bgcolor="BDB76B" align="LEFT">ADSL�A�Ȥ��e</td></tr>
	 </table>
	</DIV>
    <DIV ID=SRTAB2 >
     <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
	 </table>     
	</DIV>
-->
  
    <DIV ID="SRTAG3" onclick="srtag3" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
    <tr><td bgcolor="BDB76B" align="LEFT">�������</td></tr></table></DIV>
   <DIV ID=SRTAB3 > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table5">

	<tr><td  WIDTH="15%" class="dataListHEAD" height="23">�D�u�t�v</td>               
        <td  WIDTH="35%" height="23" bgcolor="silver" >
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(dspKey(59))) = 0  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' order by parm1" 
       If len(trim(dspkey(13))) < 1 Then
          sx=" selected " 
       end if     
       s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"  
       sx=""
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' AND CODE='" & dspkey(13) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If (rs("CODE")=dspkey(13)) or (len(trim(dspkey(13))) < 1 and rs("code")="18" )  Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>
   <select size="1" name="key13" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
        <%=s%>
   </select>
        </td>
        <td  WIDTH="15%" class="dataListSEARCH" height="23">�����q��</td>                                 
	<%
	If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(dspKey(59))) = 0 AND len(trim(dspKey(12))) = 0 Then  
		rs.open "select max(lineq1) AS lineq1 from rtEBTcmtyline where comq1=" & dspkey(0) ,conn
		if len(rs("lineq1")) > 0 then
			cusidxx=right("0" & Cstr(rs("lineq1") + 1), 2)
		else
			cusidxx="01"
		end if
        rs.Close
		dspkey(12)="00-11" & right("000" & Cstr(dspkey(0)), 4) & cusidxx
	End If
	%>
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key12" size="15" maxlength="15" value="<%=dspKey(12)%>"  <%=fieldpB%><%=fieldRole(1)%> class="dataListEntry" ID="Text43"></td>                                 
                              
 </tr>        

<tr>                                 
        <td  WIDTH="15%" class="dataListHEAD" height="23">�D�u����IP</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key6" size="20" Readonly value="<%=dspKey(6)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData" ></td>        
        <td  WIDTH="15%" class="dataListHEAD" height="23">�D�uSUBNET</td>                                 
   <% aryOption=Array("","255.255.255.0","255.255.255.128")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1  AND FIELDPB = "" Then 
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
        <td width="35%" height="23" bgcolor="silver">
        <select size="1" readonly name="key8" <%=fieldpB%><%=fieldRole(1)%><%=dataProtect%> class="dataListData">
        <%=s%>
        </select></td>                    
      </td>                                 
 
 </tr>        
<tr>                                 
        <td  class="dataListHEAD" height="23">�h�DIP(Gateway)</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key7" size="20" readonly value="<%=dspKey(7)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData"></td>        
        <td  class="dataListHEAD" height="23">DNS IP</td>                                 
        <td  height="23" bgcolor="silver">
        <%
        IF LEN(TRIM(DSPKEY(9)))=0 THEN DSPKEY(9)="203.79.224.30"
        %>
        <input type="text" name="key9" size="20" Readonly value="<%=dspKey(9)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData"></td>
 </tr>     
<tr>                                 
        <td  class="dataListHEAD" height="23">CHT�p��s��</td>                                 
        <td  height="23" bgcolor="silver" >
        <input type="text" name="key82" size="16" readonly value="<%=dspKey(82)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData"></td>
        <td  class="dataListHEAD" height="23">EBT�D�u�X���s��</td>
        <td  height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key102" size="16" readonly value="<%=dspKey(102)%>"  <%=fieldRole(5)%> class="dataListData"></td>
 <tr>                                 
        <td  class="dataListHEAD" height="23">PPPOE�����b��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key10" size="10" readonly value="<%=dspKey(10)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData" ID="Text41"></td>
        <td  class="dataListHEAD" height="23">PPPOE�����K�X</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key11" size="10" readonly value="<%=dspKey(11)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListData" ID="Text42"></td>                                 
 </tr>    
 <tr>                                 
        <td  class="dataListHEAD" height="23">COT PORT</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key103" size="10" maxlength="10" value="<%=dspKey(103)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text77"></td>        
        <td  class="dataListHEAD" height="23">����PORT</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key104" size="10" maxlength="10" value="<%=dspKey(104)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text78"></td>                                 
 </tr>    
 <tr>                                 
        <td  class="dataListHEAD" height="23">MDF1</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key105" size="10" maxlength="10" value="<%=dspKey(105)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text79"></td>        
        <td  class="dataListHEAD" height="23">MDF2</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key106" size="10" maxlength="10" value="<%=dspKey(106)%>" <%=fieldRole(1)%> class="dataListEntry" ID="Text80"></td>                                 
 </tr>
 <tr>
     <td class="dataListHEAD" height="23">����Reset�覡</td>               
    <td height="23" bgcolor="silver" colspan=3>
	<%
		s=""
		sx=" selected "
		If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then  
	       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' " 
		Else
	       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' AND CODE='" & dspkey(107) & "'"
		End If
		rs.Open sql,conn
		Do While Not rs.Eof
	       If rs("CODE")=dspkey(107) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
		      rs.MoveNext
		sx=""
		Loop
		rs.Close%>         
	 <select size="1" name="key107"  <%=fieldRole(1)%> class="dataListEntry">                                                                  
		    <%=s%>
	 </select>	 </td></tr>          
	 <tr>
	<td  height="23" class="dataListHead">Reset�Ƶ�</td>                     
    <td  height="23" bgcolor="silver" colspan=3>
		<input  class="dataListENTRY" type="text" size="100" maxlength="50" name="key108" value="<%=dspkey(108)%>"></td>          
     
 </tr>
  </table>   
  </DIV>
      <DIV ID="SRTAG4" onclick="srtag4" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="LEFT">�D�u�ӽФάI�u�i�ת��A</td></tr></table></DIV>
    <DIV ID=SRTAB4 >  
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr>
        <td  WIDTH="15%" class="dataListSearch" height="23">�D�u�ɹ��</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key45" size="10"  READONLY  value="<%=dspKey(45)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text44">     
        <input type="button" id="B45"   <%=FIELDPC%>  <%=FIELDPF%>  name="B45" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPC%>  <%=FIELDPF%>  alt="�M��" id="C45"  name="C45"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">  </td>         
        <td  WIDTH="15%" class="dataListHEAD" height="23">�i�_�ظm</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
<%  dim sexd5, sexd6
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y"   AND FIELDPB = "" Then
       sexd5=""
       sexd6=""
    Else
      ' sexd1=" disabled "
      ' sexd2=" disabled "
    End If
    If dspKey(46)="Y" Then sexd5=" checked "    
    If dspKey(46)="N" Then sexd6=" checked " %>           
        <input type="RADIO" <%=sexd5%> name="key46" size="1" value="Y"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="radio" >�i
        <input type="RADIO" <%=sexd6%> name="key46" size="1" value="N"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="radio" >���i                
         </td></tr>
    <tr>
        <td   class="dataListHEAD" height="23">���i�ظm��]</td>                                 
        <td   height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key47" size="90" MAXLENGTH=90 value="<%=dspKey(47)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text46"></td>        
    </tr>
        <tr>
        <td  class="dataListSEARCH" height="23" TITLE="�D�u�g�ɹ�i�ظm�̡A�~�i���X�D�u�ӽ�!">�D�u�ӽФ�</td>                                 
        <td   height="23" bgcolor="silver">
			<input type="text" name="key57" size="10"   READONLY value="<%=dspKey(57)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text47">     
			<input type="button" id="B57"  <%=FIELDPC%>  <%=FIELDPF%>   name="B57" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPC%>  <%=FIELDPF%>  alt="�M��" id="C57"  name="C57"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
        </td>
        <td  class="dataListHEAD" height="23">��ĳ�e��覡</td>                                 
     <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(dspKey(59))) = 0   AND FIELDPB = ""  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H1'" 
       'If len(trim(dspkey(85))) < 1 Then
       '   sx=" selected " 
       'end if     
       s=s & "<option value=""""" & sx & "></option>"  
       sx=""
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H1' AND CODE='" & dspkey(85) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If (rs("CODE")=dspkey(85)) or (len(trim(dspkey(85))) < 1 and rs("code")="N" )  Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>
   <td  height="23" bgcolor="silver">
   <select size="1" name="key85" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select15">
        <%=s%>
   </select></td>
	</tr>

        <tr>
        <td  class="dataListHEAD" height="23"  TITLE="�D�u�e����Ӫ�渹">�D�u�ӽЦC�L�渹</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key80" size="10" value="<%=dspKey(80)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text63">     
        </td>
        <td  class="dataListHEAD" height="23">�D�u�ӽЦC�L�H��</td>                                 
        <td  height="23" bgcolor="silver">
		            <input type="text" name="key58" size="6" value="<%=dspKey(58)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text48">
		    <font size=2><%=SrGetEmployeeName(dspKey(58))%></font>
        </td>  
      </TR>
     <tr>
        <td  class="dataListHEAD" height="23">�D�u�ӽ����ɤ�</td>                                 
        <td  height="23" bgcolor="silver">
			<input type="text" name="key59" size="25" value="<%=dspKey(59)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text51">
        <td   class="dataListHEAD" height="23">�D�u�ӽЦ^�Ф�</td>                                 
        <td   height="23" bgcolor="silver">
			<input type="text" name="key60" size="25" value="<%=dspKey(60)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text52">
		</td>        
      </tr>
        <tr>
        <td  class="dataListHEAD" height="23" TITLE="���s�e��ɡA������J!">���s�e���]</td>                                 
        <td   height="23" bgcolor="silver" COLSPAN=3>
			<input type="text" name="key86" size="90"  MAXLENGTH=90 value="<%=dspKey(86)%>"  <%=fieldpA%><%=fieldRole(1)%> class="dataListEntry" ID="Text67">     
        </td>
        </TR>
        <tr>
        <td  class="dataListHEAD" height="23" TITLE="EBT�e��CHT�ӽйq�������!">CHT�����</td>                                 
        <td   height="23" bgcolor="silver">
			<input type="text" name="key84" size="10"  READONLY value="<%=dspKey(84)%>"  <%=fieldpB%><%=fieldRole(1)%> class="dataListEntry" ID="Text66">     
			<input type="button" id="B84"  name="B84"   <%=FIELDPF%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPD%>   <%=FIELDPF%> alt="�M��" id="C84"  name="C84"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
		</td>
        <td  class="dataListHEAD" height="23">CHT�w�w�I�u��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key83" size="10"   READONLY value="<%=dspKey(83)%>" <%=fieldpb%><%=fieldRole(1)%> class="dataListentry" ID="Text65">     
        <input type="button" id="B83"  name="B83" <%=FIELDPD%> height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPD%> alt="�M��" id="C83"  name="C83"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
	</TR>
        <tr>
        <td   class="dataListHEAD" height="23">EBT�ӽЪ��A�^��</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key61" size="10" value="<%=dspKey(61)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text53">     
        <td   class="dataListHEAD" height="23">�D�u�I�u�i��</td>                                 
        <td  height="23" bgcolor="silver">
        <% name=""
           if dspkey(62) <> "" then
              sqlxx=" select * from RTCODE where KIND='H2' and CODE='" & dspkey(62) & "' "
              rs.Open sqlxx,conn
              if rs.eof then
                 name=""
              else
                 name=rs("codenc")
              end if
              rs.close
           end if
        %>                
        <input type="text" name="key62" size="10" value="<%=dspKey(62)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text54"><font size=2><%=name%></font>
</td>        
      </tr>       
        <tr>
        <td   class="dataListHEAD" height="23">EBT�f�ֿ��~���e</td>                                 
        <td   height="23" bgcolor="silver" colspan=3>
        <input type="text" name="key68" size="90" value="<%=dspKey(68)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text58">
		</td>        
      </tr> 
        <tr>
        <td   class="dataListHEAD" height="23">CHT�q�����q��</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key63" size="10"   READONLY value="<%=dspKey(63)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListentry" ID="Text55">     
        <input type="button" id="B63"  <%=FIELDPD%>  <%=FIELDPF%>   name="B63" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPD%>  <%=FIELDPF%>  alt="�M��" id="C63"  name="C63"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> </td>          
        <td   class="dataListHEAD" height="23">�D�u���q��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key64" size="25"   READONLY value="<%=dspKey(64)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListDATA" ID="Text56">
       <!--
        <input type="button" id="B64"   <%=FIELDPD%>  <%=FIELDPF%>  name="B64" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPD%>  <%=FIELDPF%>  alt="�M��" id="C64"  name="C64"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        --> </td>          
      </tr>     
      </tr>
             
        <tr STYLE="DISPLAY:NONE">
        <td   class="dataListHEAD" height="23">�D�u���q�H��</td>                                 
        <td   height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key79" size="6" value="<%=dspKey(79)%>"  <%=fieldpb%><%=fieldRole(1)%> class="dataListDATA" ID="Text57">   
			<input type="BUTTON" id="B79"  name="B79"  <%=FIELDPF%>   width="100%" style="Z-INDEX: 1"  value="...." onclick="Srsales79onclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"   <%=FIELDPF%>  alt="�M��" id="C79"  name="C79"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=SrGetEmployeeName(dspKey(79))%>(�g�P�Ӷ��ť�)</font>
        </td>        
      </tr>           
        <tr>
        <td  class="dataListSEARCH" height="23">�^��EBT���ɼf�֤�</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key65" size="10"   READONLY value="<%=dspKey(65)%>"  <%=fieldpE%><%=fieldRole(1)%> class="dataListENTRY" ID="Text59">     
        <input type="button" id="B65"  <%=FIELDPF%>  name="B65" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPF%> alt="�M��" id="C65"  name="C65"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> </td>
        <td   class="dataListHEAD" height="23">�^��EBT���ɼf�֭�</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key66" size="6" value="<%=dspKey(66)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text60"></td>        
      </tr>
        <tr>
        <td  class="dataListHEAD" height="23">�^��EBT���ɤ�</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key67" size="25" value="<%=dspKey(67)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text61">     
        <td  class="dataListHEAD" height="23">�D�u���qEBT�T�{��</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key109" size="25" value="<%=dspKey(109)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text81">     
      </tr>   
      <tr>
        <td  class="dataListHEAD" height="23">�M�u��</td>                                 
        <td   height="23" bgcolor="silver">
        <input type="text" name="key94" size="10" value="<%=dspKey(94)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text71">     
        <td  class="dataListHEAD" height="23">�@�o��</td>                                 
        <td   height="23" bgcolor="silver" >
        <input type="text" name="key95" size="10" value="<%=dspKey(95)%>"  <%=fieldpb%><%=fieldRole(1)%> readonly class="dataListDATA" ID="Text72">     </td>
      </tr>            
    <tr STYLE="DISPLAY:NONE">
        <td  WIDTH="15%" class="dataListHEAD" height="23">���X���ϥD�u�Ǹ�</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key96" size="5"  READONLY  value="<%=dspKey(96)%>"  class="dataListDATA" ID="Text124">  
        <input type="text" name="key97" size="5"  READONLY  value="<%=dspKey(97)%>"   class="dataListDATA" ID="Text73">  
        <%
        IF LEN(TRIM(DSPKEY(96))) = 0 OR DSPKEY(96) = "" THEN DSPKEY(96)=0
        IF LEN(TRIM(DSPKEY(97))) = 0 OR DSPKEY(97) = "" THEN DSPKEY(97)=0
        if LEN(TRIM(dspkey(96))) > 0 AND DSPKEY(96) > 1 then
              sqlxx=" select * from rtEBTCMTYH where COMQ1=" & dspkey(96) 
              rs.Open sqlxx,conn
              if rs.eof then
                 comn="(���X���ϧ䤣��)"
              else
                 comn=rs("comn")
              end if
              rs.close
        else
           comn=""
        end if
        %>
        <font size=2><%=comn%></font>
         </td>         
        <td  WIDTH="15%" class="dataListHEAD" height="23">���J���ϥD�u�Ǹ�</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key99" size="5"  READONLY  value="<%=dspKey(99)%>"  class="dataListDATA" ID="Text74">  
        <input type="text" name="key100" size="5"  READONLY  value="<%=dspKey(100)%>"   class="dataListDATA" ID="Text75">  
        <%
        IF LEN(TRIM(DSPKEY(99))) = 0 OR DSPKEY(99) = "" THEN DSPKEY(99)=0
        IF LEN(TRIM(DSPKEY(100))) = 0 OR DSPKEY(100) = "" THEN DSPKEY(100)=0
        if LEN(TRIM(dspkey(99))) > 0 AND DSPKEY(99) > 1 then
               sqlxx=" select * from rtEBTCMTYH where COMQ1=" & dspkey(99) 
              rs.Open sqlxx,conn
              if rs.eof then
                 comn="(���J���ϧ䤣��)"
              else
                 comn=rs("comn")
              end if
              rs.close
        else
           comn=""
        end if        
        %>
         <font size=2><%=comn%></font>
         </td></tr>
    <tr STYLE="DISPLAY:NONE">
        <td  WIDTH="15%" class="dataListHEAD" height="23">�D�u���X���</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key98" size="10"  READONLY  value="<%=dspKey(98)%>"  class="dataListDATA" ID="Text126">     
         </td>         
        <td  WIDTH="15%" class="dataListHEAD" height="23">�D�u���J���</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
        <input type="text" name="key101" size="10"  READONLY  value="<%=dspKey(101)%>"   class="dataListDATA" ID="Text127">  
         </td></tr>                        
  </table> 
  </DIV>
    <DIV ID="SRTAG5" onclick="srtag5" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
    <tr><td bgcolor="BDB76B" align="LEFT">�Ƶ�����</td></tr></table></DIV>
   <DIV ID="SRTAB5" > 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <TR><TD align="CENTER">
     <TEXTAREA  cols="100%"  name="key81" rows=8  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(81)%>" ID="Textarea1"><%=dspkey(81)%></TEXTAREA>
   </td></tr>
 </table> 
  </DIV>    
<tr>                                   
  </div> 
<%
    conn.Close   
    set rs=Nothing   
    set conn=Nothing 
End Sub 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->