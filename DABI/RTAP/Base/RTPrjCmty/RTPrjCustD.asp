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
                   ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
		'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                       if i <> 2 then rs.Fields(i).Value=dspKey(i)    
                       if i=2 then
                         Set rsc=Server.CreateObject("ADODB.Recordset")
                         cusidxx="P" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
                         rsc.open "select max(cusid) AS cusid from RTPrjCust where cusid like '" & cusidxx & "%' " ,conn
                         if len(rsc("cusid")) > 0 then
                            dspkey(2)=cusidxx & right("000" & cstr(cint(right(rsc("cusid"),3)) + 1),3)
                         else
                            dspkey(2)=cusidxx & "001"
                         end if
                         rsc.close
                         rs.Fields(i).Value=dspKey(i) 
                       end if      
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
		'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
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
          cusidxx="E" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
          rsc.open "select max(cusid) AS cusid from RTPrjCust where cusid like '" & cusidxx & "%' " ,conn
          if not rsC.eof then
            dspkey(2)=rsC("CUSID")
          end if
          rsC.close
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
  title="�M�ץΤ��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1, LINEQ1, CUSID, CUSNC, CUTID2, TOWNSHIP2, RADDR2, RZONE2, " &_
			  "CONTACTTEL, MEMO, FREECODE, IP11, IP12, IP13, IP14, GTMONEY, GTVALID, " &_
			  "GTSERIAL, GTEQUIP, GTPRTDAT, GTPRTUSR, FINISHDAT, DOCKETDAT, " &_
			  "STRBILLINGDAT, DROPDAT, UUSR, UDAT, CANCELDAT, CANCELUSR, NEWBILLINGDAT, DUEDAT " &_
			  "FROM RTPrjCust WHERE cusid='' "
  sqlList=	  "SELECT COMQ1, LINEQ1, CUSID, CUSNC, CUTID2, TOWNSHIP2, RADDR2, RZONE2, " &_
			  "CONTACTTEL, MEMO, FREECODE, IP11, IP12, IP13, IP14, GTMONEY, GTVALID, " &_
			  "GTSERIAL, GTEQUIP, GTPRTDAT, GTPRTUSR, FINISHDAT, DOCKETDAT, " &_
			  "STRBILLINGDAT, DROPDAT, UUSR, UDAT, CANCELDAT, CANCELUSR, NEWBILLINGDAT, DUEDAT " &_
			  "FROM RTPrjCust WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=5
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)

  if len(trim(dspkey(15)))=0 then dspkey(15)=0
  if len(trim(dspkey(10)))=0 then dspkey(10)=""
  'if trim(FREECODEX) ="checked" then 
'		dspkey(10)="Y"
 ' else
'		dspkey(10)=""
 ' end if

  if len(trim(dspkey(8)))=0 then
       formValid=False
       message="�Τ��p���q�ܤ��i�ť�"
  elseif len(trim(dspkey(4)))=0 then
       formValid=False
       message="�˾��a�}(����)���i�ť�"   
  elseif len(trim(dspkey(5)))=0 and dspkey(4)<>"06" and dspkey(4)<>"15" then
       formValid=False
       message="�˾��a�}(�m��)���i�ť�"    
  elseif len(trim(dspkey(6)))=0 then
       formValid=False
       message="�˾��a�}���i�ť�"     
  END IF

  '�ˬd�D�u�}�o�����P�θg�P==��g�P��,�h�Z���k�ݳ������ť�,�Ϥ��h������J
  IF formValid=TRUE THEN
   Set connxx=Server.CreateObject("ADODB.Connection")
   Set rsxx=Server.CreateObject("ADODB.Recordset")
   connxx.open DSN
   sqlxx="select * from RTPrjCmtyLine where comq1=" & aryparmkey(0) & " AND LINEQ1=" & ARYPARMKEY(1)
   rsxx.Open sqlxx,connxx
   if not rsxx.eof then

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
 'IF formValid=TRUE and (dspkey(66) <> "" or dspkey(67) <> "" )THEN
 '   Set connxx=Server.CreateObject("ADODB.Connection")
 '   Set rsxx=Server.CreateObject("ADODB.Recordset")
 '   connxx.open DSN
 '   SQLXX="Select count(*) as cnt from RTLessorAVSCust where port<>'0' and comq1=" & dspkey(0) & " and lineq1=" & dspkey(1) & " and port='" & dspkey(66) & "' and equip='" & dspkey(67) & "' and cusid<>'" & dspkey(2) & "' " 
  '  rsxx.open sqlxx,connxx
 '   if rsxx("cnt") > 0 then
 '      formValid=False
 '       message="����]�ƥN����port�w���䥦�Τ�b�ϥΡA���୫��"
 '   end if
 '   rsxx.close
 '   connxx.Close   
 '   set rsxx=Nothing   
 '   set connxx=Nothing 
 'END IF
 
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(25)=V(0)
        dspkey(26)=now()
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
   END SUB   
   
   Sub Sr33Clear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid    
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
       end if
   End Sub       

   Sub S10xClick()
	   document.All("key10y").Checked = false
   	   document.All("key10").value = "Y"
   End Sub

   Sub S10yClick()
	   document.All("key10x").Checked = false
   	   document.All("key10").value = ""
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
   Sub Srcounty10onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY4").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key5").value =  trim(Fusrid(0))
          document.all("key7").value =  trim(Fusrid(1))
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
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="15%" class=dataListHead>���ϧǸ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(0)%>" class=dataListdata></td>
           <td width="15%" class=dataListHead>�D�u�Ǹ�</td>
           <td width="10%"  bgcolor="silver">
           <input type="text" name="key1"
                 <%=fieldRole(1)%> readonly size="10" value="<%=dspKey(1)%>" class=dataListdata></td>                 
           <td width="25%" class=dataListHead>�Τ�Ǹ�</td>
           <td width="25%"  bgcolor="silver">
           <input type="text" name="key2"
                 <%=fieldRole(1)%> readonly size="15" value="<%=dspKey(2)%>" class=dataListdata></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(25))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(25)=V(0)
        End if  
       dspkey(26)=now()
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
	If len(trim(dspKey(23))) > 0 and basedata=false Then
       fieldPm=" class=""dataListData"" readonly "
       fieldpn=" disabled "
    Else
       fieldPm=""
       fieldpn=""
    End If

	'������b�}�l�p�Oand�h����, �~�U�i��
	If len(trim(dspKey(23))) = 0 then
       fieldPo=""
	elseif len(trim(dspKey(23))) > 0 and basedata=true and dspKey(24)<=now() then
       fieldPo=""		
	else
       fieldPo=" disabled "
	end if

    '�Τ᥼���u,��� protect
    If isnull(dspKey(21)) or len(trim(dspKey(21)))=0 Then
       fieldPh=" disabled "
    Else
       fieldPh=""
    End If

    '�Τ�}�l�p�O��,��� protect
    If len(trim(dspKey(23))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
    Else
       fieldPa=""
       fieldpb=""
    End If

    '�Τ�h����,�}�l�p�O���� protect
    If len(trim(dspKey(24))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
       fieldPC=" class=""dataListData"" readonly "
       fieldpD=" disabled "
    Else
       fieldPC=""
       fieldpD=""
    End If

    '�Τ�@�o��,�h�������� protect
    If len(trim(dspKey(27))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=" disabled "
       fieldPe=" class=""dataListData"" readonly "
    Else
       fieldPe=""
    End If

    '�O�Ҫ��C�L��, �O�Ҫ�������� protect
    If len(trim(dspKey(19))) > 0  Then
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
  <span id="tags1" class="dataListTagsOn">�M�ץΤ��T</span>
                                                            
<DIV ID="SRTAG0">
	<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr><td bgcolor="BDB76B" align="CENTER">�򥻸��</td></tr>
    </table>
</div>
<DIV ID=SRTAB0 >   
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
	<tr><td width="15%" class=dataListHEAD>�Τ�(���q)�W��</td>
		<td  width="35%"  bgcolor="silver" >
			<input type="text" name="key3" <%=fieldPm%><%=fieldRole(1)%><%=dataProtect%>
				style="ime-mode:active;" maxlength="30" value="<%=dspKey(3)%>" size="30" class=dataListENTRY>
		</td>

		<td WIDTH="15%" class="dataLISTSEARCH" height="23">������</td>                                 
		<%  
			dim FREECODE1,FREECODE2
			If trim(dspKey(10))="Y" THEN
				FREECODEx=" checked "    
				FREECODEy=""    
			ELSE
				FREECODEx=""    
				FREECODEy=" checked "    
			END IF 
		%>
		<td WIDTH="35%" height="23" bgcolor="silver">
			<input type="radio" name="key10x" value="Y" <%=FREECODEx%> <%=fieldPo%> <%=fieldRole(1)%><%=dataProtect%> ID="Radio1" onclick="S10xClick">�O
			<input type="radio" name="key10y" value="" <%=FREECODEy%> <%=fieldPo%> <%=fieldRole(1)%><%=dataProtect%> ID="Radio2" onclick="S10yClick">�_
			<input type="hidden"  name="key10" value="<%=dspKey(10)%>" class=dataListENTRY>
		</td>
	</TR>   

	<tr><td class="dataListHEAD" height="23">�s���q��</td>                                 
		<td height="23" bgcolor="silver" colspan =3>
			<input type="text" name="key8" size="50" maxlength="50" value="<%=dspKey(8)%>" <%=fieldRole(1)%> class="dataListEntry">
		</td>
	</tr>     

	<tr><td class=dataListHEAD>�Ȥ�a�}</td>
		<td bgcolor="silver" COLSPAN=3>
			<%s=""
				sx=" selected "
				If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
				sql="SELECT Cutid,Cutnc FROM RTCounty " 
				If len(trim(dspkey(4))) < 1 Then
					sx=" selected " 
				else
					sx=""
				end if     
				s=s &"<option value=""" &"""" &sx &">(����)</option>"       
				SXX10=" onclick=""Srcounty10onclick()""  "
				Else
				sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(4) & "' " 
				SXX10=""
				End If
				sx=""    
				rs.Open sql,conn
				Do While Not rs.Eof
				If rs("cutid")=dspkey(4) Then sx=" selected "
				s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
				rs.MoveNext
				sx=""
				Loop
				rs.Close
			%>
			<select size="1" name="key4" <%=fieldPn%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2" onchange="Srchangetelzip"><%=s%></select>
			<input type="text" name="key5" readonly  size="8" value="<%=dspkey(5)%>" maxlength="10" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4"><font SIZE=2>(�m��)                 
			<input type="button" id="B5" <%=fieldPn%> name="B5" width="100%" style="Z-INDEX: 1" value="...." <%=SXX10%>  >        
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldPn%> alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" onclick="SrClear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
			<input type="text" name="key6"  size="50" value="<%=dspkey(6)%>" maxlength="60"  <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListENTRY" ID="Text4">
			<input type="text" name="key7" readonly  size="5" value="<%=dspkey(7)%>" maxlength="5" readonly <%=fieldPm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListDATA" ID="Text4">
		</td>			
	</tr>

	<tr><td  class="dataListHEAD" height="23">�Τ�IP(�Ĥ@��)</td>
		<td  height="23" bgcolor="silver" >
			<input type="text" name="key11" size="15" maxlength=15 value="<%=dspKey(11)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3" ID="Text7">
		</TD>
		<td  class="dataListHEAD" height="23">�Τ�IP(�ĤG��)</td>
		<td  height="23" bgcolor="silver" >
			<input type="text" name="key12" size="15" maxlength=15 value="<%=dspKey(12)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3" ID="Text8">
		</TD>
	</tr> 

	<tr><td  class="dataListHEAD" height="23">�Τ�IP(�ĤT��)</td>
		<td  height="23" bgcolor="silver" >
			<input type="text" name="key13" size="15" maxlength=15 value="<%=dspKey(13)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3" ID="Text11">
		</TD>
		<td  class="dataListHEAD" height="23">�Τ�IP(�ĥ|��)</td>
		<td  height="23" bgcolor="silver" >
			<input type="text" name="key14" size="15" maxlength=15 value="<%=dspKey(14)%>" <%=fieldRole(1)%><%=fieldPm%><%=dataProtect%> class="dataListentry" maxlength="3" ID="Text13">
		</TD>
	</tr> 
</table>
</div>


<DIV ID="SRTAG1">
	<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
		<tr><td bgcolor="BDB76B" align="CENTER">�O�Ҫ�����</td></tr>
	</table>
</div>
    
<DIV ID=SRTAB1>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">

 	<tr><td width="15%" class="dataListHead">�O�Ҫ��~��</td>                    
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L6' " 
			If len(trim(dspkey(16))) < 1 Then
				sx=" selected " 
			else
				sx=""
			end if     
			Else
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L6' AND CODE='" & dspkey(16) &"' " 
			End If
			rs.Open sql,conn
			s=""
			s=s &"<option value=""" &"""" &sx &"></option>"
			sx=""
			Do While Not rs.Eof
			If rs("CODE")=dspkey(16) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
        <td width="35%" bgcolor="silver">
          <select name="key16" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> size="1"
                  maxlength="8" class="dataListEntry" ID="Select3"><%=s%></select>
		</td>

        <td width="10%" class="dataListHead">�Τ�O�޳]��</td>                    
		<%
		s=""
		sx=" selected "
		If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
		sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='P2' " 
		If len(trim(dspkey(18))) < 1 Then
			sx=" selected " 
		else
			sx=""
		end if     
		Else
		sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='P2' AND CODE='" & dspkey(18) &"' " 
		End If
		rs.Open sql,conn
		s=""
		s=s &"<option value=""" &"""" &sx &"></option>"
		sx=""
		Do While Not rs.Eof
		If rs("CODE")=dspkey(18) Then sx=" selected "
		s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
		rs.MoveNext
		sx=""
		Loop
		rs.Close
		%>
        <td width="23%" bgcolor="silver" >
			<select name="key18" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>
		</td>
	</tr>

	<tr><td width="10%" class="dataListHead">�O�Ҫ�</td>                    
        <td width="23%" bgcolor="silver">
			<input type="text" name="key15" size="10" value="<%=dspKey(15)%>" <%=fieldRole(1)%><%=fieldPg%><%=dataProtect%> class="dataListEntry" maxlength="10" ID="Text16">
		</td>

        <td width="10%" class="dataListHead">�O�Ҫ��Ǹ�</td>
        <td width="23%" bgcolor="silver">
			<input type="text" name="key17" size="13" Readonly value="<%=dspKey(17)%>" <%=fieldRole(1)%><%=fieldPg%><%=dataProtect%> class="dataListData">
		</td>
	</tr>
	  
	<tr><td class="dataListHEAD" height="23">�O�Ҫ����ڦC�L�H</td>                                 
		<td  height="23" bgcolor="silver">
				<input type="text" name="key20" size="10" READONLY value="<%=dspKey(20)%>" class="dataListDATA" ID="Text1">
				<font size=2>
				<%
					if trim(len(dspKey(20))) =6 then
						response.Write SrGetEmployeeName(dspKey(20))
					else 
						sql="SELECT shortnc FROM RTObj where cusid ='" &dspKey(20)&"' "
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
			<input type="text" name="key19" size="25" READONLY value="<%=dspKey(19)%>" <%=fieldPg%><%=fieldRole(1)%> class="dataListDATA" ID="Text21">
        </td>       
	</tr>	  
</table>     
</DIV> 

<DIV ID="SRTAG4"">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
		<tr><td bgcolor="BDB76B" align="CENTER">�Τ�ӽСB���ʤάI�u�i�ת��A</td></tr>
    </table>
</DIV>

<DIV ID=SRTAB4 >  
<table border="1" width="100%" cellpadding="0" cellspacing="0" >
	<tr><td  WIDTH="15%" class="dataListHEAD" height="23">���u���</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver" >
			<input type="text" name="key21" size="12" READONLY value="<%=dspKey(21)%>" class="dataListentry" ID="Text57">
			<input type="button" id="B21"  <%=FIELDPD%>    name="B21" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=FIELDPD%>  alt="�M��" id="C21" name="C21"  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
        </td>

        <td  WIDTH="15%" class="dataListHEAD" height="23">�������</td>                                 
        <td  WIDTH="35%" height="23" bgcolor="silver">
	        <input type="text" name="key22" size="12" READONLY value="<%=dspKey(22)%>" class="dataListdata" ID="Text57">
			<input type="button" height="100%" width="100%" id="B22" name="B22" onclick="SrBtnOnClick" <%=fieldPh%> style="Z-INDEX: 1" value="....">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C22" name="C22" onclick="SrClear" <%=fieldPh%> style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut">
        </td>
	</TR>
	
	<tr><td class="dataListHEAD" height="23">�}�l�p�O��</td>                                 
        <td WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key23" size="12" READONLY value="<%=dspKey(23)%>" <%=fieldpC%> <%=fieldRole(1)%> class="dataListentry" ID="Text22" >
			<input type="button" id="B23"  name="B23" height="100%" width="100%" <%=fieldpD%> style="Z-INDEX: 1" value="...." onclick="SrBtn33OnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C23"  name="C23"   <%=fieldpD%> style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Sr33Clear">
		</td>
	
		<td class="dataListHEAD" height="23">�h����</td>                                 
		<td height="23" bgcolor="silver" >
			<input type="text" name="key24" size="12" READONLY value="<%=dspKey(24)%>" <%=fieldpe%> <%=fieldRole(1)%> class="dataListentry" ID="Text6">
			<input type="button" id="B24" name="B24" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldPn%>  alt="�M��" id="C24" name="C24"  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
       </td>
	</tr> 

	<tr><td class="dataListHEAD" height="23">�����</td>                                 
        <td WIDTH="23%" height="23" bgcolor="silver" >
			<input type="text" name="key29" size="12" READONLY value="<%=dspKey(29)%>" <%=fieldRole(1)%> class="dataListentry" ID="Text22" >
			<input type="button" id="B29"  name="B29" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtn33OnClick">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C29" name="C29" style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Sr33Clear">
		</td>
	
		<td class="dataListHEAD" height="23">�����</td>                                 
		<td height="23" bgcolor="silver" >
			<input type="text" name="key30" size="12" READONLY value="<%=dspKey(30)%>" <%=fieldRole(1)%> class="dataListentry" ID="Text6">
			<input type="button" id="B30" name="B30" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C30" name="C30"  style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"> 
       </td>
	</tr> 

 	<tr><td class="dataListHEAD" height="23">�@�o�H��</td>                                 
        <td height="23" bgcolor="silver">
			<input type="text" name="key28" size="6" value="<%=dspKey(28)%>" <%=fieldRole(1)%> readonly class="dataListDATA" ID="Text43">
			<font size=2><%=SrGetEmployeeName(dspKey(28))%></font>
        </td>

 		<td class="dataListHEAD" height="23">�@�o���</td>                                 
        <td height="23" bgcolor="silver">
			<input type="text" name="key27" size="25" value="<%=dspKey(27)%>"  <%=fieldpa%><%=fieldRole(1)%> readonly class="dataListdata" ID="Text41">
		</td>
	</tr>     

	<tr><td  class="dataListHEAD" height="23">�ק�H��</td>                                 
		<td  height="23" bgcolor="silver">
			<input type="text" name="key25" size="6" READONLY value="<%=dspKey(25)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text2">
			<font size=2><%=SrGetEmployeeName(dspKey(25))%></font>
		</td>  
		<td  class="dataListHEAD" height="23">�ק���</td>                                 
		<td  height="23" bgcolor="silver">
			<input type="text" name="key26" size="25" READONLY value="<%=dspKey(26)%>"  <%=fieldpa%><%=fieldRole(1)%> class="dataListDATA" ID="Text9">
		</td>       
	</tr>         
</table> 
</DIV>

<DIV ID="SRTAG5" onclick="SRTAG5" style="cursor:hand">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
		<tr><td bgcolor="BDB76B" align="CENTER">�Ƶ�����</td></tr>
    </table>
</DIV>

<DIV ID="SRTAB5" > 
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
    <TR><TD align="CENTER" bgcolor="silver">
		<TEXTAREA  cols="100%"  name="key9" rows=8  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%>  value="<%=dspkey(9)%>" ID="Textarea1"><%=dspkey(9)%></TEXTAREA>
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
Sub SrReadExtDB()
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
End Sub
' -------------------------------------------------------------------------------------------- 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/RTGetUserRight.asp" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
