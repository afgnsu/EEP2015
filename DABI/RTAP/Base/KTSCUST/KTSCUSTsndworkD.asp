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
                   case ucase("/webap/rtap/base/KTSCUST/KTSCUSTSNDWORKd.asp")
                      ' response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 1 then rs.Fields(i).Value=dspKey(i)    
                       if i=1 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         cusidxx="S" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
                         rsc.open "select max(PRTNO) AS PRTNO from KTSCUSTSNDWORK where PRTNO like '" & cusidxx & "%' " ,conn
                         if len(rsc("PRTNO")) > 0 then
                            dspkey(1)=cusidxx & right("0000" & cstr(cint(right(rsc("PRTNO"),4)) + 1),4)
                         else
                            dspkey(1)=cusidxx & "0001"
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
                 case ucase("/webap/rtap/base/KTSCUST/KTSCUSTSNDWORKd.asp")
                 'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
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
    ' ��{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(2)Ū�X�ܵe��
    if accessmode ="A" then
       runpgm=Request.ServerVariables("PATH_INFO")
       if ucase(runpgm)=ucase("/webap/rtap/base/KTSCUST/KTSCUSTSNDWORKd.asp") then
          cusidxx="S" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
          rsc.open "select max(PRTNO) AS PRTNO from KTSCUSTSNDWORK where PRTNO like '" & cusidxx & "%' " ,conn
          if not rsC.eof then
            dspkey(1)=rsC("PRTNO")
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
  title="KTS�Τ�˾����u���ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CUSID, PRTNO, SENDWORKDAT, PRTUSR, ASSIGNENGINEER, ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, " _
             &"DROPDESC, CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT,  BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
             &"STOCKCLOSEUSR, STOCKFINCHK, PRODNO, ITEMNO, MEMO, PRTDAT,  UNCLOSEDAT, DROPUSR, CLOSEUSR, EUSR, EDAT, UUSR, UDAT,FINISHDAT " _
             &"FROM KTSCUSTSNDWORK WHERE CUSID='' "
  sqlList="SELECT CUSID, PRTNO, SENDWORKDAT, PRTUSR, ASSIGNENGINEER, ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, " _
             &"DROPDESC, CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT,  BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
             &"STOCKCLOSEUSR, STOCKFINCHK, PRODNO, ITEMNO, MEMO, PRTDAT,  UNCLOSEDAT, DROPUSR, CLOSEUSR, EUSR, EDAT, UUSR, UDAT,FINISHDAT " _
             &"FROM KTSCUSTSNDWORK WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=0
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
      
    if LEN(TRIM(dspkey(2))) = 0 then
       formValid=False
       message="���u������i�ť�" 
    ELSEif len(trim(DSPKEY(4))) = 0 and len(trim(DSPKEY(5))) = 0 THEN
       formValid=False
       message="�w�w�˾��H���θg�P�ӥ�����J�䤤�@��" 
    ELSEif len(trim(DSPKEY(4))) > 0 and len(trim(DSPKEY(5))) > 0 THEN
       formValid=False
       message="�w�w�˾��H���θg�P�ӥu���J�䤤�@��"    
    ELSEif len(trim(DSPKEY(6))) = 0 and len(trim(DSPKEY(7))) = 0 AND LEN(TRIM(DSPKEY(10))) > 0 THEN
       formValid=False
       message="��ڸ˾��H���θg�P�ӥ�����J�䤤�@��" 
    ELSEif len(trim(DSPKEY(6))) > 0 and len(trim(DSPKEY(7))) > 0 AND LEN(TRIM(DSPKEY(10))) > 0 THEN
       formValid=False
       message="��ڸ˾��H���θg�P�ӥu���J�䤤�@��"    
    elseif len(trim(DSPKEY(19))) = 0 and len(trim(DSPKEY(20))) = 0  THEN
       formValid=False
       message="�q���`���������i�ť�"    
    END IF       
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(28)=V(0)
        dspkey(29)=datevalue(now())
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
       prog="RTGetproddetail.asp"
       prog=prog & "?KEY=" & document.all("KEY19").VALUE & ";" & document.all("KEY1").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:700px;dialogHeight:480px;")  
       'FUsr=Window.OPEN(prog,"d2","dialogWidth:700px;dialogHeight:480px;") 
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key20").value =  trim(Fusrid(0))
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
       <tr><td width="12%" class=dataListHead>�Τ�s��</td>
           <td width="25%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="12" value="<%=dspKey(0)%>" maxlength="15" class=dataListdata ID="Text9"></td>
           <td width="15%" class=dataListHead>���u�渹</td>
           <td width="25%"  bgcolor="silver">
           <input type="text" name="key1"
                 <%=fieldRole(1)%> readonly size="12" value="<%=dspKey(1)%>" maxlength="12" class=dataListdata ID="Text24"></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(26))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(26)=V(0)
        End if  
       dspkey(27)=datevalue(now())
    else
        if len(trim(dspkey(28))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(28)=V(0)
        End if         
        dspkey(29)=datevalue(now())
    end if          
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    '�����p���A���protect
    If len(trim(dspKey(10))) > 0 OR len(trim(dspKey(8))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldPb=" DISABLED "
       FIELDPC=""
       FIELDPD=""
    Else
       fieldPa=""
       FIELDPb=" onclick=""SrBtnOnClick"" "
       FIELDPD=" onclick=""SrCLEAR"" "
    End If
    If len(trim(dspKey(10))) > 0 then
        fieldPe=" DISABLED "
    else
        fieldPe=""
    end if

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
  <span id="tags1" class="dataListTagsOn">�˾����u����</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>        
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr><td width="14%" class=dataListHead>���u���</td>
    <td width="40%" bgcolor="silver" COLSPAN=3>
        <input type="text" name="key2" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(2)%>" size="10" class=dataListEntry ID="Text1">
       <input  type="button" id="B2" name="B2" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=FIELDPB%>>
       <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpd%> alt="�M��" id="C2"  name="C2"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" <%=FIELDPD%>>                              
    </td>
 </tr>
 <tr>
    <td width="14%" class=dataListHead>���u��C�L��</td></td>
    <td width="40%" bgcolor="silver" >
        <input type="text" name="key22" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(22)%>" size="10" READONLY  class=dataListDATA ID="Text8">
     </td>    
    <td width="13%" class=dataListHead>�̪�C�L�H��</td></td>
<%
  name="" 
           if dspkey(3) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(3) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
          
 %>    
    <td width="35%" bgcolor="silver" >
        <input type="text" name="key3" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="6"
               value="<%=dspKey(3)%>" size="6" READONLY class=dataListDATA><font size=2><%=name%></font>
    </td></tr>

<tr><td class=dataListHEAD>�w�w�˾��H��</td>
<td bgcolor="silver" >
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(38))) = 0  Then 
       sql="SELECT RTEmployee.EMPLY, RTObj.CUSNC FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
          &"WHERE (RTEmployee.DEPT IN ('B100', 'B106', 'B107', 'B200', 'B300', 'B401','B600')) AND (RTEmployee.TRAN2 <> '10') AND " _
          &"(RTEmployee.AUTHLEVEL = '2') ORDER BY  RTObj.CUSNC "
       s="<option value="""" >(�}�o�~��)</option>"
    Else
       sql="SELECT RTEmployee.EMPLY, RTObj.CUSNC FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
          &"WHERE RTEmployee.EMPLY='" & DSPKEY(4) & "' "
       s="<option value="""" >(�}�o�~��)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�}�o�~��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("EMPLY")=dspkey(4) Then sx=" selected "
       s=s &"<option value=""" &rs("EMPLY") &"""" &sx &">" &rs("CUSNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>    
        <select size="1" name="key4" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select3">                                            
              <%=s%>
        </select>
 </td>
<td class=dataListHEAD>��ڸ˾��H��</td>
<td bgcolor="silver" >
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(38))) = 0  Then 
       sql="SELECT RTEmployee.EMPLY, RTObj.CUSNC FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
          &"WHERE (RTEmployee.DEPT IN ('B100', 'B106', 'B107', 'B200', 'B300', 'B401','B600')) AND (RTEmployee.TRAN2 <> '10') AND " _
          &"(RTEmployee.AUTHLEVEL = '2') ORDER BY  RTObj.CUSNC "
       s="<option value="""" >(�}�o�~��)</option>"
    Else
       sql="SELECT RTEmployee.EMPLY, RTObj.CUSNC FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
          &"WHERE RTEmployee.EMPLY='" & DSPKEY(6) & "' "
       s="<option value="""" >(�}�o�~��)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�}�o�~��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("EMPLY")=dspkey(6) Then sx=" selected "
       s=s &"<option value=""" &rs("EMPLY") &"""" &sx &">" &rs("CUSNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>    
        <select size="1" name="key6" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" ID="Select4">                                            
              <%=s%>
        </select>
</td>
 </tr>  
<tr><td  class=dataListHead>�w�w�˾��g�P��</td>
    <td  bgcolor="silver" >
    <%
    if dspkey(5)="" then
       SQL="SELECT * from ktscust where cusid='" & dspkey(0) & "' "
       rs.open sql,conn
       if rs.eof then
          dspkey(5)=""
       else
          dspkey(5)=rs("consignee2")
       end if
    end if
    %>
        <input type="text" name="key5" size="30" maxlength="30" value="<%=dspKey(5)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text30">
    </td>
    <td  class=dataListHead>��ڸ˾��g�P��</td>
    <td  bgcolor="silver" >
        <input type="text" name="key7" size="30" maxlength="30" value="<%=dspKey(7)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListEntry" ID="Text5">
    </td></tr>
<tr>
    <td  class=dataListHead>��ڸ˾���</td>
    <td  bgcolor="silver" >
        <input type="text" name="key30" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(30)%>" size="10" READONLY class=dataListENTRY ID="Text3">
       <input  type="button" id="B30" name="B30" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=FIELDPB%>>
       <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpD%> alt="�M��" id="C30"  name="C30"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" <%=FIELDPD%>>                              
    </td>   
    <td  class=dataListHead>���u���פ�</td>
    <td  bgcolor="silver" >
        <input type="text" name="key10" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(10)%>" size="10" READONLY class=dataListdata ID="Text13">
               <!--
       <input  type="button" id="B12" name="B12" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=FIELDPC%>>
       <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpa%> alt="�M��" id="C12"  name="C12"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" <%=FIELDPD%>>                              
    -->
    </td>   

  </tr>
  <tr>
      <td  class=dataListHead>�����u���פ�</td>
    <td  bgcolor="silver" >
        <input type="text" name="key23" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(23)%>" size="10" READONLY class=dataListdata ID="Text7">
               <!--
       <input  type="button" id="B12" name="B12" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=FIELDPC%>>
       <IMG  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpa%> alt="�M��" id="C12"  name="C12"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" <%=FIELDPD%>>                              
    -->
    </td>       
      <td  class=dataListHead>���פH��</td>
    <%
  name="" 
           if dspkey(25) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(25) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
          
 %>    
    <td  bgcolor="silver"  colspan=3>
        <input type="text" name="key25" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(25)%>" size="10" READONLY class=dataListDATA ID="Text29">
               <font size=2><%=name%></font>
    </td>        
 </TR>
  <tr>
<td  class=dataListHead>�@�o���</td>
    <td  bgcolor="silver" >
        <input type="text" name="key8" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(8)%>" size="10" READONLY class=dataListDATA ID="Text27">
    </td>    
    <td  class=dataListHead>�@�o�H��</td>
    <%
  name="" 
           if dspkey(24) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(24) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
          
 %>    
    <td  bgcolor="silver" >
        <input type="text" name="key24" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(24)%>" size="10" READONLY class=dataListDATA ID="Text28">
               <font size=2><%=name%></font>
    </td>        
 </TR>

 <tr>
   <td class=dataListHEAD>�����u/�@�o��]</td>          
   <td  height="23" bgcolor="silver" COLSPAN=3>
     <input type="text" name="key9" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="90"
               value="<%=dspKey(9)%>" size="90" class=dataListEntry ID="Text2">
   </TD>
   </TR>
 <tr> 
    <td  class=dataListHead>�洫���]�ƫ���</td>
    <td  bgcolor="silver" COLSPAN=3>
        <%  set conn=server.CreateObject("ADODB.Connection")
    set rs=server.CreateObject("ADODB.recordset")
    conn.Open dsn
    s=""
   ' sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and len(trim(dspkey(10))) = 0 Then 
       sql="SELECT * FROM RTprodh ORDER BY prodno "
       If len(trim(dspkey(19))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
       SXX20=" onclick=""Srcounty20onclick()""  "             
    Else
       sql="SELECT * FROM RTprodh WHERE prodno='" &dspkey(19) &"' order by prodno"
       SXX20=""
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
      If rs("prodno")=dspkey(19) Then sx=" selected "
       s=s &"<option value=""" &rs("prodno") &"""" &sx &">" &rs("prodNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    
    sql="SELECT itemno,spec FROM RTprodd1 where prodno='" & dspkey(19) & "' and itemno='" & dspkey(20) & "' ORDER BY prodno "
    rs.Open sql,conn
    if rs.EOF then 
       objname = ""
    else
       objname = rs("spec")
    end if
    rs.close
    %>           
    <select  name="key19" <%=fieldpa%><%=keyProtect%> class=dataListEntry size="1" 
            style="text-align:left;" maxlength="8" ID="Select2"><%=s%></select>  
    <input  type="text" name="key20"
                 readonly size="5" value="<%=dspKey(20)%>"<%=fieldpa%> <%=keyProtect%>  class=dataListEntry maxlength="5" ID="Text4">          
    <input type="button" id="B20"  name="B20" height="100%"  width="100%" style="Z-INDEX: 1" value="...." <%=SXX20%> >
    <%=objname%>                                     
    </td>        
</tr>           
<tr>
 <td class=dataListHEAD>�����p���</td>
    <td bgcolor="silver">   
    <input type="text" name="key11" size="6" MAXLENGTH=6 value="<%=dspKey(11)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text10">
    </td>                            
   <td class=dataListHead>�����p���</td>          
    <td bgcolor="silver">   
    <input type="text" name="key12" size="10" MAXLENGTH=10 value="<%=dspKey(12)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text11">
    </td>  
  </TR>
  <tr>        
   <td class=dataListHead>�������b��</td>          
    <td  bgcolor="silver">     
   <%   NAME=""
          if dspkey(13) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(13) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name="(��H�ɧ䤣�쵲�b�H��)"
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if    %>
    <input type="text" name="key13" size="6" MAXLENGTH=6 value="<%=dspKey(13)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text15"><font size=3><%=NAME%></font>
    </td>
   <td class=dataListHead>�����|�p�f�֤�</td>          
    <td  bgcolor="silver">     
 <input type="text" name="key14" size="10" MAXLENGTH=10 value="<%=dspKey(14)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text16">
    </td>    
</tr>             
<tr>
 <td class=dataListHEAD>�w�s�p���</td>
    <td bgcolor="silver">   
    <input type="text" name="key15" size="6" MAXLENGTH=6 value="<%=dspKey(15)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text14">
    </td>                            
   <td class=dataListHead>�w�s�p���</td>          
    <td bgcolor="silver">   
    <input type="text" name="key16" size="10" MAXLENGTH=10 value="<%=dspKey(16)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text21">
    </td>  
  </TR>
  <tr>        
   <td class=dataListHead>�w�s���b��</td>          
    <td  bgcolor="silver">     
   <%   NAME=""
          if dspkey(17) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(17) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name="(��H�ɧ䤣��w�s���b�H��)"
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if    %>
    <input type="text" name="key17" size="6" MAXLENGTH=6 value="<%=dspKey(17)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text25"><font size=3><%=NAME%></font>
    </td>
   <td class=dataListHead>�w�s�|�p�f�֤�</td>          
    <td  bgcolor="silver">     
    <input type="text" name="key18" size="10" MAXLENGTH=10 value="<%=dspKey(18)%>"  READONLY  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text26">
    </td>    
</tr>  
<tr>
        <td  class="dataListHEAD" height="23">���ɤH��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(26) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(26) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key26" size="6" READONLY value="<%=dspKey(26)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">���ɤ��</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key27" size="10" READONLY value="<%=dspKey(27)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>  
<tr>
        <td  class="dataListHEAD" height="23">�ק�H��</td>                                 
        <td  height="23" bgcolor="silver">
        <%  name="" 
           if dspkey(28) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(28) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
  %>    <input type="text" name="key28" size="6" READONLY value="<%=dspKey(28)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2"><font size=2><%=name%></font>
        </td>  
        <td  class="dataListHEAD" height="23">�ק���</td>                                 
        <td  height="23" bgcolor="silver">
        <input type="text" name="key29" size="10" READONLY value="<%=dspKey(29)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
        </td>       
 </tr>        
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <tr><td bgcolor="BDB76B" align="CENTER">�Ƶ�����</td></tr>
    <TR><TD align="CENTER">
     <TEXTAREA  cols="100%" name="key21" rows=5  MAXLENGTH=300 <%=fieldpa%>  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(21)%>" ID="Textarea1"><%=dspkey(21)%></TEXTAREA>
   </td></tr>
 </table>            
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