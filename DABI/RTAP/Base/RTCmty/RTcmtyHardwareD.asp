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
                   ' ���{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                   case ucase("/webap/rtap/base/RTCMTY/RTCMTYHARDWAREd.asp")
                       'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       IF I=2 THEN
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         rsc.open "select max(entryno) AS entryno from rtCMTYhardware where comq1=" & dspkey(0)  & " AND PRTNO='" & DSPKEY(1) & "' "  ,conn
                         if len(trim(rsc("entryno"))) > 0 then 
                            dspkey(2)=rsc("entryno") + 1
                         else
                            dspkey(2)=1
                         end if
                         rsc.close
                       END IF
                      'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       rs.Fields(i).Value=dspKey(i)     
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

                 ' ���{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtCMTY/RTCMTYHARDWAREd.asp")
                    rs.Fields(i).Value=dspKey(i)
                  '   if i<>0 then rs.Fields(i).Value=dspKey(i)         
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
    ' ���{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(2)Ū�X�ܵe��
    if accessmode ="A" then
       runpgm=Request.ServerVariables("PATH_INFO")
       if ucase(runpgm)=ucase("/webap/rtap/base/rtCMTY/RTCMTYhardwared.asp") then
          rs.open "select max(entryno) AS ENTRYNO from rtCMTYhardware WHERE  comq1=" & dspkey(0) & " AND PRTNO='" & DSPKEY(1) & "' " ,conn
          if not rs.eof then
            dspkey(2)=rs("entryno")
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
<body bgcolor="#FFFFFF" text="#0000FF"  background="/WEBAP/IMAGE/bg.gif" bgproperties="fixed">
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
  title="HI-Building�D�u���u��]�Ƹ�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1, PRTNO, ENTRYNO, PRODNO, ITEMNO, QTY, DROPDAT, DROPREASON, WAREHOUSE, ASSETNO, DROPUSR,UNIT,eusr,edat,uusr,udat " _
             &"FROM RTCMTYhardware WHERE COMQ1=0 "
  sqlList="SELECT COMQ1, PRTNO, ENTRYNO, PRODNO, ITEMNO, QTY, DROPDAT, DROPREASON, WAREHOUSE, ASSETNO, DROPUSR,UNIT,eusr,edat,uusr,udat " _
             &"FROM RTCMTYhardware  WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    set connyy=server.CreateObject("ADODB.Connection")
    set rsyy=server.CreateObject("ADODB.recordset")
    connyy.Open dsn     
    sqlyy="SELECT * FROM RTCMTYSNDWORK WHERE COMQ1=" & DSPKEY(0) & " AND PRTNO='" & DSPKEY(1) & "' "
    RSYY.Open SQLYY,CONNYY
    errflg="" : errflg1=""
    IF RSYY("SNDTYPE")="OP" then
       ERRFLG="Y"
    ELSE
       ERRFLG=""
    end if
    IF len(trim(RSYY("STOCKCLOSEYM"))) > 0 then
       ERRFLG1="Y"
    ELSE
       ERRFLG1=""
    end if
    RSYY.Close
    CONNYY.Close
    SET RSYY=NOTHING
    SET CONNYY=NOTHING
    IF LEN(DSPKEY(2))=0 THEN DSPKEY(2)=0
    IF ERRFLG="Y" THEN
       formValid=False
       message="���u��" & DSPKEY(1) & "�D�зǤu�{�A���i��J�]�Ʃ���"   
    elseif  ERRFLG1="Y" THEN
       formValid=False
       message="���u��" & DSPKEY(1) & " �w����w�s�p��@�~�A���i�A��J�]�Ʃ���"   
  '  ELSEif len(dspkey(10)) < 1 OR len(dspkey(10)) <> 10 Then
  '     formValid=False
  '     message="�겣�s�����i�ťթΪ��פ���10�X"       
    ELSEif LEN(TRIM(dspkey(3))) = 0 OR LEN(TRIM(dspkey(4))) = 0  then
       formValid=False
       message="�п�J�]�ƦW�٤γW��" 
    ELSEif len(trim(DSPKEY(5))) = 0 OR NOT ISNUMERIC(DSPKEY(5))  THEN
       formValid=False
       message="�п�J�]�Ƽƶq�ή榡����" 
    ELSEif len(trim(DSPKEY(11))) = 0 THEN
       formValid=False
       message="�п�J�ƶq���" 
    ELSEif len(trim(DSPKEY(8))) = 0 AND CONSIGNEE="N"  THEN
       formValid=False
       message="�п�J�]�ƥX�f�w�O"        
    ELSEif len(trim(DSPKEY(8))) <> 0 AND CONSIGNEE="Y"  THEN
       formValid=False
       message="�D�u�}�o���g�P�ӡA���i��J�X�f�w�O"               
    END IF       
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(14)=V(0)
        dspkey(15)=datevalue(now())
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
          '���B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
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
   Sub Srprod4onclick()
       prog="RTGetproddetail.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:700px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key4").value =  trim(Fusrid(0))
          DOCUMENT.ALL("DEVICENAME").VALUE=TRIM(FUSRID(1))
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
      <table width="100%" border=1 cellPadding=0 cellSpacing=0 ID="Table2">
       <tr><td width="15%" class=dataListHead>���ϧǸ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="5" value="<%=dspKey(0)%>" maxlength="5" class=dataListdata ID="Text22"></td>
           <td width="15%" class=dataListHead>���u�渹</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key1"
                 <%=fieldRole(1)%> readonly size="12" value="<%=dspKey(1)%>" maxlength="12" class=dataListdata ID="Text3"></td>                 
           <td width="15%" class=dataListHead>����</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key2"
                 <%=fieldRole(1)%> readonly size="3" value="<%=dspKey(2)%>" maxlength="3" class=dataListdata ID="Text24"></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(12))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(12)=V(0)
        End if  
       dspkey(13)=datevalue(now())
    else
        if len(trim(dspkey(14))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(14)=V(0)
        End if         
        dspkey(15)=datevalue(now())
    end if          
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '�����u��w����w�s�p���A�]�Ƹ�ƧY�����\����
    set connyy=server.CreateObject("ADODB.Connection")
    set rsyy=server.CreateObject("ADODB.recordset")
    connyy.Open dsn     
    sqlyy="SELECT * FROM RTCMTYSNDWORK WHERE COMQ1=" & DSPKEY(0)  & " AND PRTNO='" & DSPKEY(1) & "' "
    RSYY.Open SQLYY,CONNYY
    ERRSTOCK=""
    IF RSYY("STOCKCLOSEYM")<>"" then
       ERRSTOCK="Y"
    ELSE
       ERRSTOCK=""
    end if
    RSYY.Close
    CONNYY.Close
    SET RSYY=NOTHING
    SET CONNYY=NOTHING
   ' RESPONSE.Write "ERR=" & ERRSTOCK
    If ERRSTOCK="Y" Then
       fieldPa=" class=""dataListData"" readonly "
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
  <span id="tags1" class="dataListTagsOn">�򥻸�Ƥεo�]�w��</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>        
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr>
           <td width="20%" class=dataListHead>�]��/�W��</td>
           <td width="40%" bgcolor=silver >
<%  set conn=server.CreateObject("ADODB.Connection")
    set rs=server.CreateObject("ADODB.recordset")
    conn.Open dsn
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND ERRSTOCK="" Then 
       sql="SELECT * FROM RTprodh ORDER BY prodno "
       If len(trim(dspkey(3))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
       SXX4=" onclick=""Srprod4onclick()""  "             
    Else
       sql="SELECT * FROM RTprodh WHERE prodno='" &dspkey(3) &"' order by prodno"
       SXX4=""
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("prodno")=dspkey(3) Then sx=" selected "
       s=s &"<option value=""" &rs("prodno") &"""" &sx &">" &rs("prodNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>           
    <select  name="key3" <%=fieldpa%> <%=dataProtect%> class=dataListEntry size="1" 
            style="text-align:left;" maxlength="8" ID="Select7"><br><%=s%></select>

    <input  type="text" name="key4"
                 readonly size="5" value="<%=dspKey(4)%>" <%=fieldpa%><%=dataProtect%> class=dataListEntry maxlength="5" ID="Text25">          
    <input type="button" id="B4"  name="B4" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=SXX4%> >
              
    </td>    
<td width="15%" class=dataListHead>�겣�s��</td></td>
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key9" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(9)%>" size="15" class=dataListEntry ID="Text1">
    </td>    
</tr>
<td width="10%" class=dataListHead>�]��/�W��W��</td></td>
    <td width="40%" bgcolor="silver" COLSPAN=3>
  <%
  DEVICENAME=""
  IF LEN(DSPKEY(3)) > 0 AND LEN(DSPKEY(4)) > 0 THEN
     Sql="SELECT itemno,itemnc,spec FROM RTprodd1 where prodno='" & dspkey(3) & "' and itemno='" & dspkey(4) & "' "
     rs.Open sql,conn
    if rs.EOF then 
       DEVICEname = ""
    else
       DEVICEname = rs("spec") & "--" & rs("itemnc")
    END IF
    RS.CLOSE
  END IF
  %>
        <input type="text"  READONLY name="DEVICENAME" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="90"
               value="<%=DEVICENAME%>" size="90" class=dataListDATA ID="Text5">
<tr><td class=dataListHead>�ƶq</td>
    <td bgcolor="silver" >
        <input type="text" name="key5" size="8" value="<%=dspkey(5)%>" maxlength="10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text4">
     <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1   Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B5' " 
       If len(trim(dspkey(11))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B5' AND CODE='" & dspkey(11) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(11) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key11" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select15">                                                                  
        <%=s%>
   </select>        </td>
<td class=dataListHEAD>�X�w�O</td>
    <td bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) AND ERRSTOCK="" Then 
       sql="SELECT * FROM HBWAREHOUSE ORDER BY WAREHOUSE "
       If len(trim(dspkey(8))) < 1  Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT * FROM HBWAREHOUSE WHERE WAREHOUSE='" &dspkey(8) &"' "
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("WAREHOUSE")=dspkey(8) Then sx=" selected "
       s=s &"<option value=""" &rs("WAREHOUSE") &"""" &sx &">" &rs("WARENAME") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
   <select size="1" name="key8"<%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select4">
   <%=s%>
   </select>
</td>      
</tr>  
<tr>
        <td  class="dataListHEAD" height="23">�@�o���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key6" size="10" READONLY value="<%=dspKey(6)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
        <td  class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(10) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(10) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key10" size="6" READONLY value="<%=dspKey(10)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>                                            
 </tr>        
 <tr>
   <td class=dataListHEAD>�@�o��]</td>          
   <td  height="23" bgcolor="silver" COLSPAN=3>
   <input type="text" name="key7" size="90" MAXLENGTH=90 value="<%=dspKey(7)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text16">
   </TD>
</tr>    
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(12) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(12) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key12" size="6" READONLY value="<%=dspKey(12)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key13" size="10" READONLY value="<%=dspKey(13)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(14) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(14) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key14" size="6" READONLY value="<%=dspKey(14)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key15" size="10" READONLY value="<%=dspKey(15)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>               
   </table> 
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