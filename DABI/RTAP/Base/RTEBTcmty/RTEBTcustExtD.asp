<!-- #include virtual="/WebUtilityV4/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(100),aryKeyValue(100),numberOfField,aryKey,aryKeyNameDB(100)
  Dim dspKey(100),userDefineKey,userDefineData,extDBField,extDB(100),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  Dim aryParmKey
 '90/09/03 ADD-START
 '增加EXTDBFIELD2,EXTDBFILELD3(多檔維護)
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
      'edson 2001/11/1 增加==>為了日期欄位能當key使用..必須有單引號
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
                 ' 當程式為社區業務員，因其dspkey(2)為IDENTIFY欄位，故不搬入值（由程式控制產生)   
                 case ucase("/webap/rtap/base/RTEBTcmty/rtEBTCUSTEXTd.asp")  
                  '    response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"
                      if i<>3 then rs.Fields(i).Value=dspKey(i)          
                      IF I=3 THEN
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         rsc.open "select max(ENTRYNO) AS ENTRYNO from rtEBTcustEXT where COMQ1=" & DSPKEY(0) & " AND LINEQ1=" & DSPKEY(1) & " AND CUSID='" & DSPKEY(2) & "' " ,conn
                         if len(rsc("ENtRYNO")) > 0 then
                            dspkey(3)=RSC("ENTRYNO") + 1
                         else
                            dspkey(3)=1
                         end if
                         rsc.close
                         rs.Fields(i).Value=dspKey(i)     
                      END IF      
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
               ' 當程式為社區業務員，因其dspkey(2)為IDENTIFY欄位，故不搬入值（由程式控制產生)   
                 case ucase("/webap/rtap/base/RTEBTcmty/rtEBTCUSTEXTd.asp")  
                     rs.Fields(i).Value=dspKey(i)
                 case else
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
   ' 當程式為社區業務員，因其dspkey(2)為IDENTIFY欄位，故不搬入值（由程式控制產生)  
    if accessmode ="A" then    
    runpgm=Request.ServerVariables("PATH_INFO")
    if UCASE(RUNPGM) = ucase("/webap/rtap/base/RTEBTcmty/rtEBTCUSTEXTd.asp")   then
       rs.open "select max(ENTRYNO) AS ENTRYNO from rtEBTcustEXT where COMQ1=" & DSPKEY(0) & " AND LINEQ1=" & DSPKEY(1) & " AND CUSID='" & DSPKEY(2) & "' " ,conn
       if not rs.eof then
          dspkey(3)=rs("ENTRYNO")
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
  numberOfKey=4
  title="AVS客戶附加服務資料維護"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1,LINEQ1,CUSID,ENTRYNO,TELNO,DIALERPAYTYPE,SRVTYPE,SDATE,DROPDAT,CHKDAT,TRANSDAT,eusr,edat,uusr,udat,cbccontractno,emcontractno FROM RTEBTcustext WHERE COMQ1=0 "
  sqlList="SELECT COMQ1,LINEQ1,CUSID,ENTRYNO,TELNO,DIALERPAYTYPE,SRVTYPE,SDATE,DROPDAT,CHKDAT,TRANSDAT,eusr,edat,uusr,udat,cbccontractno,emcontractno FROM RTEBTcustext WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  userdefineactivex="Yes"  
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(trim(dspkey(3)))=0 then dspkey(3)=0
    If len(trim(dspkey(4))) = 0 then
       message="請輸入電話號碼(含區碼)"
       formValid=False       
    elseif LEN(TRIM(dspKey(6)))=0 Then
       message="請選擇附加服務"
       formValid=False
    elseif Not IsDate(dspKey(7)) Then
       message="申請日期不可空白或格式錯誤"
       formValid=False       
    elseif IsDate(dspkey(8)) then
        if DateDiff("d",DateValue(dspKey(7)),DateValue(dspKey(8)))<0 Then
           message="作廢日期不得小於申請日期"
           formValid=False
        end if  
    End If
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="修改" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(13)=V(0)
        dspkey(14)=datevalue(now())
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
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
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
<tr><td width="20%" class=dataListSearch>資料範圍</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
</table>

<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr>
    <td width="10%" class=dataListHead>社區序號</td>
    <td width="10%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key0" SIZE=5 readonly
               style="text-align:left;" maxlength="5"
               value="<%=dspKey(0)%>"></td>
    <td width="10%" class=dataListHead>主線序號</td>
    <td width="10%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key1" SIZE=5 readonly
               style="text-align:left;" maxlength="5"
               value="<%=dspKey(1)%>"></td>
    <td width="10%" class=dataListHead>用戶合約編號</td>
    <td width="18%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key2" SIZE=20 readonly
               style="text-align:left;" maxlength="20"
               value="<%=dspKey(2)%>" ID="Text1"></td>               
    <td width="10%" class=dataListHead>單次</td>
    <td width="18%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key3" size=3
               style="text-align:left;" maxlength="4" readonly
               value="<%=dspKey(3)%>"></td>
   </TR>

</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------    
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="新增" then
        if len(trim(dspkey(11))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(11)=V(0)
        End if  
       dspkey(12)=datevalue(now())
    else
        if len(trim(dspkey(13))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(13)=V(0)
        End if         
        dspkey(14)=datevalue(now())
    end if         
' -------------------------------------------------------------------------------------------- 
%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
      <TR>
    <td width="15%" class=dataListHead>電話號碼</td>
    <td width="18%" bgcolor="silver" COLSPAN=3>
        <input class=dataListentry type="text" name="key4" 
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(4)%>" <%=keyProtect%>  ID="Text5"></td>         
    </TR>
    <tr>      
    <td width="20%" class=dataListHead>附加服務</td>
    <td width="30%" bgcolor="silver" >
    <%  Dim conn,rs,s,sx,sql
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    If accessMode="A" and sw="" Then
       sql="SELECT code, codenc FROM RTCode WHERE kind = 'E7' AND CODE='03'"
    Else
       sql="SELECT code, codenc FROM RTCode WHERE kind = 'E7' " _
          &"and RTcode.code='" &dspKey(6) &"' "
    End If
   ' Response.Write "SQL=" & sql
    rs.Open sql,conn
    s=""
    sx=" selected "
    Do While Not rs.Eof
       If rs("code")=dspKey(6) Then sx=" selected "
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
        <select class=dataListEntry name="key6" <%=keyProtect%> size="1"
               style="text-align:left;" maxlength="8"><%=s%></select></td>
    <td width="20%" class=dataListHead>資費方案</td>
    <td width="30%" bgcolor="silver" >
    <%  
    S=""
    If accessMode="A" and sw="" Then
       sql="SELECT code, codenc FROM RTCode WHERE kind = 'G7' "
    Else
       sql="SELECT code, codenc FROM RTCode WHERE kind = 'G7' " 
    End If
    If len(trim(dspkey(5))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
    else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
    end if     

   ' Response.Write "SQL=" & sql
    rs.Open sql,conn
    sx=" selected "
    Do While Not rs.Eof
       If rs("code")=dspKey(5) Then 
          sx=" selected "
       ELSE
          SX=""
       END IF
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
        <select class=dataListEntry name="key5" <%=keyProtect%> size="1"
               style="text-align:left;" maxlength="8" ID="Select1"><%=s%></select></td>               
    </TR>
    <TR>
    <td width="20%" class=dataListHead>申請日期</td>
    <td width="30%" bgcolor="silver">
        <input class=dataListENTRY type="text" READONLY name="key7" 
               style="text-align:left;" SIZE=12  maxlength="8"
               value="<%=dspKey(7)%>">
        <input type="button" id="B7"  name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="清除" id="C7"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
               </td>
    <td width="20%" class=dataListHead>作廢日期</td>
    <td width="30%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key8"
               style="text-align:left;" SIZE=12  maxlength="8"
               value="<%=dspKey(8)%>">
</td>               
 </tr>  
    <TR>
    <td width="20%" class=dataListHead>轉檔審核日</td>
    <td width="30%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key9" 
               style="text-align:left;" SIZE=12  maxlength="8"
               value="<%=dspKey(9)%>" ID="Text3">
    </td>
    <td width="20%" class=dataListHead>電子轉檔日</td>
    <td width="30%" bgcolor="silver">
        <input class=dataListDATA type="text" name="key10"
               style="text-align:left;" SIZE=12 maxlength="8"
               value="<%=dspKey(10)%>" ID="Text4">
</td>               
 </tr>   
<tr>
        <td  class="dataListSEARCH" height="23">CBC合約編號</td>                                 
        <td  height="23" bgcolor="silver">
         <input type="text" name="key15" size="15" READONLY value="<%=dspKey(15)%>"  class="dataListDATA" ID="Text6"><font size=2></font>
        </td>  
        <td  class="dataListSEARCH" height="23">EM合約編號</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key16" size="15" READONLY value="<%=dspKey(16)%>"  class="dataListDATA" ID="Text7">
        </td>       
 </tr>           
<tr>
        <td  class="dataListHEAD" height="23">建檔人員</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(11) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(11) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key11" size="6" READONLY value="<%=dspKey(11)%>"  class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">建檔日期</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key12" size="10" READONLY value="<%=dspKey(12)%>"  class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">修改人員</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(13) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(13) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key13" size="6" READONLY value="<%=dspKey(13)%>"  class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">修改日期</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key14" size="10" READONLY value="<%=dspKey(14)%>"  class="dataListDATA" ID="Text9">
        </td>       
 </tr>         

</table>
<%
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include virtual="/Webap/include/employeeref.inc" -->