<%  
  Dim fieldRole,fieldPa,DtlCnt  
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
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
 
                 ' ���{����ADSL�ȶD��ƺ��@�@�~��(���ϤU),�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtsparq499CMTY/RTFAQD.asp")  
                      if i=0 then  
                         YY=cstr(datepart("yyyy",now())-1911)
                         mm=right(cstr("0" & cstr(datepart("m",now()))),2)
                         dd=right(cstr("0" & cstr(datepart("d",now()))),2)
                         YYMMDD=yy & mm & dd
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         sqlstr2="select max(caseno) AS caseno from rtfaqh where  caseno like '" & yymmdd & "%'" 
                         rsc.open sqlstr2,conn
                         if len(rsc("caseno")) > 0 then
                            dspkey(i)=yymmdd & right("0000" & cstr(cint(mid(rsc("caseno"),7,4)) + 1),4)
                         else
                            dspkey(i)=yymmdd & "0001"
                         end if                                                             
                      end if
                     ' response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                      rs.Fields(i).Value=dspKey(i)                                                                                        
                ' ���{����ADSL�ȶD�B�z���I������,�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtsparq499cmty/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)            
                 case else
                      rs.Fields(i).Value=dspKey(i)
               end select
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
                 ' ���{����adsl�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtsparq499cmty/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                           
                 case else
               '  response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
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
    ' ���{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
    runpgm=Request.ServerVariables("PATH_INFO")
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp") then
       rs.open "select max(comq1) AS comq1 from rtcmty",conn
       if not rs.eof then
          dspkey(0)=rs("comq1")
       end if
       rs.close
    end if

   ' ���{�����ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
    if ucase(runpgm)=ucase("/webap/rtap/base/rtsparq499cmty/RTfaqprocessd.asp") then
       rs.open "select max(entryno) AS entryno from rtfaqd1",conn
       if not rs.eof then
          dspkey(1)=rs("entryno")
       end if
       rs.close
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
<body bgcolor="#FFFFFF" text="#0000FF"  background="backgroup.jpg" bgproperties="fixed">
<form method="post" id="form">
<input type="text" name="sw" value="<%=sw%>" style="display:none;" ID="Text2">
<input type="text" name="reNew" value="N" style="display:none;" ID="Text3">
<input type="text" name="rwCnt" value="<%=rwCnt%>" style="display:none;" ID="Text4">
<input type="text" name="accessMode" value="<%=accessMode%>" style="display:none;" ID="Text5">
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
  title="����(�Ȥ�)�ȶD��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CASENO,PRODUCT,FAQMAN,CUSID,TEL1,TEL2,MOBILE,RCVUSR,COMQ1,RCVDATE,BREAKDATE,SendDate," _
             &"dropdate,dropusr,finishdate,finishusr,finishfac,monthclose,memo,entryno, servicetype,comtype,DEVICETYPE  FROM RTfaqh WHERE CASENO=0 "
  sqlList="SELECT CASENO,PRODUCT,FAQMAN,CUSID,TEL1,TEL2,MOBILE,RCVUSR,COMQ1,RCVDATE,BREAKDATE,SendDate," _
         &"dropdate,dropusr,finishdate,finishusr,finishfac,monthclose,memo,entryno, servicetype,comtype,DEVICETYPE  FROM RTfaqh WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=99
  userDefineSave="Yes"  
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    IF LEN(TRIM(DSPKEY(19)))= 0 THEN dspkey(19)=session("LINEQ1")
    IF LEN(TRIM(DSPKEY(21)))= 0 THEN DSPKEY(21)="6"
    if not Isdate(dspkey(9)) and len(dspkey(9)) > 0 then
       formValid=False
       message="���z������~"     
    elseif len(dspkey(9)) = 0 then
       formvalid=False
       message="���z������o�ť�"       
    elseif not Isdate(dspkey(10)) and len(dspkey(10)) > 0 then
       formValid=False
       message="�L�k�W��������~"           
    elseif len(dspkey(20)) = 0 then
       formvalid=False
       message="�п�ܪA�����O"               
    elseif len(dspkey(22)) = 0 then
       formvalid=False
       message="�п�ܥΤ�]�ƺ���"                
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
       call objEF2KDT.show(0)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
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
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font color="#FFFFFF">�ץ�s��</font></td>
    <td width="26%" bgcolor="#c0c0c0" height="23">
    <input name="key0" size="10" class="dataListData" value="<%=dspkey(0)%>" maxlength="10"  readonly ></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font color="#FFFFFF">���~</font></td>
    <td width="25%" bgcolor="#c0c0c0" height="23">
    <select name="key1" size="1"  <%=dataprotect%>  class="dataListentry">
<% if len(dspkey(1)) = 0 then %> 
      <option value='RT'>RT�]��</option>      
      <option value='COT'>COT</option>
      <option value='T1�M�u'>T1�M�u</option>      
      <option value='PL1600'>PL1600</option>
      <option value='���ݥ�Ĺ'>���ݥ�Ĺ</option>            
      <option value='�ӤH�q��'>�ӤH�q��</option>                  
<% else %>
      <option value='<%=dspkey(1)%>'  class="datalistdata"><%=dspkey(1)%> </option>
<% End if %>
    </select>
    </td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
       if len(trim(dspkey(7))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(7)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(7))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    If IsDate(dspKey(14)) or UCASE(trim(dataprotect))="READONLY" Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=""
    Else
       fieldPa=""
       fieldpb=" onclick=""SrBtnOnClick"" "
    End If
    if UCASE(trim(dataprotect))="READONLY" then
       fieldpd=" disabled "
       fieldpb=""
    end if
    'Ū�����ϦW��
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    
    Dim SQLCMTY,SQLCUST
    IF len(trim(dspkey(8))) = 0 then
       sqlCMTY="select comn, convert(char(3),RTSparq499CmtyLine.LINEIPSTR1) + '.' + CONVERT(char(3), RTSparq499CmtyLine.LINEIPSTR2) + '.' + CONVERT(char(3),RTSparq499CmtyLine.LINEIPSTR3) + '.' + CONVERT(char(3), RTSparq499CmtyLine.LINEIPSTR4) + '-' + CONVERT(char(3),RTSparq499CmtyLine.LINEIPEND) AS LINEIP from RTsparq499CMTYLINE LEFT OUTER JOIN RTsparq499CMTYH ON RTsparq499CMTYLINE.COMQ1=RTsparq499CMTYH.COMQ1 where RTsparq499cMTYLINE.comq1=" & session("COMQ1") & " AND RTsparq499cMTYLINE.LINEQ1=" & session("LINEQ1")
       dspkey(8)=session("COMQ1")       
    else
       sqlCMTY="select comn, convert(char(3),RTSparq499CmtyLine.LINEIPSTR1) + '.' + CONVERT(char(3), RTSparq499CmtyLine.LINEIPSTR2) + '.' + CONVERT(char(3),RTSparq499CmtyLine.LINEIPSTR3) + '.' + CONVERT(char(3),RTSparq499CmtyLine.LINEIPSTR4) + '-' + CONVERT(char(3),RTSparq499CmtyLine.LINEIPEND) AS LINEIP from RTsparq499CMTYLINE LEFT OUTER JOIN RTsparq499CMTYH ON RTsparq499CMTYLINE.COMQ1=RTsparq499CMTYH.COMQ1 where RTsparq499cMTYLINE.comq1=" & dspkey(8) & " AND RTsparq499cMTYLINE.LINEQ1=" & dspkey(19)
    end if
  ' response.Write "SQLCMTY=" & SQLCMTY
    rs.Open SQLCMTY,Conn,1,1,1
    if not rs.EOF  then
       comn=rs("COMN")
       ipaddr = rs("LINEIP")       
    end if
    rs.close
    'Ū���Ȥ�W��,�q��,�a�}
    if len(trim(dspkey(3))) = 0 then dspkey(3)=session("cusid")
    if len(trim(dspkey(19))) = 0 then dspkey(19)=session("LINEQ1")
    SQLCUST="select a.cusid, a.cusnc, isnull(rtcounty.cutnc, '')+ a.township2+ a.raddr2 as addr, a.contacttel, a.mobile, "_
		   &"a.cocontacttel + case when a.cocontacttel<>'' and a.cocontacttelext<>'' then '#' else '' end +a.cocontacttelext as COMTEL "_
		   &"from RTSparq499Cust a "_
		   &"left outer join rtcounty on rtcounty.cutid = a.cutid2 "_
		   &"where a.cusid='" & dspkey(3) &"' "
    'Response.Write "SQLCUST=" & sqlcust
    rs.open SQLCUST,CONN,1,1,1
    If not rs.Eof Then 
       if len(trim(dspkey(2))) = 0 then
          dspkey(2)=rs("cusnc")
       end if       
       if len(trim(dspkey(4))) = 0 then
          dspkey(4)=rs("COMTEL")
       end if
       if len(trim(dspkey(5))) = 0 then
          dspkey(5)=rs("contacttel")
       end if
       if len(trim(dspkey(6))) = 0 then
          dspkey(6)=rs("mobile")
       end if       
       ADDR=rs("addr")
    end if
    rs.close
    set rs=nothing
 %>
<table border="1" width="100%" cellspacing="0" cellpadding="0" height="717">

  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">�Ȥ�W��</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="23"><input name="key2"  <%=dataprotect%>  size="20" maxlength="12" <%=fieldpa%> class="dataListentry" value="<%=dspkey(2)%>" ></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font  color="#FFFFFF">�����Ҧr��</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="23"><input name="key3"  <%=dataprotect%> size="20"  class="dataListData" value="<%=dspkey(3)%>" readonly></td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">�Ȥ�q��(1)</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="23"><input name="key4"  <%=dataprotect%>  size="30" maxlength="15"  <%=fieldpa%>  class="dataListentry" value="<%=dspkey(4)%>" ></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font  color="#FFFFFF">�Ȥ�q��(2)</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="23"><input name="key5"  <%=dataprotect%> size="30"  maxlength="15"   <%=fieldpa%>  class="dataListentry" value="<%=dspkey(5)%>" ></td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">�Ȥ��ʹq��</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="23"><input name="key6"  <%=dataprotect%> size="30"  maxlength="15"   <%=fieldpa%>  class="dataListentry" value="<%=dspkey(6)%>" ></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font  color="#FFFFFF">���z�H��</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="23"><input name="key7"  <%=dataprotect%> size="20" class="dataListData" value="<%=dspkey(7)%>" readonly ></td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">���ϦW��</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="23"><input name="key8" size="20" class="dataListData" value="<%=dspkey(8)%>" style="display:none"><font ><%=comn%></font></td>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">����IP</font></td>
    <td width="36%" bgcolor="#c0c0c0" height="23"><input name="key23" size="20" class="dataListData" value="<%=dspkey(8)%>" style="display:none"><font ><%=IPADDR%></font></td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font  color="#FFFFFF">�a�}</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="23" colspan="3"><font ><%=addr%></font></td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="25"><font  color="#FFFFFF">���z�ɶ�</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="25"><input name="key9"  <%=dataprotect%> size="25"  <%=fieldpa%>   class="dataListentry"  value="<%=dspkey(9)%>">
    <input type="button" id="B9"  name="B9" height="100%" width="100%" style="Z-INDEX: 1"  value="...."   <%=fieldpb%>></td> 
    <td width="15%" bgcolor="#006666" class="DataListHead" height="25"><font  color="#FFFFFF">�o��ɶ�</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="25"><input name="key11"  <%=dataprotect%> size="25"  <%=fieldpa%>  class="dataListentry"  value="<%=dspkey(11)%>">
    <input type="button" id="B11"  name="B11" height="100%" width="100%" style="Z-INDEX: 1"  value="...."  <%=fieldpb%>></td> 
  </tr> 
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="25"><font  color="#FFFFFF">�@�o���</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="25"><input name="key12"  <%=dataprotect%> size="20"  <%=fieldpa%>   readonly  class="dataListdata"  value="<%=dspkey(12)%>">
    </td> 
    <td width="15%" bgcolor="#006666" class="DataListHead" height="25"><font  color="#FFFFFF">�@�o�H��</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="25"><input name="key13" size="20"  class="dataListdata"  readonly  value="<%=dspkey(13)%>"></td> 
  </tr>   
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="25"><font  color="#FFFFFF">���פ��</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="25"><input name="key14" size="20"   class="dataListdata"  readonly  value="<%=dspkey(14)%>"></td> 
    <td width="15%" bgcolor="#006666" class="DataListHead" height="25"><font  color="#FFFFFF">�ư��H��</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="25"><input name="key15" size="20"   class="dataListdata"  readonly  value="<%=dspkey(15)%>"></td> 
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="25"><font  color="#FFFFFF">�ư��t��</font></td>
    <td width="36%" bgcolor="#c0c0c0"  height="25"><input name="key16" size="20"  class="dataListdata"  readonly  value="<%=dspkey(16)%>"></td> 
    <td width="15%" bgcolor="#006666" class="DataListHead" height="25"><font  color="#FFFFFF">inbound / outbound</font></td>
    <td width="35%" bgcolor="#c0c0c0"  height="25">
    	<!--<input name="key17" size="20"   class="dataListdata"  readonly  value="<%=dspkey(17)%>">-->
		<select name="key17" size="1"  <%=dataprotect%>  class="dataListentry">
		<% if len(dspkey(17)) = 0 then %>
			<option value=''></option>
			<option value='I'>�Τ�ӹq</option>      
			<option value='O'>�ȪACall Out</option>
		<% else %>
			<option value='<%=dspkey(17)%>'  class="datalistdata"><%=dspkey(17)%> </option>
		<% End if %>
		</select>
	</td> 
  </tr>         
	<tr>
		<%
    s=""
    sx=" selected "
    
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='E8' " 
       If len(trim(dspkey(20))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(20) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>
		<td width="14%" bgcolor="#006666" class="datalisthead" height="25"><font color="#FFFFFF">�A�����O</font></td>
		<td width="36%" bgcolor="#c0c0c0" height="25"><select name="key20" <%=dataprotect%> <%=fieldpa%> class="dataListEntry" size="1" 
            style="text-align:left;" maxlength="2" ID="Select1"><%=s%></select>
		</td>
		<td width="15%" bgcolor="#c0c0c0" class="datalisthead"><font color="#FFFFFF">�Τ�]�ƺ���</td>
		<%
    s=""
    sx=" selected "
    
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='J1' " 
       If len(trim(dspkey(22))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(22) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>		
		<td width="35%" bgcolor="#c0c0c0" height="25"><select name="key22" <%=dataprotect%> <%=fieldpa%> class="dataListEntry" size="1" 
            style="text-align:left;" maxlength="2" ID="Select2"><%=s%></select></td>
	</tr>
	<tr style="display:none">
		<td width="14%" bgcolor="#006666" style="display:none" class="datalisthead" height="25"><font style="display:none" color="#FFFFFF">���</font></td>
		<td width="36%" bgcolor="#c0c0c0" height="25" style="display:none"><input name="key21"  <%=dataprotect%> size="20"  <%=fieldpa%>   class="dataListentry" value="<%=dspkey(21)%>" ID="Text1"></td>
	</tr>  
  <tr> 
    <td width="100%" colspan="4" bgcolor="#a4bcdb" height="11"> 
   <p align="center"><font color="#000000" >�Ȥ���D�y�z</font></p></td> 
  </tr> 
  <tr> 
    <td width="100%" colspan="4" bgcolor="#c0c0c0" height="311"> 
      <p style="LINE-HEIGHT: 100%; MARGIN-BOTTOM: 5px; MARGIN-TOP: 5px">
      <font color="#ff0000" >�L�k�W���ɶ���&nbsp;&nbsp;&nbsp; <input name="key10"  <%=dataprotect%> size="25"  <%=fieldpa%>   class="dataListentry" value="<%=dspkey(10)%>">
     <input type="button" id="B10"  name="B10" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpb%>></font>   
     <font >                            
      <p style="LINE-HEIGHT: 100%; MARGIN-BOTTOM: 5px; MARGIN-TOP: 5px">
      ���D�G</p>
 <%
    Set rs=Server.CreateObject("ADODB.Recordset")
    sqlfaqD2="SELECT * FROM RTFAQD2 RIGHT OUTER JOIN " _
            &"RTCode ON RTFAQD2.CODEID = RTCode.CODE AND CASENO ='" & DSPKEY(0) & "'" _
            &"WHERE RTCODE.KIND = 'D6' "
    rs.open sqlfaqd2,conn,1,1
    Dtlcnt=0
    Do until rs.eof
       IF not IsNull(RS("caseno")) then
          fieldpc=" checked "
       else
          fieldpc=""
       end if
    '-----
  %>
        <p style="LINE-HEIGHT: 100%; MARGIN-BOTTOM: 5px; MARGIN-TOP: 5px">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ext<%=Dtlcnt%>"  <%=fieldpc%> <%=fieldpd%> value="<%=rs("code")%>"><%=rs("codenc")%></p>  
  <%
    dtlcnt=Dtlcnt+1
    rs.MoveNext
    loop
    rs.close
    set rs=nothing
  %>                               
      <p style="LINE-HEIGHT: 100%; MARGIN-BOTTOM: 3px; MARGIN-TOP: 3px" align="center">
      </font>
      <TEXTAREA cols="80%" name="key18" rows=10   <%=fieldpa%>  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(18)%>"><%=dspkey(18)%></TEXTAREA></p>
    </td>
  </tr>
  <input name="key19" size="10"  <%=fieldpa%>  class="dataListentry" value="<%=dspkey(19)%>" style="display:none">
  <tr>
    <td width="100%" colspan="4" bgcolor="#a4bcdb" height="11">
      <p align="center"><font color="#000000" >�ȪA���B�z���I</font></p></td>
  </tr>
  <%
    Set rs=Server.CreateObject("ADODB.Recordset")
    s1=""
    sqlfaqd1="SELECT RTFAQD1.CASENO AS Expr1, RTFAQD1.ENTRYNO AS Expr2, " _
            &"RTFAQD1.LOGDATE AS Expr3, RTFAQD1.LOGDESC, RTObj.CUSNC AS Expr4, RTObj1.SHORTNC AS Expr5, " _
            &"RTFAQD1.LOGDROPDATE AS Expr6, RTObj2.CUSNC AS Expr7,rtfaqd1.logusrrole " _
            &"FROM RTObj RTObj2 INNER JOIN " _
            &"RTEmployee RTEmployee1 ON  " _
            &"RTObj2.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
            &"RTObj RTObj1 RIGHT OUTER JOIN " _
            &"RTFAQD1 ON RTObj1.CUSID = RTFAQD1.LOGFAC ON  " _
            &"RTEmployee1.EMPLY = RTFAQD1.LOGDROPUSR LEFT OUTER JOIN " _
            &"RTObj INNER JOIN " _
            &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
            &"RTFAQD1.LOGUSR = RTEmployee.EMPLY " _
            &"WHERE RTFAQD1.CASENO='" & dspkey(0) & "' and logusrrole='4' and logdropdate is null order by logdate desc"
    rs.open sqlfaqd1,conn,1,1
    Do until rs.eof
       s1=s1 & "�B�z����G" & rs("expr3") & "�@" & "�B�z�H���G" & rs("expr4") & rs("expr5") & chr(13)&chr(10) & "�B�z���I�G" & chr(13)&chr(10)  & rs("logdesc") & chr(13)&chr(10) & chr(13)&chr(10)
    rs.MoveNext
    loop
    rs.close
    set rs=nothing
  %>
  <tr>
    <td width="100%" colspan="4" bgcolor="#c0c0c0"  height="117">
      <p align="center"><font ><TEXTAREA cols="80%" name=S1 rows=10 class="dataListdata" readonly ><%=S1%></TEXTAREA></font></p>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="4" bgcolor="#a4bcdb" height="11">
      <p align="center"><font color="#000000" >�䥦�����B�z���I�λ���</font></p>
    </td>
  </tr>
  <%
    Set rs=Server.CreateObject("ADODB.Recordset")
    S2=""
    sqlfaqd1="SELECT RTFAQD1.CASENO AS Expr1, RTFAQD1.ENTRYNO AS Expr2, " _
            &"RTFAQD1.LOGDATE AS Expr3, RTFAQD1.LOGDESC, RTObj.CUSNC AS Expr4, RTObj1.SHORTNC AS Expr5, " _
            &"RTFAQD1.LOGDROPDATE AS Expr6, RTObj2.CUSNC AS Expr7,rtfaqd1.logusrrole " _
            &"FROM RTObj RTObj2 INNER JOIN " _
            &"RTEmployee RTEmployee1 ON  " _
            &"RTObj2.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
            &"RTObj RTObj1 RIGHT OUTER JOIN " _
            &"RTFAQD1 ON RTObj1.CUSID = RTFAQD1.LOGFAC ON  " _
            &"RTEmployee1.EMPLY = RTFAQD1.LOGDROPUSR LEFT OUTER JOIN " _
            &"RTObj INNER JOIN " _
            &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
            &"RTFAQD1.LOGUSR = RTEmployee.EMPLY " _
            &"WHERE RTFAQD1.CASENO='" & dspkey(0) & "' and logusrrole<>'4' and logdropdate is null order by logdate desc" 
            
    rs.open sqlfaqd1,conn,1,1
    Do until rs.eof
       s2=s2 & "�B�z����G" & rs("expr3") & "�@" & "�B�z�H���G" & rs("expr4") & rs("expr5") & chr(13)&chr(10) & "�B�z���I�G"  & chr(13)&chr(10)  & rs("logdesc") & chr(13)&chr(10) & chr(13)&chr(10)
    rs.MoveNext
    loop
    rs.close
    set rs=nothing
  %>  
  <tr>
    <td width="100%" colspan="4" bgcolor="#c0c0c0"  height="117">
      <p align="center"><font ><TEXTAREA cols="80%" name=S2 rows=10 class="dataListdata" readonly ><%=S2%></TEXTAREA></font></p><P>
    </td>
  </tr>
</table></center>
<% 
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
    Set comm=Server.CreateObject("ADODB.Command")
    
'------ RTObj ---------------------------------------------------
    DELFAQD2="delete from rtfaqd2 where caseno='" & dspkey(0) & "'"
    conn.Execute delFAQD2  
    For i=0 to 99
        if len(trim(extdb(i))) > 0  then
           rs.Open "SELECT * FROM RTFAQD2 WHERE caseno='" &dspKey(0) &"' and codeid='" & extDB(i) & "'" ,conn,3,3
           sqlxx="SELECT * FROM RTFAQD2 WHERE caseno='" &dspKey(0) &"' and codeid='" & extDB(i) & "'"
         '  response.write sqlxx
           If rs.Eof Or rs.Bof Then
              rs.AddNew
              rs("caseno")=dspKey(0)
              rs("codeid")=extDB(i)          
           End If
        rs("Eusr")=dspkey(7)
        rs("Edat")=now()
       ' rs("Uusr")=dspKey(47)
       ' rs("Udat")=dspKey(48)
           rs.Update
           rs.Close
        end if
    Next
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->