<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
    'response.write fieldRole
%>
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(150),aryKeyValue(150),numberOfField,aryKey,aryKeyNameDB(150)
  Dim dspKey(150),userDefineKey,userDefineData,extDBField,extDB(150),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  '�ק�@
  Dim aryParmKey, aryParm
 '90/09/03 ADD-START
 '�W�[EXTDBFIELD2,EXTDBFILELD3(�h�ɺ��@)
  dim extDBField2,extDB2(150),extDBField3,extDB3(150),extDBField4,extDB4(150)
  extDBfield2=0
  extDBField3=0
  extDBField4=0
 '----90/09/03 add-end
  extDBField=0
  aryParmKey=Split(Request("Key") &";;;;;;;;;;;;;;;",";")
  '�ק�G
  aryParm=Split(Request("parm") &";;;;;;;;;;;;;;;",";")
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
'response.write "aryKeyType(" &i& ")=" & aryKeyType(i) &"<BR>"
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
   ' RESPONSE.WRITE SQL
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
                       if i=0 then
                          Set rsc=Server.CreateObject("ADODB.Recordset")
                          cusidxx=right("0" & datePART("yyyy",NOW())-1911,3) & right("0" & trim(datePART("m",NOW())),2)& right("0" & trim(datePART("d",NOW())),2)
                          rsc.open "select max(caseno) AS caseno from RTFaqM where caseno LIKE '" & cusidxx & "%' " ,conn
                          if len(trim(rsc("caseno"))) > 0 then 
                             dspkey(0)=cusidxx & right("00" & cstr(cint(right(rsc("caseno"),3)) + 1),3)
                          else
                             dspkey(0)=cusidxx & "001"
                          end if
                          rsc.close
                       end if 
                       'response.write "I=" & i & ";VALUE=" & dspkey(i) & "�@�@;type=" & sType & "<BR>"
                       rs.Fields(i).Value=dspKey(i)                       
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
              'runpgm=Request.ServerVariables("PATH_INFO") 
              'select case ucase(runpgm)   
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
              '   case ucase("/webap/rtap/base/HBservice/RTFaqD.asp")
                    'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)    
              '   case else
              '       rs.Fields(i).Value=dspKey(i)
              ' end select
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
       'runpgm=Request.ServerVariables("PATH_INFO")
       'if ucase(runpgm)=ucase("/webap/rtap/base/HBservice/RTFaqD.asp") then
          cusidxx=right("0" & datePART("yyyy",NOW())-1911,3) & right("0" & trim(datePART("m",NOW())),2)& right("0" & trim(datePART("d",NOW())),2)
          rsc.open "select max(caseno) AS caseno from RTFaqM where caseno LIKE '" & cusidxx & "%' " ,conn
          if not rsC.eof then
            dspkey(0)=rsC("caseno")
          end if
          rsC.close
       'end if
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
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="vbscript">
Sub Window_onLoad()
  window.Focus()
  
    s21 = document.all("key21").value
        '���T�Τ�
    if s21 ="01" then
        window.SRTAB0.style.display=""
        window.SRTAB2.style.display=""
    else
        ' ���ϼ�� -> ����,cusid,entryno
        window.SRTAB0.style.display=""
        window.SRTAB2.style.display="none"
        ' ��L��� -> �A����comtype,comq1,lineq1
        if s21 ="03" then   
            window.SRTAB0.style.display="none"
        end if
    end if
  
  '�ק�A
  CmtyCustView
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
  numberOfKey=1
  title="�ȪA��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB=	"SELECT CASENO, COMTYPE, COMQ1, LINEQ1, CUSID, ENTRYNO, FAQMAN, TEL, " &_
				"MOBILE, FAQREASON, IOBOUND, MEMO, RCVUSR, RCVDAT, CLOSEUSR, " &_
				"CLOSEDAT, UUSR, UDAT, CANCELUSR, CANCELDAT, ASKCASE, CUSTSRC FROM RTFaqM " &_
				"WHERE caseno='' "
  sqlList=		"SELECT CASENO, COMTYPE, COMQ1, LINEQ1, CUSID, ENTRYNO, FAQMAN, TEL, " &_
				"MOBILE, FAQREASON, IOBOUND, MEMO, RCVUSR, RCVDAT, CLOSEUSR, " &_
				"CLOSEDAT, UUSR, UDAT, CANCELUSR, CANCELDAT, ASKCASE, CUSTSRC FROM RTFaqM " &_
				"WHERE "
  userDefineRead="Yes"      
  userDefineSave="Yes"       
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=99
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
  If len(dspKey(20))=0 Then dspKey(20) =""      '�Ȥ�ӹq�߰ݤ��
  If len(dspKey(2))=0 Then dspKey(2) = 0        'comq1
  If len(dspKey(3))=0 Then dspKey(3) = 0        'lineq1
  If len(dspKey(5))=0 Then dspKey(5) = 0        'entryno

  if dspkey(21) ="01" and (len(dspKey(2))=0 or len(dspKey(4))=0) then
       formValid=False
       message="���ϩΫȤᤣ�i�ť�"   
  elseif dspkey(21) ="02" and len(dspKey(2))=0 then
       formValid=False
       message="���Ϥ��i�ť�"   
  elseif len(trim(dspkey(6)))=0 then
       formValid=False
       message="[�p���H]���i�ť�"   
  elseif len(trim(dspkey(7)))=0 and len(trim(dspkey(8)))=0 then
       formValid=False
       message="[�p���q��]�M[��ʹq��]�ܤֻݿ�J�@��"
  elseif len(trim(dspkey(9)))=0 then
       formValid=False
       message="[�ȶD��]]���i�ť�"   
  elseif len(trim(dspkey(10)))=0 then
       formValid=False
       message="[�i�X�u�O]���i�ť�"
  end if
  '�ˬd�Ȥ�D�ɪ��A�O�_���\�إ߫ȪA��ơJ(1)�w�h���h���i�ଣ�u��



'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(16)=V(0)
        dspkey(17)=now()
    end if        
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveXScript()%>
   <SCRIPT Language="VBScript">
'   Sub Srbtnonclick()
'       Dim ClickID
'       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
'       clickkey="KEY" & clickid
'	   if isdate(document.all(clickkey).value) then
'	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
'       end if
'       call objEF2KDT.show(1)
'       if objEF2KDT.strDateTime <> "" then
'          document.all(clickkey).value = objEF2KDT.strDateTime
'       end if
'   END SUB

'   Sub SrClear()
'       Dim ClickID
'       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
'       clickkey="C" & clickid
'       clearkey="key" & clickid    
'       if len(trim(document.all(clearkey).value)) <> 0 then
'          document.all(clearkey).value =  ""
         '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
'       end if
'   End Sub    

   Sub Srcounty3onclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,4,len(window.event.srcElement.id)-1)
	   colComn = document.all("colComn").VALUE
	   colCusnc = document.all("colCusnc").VALUE
	   colRaddr = document.all("colRaddr").VALUE
	   colCustSrc = document.all("key21").VALUE
	   'if colComn ="" then colComn ="*"
       prog="RTGetFaq.asp?KEY=" & ClickID &";"& colComn &";"& colCusnc &";"& colRaddr &";"& colCustSrc
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:630px;dialogHeight:480px;")
      ' FUsr=Window.open(prog,"d2","resizable=yes", true)
       if fusr <> "" then 
			FUsrID=Split(Fusr,";")
			if Fusrid(0) ="Y" then
				document.all("key1").value =  trim(Fusrid(1))
				document.all("key2").value =  trim(Fusrid(2))
				document.all("key3").value =  trim(Fusrid(3))
				document.all("key4").value =  trim(Fusrid(4))
				document.all("key5").value =  trim(Fusrid(5))

				document.all("key6").value =  trim(Fusrid(16))
				document.all("key7").value =  trim(Fusrid(17))
				document.all("key8").value =  trim(Fusrid(18))

				document.all("colComtypenc").value =  trim(Fusrid(6))
				'document.all("colBelongnc").value =  trim(Fusrid(7))
				document.all("colSalesnc").value = "["& trim(Fusrid(7)) &"] "& trim(Fusrid(8))
				document.all("colComq").value =  trim(Fusrid(9))
				document.all("colComn").value =  trim(Fusrid(10))
				document.all("colLinetel").value =  trim(Fusrid(11))
				document.all("colCmtyip").value =  trim(Fusrid(12))
				document.all("colLinerate").value =  trim(Fusrid(13))
				document.all("colArrivedat").value =  trim(Fusrid(14))
				document.all("colRcomdrop").value =  trim(Fusrid(15))
				document.all("colCusnc").value =  trim(Fusrid(16))
				document.all("colContacttel").value =  trim(Fusrid(17))
				document.all("colCompanytel").value =  trim(Fusrid(18))
				document.all("colRaddr").value =  trim(Fusrid(19))
				document.all("colCustip").value =  trim(Fusrid(20))
				document.all("colCasekind").value =  trim(Fusrid(21))
				document.all("colPaycycle").value =  trim(Fusrid(22))
				document.all("colPaytype").value =  trim(Fusrid(23))
				document.all("colOverdue").value =  trim(Fusrid(24))
				document.all("colFreecode").value =  trim(Fusrid(25))
				document.all("colDocketdat").value =	trim(Fusrid(26))
				document.all("colStrbillingdat").value =trim(Fusrid(27))
				document.all("colNewbillingdat").value =trim(Fusrid(28))
				document.all("colDuedat").value	=  trim(Fusrid(29))				
				document.all("colDropdat").value =  trim(Fusrid(30))
				document.all("colCanceldat").value =  trim(Fusrid(31))
				document.all("colSecondcase").value =  trim(Fusrid(32))
				document.all("colIdslamip").value =  trim(Fusrid(33))
				document.all("colGateway").value =  trim(Fusrid(34))
				document.all("colNciccusno").value =  trim(Fusrid(35))
				document.all("colSp499cons").value =  trim(Fusrid(36))
				document.all("colWtlApplyDat").value =  trim(Fusrid(37))
			End if       
       end if
       '�ק�B 
       CmtyCustView
   End Sub

	'�ק�C --------------------------------------------------------------------------------------------
   Sub CmtyCustView()
	   if document.all("key2").value ="" then
			window.btnViewCmty.style.display="none"
	   else
			window.btnViewCmty.style.display=""
	   end if

	   if document.all("key3").value ="" or document.all("key3").value ="0" then
			window.btnViewLine.style.display ="none"
	   else
			window.btnViewLine.style.display =""
	   end if

	   if document.all("key4").value ="" then
			window.btnViewCust.style.display="none"
	   else
			window.btnViewCust.style.display=""
	   end if
   end sub

	sub btnViewOnClick()
		dim comtype, comq1, lineq1, cusid, entryno, XRND, ClickID
		comtype = document.all("key1").value
		comq1 = document.all("key2").value
		lineq1 = document.all("key3").value
		cusid = document.all("key4").value
		entryno = document.all("key5").value
        ClickID = window.event.srcElement.id
		Randomize
		XRND = RND()
		if ClickID = "btnViewComq1" then
			select case comtype
				case "3"
					prog = "/webap/rtap/base/rtsparqadslcmty/RTCmtyK.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "6"
					prog = "/webap/rtap/base/rtsparq499cmty/RTsparq499CmtyK.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "7"
					prog = "/webap/rtap/base/RTlessorAVSCMTY/RTLessorAVSCmtyK2.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "8"
					prog = "/webap/rtap/base/RTlessorCMTY/RTLessorCmtyK2.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "9"
					prog = "/webap/rtap/base/RTPrjCmty/RTPrjCmtyK2.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "A"
					prog = "/webap/rtap/base/RTSonetCMTY/RTSonetCmtyK2.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
				case "B"
					prog = "/webap/rtap/base/RTfareastCMTY/RTfareastCmtyK2.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";"
                                case else
					prog =""
			end select
		elseif ClickID = "btnViewLineq1" then
			select case comtype
				case "6"
					prog = "/webap/rtap/base/rtsparq499cmty/RTSparq499cmtylineK.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";" &lineq1 &";"
				case "7"
					prog = "/webap/rtap/BASE/RTlessorAVSCMTY/RTLessorAVSCmtyLineK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"
				case "8"
					prog = "/webap/rtap/BASE/RTlessorCMTY/RTLessorCmtyLineK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"
				case "9"
					prog = "/webap/rtap/BASE/RTPrjCmty/RTPrjCmtyLineK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"
				case "A"
					prog = "/webap/rtap/BASE/RTSonetCMTY/RTSonetCmtyLineK2.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"
				case "B"
					prog = "/webap/rtap/BASE/RTfareastCMTY/RTfareastCmtyLineK2.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"
				case else
					prog =""       
			end select
		elseif ClickID = "btnViewCusid" then
			select case comtype
				case "3"
					prog = "/webap/rtap/base/rtsparqadslcmty/RTCustK.asp?V=" &XRND& "&faq="& comq1 &";"& cusid &";"& entryno &";"
				case "6"
					prog = "/webap/rtap/base/rtsparq499cmty/RTSparq499CustK.asp?V=" &XRND& "&accessMode=I&key=" & comq1 &";" &lineq1 &";" &cusid &";"
				case "7"
					prog = "/webap/rtap/BASE/RTlessorAVSCMTY/RTLessorAVSCustK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"& cusid &";"
				case "8"
					prog = "/webap/rtap/BASE/RTlessorCMTY/RTLessorCustK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"& cusid &";"
				case "9"
					prog = "/webap/rtap/BASE/RTPrjCmty/RTPrjCustK.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"& cusid &";"
				case "A"
					prog = "/webap/rtap/BASE/RTSonetCMTY/RTSonetCustK2.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"& cusid &";"
				case "B"
					prog = "/webap/rtap/BASE/RTfareastCMTY/RTfareastCustK2.asp?V=" &XRND& "&accessMode=I&key="& comq1 &";"& lineq1 &";"& cusid &";"
				case else
					prog =""       
			end select
		end if
		StrFeature=	"Top=0,left=0,scrollbars=yes,status=yes,location=no,menubar=no," &_
					"width=" & window.screen.width -7 &"px, height="& window.screen.height -74 & "px"
		FUsr=Window.open(prog,"d2", StrFeature)
	end sub

	sub colOnkeypress()
		if window.event.keycode =13 then 
			document.all("Btn" & mid(window.event.srcElement.id,4,len(window.event.srcElement.id)-1)).focus
		end if
	end sub
	'--------------------------------------------------------------------------------------------------
  
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

   Sub SrChangeCustSrc()
        s21 = document.all("key21").value
            '���T�Τ�
        if s21 ="01" then
            window.SRTAB0.style.display=""
            window.SRTAB2.style.display=""
        else
            ' ���ϼ�� -> ����,cusid,entryno
            window.SRTAB0.style.display=""
            window.SRTAB2.style.display="none"
            document.all("colCusnc").value =""
            document.all("colRaddr").value =""
            document.all("colContacttel").value =""
            document.all("colCompanytel").value =""
            document.all("key4").value =""
            document.all("key5").value =""
            document.all("colFreecode").value =""
            document.all("colCustip").value =""
            document.all("colCasekind").value =""
            document.all("colPaytype").value =""
            document.all("colPaycycle").value =""
            document.all("colDocketdat").value =""
            document.all("colDropdat").value =""
            document.all("colOverdue").value =""
            document.all("colStrbillingdat").value =""
            document.all("colNewbillingdat").value =""
            document.all("colSecondcase").value =""
            document.all("colDuedat").value =""
            document.all("colCanceldat").value =""
            document.all("colNciccusno").value =""
            document.all("colSp499cons").value =""
            document.all("colWtlApplydat").value =""
            ' ��L��� -> �A����comtype,comq1,lineq1
            if s21 ="03" then   
                window.SRTAB0.style.display="none"
                document.all("colCOMN").value =""
                document.all("colComq").value =""
                document.all("key2").value =""
                document.all("key3").value =""
                document.all("key1").value =""
                document.all("colComtypenc").value =""
                document.all("colSalesnc").value =""
                document.all("colCmtyip").value =""
                document.all("colGateway").value =""
                document.all("colIdslamip").value =""
                document.all("colLinerate").value =""
                document.all("colLinetel").value =""
                document.all("colArrivedat").value =""
                document.all("colRcomdrop").value =""
            end if
        end if
   End Sub
   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()%>
	<table width="100%" border=1 cellPadding=0 cellSpacing=0>
		<tr><td width="10%" class=dataListHead>�ȪA�渹</td>
			<td width="15%"  bgcolor="silver">
				<input type="text" name="key0" readonly size="12" value="<%=dspKey(0)%>" class=dataListdata>
			</td>
		</tr>
	</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(16))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(16)=V(0)
			   	dspkey(12)=V(0)	'���z�H
        End if  
       dspkey(17)=now()
       dspkey(13)=now()	'���z�ɶ�

		'�ק�T
		dspkey(1) = aryParm(0)
		dspkey(2) = aryParm(1)
		dspkey(3) = aryParm(2)
		dspkey(4) = aryParm(3)
		dspkey(5) = aryParm(4)

    else
        'if len(trim(dspkey(16))) < 1 then
        '   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
        '        V=split(rtnvalue,";")  
        '        DSpkey(16)=V(0)
        'End if         
        'dspkey(17)=now()
    end if      
' -------------------------------------------------------------------------------------------- 

    '�ȪA�浲�׫� protect
    If len(trim(dspKey(14))) > 0  Then
       fieldPa=" class=""dataListData"" readonly "
    Else
       fieldPa=""        
    end if

    If accessMode <>"A" Then
       fieldpb=" disabled "
    Else
       fieldpb=""
    End If
      
%>
  <!--
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>           
  -->
<span id="tags1" class="dataListTagsOn">�Τ�ȪA��T</span>
                                                            
<div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td>
<td>     

<%
if dspkey(21) ="02" then '���ϼ��
	select case dspkey(1)
		case "1", "4"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1) as comq, b.comn, b.t1attachtel as LINETEL, '' as gateway, " &_
				"e.snmpip as CMTYIP, f.codenc as LINERATE, b.t1arrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTCmty b " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTsnmp e on e.comq1 = b.comq1 and e.comkind ='3' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where (c.comtype ='1' or c.comtype ='4') " &_
				"and b.comq1 =" &dspkey(2)
		case "2"
			sql="select j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.cutyid) as comq, b.comn, b.cmtytel as LINETEL, '' as gateway, " &_
				"b.ipaddr as CMTYIP, f.codenc as LINERATE, b.linearrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTCustAdslCmty b " &_
				"left outer join HBAdslCmty c on b.cutyid = c.comq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where c.comtype ='2' " &_
				"and b.cutyid =" &dspkey(2)
		case "3"
			sql="select j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.cutyid) as comq, b.comn, b.cmtytel as LINETEL, '' as gateway, " &_
				"b.ipaddr as CMTYIP, f.codenc as LINERATE, b.linearrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTSparqAdslCmty b " &_
				"left outer join HBAdslCmty c on b.cutyid = c.comq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='3' " &_
				"and b.cutyid =" &dspkey(2)
		case "5"
			sql="select j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip as CMTYIP, f.codenc as LINERATE, b.hinetnotifydat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTEbtCmtyLine b " &_
				"inner join RTEbtCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where c.comtype ='5' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case "6"
			sql="select j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"replace(str(b.lineipstr1) +'.'+ str(b.lineipstr2) +'.'+ str(b.lineipstr3) +'.'+ str(b.lineipstr4) +'~'+ str(b.lineipend),' ','')  as CMTYIP, " &_
				"f.codenc as LINERATE, b.linearrivedat as ARRIVEDAT, b.dropdat as RCOMDROP, b.idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTSparq499CmtyLine b " &_
				"inner join RTSparq499CmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='6' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case "7"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTLessorAvsCmtyLine b " &_
				"inner join RTLessorAvsCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='7' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case "8"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTLessorCmtyLine b " &_
				"inner join RTLessorCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='8' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case "9"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.arrivedat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTPrjCmtyLine b " &_
				"inner join RTPrjCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='9' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case "A"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTSonetCmtyLine b " &_
				"inner join RTSonetCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='A' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
                case "B"
			sql="select	j.codenc as comtypenc, case c.groupnc when '' then '���P' else '�g�P' end as belongnc, c.groupnc + c.leader as salesnc, convert(varchar(5), b.comq1)+'-'+convert(varchar(5), b.lineq1) as comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"'' as cusnc, '' as contacttel, '' as companytel, '' as raddr, '' as CUSTIP, '' as CASEKIND, '' as paycycle, " &_
				"'' as paytype, '' as overdue, '' as freecode, " &_
				"null as docketdat, null as strbillingdat, null as newbillingdat, null as duedat, null as dropdat, null as canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from RTfareastCmtyLine b " &_
				"inner join RTfareastCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmty c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 " &_
				"left outer join RTCode j on j.code = c.comtype and j.kind ='P5' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='B' " &_
				"and b.comq1 = "&dspkey(2)&" and b.lineq1 ="&dspkey(3)
		case else
			sql=""	
	end select
else
	select case dspkey(1)
		case "1", "4"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, b.comn, b.t1attachtel as LINETEL, '' as gateway, " &_
				"e.snmpip as CMTYIP, f.codenc as LINERATE, b.t1arrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, '' as CUSTIP, a.usekind as CASEKIND, '' as paycycle, " &_
				"'' as paytype, replace(a.overdue,'N','') as overdue, replace(a.freecode,'N','') as freecode, " &_
				"c.docketdat, null as strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTCust a " &_
				"inner join RTCmty b on a.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on a.cusid = c.cusid and a.entryno = c.entryno " &_
				"left outer join RTsnmp e on e.comq1 = b.comq1 and e.comkind ='3' " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where (c.comtype ='1' or c.comtype ='4') " &_
				"and a.cusid = '" &dspkey(4)& "' and a.entryno =" &dspkey(5)
		case "2"
			sql="select c.comtypenc, c.belongnc, c.salesnc, c.comq, b.comn, b.cmtytel as LINETEL, '' as gateway, " &_
				"b.ipaddr as CMTYIP, f.codenc as LINERATE, b.linearrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, '' as CUSTIP, a.usekind as CASEKIND, '' as paycycle, " &_
				"'' as paytype, replace(a.overdue,'N','') as overdue, replace(a.freecode,'N','') as freecode, " &_
				"c.docketdat, null as strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTCustAdsl a " &_
				"inner join RTCustAdslCmty b on a.comq1 = b.cutyid " &_
				"left outer join HBAdslCmtyCust c on a.cusid = c.cusid and a.entryno = c.entryno " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='2' " &_
				"and a.cusid = '" &dspkey(4)& "' and a.entryno =" &dspkey(5)
		case "3"
			sql="select c.comtypenc, c.belongnc, c.salesnc, c.comq, b.comn, b.cmtytel as LINETEL, '' as gateway, " &_
				"b.ipaddr as CMTYIP, f.codenc as LINERATE, b.linearrive as ARRIVEDAT, b.rcomdrop, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, '' as CUSTIP, a.usekind as CASEKIND, '' as paycycle, " &_
				"'' as paytype, replace(a.overdue,'N','') as overdue, replace(a.freecode,'N','') as freecode, " &_
				"c.docketdat, null as strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, a.exttel +'-'+ a.sphnno as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTSparqAdslCust a " &_
				"inner join RTSparqAdslCmty b on a.comq1 = b.cutyid " &_
				"left outer join HBAdslCmtyCust c on a.cusid = c.cusid and a.entryno = c.entryno " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='3' " &_
				"and a.cusid = '" &dspkey(4)& "' and a.entryno =" &dspkey(5)
		case "5"
			sql="select c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip as CMTYIP, f.codenc as LINERATE, b.hinetnotifydat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, '' as CUSTIP, g.codenc as CASEKIND, h.codenc as paycycle, " &_
				"'' as paytype, replace(a.overdue,'N','') as overdue, replace(a.freecode,'N','') as freecode, " &_
				"c.docketdat, null as strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTEbtCust a " &_
				"inner join RTEbtCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTEbtCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode g on g.code = a.casetype and g.kind ='H5' " &_
				"left outer join RTCode h on h.code = a.paytype and h.kind ='G6' " &_
				"where 	c.comtype ='5' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "6"
			sql="select c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"replace(str(b.lineipstr1) +'.'+ str(b.lineipstr2) +'.'+ str(b.lineipstr3) +'.'+ str(b.lineipstr4) +'~'+ str(b.lineipend),' ','')  as CMTYIP, " &_
				"f.codenc as LINERATE, b.linearrivedat as ARRIVEDAT, b.dropdat as RCOMDROP, b.idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, replace(a.custip1+'.'+ a.custip2 +'.'+ a.custip3 +'.'+ a.custip4, '...', '') as CUSTIP, " &_
				"g.codenc as CASEKIND, h.codenc as paycycle, " &_
				"'' as paytype, replace(a.overdue,'N','') as overdue, replace(a.freecode,'N','') as freecode, " &_
				"c.docketdat, null as strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, a.nciccusno +'-'+ a.sphnno as nciccusno, case a.consignee when '12973008' then '�컷�ݥΤ�' else '' end as Sp499cons, a.WtlApplyDat " &_
				"from 	RTSparq499Cust a " &_
				"inner join RTSparq499CmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTSparq499CmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode g on g.code = a.casetype and g.kind ='L9' " &_
				"left outer join RTCode h on h.code = a.paytype and h.kind ='M1' " &_
				"where 	c.comtype ='6' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "7"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, replace(a.ip11+'.'+a.ip12+'.'+a.ip13+'.'+a.ip14,'...','') as CUSTIP, " &_
				"g.codenc as CASEKIND, h.codenc as paycycle, i.codenc as paytype, replace(a.overdue,'N','') as overdue, " &_
				"replace(a.freecode,'N','') as freecode, c.docketdat, a.strbillingdat, a.newbillingdat, a.duedat, c.dropdat, c.canceldat, " &_
				"replace(a.secondcase,'N','') as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTLessorAvsCust a " &_
				"inner join RTLessorAvsCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTLessorAvsCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode g on g.code = a.casekind and g.kind ='O9' " &_
				"left outer join RTCode h on h.code = a.paycycle and h.kind ='M8' " &_
				"left outer join RTCode i on i.code = a.paytype and i.kind ='M9' " &_
				"where 	c.comtype ='7' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "8"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, replace(a.ip11+'.'+a.ip12+'.'+a.ip13+'.'+a.ip14,'...','') as CUSTIP, " &_
				"g.codenc as CASEKIND, h.codenc as paycycle, i.codenc as paytype, replace(a.overdue,'N','') as overdue, " &_
				"replace(a.freecode,'N','') as freecode, c.docketdat, a.strbillingdat, a.newbillingdat, a.duedat, c.dropdat, c.canceldat, " &_
				"replace(a.secondcase,'N','') as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTLessorCust a " &_
				"inner join RTLessorCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTLessorCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode g on g.code = a.casekind and g.kind ='O9' " &_
				"left outer join RTCode h on h.code = a.paycycle and h.kind ='M8' " &_
				"left outer join RTCode i on i.code = a.paytype and i.kind ='M9' " &_
				"where 	c.comtype ='8' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "9"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.arrivedat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, replace(a.ip11+'.'+a.ip12+'.'+a.ip13+'.'+a.ip14,'...','') as CUSTIP, " &_
				"'' as CASEKIND, '' as paycycle, '' as paytype, '' as overdue, " &_
				"replace(a.freecode,'N','') as freecode, c.docketdat, a.strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, '' as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTPrjCust a " &_
				"inner join RTPrjCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTPrjCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"where 	c.comtype ='9' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "A"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, a.ip11 as CUSTIP, " &_
				"'' as CASEKIND, h.codenc as paycycle, '' as paytype, convert(varchar(10), a.overduedat,111) as overdue, " &_
				"replace(a.freecode,'N','') as freecode, c.docketdat, a.strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, a.memberid as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTSonetCust a " &_
				"inner join RTSonetCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTSonetCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode h on h.code = a.paycycle and h.kind ='M8' " &_
				"where 	c.comtype ='A' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "
		case "B"
			sql="select	c.comtypenc, c.belongnc, c.salesnc, c.comq, d.comn, b.linetel as LINETEL, b.gateway, " &_
				"b.lineip  as CMTYIP, f.codenc as LINERATE, b.hardwaredat as ARRIVEDAT, b.dropdat as RCOMDROP, '' as idslamip, " &_
				"c.cusnc, c.contacttel, c.companytel, c.raddr, a.ip11 as CUSTIP, " &_
				"'' as CASEKIND, h.codenc as paycycle, '' as paytype, convert(varchar(10), a.overduedat,111) as overdue, " &_
				"replace(a.freecode,'N','') as freecode, c.docketdat, a.strbillingdat, null as newbillingdat, null as duedat, c.dropdat, c.canceldat, " &_
				"'' as secondcase, a.memberid as nciccusno, '' as Sp499cons, null as WtlApplyDat " &_
				"from 	RTfareastCust a " &_
				"inner join RTfareastCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
				"inner join RTfareastCmtyH d on d.comq1 = b.comq1 " &_
				"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.lineq1 = a.lineq1 and a.cusid = c.cusid " &_
				"left outer join RTCode f on f.code = b.linerate and f.kind ='D3' " &_
				"left outer join RTCode h on h.code = a.paycycle and h.kind ='M8' " &_
				"where 	c.comtype ='B' " &_
				"and a.comq1 = "&dspkey(2)&" and a.lineq1 ="&dspkey(3)&" and a.cusid ='" &dspkey(4)& "' "		
		case else
			sql=""	
	end select
end if
   ' response.write "SQL=" & SQL
    Dim conn,rs,s,sx,sql,t
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    if sql <>"" then 
		rs.OPEN sql,CONN
		IF RS.EOF THEN
			comtypenc =""		:   belongnc =""	:	salesnc =""		:	comq =""	
			comn =""	        :	linetel =""		:	cmtyip =""		:	linerate =""	
			arrivedat =""		:	rcomdrop =""	:	idslamip =""	:	gateway =""
			cusnc =""			:	contacttel =""	:   companytel =""	:	raddr =""
			custip =""			:   casekind =""	:	paycycle =""	:   paytype =""		
			overdue =""			:	freecode =""	:   docketdat =""	:   strbillingdat =""
			newbillingdat =""	:   duedat =""		:	dropdat =""		:   canceldat =""
			nciccusno =""		:	sp499cons =""	:	wtlapplydat =""
		ELSE
			comtypenc =rs("comtypenc")	:	belongnc = rs("belongnc")	:	salesnc = rs("salesnc")
			comq = rs("comq")			:	comn = rs("comn")			:	linetel = rs("linetel")
			cmtyip = rs("cmtyip")       :	linerate = rs("linerate")	:	arrivedat = rs("arrivedat")
			rcomdrop = rs("rcomdrop")	:	idslamip = rs("idslamip")	:	gateway = rs("gateway")
			cusnc = rs("cusnc")			:	casekind = rs("casekind")	:	companytel = rs("companytel")
			raddr = rs("raddr")			:	custip = rs("custip")		:	contacttel = rs("contacttel")
			paycycle = rs("paycycle")	:	paytype = rs("paytype")		:	secondcase = rs("secondcase")
			overdue = rs("overdue")     :	freecode = rs("freecode")	:	strbillingdat = rs("strbillingdat")
			docketdat = rs("docketdat")	:	dropdat = rs("dropdat")		:	newbillingdat = rs("newbillingdat")
			canceldat = rs("canceldat") :	duedat = rs("duedat")		:	nciccusno = rs("nciccusno")
			sp499cons = rs("sp499cons")	:	wtlapplydat = rs("wtlapplydat")
		END IF
		RS.CLOSE
	end if
%>
<DIV ID="SRTAG0">
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
	<tr><td bgcolor="BDB76B" align="center">�Ȥ�򥻸�Ƭd��</td></tr>
</table>
</DIV>


<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
	<tr>
		<td width="10%" class=dataListHEAD>�Ȥ�ӷ������O</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 and len(trim(dspkey(15)))=0 Then  
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='Q3' " 
			If len(trim(dspkey(21))) < 1 Then
				sx=" selected " 
				's=s & "<option value=""""" & sx & "></option>"  
				sx=""
			else
				's=s & "<option value=""""" & sx & "></option>"  
				sx=""
			end if     
			Else
			    sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='Q3' AND CODE='" & dspkey(21) & "'"
			End If
			rs.Open sql,conn
			Do While Not rs.Eof
			If rs("CODE")=dspkey(21) Then sx=" selected "
			    s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
		<td bgcolor="silver" colspan=5 >
		<select size="1" name="key21" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select3" onChange="srChangeCustSrc()">
			<%=s%>
		</select></td>
	</tr>
</table>


<DIV ID="SRTAB0">
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table7">
	<tr>
		<td width="10%" class=dataListsearch>���ϦW��</td>
		<td bgcolor="silver" colspan=5 >
			<input type="text" size="42" id="colCOMN" NAME="colCOMN" value="<%=comn%>" style="color=blue;" onkeypress="colOnkeypress()" >
			<input type="button" id="BtnComn" name="BtnComn" <%=fieldPb%> value="���ϦW�ٷj�M" onclick="Srcounty3onclick()">
			<!--�ק�D -->
			<span id="btnViewCmty">
				<input type="button" id="btnViewComq1" name="btnViewComq1" value="���ϸ��" onclick="btnViewOnClick()" style="color:green;">
			</span>
			<span id="btnViewLine">
				<input type="button" id="btnViewLineq1" name="btnViewLineq1" value="�D�u���" onclick="btnViewOnClick()" style="color:green;">
			</span>
		</td>
	</tr>
	<tr>
	    <td width="10%" class=dataListsearch>�D�u�Ǹ�</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="7" name="colComq" value="<%=comq%>" class="dataListsearch3" ID="Text22">
			<input type="text" name="key2" readonly size="4" value="<%=dspkey(2)%>" class="dataListDATA" ID="Text1" style="display:none;">
			<input type="text" name="key3" readonly size="3" value="<%=dspkey(3)%>" class="dataListDATA" ID="Text2" style="display:none;">
		</td>
		<td width="10%" class=dataListsearch>��קO</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" name="key1" readonly size="2" value="<%=dspkey(1)%>" class="dataListDATA" ID="Text3" style="display:none;">
			<input type="text" readonly size="10" name="colComtypenc" value="<%=comtypenc%>" class="dataListsearch3" ID="Text42">
		</td>
		<td width="10%" class=dataListsearch>�ҰϷ~��</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="15" name="colSalesnc" value="[<%=belongnc%>] <%=salesnc%>" class="dataListsearch3" ID="Text15">
		</td>
	</tr>
	<tr>
	    <td width="10%" class=dataListsearch>����IP</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="20" name="colCmtyip" value="<%=cmtyip%>" class="dataListsearch3" ID="Text45">
		</td>
	    <td width="10%" class=dataListsearch>Gateway IP</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="20" name="colGateway" value="<%=gateway%>" class="dataListsearch3" ID="Text21">
		</td>
	    <td width="10%" class=dataListsearch>iDSLAM IP</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="20" name="colIdslamip" value="<%=idslamip%>" class="dataListsearch3" ID="Text44">
		</td>
	</tr>
	<tr>
	    <td class=dataListsearch>�D�u�t�v</td>
		<td bgcolor="silver">
			<input type="text" readonly size="15" name="colLinerate" value="<%=linerate%>" class="dataListsearch3" ID="Text23">
		</td>
	    <td width="10%" class=dataListsearch>�����q��</td>
		<td width="23%" bgcolor="silver" colspan=3>
			<input type="text" readonly size="15" name="colLinetel" value="<%=linetel%>" class="dataListsearch3" ID="Text16">
		</td>
	</tr>
	<tr><td class=dataListsearch>�u������</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="12" name="colArrivedat" value="<%=arrivedat%>" class="dataListsearch3" ID="Text24">
		</td>
	    <td class=dataListsearch>�M�u��</td>
		<td bgcolor="silver" colspan=3>
			<input type="text" readonly size="12" name="colRcomdrop" value="<%=rcomdrop%>" class="dataListsearch3" style="color:red;" ID="Text25" >
		</td>
	</tr>
</table>
</DIV>

<DIV ID=SRTAB2 >
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table9">
	<tr>
		<td width="10%" class=dataListsearch>�Τ�W��</td>
		<td bgcolor="silver" colspan=5>
			<input type="text" size="42" value="<%=cusnc%>" id ="colCusnc" NAME="colCusnc" style="color=blue;" ID="Text41" onkeypress="colOnKeypress()">
		    <input type="button" id="BtnCusnc" name="BtnCusnc" width="100%" value="�Τ�W�ٷj�M" onclick="Srcounty3onclick()" <%=fieldPb%>>
			<!--�ק�E -->			
			<span id="btnViewCust">
				<input type="button" id="btnViewCusid" name="btnViewCusid" value="�Τ���" onclick="btnViewOnClick()" style="color:green;">
			</span>
				<input type="text" readonly size="12" name="colSp499cons" value="<%=sp499cons%>" style="color=red;" class="dataListsearch3">
		</td>
	</tr>
	<tr>
	    <td width="10%" class=dataListsearch>�Τ�a�}</td>
		<td bgcolor="silver" colspan=3>
			<input type="text" size="55" value="<%=raddr%>" id="colRaddr" NAME="colRaddr" style="color=blue;" ID="Text26" onkeypress="colOnKeypress()" >
			<input type="button" id="BtnRaddr" name="BtnRaddr" width="100%" value="�Τ�a�}�j�M" onclick="Srcounty3onclick()" <%=fieldPb%>>
		</td>
		<td class=dataListsearch>WTL�ӽФ�</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="20" name="colWtlApplyDat" value="<%=WtlApplyDat%>" class="dataListsearch3" ID="Text35">
		</td>
	</tr>

	<tr style="display:none;">
		<td class=dataListsearch>�Τ�q��</td>
		<td bgcolor="silver" colspan=3>
			<input type="text" readonly size="50" name="colContacttel" value="<%=contacttel%>" class="dataListsearch3" ID="Text31">			
		</td>
	    <td class=dataListsearch>��ʹq��</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="29" name="colCompanytel" value="<%=companytel%>" class="dataListsearch3" ID="Text30">
		</td>
	</tr>

	<tr>
		<td width="10%" class=dataListsearch>�Τ�s��</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="15" name="key4" value="<%=dspkey(4)%>" class="dataListsearch3" ID="Text28">
			<font size=2 color=black>����: </font>
			<input type="text" readonly size="2" name="key5" value="<%=dspkey(5)%>" class="dataListsearch3" ID="Text4">
		</td>
	    <td width="10%" class=dataListsearch>������</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="2" name="colFreecode" value="<%=freecode%>" class="dataListsearch3" style="color:red;" ID="Text5">
		</td>
	    <td width="10%" class=dataListsearch>�Τ�IP</td>
		<td width="23%" bgcolor="silver" >
			<input type="text" readonly size="20" name="colCustip" value="<%=custip%>" class="dataListsearch3" ID="Text29">
		</td>
	</tr>	
	<tr>
		<td class=dataListsearch>�Τ���</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="29" name="colCasekind" value="<%=casekind%>" class="dataListsearch3" ID="Text32">
		</td>
	    <td class=dataListsearch>ú�O�覡</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="15" name="colPaytype" value="<%=paytype%>" class="dataListsearch3" ID="Text33">
		</td>
		<td class=dataListsearch>ú�O�g��</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="29" name="colPaycycle" value="<%=paycycle%>" class="dataListsearch3" ID="Text34">
		</td>
	</tr>
	<tr>
		<td class=dataListsearch>������</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="25" name="colDocketdat" value="<%=docketdat%>" class="dataListsearch3" ID="Text35">
		</td>
		<td class=dataListsearch>�h����</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="10" name="colDropdat" value="<%=dropdat%>" class="dataListsearch3" style="color:red;" ID="Text38">
		</td>
	    <td class=dataListsearch>���</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="10" name="colOverdue" value="<%=overdue%>" class="dataListsearch3" style="color:red;" ID="Text39">
		</td>
	</tr>
	<tr>
	    <td class=dataListsearch>�}�l�p�O��</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="10" name="colStrbillingdat" value="<%=strbillingdat%>" class="dataListsearch3" ID="Text36">
		</td>
	    <td class=dataListsearch>�����</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="10" name="colNewbillingdat" value="<%=newbillingdat%>" class="dataListsearch3" ID="Text37">
		</td>
	    <td class=dataListsearch>�O�_���ĤG��</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="2" name="colSecondcase" value="<%=secondcase%>" class="dataListsearch3" ID="Text14">
		</td>
	</tr>
	<tr>
	    <td class=dataListsearch>�����</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="10" name="colDuedat" value="<%=duedat%>" class="dataListsearch3"
			<%	if len(duedat)> 0 then
					if dateadd("d",1,duedat) < now() then response.Write "style=""color:red;""" 
				end if
			%> ID="Text43">
		</td>
	    <td class=dataListsearch>�@�o��</td>
		<td bgcolor="silver">
			<input type="text" readonly size="25" name="colCanceldat" value="<%=canceldat%>" class="dataListsearch3" style="color:red;" ID="Text40">
		</td>
	    <td class=dataListsearch>��b�N��</td>
		<td bgcolor="silver" >
			<input type="text" readonly size="20" name="colNciccusno" value="<%=nciccusno%>" class="dataListsearch3" ID="Text46">
		</td>
	</tr>
</table>
</DIV>


<DIV ID="SRTAG2">
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
		<tr><td bgcolor="BDB76B" align="center">�ȪA���e</td></tr>
    </table>
</DIV>

<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table5">
	<tr>
		<td width="10%" class=dataListHEAD>�p���H</td>
		<td width="23%" bgcolor="silver">   
			<% IF DSPKEY(6)="" THEN DSPKEY(6)=CUSNC %>
			<input type="text" size="30" maxlength=50 name="key6" value="<%=dspKey(6)%>" <%=fieldpa%><%=fieldRole(1)%> class="dataListentry">
		</TD>

		<td width="10%" class=dataListHEAD>�i�X�u�O</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 and len(trim(dspkey(15)))=0 Then  
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='P8' " 
			If len(trim(dspkey(10))) < 1 Then
				sx=" selected " 
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			else
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			end if     
			Else
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='P8' AND CODE='" & dspkey(10) & "'"
			End If
			rs.Open sql,conn
			Do While Not rs.Eof
			If rs("CODE")=dspkey(10) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
		<td width="23%" bgcolor="silver" >
		<select size="1" name="key10" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select1" >                                                                  
			<%=s%>
		</select></td>

		<td width="10%" class=dataListHEAD>�ȶD��]</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 and len(trim(dspkey(15)))=0 Then  
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='P7' " 
			If len(trim(dspkey(9))) < 1 Then
				sx=" selected " 
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			else
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			end if     
			Else
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='P7' AND CODE='" & dspkey(9) & "'"
			End If
			rs.Open sql,conn
			Do While Not rs.Eof
			If rs("CODE")=dspkey(9) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
		<td width="23%" bgcolor="silver" >
		<select size="1" name="key9" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35" >                                                                  
			<%=s%>
		</select></td>
	</tr>

	<TR><td class="dataListHEAD" height="23">�p���q��</td>               
		<td  height="23" bgcolor="silver">   
			<% IF DSPKEY(7)="" THEN DSPKEY(7)=CONTACTTEL %>
			<input type="text" name="key7" size="30" maxlength=50 value="<%=dspKey(7)%>"<%=fieldpa%><%=fieldRole(1)%> class="dataListentry" ID="Text56">
		</TD>
		<td class="dataListHEAD" height="23">��ʹq��</td>               
		<td height="23" bgcolor="silver" >
			<% IF DSPKEY(8)="" THEN DSPKEY(8)=companytel %>
			<input type="text" name="key8" size="30" maxlength=50 value="<%=dspKey(8)%>" <%=fieldpa%><%=fieldRole(1)%> class="dataListentry" ID="Text6">
		</td>
		<td width="10%" class=dataListHEAD>�ӹq�߰ݤ��</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 and len(trim(dspkey(15)))=0 Then  
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='Q2' and parm1 <>'archive' order by parm1 " 
			If len(trim(dspkey(20))) < 1 Then
				sx=" selected " 
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			else
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			end if     
			Else
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='Q2' AND CODE='" & dspkey(20) & "'"
			End If
			rs.Open sql,conn
			Do While Not rs.Eof
			If rs("CODE")=dspkey(20) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
		<td width="23%" bgcolor="silver" >
		<select size="1" name="key20" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select2" >                                                                  
			<%=s%>
		</select></td>
	</tr>

	<tr><td class="dataListHEAD" height="23">���z�H��</td>
		<td height="23" bgcolor="silver">
			<input type="text" name="key12" size="6" READONLY value="<%=dspKey(12)%>" class="dataListDATA">
			<font size=2><%=SrGetEmployeeName(dspKey(12))%></font>
		</td>  
		<td class="dataListHEAD" height="23">���z�ɶ�</td>
		<td height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key13" size="25" READONLY value="<%=dspKey(13)%>"  class="dataListDATA" ID="Text9">
		</td>       
	</tr>
	
	<tr><td class="dataListHEAD" height="23">���פH��</td>                                 
        <td height="23" bgcolor="silver">
			<input type="text" name="key14" size="6" readonly value="<%=dspKey(14)%>" class="dataListDATA" ID="Text8">
			<font size=2><%=SrGetEmployeeName(dspKey(14))%></font>
        </td>
		<td  class="dataListHEAD" height="23">���׮ɶ�</td>
		<td height="23" bgcolor="silver" colspan=3>
			<input type="text" name="key15" size="25" readonly value="<%=dspKey(15)%>" class="dataListdata" ID="Text7">
		</td>
	</tr>

	<tr><td  class="dataListHEAD" height="23">�ק�H��</td>
        <td  height="23" bgcolor="silver">
			<input type="text" name="key16" size="6" READONLY value="<%=dspKey(16)%>" class="dataListDATA" ID="Text10">
			<font size=2><%=SrGetEmployeeName(dspKey(16))%></font>
        </td>
        <td  class="dataListHEAD" height="23">�ק�ɶ�</td>
        <td  height="23" bgcolor="silver" colspan=3>
	        <input type="text" name="key17" size="25" READONLY value="<%=dspKey(17)%>" class="dataListDATA" ID="Text11">
        </td>
	</tr>

	<tr><td  class="dataListHEAD" height="23">�@�o�H��</td>
        <td  height="23" bgcolor="silver">
			<input type="text" name="key18" size="6" READONLY value="<%=dspKey(18)%>" style="color:red;" class="dataListDATA" ID="Text12">
			<font size=2 color=red><%=SrGetEmployeeName(dspKey(18))%></font>
        </td>
        <td  class="dataListHEAD" height="23">�@�o�ɶ�</td>
        <td  height="23" bgcolor="silver" colspan=3>
	        <input type="text" name="key19" size="25" READONLY value="<%=dspKey(19)%>" style="color:red;" class="dataListDATA" ID="Text13">
        </td>
	</tr>

	<tr><td class="dataListHEAD">�Ƶ�</td>
		<td colspan=5>
			<TEXTAREA cols="100%" name="key11" rows=10 MAXLENGTH=800 <%=fieldpa%> class="dataListentry" <%=dataprotect%> value="<%=dspkey(11)%>" ID="Textarea2"><%=dspkey(11)%></TEXTAREA>
		</td>
	</tr>
</table>

<DIV ID="SRTAG6">
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table8">
	<tr><td bgcolor="BDB76B" align="center">�ȶD�l��</td></tr>
</table>
</DIV>

<DIV ID="SRTAB6" > 
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
    <tr class="dataListHEAD"><td>����</td><td>�i�X�u</td><td>�l��<br>�H��</td><td>�l��ɶ�</td><td>�Ƶ�</td></tr>
	<%   
		sqlfaqlist="select a.entryno, d.codenc as ioboundnc, c.name as addusrname, " &_
					" a.adddat, left(a.memo,50)+ case when len(a.memo) >50 then'...' else '' end as shortmemo " &_
					"from	RTFaqAdd a " &_
					"inner join RTFaqM b on a.caseno = b.caseno " &_
					"left outer join RTEmployee c on c.emply = a.addusr " &_
					"left outer join RTCode d on d.code = a.iobound and d.kind ='P8' " &_					
					"WHERE a.canceldat is null " &_
					"and a.caseno ='" & dspkey(0) & "' "
		rs.open sqlfaqlist,conn
		Do While Not rs.Eof
			response.Write	"<tr class=""dataListentry"">" &_
							"<td>"& rs("entryno") & "</td>" &_
							"<td>"& rs("ioboundnc") & "</td>" &_	
							"<td nowrap>"& rs("addusrname") & "</td>" &_	
							"<td nowrap>"& rs("adddat") & "</td>" &_	
							"<td>"& rs("shortmemo") & "</td>" &_	
							"</tr>"
			rs.MoveNext
		Loop
		rs.close
	%>
</table>
</div>

<P></P>

<DIV ID="SRTAG7" >
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table10">
	<tr><td bgcolor="BDB76B" align="center">�ȶD���u</td></tr>
</table>
</DIV>

<DIV ID="SRTAB7" > 
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table11">
    <tr class="dataListHEAD"><td>���u�渹</td><td>���u�H��</td><td>���u��</td><td>���u�O</td><td>�w�w�I�u�H</td><td>��ڬI�u�H</td><td>���u�H��</td><td>���u��</td><td>�Ƶ�</td></tr>
	<%   
		sqlfaqlist=	"select a.workno, e.name as sndwrkusrnc, a.sndwrkdat, c.codenc as worktypenc, " &_
					"isnull(g.shortnc, d.name) as assignengnc, isnull(i.shortnc, h.name) as finishengnc, " &_
					"f.name as finishusr, a.finishdat, " &_
					"left(a.memo,30)+ case when len(a.memo) >30 then'...' else '' end as shortmemo " &_
					"from	RTSndWork a " &_
					"inner join RTFaqM b on b.caseno = a.linkno " &_
					"left outer join RTCode c on c.code = a.worktype and c.kind ='P6' " &_
					
					"left outer join RTEmployee d on d.emply = a.assigneng " &_
					"left outer join RTObj g on g.cusid = a.assigncons " &_
					"left outer join RTEmployee h on h.emply = a.finisheng " &_
					"left outer join RTObj i on i.cusid = a.finishcons " &_
					
					"left outer join RTEmployee e on e.emply = a.sndwrkusr " &_
					"left outer join RTEmployee f on f.emply = a.finishusr " &_
					"where 	(a.worktype ='01' or a.worktype ='09') " &_
					"and a.canceldat is null " &_
					"and a.linkno ='" & dspkey(0) & "' "
		rs.open sqlfaqlist,conn
		Do While Not rs.Eof
			response.Write	"<tr class=""dataListentry"">" &_
							"<td>"& rs("workno") & "</td>" &_
							"<td>"& rs("sndwrkusrnc") & "</td>" &_	
							"<td>"& rs("sndwrkdat") & "</td>" &_	
							"<td>"& rs("worktypenc") & "</td>" &_	
							"<td>"& rs("assignengnc") & "</td>" &_	
							"<td>"& rs("finishengnc") & "</td>" &_	
							"<td>"& rs("finishusr") & "</td>" &_	
							"<td>"& rs("finishdat") & "</td>" &_	
							"<td>"& rs("shortmemo") & "</td>" &_	
							"</tr>"	
			rs.MoveNext
		Loop
		rs.close
	%>
</table>
</div>

</DIV>
<P></P>
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
'    Dim conn,rs
' Smode A:add U:update
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'
    'Set conn=Server.CreateObject("ADODB.Connection")
    'conn.open DSN
    'Set rs=Server.CreateObject("ADODB.Recordset")
    'Set comm=Server.CreateObject("ADODB.Command")
    
'------ RTObj ---------------------------------------------------
    'DELFAQlist="delete from RTLessorAVScustfaqlist where faqno='" & dspkey(1) & "'"
    'conn.Execute DELFAQlist  
    'For i=0 to 99
    '    if len(trim(extdb(i))) > 0  then
    '       rs.Open "SELECT * FROM RTLessorAVScustfaqlist WHERE faqno='" &dspKey(1) &"' and faqcod='" & extDB(i) & "'" ,conn,3,3
    '       If rs.Eof Or rs.Bof Then
    '          rs.AddNew
    '          rs("cusid")=dspKey(0)
    '          rs("faqno")=dspKey(1)
    '          rs("faqcod")=extDB(i)          
    '       End If
    '       rs.Update
    '       rs.Close
    '    end if
    'Next
    'conn.Close
    'Set rs=Nothing
    'Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/checkid.inc" -->
<!-- #include virtual="/Webap/include/companyid.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
