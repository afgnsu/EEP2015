<%
  Dim fieldRole,fieldPa,fieldPb
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
%>
<!-- #include virtual="/WebUtilityV4/DBAUDI/cType.inc" -->
<!-- #include virtual="/WebUtilityV4/DBAUDI/dataList.inc" -->
<%
  Dim aryKeyName,aryKeyType(120),aryKeyValue(120),numberOfField,aryKey,aryKeyNameDB(120)
  Dim dspKey(120),userDefineKey,userDefineData,extDBField,extDB(120),userDefineRead,userDefineSave
  Dim conn,rs,i,formatName,sqlList,sqlFormatDB,userdefineactivex
  Dim aryParmKey
 '90/09/03 ADD-START
 '�W�[EXTDBFIELD2,EXTDBFILELD3(�h�ɺ��@)
  dim extDBField2,extDB2(120),extDBField3,extDB3(120),extDBField4,extDB4(120)
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
                 ' ��{�����Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(2)���۰ʷm�����(max+1)�A�G���h�J�ȡ]�ѵ{�������)   
               case ucase("/webap/rtap/base/rtcmty/RTCustD.asp")
                     if i=1 then
                        cusidxx="H" & cstr(DATEPART("yyyy",now())-1911) & right("0" & datepart("m",now()),2) & right("0" & datepart("d",now()),2)
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(cusid) AS cusid from rtcust where  cusid like '" & cusidxx & "%'"
                        rsc.open "select max(cusid) AS cusid from rtcust where  cusid like '" & cusidxx & "%'",conn
                        if len(rsc("cusid")) > 0 then
                           dspkey(i)=cusidxx & right("000" & cstr(cint(right(rsc("cusid"),3)) + 1),3)
                        else
                           dspkey(i)=cusidxx & "001"
                        end if
                        rsc.close                     
                     end if
                     if i=2 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcust where  cusid='" & dspkey(1) & "'"
                        rsc.open "select max(entryno) AS entryno from rtcust where  cusid='" & dspkey(1) & "'",conn
                        if len(rsc("entryno")) > 0 then
                           dspkey(i)=rsc("entryno") + 1
                        else
                           dspkey(i)=1
                        end if
                        rsc.close
                      end if
                      IF I=89 and dspkey(88)="Y" THEN
                         Set connxx=Server.CreateObject("ADODB.Connection")  
                         Set rsxx=Server.CreateObject("ADODB.Recordset")
                         DSNXX="DSN=RTLIB"
                         connxx.Open DSNxx
                         sqlXX="SELECT * FROM RTcmty INNER JOIN RTCODE ON RTCMTY.COMTYPE = RTCODE.CODE AND RTCODE.KIND='B3' where comq1=" & dspkey(0) 
                         rsxx.Open sqlxx,connxx
                         IF NOT RSXX.EOF THEN
                            PARM1=trim(RSXX("PARM1"))
                         ELSE
                            PARM1=""
                         END IF
                         RSXX.CLOSE
                         IF DSPKEY(89) ="" THEN
                            yy2=cstr(DATEPART("yyyy",now())-1911)
                            SQLXX="SELECT MAX(CONSENTNO) as consentno FROM RTCUST WHERE CONSENTNO LIKE '" & PARM1 & trim(yy2) & "%' "
                            rsxx.Open sqlxx,connxx
                            if len(rsxx("consentno")) > 0 then
                               dspkey(89)=parm1 & yy2 & right("0000" + cstr(cint(right(rsxx("consentno"),4)) + 1),4)
                            else
                               dspkey(89)=parm1 & yy2 & "0001"
                            end if
                            dspkey(90)=now()
                            RSXX.CLOSE
                         END IF
                         CONNXX.CLOSE
                         SET RSXX=NOTHING
                         SET CONNXX=NOTHING
                      END IF
                      rs.fields(i).value=dspkey(i)              
                           
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
                 case ucase("/webap/rtap/base/rtcmty/RTCustD.asp")              
                     IF I=89 AND DSPKEY(88)="Y" THEN
                         Set connxx=Server.CreateObject("ADODB.Connection")  
                         Set rsxx=Server.CreateObject("ADODB.Recordset")
                         DSNXX="DSN=RTLIB"
                         connxx.Open DSNxx
                         sqlXX="SELECT * FROM RTcmty INNER JOIN RTCODE ON RTCMTY.COMTYPE = RTCODE.CODE AND RTCODE.KIND='B3' where comq1=" & dspkey(0) 
                         rsxx.Open sqlxx,connxx
                         IF NOT RSXX.EOF THEN
                            PARM1=trim(RSXX("PARM1"))
                         ELSE
                            PARM1=""
                         END IF
                         RSXX.CLOSE
                         IF DSPKEY(89) ="" THEN
                            yy2=cstr(DATEPART("yyyy",now())-1911)
                            SQLXX="SELECT MAX(CONSENTNO) as consentno FROM RTCUST WHERE CONSENTNO LIKE '" & PARM1 & trim(yy2) & "%' "
                            rsxx.Open sqlxx,connxx
                            if len(rsxx("consentno")) > 0 then
                               dspkey(89)=parm1 & yy2 & right("0000" + cstr(cint(right(rsxx("consentno"),4)) + 1),4)
                            else
                               dspkey(89)=parm1 & yy2 & "0001"
                            end if
                            dspkey(90)=now()
                            RSXX.CLOSE
                         END IF
                         CONNXX.CLOSE
                         SET RSXX=NOTHING
                         SET CONNXX=NOTHING
                      END IF          
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
    ' ��{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
    if accessmode ="A" then
       runpgm=Request.ServerVariables("PATH_INFO")
       if ucase(runpgm)=ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp") then
          rs.open "select max(comq1) AS comq1 from rtcmty",conn
          if not rs.eof then
             dspkey(0)=rs("comq1")
          end if
          rs.close
       end if
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcmty/RTCustd.asp") then
       rs.open "select max(CUSID) AS CUSID from rtcUST where CUSID LIKE '" & CUSIDXX & "%' " ,conn
       if not rs.eof then
          dspkey(1)=rs("CUSID")
       end if
       rs.close
    end if              
    ' ��{�������ݥ�Ĺ���@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(2)Ū�X�ܵe��
    runpgm=Request.ServerVariables("PATH_INFO")
    if ucase(runpgm)=ucase("/webap/rtap/RTSS365/RTDELIVERCUST/RTTELVISITD.asp") then
       rs.open "select max(seq1) AS SEQ1 from rtSS365TEL",conn
       if not rs.eof then
          dspkey(2)=rs("SEQ1")
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
  numberOfKey=3
  title="�Ȥ�򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  'sqlFormatDB="SELECT * FROM RTCust WHERE Comq1=0 "
  sqlFormatDB="SELECT COMQ1, CUSID, ENTRYNO, CUSNO, OFFICE, EXTENSION, HOME, MOBILE, EMAIL, BIRTHDAY, "_
  	     &"CUSTYPE, USEKIND, SPEED, LINETYPE, BUILDHIGH, SETFLOOR, SETROOM, PROFAC, RCVD, REQDAT, "_
  	     &"INSPRTNO, INSPRTDAT, INSPRTUSR, FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO, " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, " _
             &"ACCCFMDAT, ACCCFMUSR, ENDCOD, OPERENVID, NOTE, EUSR, EDAT, UUSR, UDAT, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, SETFEEDESC, rcvdtldat, sex, cutid2, " _
             &"township2, raddr2, rzone2, cutid1, township1, raddr1, rzone1, fax, contact, voucher, " _
             &"sndinfodat, idnumber, COTPORT, ANO, BNO, CUTID3, TOWNSHIP3, RADDR3, RZONE3, transdat, " _
             &"voucherid, holdemail, ip, transprtno, freecode, OVERDUE, PROPOSER,applyipdat,CONTRACTCONSENT,CONSENTNO,consentdat, "_
             &"idnumbertype,CUSTLINEADJFLG,secondidtype,secondno, REVIVEDAT, REVIVEFLAG, GTMONEY, GTVALID, GTSERIAL,GIVEAVDAT, developerid "_
             &"FROM RTCust where comq1=0"
  'sqlList="SELECT * FROM RTCust WHERE "
  sqllist    ="SELECT COMQ1, CUSID, ENTRYNO, CUSNO, OFFICE, EXTENSION, HOME, MOBILE, EMAIL, BIRTHDAY, "_
  	     &"CUSTYPE, USEKIND, SPEED, LINETYPE, BUILDHIGH, SETFLOOR, SETROOM, PROFAC, RCVD, REQDAT, "_
  	     &"INSPRTNO, INSPRTDAT, INSPRTUSR, FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO, " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, " _
             &"ACCCFMDAT, ACCCFMUSR, ENDCOD, OPERENVID, NOTE, EUSR, EDAT, UUSR, UDAT, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, SETFEEDESC, rcvdtldat, sex, cutid2, " _
             &"township2, raddr2, rzone2, cutid1, township1, raddr1, rzone1, fax, contact, voucher, " _
             &"sndinfodat, idnumber, COTPORT, ANO, BNO, CUTID3, TOWNSHIP3, RADDR3, RZONE3, transdat, " _
             &"voucherid, holdemail, ip, transprtno, freecode, OVERDUE, PROPOSER,applyipdat,CONTRACTCONSENT,CONSENTNO,consentdat, "_
             &"idnumbertype,CUSTLINEADJFLG,secondidtype,secondno, REVIVEDAT, REVIVEFLAG, GTMONEY, GTVALID, GTSERIAL,GIVEAVDAT, developerid "_
             &"FROM RTCust where "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userDefineRead="Yes"
  userDefineSave="Yes"
  userdefineactivex="Yes"  
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx

'---�ˬd HN���X�O�_������ DSPKEY(3)---------
   IF LEN(TRIM(DSPKEY(3))) > 0 THEN
      
	  if LEN(TRIM(DSPKEY(2))) =0 then
		 DSPKEY(2) =1
	  end if   
      sqlXX="SELECT count(*) AS CNT FROM RTCust where cusno='" & trim(dspkey(3)) & "' and not (cusid='" & dspkey(1) & "' and entryno=" & dspkey(2) & ")"
      
      rsxx.Open sqlxx,connxx
      s=""
'Response.Write "CNT=" & RSXX("CNT")
      If RSXX("CNT") > 0 Then
         message="HN���X�w�s�bHB�Ȥ�A���i���ƿ�J!"
         formvalid=false
      End If
      rsxx.Close
      
      if formvalid then
         sqlXX="SELECT count(*) AS CNT FROM RTCustADSL where cusno='" & trim(dspkey(3)) & "' "
         rsxx.Open sqlxx,connxx
         If RSXX("CNT") > 0 Then
            message="HN���X�w�s�bADSL�Ȥ�A���i���ƿ�J!"
            formvalid=false
         end if
		 rsxx.Close         
      End If
   end IF
 '�ˬd�D�u�O�_�w���q
      sqlXX="SELECT * FROM RTcmty where comq1=" & dspkey(0) 
      rsxx.Open sqlxx,connxx
      ADSLAPPLY=""
      If rsxx.Eof Then
         message="���ϥN��:" &dspkey(0) &"�b���ϰ򥻸�Ƥ��䤣��"
         formvalud=false
         adslapply="N"
      Else 
         IF ISNULL(RSXX("t1APPLY")) and  ISNULL(RSXX("HINET"))  THEN
            adslapply="N"
         ELSE
            adslapply="Y"
         END IF
      End If
      rsxx.Close      
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing       
'-------�榸------------------------------
    If Not IsNumeric(dspKey(2)) Then dspKey(2)=0
'--------------- -------------------------
    If Not IsNumeric(dspKey(26)) Then dspKey(26)=0   '�������B
    If Not IsNumeric(dspKey(27)) Then dspKey(27)=0   '�ꦬ���B 
    If Not IsNumeric(dspKey(49)) Then dspKey(49)=3   '�w�����O
    If Not IsNumeric(dspKey(54)) Then dspKey(54)=0   '�зǬI�u�O
    If Not IsNumeric(dspKey(55)) Then dspKey(55)=0   '�I�u�ɧU�O
    If Not IsNumeric(dspKey(52)) Then dspKey(52)=0   '�˾�(��)
    If Not IsNumeric(dspKey(53)) Then dspKey(53)=0   '�˾�(��)
	If Not IsNumeric(dspKey(97)) Then dspKey(97)=0   '�O�Ҫ�
'-------�˾��Ӽh -------------------------
    if len(trim(dspkey(14))) = 0 then dspkey(14)=0
    if len(trim(dspkey(15))) = 0 then dspkey(15)=0
    if len(trim(dspkey(16))) = 0 then dspkey(16)=""
    if len(trim(dspkey(88))) = 0 then dspkey(88)=""
    if len(trim(dspkey(92))) = 0 then dspkey(92)=""
    dspkey(82) =trim(dspkey(82))					'IP �e�ᤣ�i�ť�
    IF DSPKEY(88)="Y" AND LEN(TRIM(DSPKEY(90)))=0 THEN
       DSPKEY(90)=NOW()
    END IF
 '   If len(trim(dspkey(1))) < 1 then
 '      message="�ФJ�Ȥ�N�X"
 '      formValid=False
    If Not (IsNumeric(dspKey(14)) Or IsNumeric(dspKey(15))) Then
       message="�ФJ�˾��Ӽh���"
       formValid=False       
'-------�M�P��] -------------------------
'    elseIf IsDate(dspKey(28)) and Len(dspKey(35)) < 1 Then
'          message="�п�J�M�P��]"
'          formValid=False
'-------�w�w�˾��ɶ�----------------------
'    elseIf (dspKey(49) = "1" Or dspKey(49) = "2") and _
'           Not (IsDate(dspKey(51)) And IsNumeric(dspKey(52)) _
'           And IsNumeric(dspKey(53))) Then
'              message="�п�J�w�w�˾��ɶ�"
'              formValid=False
    elseIf dspKey(52) > 24 Or dspKey(53) > 59 Then
       message="�п�J���T�w�w�˾��ɶ�"
       formValid=False
    elseif len(trim(extdb(0))) < 1 then
       message="�п�J�Ȥ�W��"
       formValid=False    
'    elseif len(trim(dspkey(58))) < 1 then
'       message="�п�J�Ȥ�ʧO"
'       formValid=False           
    elseif not Isdate(dspkey(9)) and len(dspkey(9)) > 0 then
       message="�X�ͤ�����~"
       formValid=False            
    elseif not Isdate(dspkey(18)) and len(dspkey(18))  > 0 then
       message="�ӽФ�����~"
       formValid=False            
    elseif not Isdate(dspkey(70)) and len(dspkey(70))  > 0 then
       message="�q���o�]������~"
       formValid=False     
    elseif not Isdate(dspkey(19)) and len(dspkey(19))  > 0 then
       message="�o�]������~"
       formValid=False            
    elseif not Isdate(dspkey(23)) and len(dspkey(23))  > 0 then
       message="���u������~"
       formValid=False     
    elseif not Isdate(dspkey(24)) and len(dspkey(24))  > 0 then
       message="����������~"
       formValid=False             
    elseif not IsNumeric(dspkey(26)) and len(dspkey(26))  > 0 then
       message="�������B���~"
       formValid=False           
    elseif not IsNumeric(dspkey(27)) and len(dspkey(27))  > 0 then
       message="�ꦬ���B���~"
       formValid=False             
    elseif not Isdate(dspkey(28)) and len(dspkey(28))  > 0 then
       message="�M�P������~"
       formValid=False             
    elseif not Isdate(dspkey(31)) and len(dspkey(31))  > 0 then
       message="���ڤ�����~"
       formValid=False          
    elseif not Isdate(dspkey(51)) and len(dspkey(51))  > 0 then
       message="�w�w�˾�������~"
       formValid=False          
    elseif not IsNumeric(dspkey(52)) and len(dspkey(52))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False          
    elseif not IsNumeric(dspkey(53)) and len(dspkey(53))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False              
    elseif not IsNumeric(dspkey(55)) and len(dspkey(55))  > 0 then
       message="�I�u�ɧU���B���~"
       formValid=False                     
    elseif (dspkey(49)="1" or dspkey(49)="2" ) and dspkey(17) <> "" then
       message="�w�ˤH����(�~��)��(�޳N��)��,�I�u�t�ӥ����ť�"
       formvalid=false
    elseif (dspkey(49)="3" ) and dspkey(17) = "" then
       message="�w�ˤH����(�t��)��,�I�u�t�Ӥ��o�ť�"
       formvalid=false       
    elseif (dspkey(49)="1" ) and dspkey(50) = "" then
       message="�w�ˤH����(�~��)��,�w�w�w�ˤH�����o�ť�"
       formvalid=false      
    elseif LEN(TRIM(dspkey(24)))<>0 and ADSLAPPLY <> "Y" then
       message="�D�u�|�����q�A���o����"
       formvalid=false                     
    elseif LEN(TRIM(dspkey(23)))<>0 and ADSLAPPLY <> "Y" then
       message="�D�u�|�����q�A���o��J���u���" 
       formvalid=false              
    elseif dspkey(11) <> "�p�q��" AND dspkey(11) <> "�����p�q" and DSPKEY(88) = "Y" then
       message="�D�p�q��Τ�γ����p�q�Τᤣ�o�Ŀ�~���P�N��"
       formvalid=false             
  '  elseif ( dspkey(11) = "�p�q��" OR dspkey(11) = "�����p�q" ) and DSPKEY(88) = "" and then
  '     message="�p�q��Τ�γ����p�q�Τᥲ���Ŀ�~���P�N�Ѧs�b�P�_"
  '     formvalid=false            
    elseif LEN(TRIM(dspkey(90)))<>0 and LEN(TRIM(dspkey(28)))<>0 and dspkey(28) < dspkey(90) then
       message="�h��������o�p��P�N�ѫ��ɤ��"
       formvalid=false                               
    elseif LEN(TRIM(dspkey(93))) = 0 and dspkey(91)<>"02" and accessMode ="A" and dspKey(84)<>"Y" then
       message="�ĤG�ҷ����O���i�ť�"
       formvalid=false                 
    elseif LEN(TRIM(dspkey(94))) = 0 and dspkey(91)<>"02" and accessMode ="A" and dspKey(84)<>"Y" then
       message="�ĤG�ҷӸ��X���i�ť�"
       formvalid=false                              
    End If
    IF formvalid=TRUE THEN
       if (dspkey(91)="01" or dspkey(91)="02") and dspkey(71) <> "" and accessMode ="A" then
         idno=dspkey(71)
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
                     message="���~��]�ݬd�A���p����T��"
                     formvalid=false     
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
'-------�J�b���=�������--------------
'    dspkey(25)=dspkey(24)
    if dspkey(58) <> "F" and dspkey(58) <>"M" then dspkey(58)=""
    if dspkey(84) <> "Y" and dspkey(84) <>"N" then dspkey(84)=""    
'-------Not allowed Nulls fields-------------
'    Dim aryNull
'    aryNull=Array(0,3,4,5,6,7,8,10,11,12,13,16,17,20,22,29,30,33,35,36,37,39,41,42,43,44,45,47,50,56)
'    For i = 0  To Ubound(aryNull)
'        If Len(dspKey(aryNull(i)))<1 Then
'           formValid=False
'           message="Null string Not allowed"
'           Exit For
'        End If
'    Next
'    aryNull=Array(9,18,19,21,23,24,25,28,31,32,34,38,40,46,48,51)
'    For i = 0  To Ubound(aryNull)
'        If Len(dspKey(aryNull(i)))=0 Then
'        ElseIf IsDate(dspKey(aryNull(i))) Then
'        Else           
'           formValid=False
'           message="Date field Invalid"
'           Exit For
'        End If
'    Next

'-------�����ɥΤ�IP���i�ť�(�u���p�q��)--------------
'---�������j�󧹤u��(�ư����u�鬰�ťժ�==>��ӽЮɧ��u�鬰�ť�,�G�����ư�),�Τ�ip���i�ť�
    if trim(dspkey(11)) = "�p�q��" AND dspKey(24) >= dspkey(23) and len(dspkey(23)) > 0 and len(dspkey(82))=0  then
          message="�p�q��Ȥ�����ɥΤᤧ�T�wIP���i�ť�!"
          formvalid=false    
    end if
'-------�s���覡�P�t�v�ˬd--------------
    if (trim(dspkey(12)) ="512KBPS") AND (TRIM(DSPKEY(11)) <> "�p�q��" and TRIM(DSPKEY(11)) <> "�����p�q") then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if    
    if (trim(dspkey(12)) ="128KBPS") AND (TRIM(DSPKEY(11)) <> "�����" ) then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if        
    if (trim(dspkey(12)) ="2048KBPS") AND TRIM(DSPKEY(11)) <> "���֫�" and TRIM(DSPKEY(11)) <>"��������" and TRIM(DSPKEY(11)) <> "�p�q�����" then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if        
    if (trim(dspkey(12)) ="2M/384K" or trim(dspkey(12)) ="2M/128K") AND TRIM(DSPKEY(11)) <> "ADSL" and TRIM(DSPKEY(11)) <>"�����ADSL" and TRIM(DSPKEY(11)) <> "�p�q��ADSL" and TRIM(DSPKEY(11)) <> "������ADSL" then
          message="�s���覡�P�s�u�t�v�����!"
          formvalid=false    
    end if        

'�t�ӼзǬI�u�O(�I�u�t�Ӥ����ťաA�B�L�I�ڦC�L�帹�ɡA�l�i�ܧ�^
    if len(trim(dspkey(17))) > 0 and len(trim(dspkey(37))) = 0 then
       Dim Connsupp,Rssupp,sqlsupp,dsn
       Set connsupp=server.CreateObject("ADODB.Connection")
       Set rssupp=Server.CreateObject("ADODB.RecordSet")
       DSN="DSN=RTLIB"
       Sqlsupp="select * from RtSupp where cusid='" & dspkey(17) & "'"
       connsupp.open DSN
       rssupp.open sqlsupp,connsupp,1,1
       if rssupp.eof then
          dspkey(54) = 0
       else
          dspkey(54) = rssupp("STDFee")
       end if
    end if
 '���ڦW�٩��p���H���ťծɡA�N�Ȥ�W�٩�J�p���H�Φ��ڦW��
 '   if len(dspkey(68)) <= 0 and len(trim(extdb(0))) <=10 then
 '      dspkey(68)=extdb(0)
 '   end if
    if len(dspkey(69)) <= 0 then
       dspkey(69)=extdb(0)
    end if
 '�ӽХN��H���ťծɡA�w�]��"N"
   IF len(trim(dspkey(86))) = 0 then
      dspkey(86)="N"
   end if   
   Set connxx=Server.CreateObject("ADODB.Connection")  
   Set rsxx=Server.CreateObject("ADODB.Recordset")
   DSNXX="DSN=RTLIB"
   connxx.Open DSNxx
   sqlXX="SELECT * FROM RTcmty where comq1=" & dspkey(0) 
   rsxx.Open sqlxx,connxx
   IF NOT RSXX.EOF THEN
      COMTYPE=RSXX("COMTYPE")
   ELSE
      COMTYPE=""
   END IF
   IF ((COMTYPE >= "01" AND COMTYPE <="04") OR COMTYPE="14") AND DSPKEY(88) = "Y" THEN
      message="���P���ϥΤᤣ�i�Ŀ�Τ�~���P�N��"
      formvalid=false       
  ' ELSEIF ((COMTYPE >= "05" AND COMTYPE <="13") OR COMTYPE="15") AND DSPKEY(88) = "" THEN
  '    message="�g�P���ϥΤ�ФĿ�Τ�O�_���~���P�N��"
  '    formvalid=false            
   END IF
   rsxx.Close      
   Set rsxx=Nothing
   connxx.Close
   Set connxx=Nothing    
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(47)=V(0)
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
   Sub Srcounty60onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY59").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key60").value =  trim(Fusrid(0))
          document.all("key62").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub    
   Sub Srcounty64onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY63").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key64").value =  trim(Fusrid(0))
          document.all("key66").value =  trim(Fusrid(1))          
       End if       
       end if
   End Sub   
   Sub Srcounty76onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY75").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key76").value =  trim(Fusrid(0))
          document.all("key78").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY101").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key101").value =  trim(Fusrid(0))
       End if       
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
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"    codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()
    s=FrGetCmtyDesc(aryParmKey(0))%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="15%" class=dataListHead>���ϫ��ɬy����</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key0" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(0)%>" class=dataListData></td>
    <td width="15%" class=dataListHead>�Ȥ�N��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="14"
               value="<%=dspKey(1)%>" class=dataListdata readonly></td>
    <td width="15%" class=dataListHead>�Ȥ�榸</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key2" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(2)%>" class=dataListdata></td>
    <% if trim(dspkey(11))="�p�q��" then
          textX="�ӽ����ɤ�"
          DSPX=""
       else
          textX="�������ɤ�"
          DSPX=" style=""display:none"" "
       end if 
    %>
    <td width="15%" BGCOLOR=#BDB76B><%=TEXTX%></td>
    <td width="10%" bgcolor=#DCDCDC>
        <input type="text" name="key79" readonly
               style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(79)%>" style="text-align:left;color:red" class=dataListData></td>
  </tr>
  <tr>
          <td <%=dspx%> width="15%" BGCOLOR=#BDB76B>�p�q������渹</td>                    
        <td  <%=dspx%> width="10%" bgcolor=#DCDCDC>
        <input  <%=dspx%> type="text" name="key83" size="10" value="<%=dspKey(83)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListdata" maxlength="25" readonly></td>                     
  </tr>
</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(45))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(45)=V(0)
                extdb(46)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(45))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(46)=datevalue(now())
    else
        if len(trim(dspkey(47))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(47)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(47))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(45))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(48)=datevalue(now())
    end if  
' -------------------------------------------------------------------------------------------- 
    
    Dim conn,rs,s,sx,sql,t
    '���׽X
    If dspKey(42)="Y" Then
       fieldPa=" class=""dataListData"" readonly "
    Else
       fieldPa=""
    End If
    '�w�त�عq�H������==>�������protect(�������)  
    '===============
    '91/3/13 �ק�p�U
    '�p�q��Ȥ�H�����渹��lock field����(��������ɤ�==>�{������۰ʧאּ�ӽ����ɤ�)
    '�T�w��Ȥ�H�������ɤ鬰lock field����
    '=================
    if trim(dspkey(11)) = "�p�q��" OR trim(dspkey(11)) = "�����p�q" then
       if len(trim(dspkey(83))) > 0 then
          fieldPg=" class=""dataListData"" readonly "
          fieldpc=""
          fieldpe=""
          fieldpf=""
          FLG=""
       else
          fieldPg=""               
          fieldpc=" Onclick=""Srbtnonclick"" "
          fieldpe=" Onclick=""Srclear"" "
          fieldpf=" Onclick=""SrAddusr"" "   
          FLG="Y"    
       end if    
    else
       if len(trim(dspkey(79))) > 0 then
          fieldPg=" class=""dataListData"" readonly "
          fieldpc=""
          fieldpe=""
          fieldpf=""
          FLG=""
       else
          fieldPg=""               
          fieldpc=" Onclick=""Srbtnonclick"" "
          fieldpe=" Onclick=""Srclear"" "
          fieldpf=" Onclick=""SrAddusr"" "     
          FLG="Y"  
       end if       
    end if
    '���ڪ�w�C�L�Φw�˭����O���o�](�Ϊť�)�ɡA���i���w�˭��u�s�A���i���w�ˤH����ơ]�Y�w�˭��u�sdisable)
    If Len(Trim(dspKey(29))) > 0  Then
       fieldPb=" class=""dataListData"" readonly "
    Else
       fieldPb=""
    End If
    if dspkey(42)="Y" or Len(Trim(dspKey(29))) > 0  then
       fieldPbx=""       
    else
       fieldPbx="SrAddusr()"
    end if        
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>                                      
  <div class=dataListTagOn> 
<table width="100%"><tr><td width="100%">&nbsp;</td></tr>                                                      
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag1" height="354"> 
    <TR>
        <td bgcolor="purple" style="color:white" width="15%"  height="34"><font size=2>�p�q�Τ�IP</FONT></font></td>                                 
        <td width="10%"  height="34" bgcolor="silver"><input type="text" name="key82" size="20" value="<%=dspKey(82)%>" maxlength="15" <%=fieldRole(1)%><%=fieldpg%><%=dataProtect%> class="dataListEntry"></td>
        <td width="14%" class="dataListsearch" height="25">������</td>       
       <%  dim freecode1, freecode2
    if len(trim(dspkey(83))) =0 and dspkey(67) <> "Y" then
       If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
          freecode1=""
          freecode2=""
       Else
          freecode1=" disabled "
          freecode2=" disabled "
       end if
    else
   '       freecode1=" disabled "
   '       freecode2=" disabled "
    End If
    If dspKey(84)="Y" Then freecode1=" checked "    
    If dspKey(84)="N" Then freecode2=" checked " %>                          
        <td width="14%" height="25" bgcolor="silver" >
        <input type="radio" value="Y"  name="key84" <%=FREECODE1%><%=FIELDROLE(1)%>><font size=2>�O</font>
        <input type="radio" name="key84" value="N" <%=FREECODE2%><%=FIELDROLE(1)%>><font size=2>�_</font></td>     
 <td width="10%" class="dataListsearch" height="32">�p�qIP�ӽФ�</td>                              
        <td width="16%" height="32" bgcolor="silver">
        <% 'response.Write "ROLE8=" & fieldRole(8)
         IF len(trim(fieldRole(8))) < 1 then
             fieldPK=" Onclick=""Srbtnonclick"" "
             FieldPQ=" Onclick=""Srclear"" "
          else
             FieldPK=""
             FieldPQ=""
          end if
        %>
          <input type="text" name="key87" size="10" value="<%=dspkey(87)%>" maxlength="10" <%=fieldpg%><%=fieldRole(8)%><%=dataProtect%> READONLY class=dataListEntry ID="Text1">
          <input type="button" id="B87"  name="B87" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpK%>>
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C87"  name="C87"   style="Z-INDEX: 1" <%=fieldpQ%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    </td>         
    </TR>                                     
      <tr>                                      
        <td  class="dataListHead" height="32">�Ȥ�W��</td>                                      
        <td height="32" bgcolor="silver"><!--webbot
          bot="Validation" B-Value-Required="TRUE" I-Maximum-Length="50" -->
          <input type="text" name="ext0" size="28" maxlength="50" value="<%=extDB(0)%>"<%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                              
        <td  class="dataListHead" height="32">�ʧO</td>
<%  dim sexd1, sexd2
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       sexd1=""
       sexd2=""
    Else
      ' sexd1=" disabled "
      ' sexd2=" disabled "
    End If
    If dspKey(58)="M" Then sexd1=" checked "    
    If dspKey(58)="F" Then sexd2=" checked " %>                          
        <td  height="32" bgcolor="silver">
        <input type="radio" value="M" <%=sexd1%> name="key58" <%=fieldRole(1)%><%=dataProtect%>>�k
        <input type="radio" name="key58" value="F" <%=sexd2%><%=fieldRole(1)%><%=dataProtect%>>�k</td>                              
        <td  class="dataListHead" height="32">�X�ͤ��</td>                              
        <td  height="32" bgcolor="silver">
          <input type="text" name="key9" size="10" value="<%=dspkey(9)%>" maxlength="10" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class=dataListEntry>
          <input type="button" id="B9"  name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                              
      </tr>                              
      <tr>                              
        <td  class="dataListHead" height="25">�b��(�q�T)�a�}</td>                              
        <td  colspan="3" height="25" bgcolor="silver">
  <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and flg = "Y" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(59))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX60=" onclick=""Srcounty60onclick()""  "
	   key59chg=" onchange=""key59onchange()"" "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(59) &"' " 
       SXX60=""
       key59chg=""
    End If
    rs.Open sql,conn
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("cutid")=dspkey(59) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key59" <%=key59chg%> <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        <input type="text" name="key60" size="8" value="<%=dspkey(60)%>" maxlength="10" readonly <%=fieldpg%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B60"  name="B60"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX60%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C60"  name="C60"   style="Z-INDEX: 1" <%=fieldpc%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key61" size="32" value="<%=dspkey(61)%>" maxlength="60" <%=fieldpg%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td  height="25" bgcolor="silver"><input type="text" name="key62" size="10" value="<%=dspkey(62)%>" maxlength="5" <%=fieldpg%> <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                 
      <tr>                                 
        <td  class="dataListHead" height="25">�˾��a�}</td>                                 
        <td  colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  and flg = "Y" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(63))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX64=" onclick=""Srcounty64onclick()""  "
	   key63chg=" onchange=""key63onchange()"" "       
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(63) &"' " 
       SXX64=""
	   key63chg=""       
    End If
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(63) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key63" <%=key63chg%> <%=fieldpg%><%=FIELDROLE(1)%><%=dataProtect%> size="1"  style="text-align:left;" maxlength="8" class="dataListEntry">
        <%=s%></select>
        <input type="text" name="key64" size="8" value="<%=dspkey(64)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B64"  name="B64"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX64%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C64"  name="C64"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    
        <input type="text" name="key65" size="32" value="<%=dspkey(65)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                
        <td  class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td  height="25" bgcolor="silver"><input type="text" name="key66" size="10" value="<%=dspkey(66)%>" maxlength="5" <%=fieldpg%> <%=fieldpa%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>
      <tr>                                 
        <td  class="dataListHead" height="25">���y�a�}</td>                                 
        <td  colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and flg = "Y" Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(75))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       SXX76=" onclick=""Srcounty76onclick()""  "
	   key75chg=" onchange=""key75onchange()"" "       
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(75) &"' " 
       SXX76=""
	   key75chg=""       
    End If
    s=s &"<option value=""" &"""" &sx &">(�����O)</option>"
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(75) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key75" <%=key75chg%> <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>
        <input type="text" name="key76" size="8" value="<%=dspkey(76)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B76"  name="B76"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX76%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C76"  name="C76"  <%=fieldpc%> style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
        <input type="text" name="key77" size="32" value="<%=dspkey(77)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                     
        <td  class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td  height="25" bgcolor="silver"><input type="text" name="key78" size="10" value="<%=dspkey(78)%>" maxlength="5" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                
      <tr>          
<script language="vbscript">
Sub SrAddrEqual()
  Dim i,objOpt
  document.All("key63").value=document.All("key59").value
  document.All("key64").value=document.All("key60").value
  document.All("key65").value=document.All("key61").value
  document.All("key66").value=document.All("key62").value
End Sub 
Sub SrAddrEqual2()
  document.All("key75").value=document.All("key59").value
  document.All("key76").value=document.All("key60").value
  document.All("key77").value=document.All("key61").value
  document.All("key78").value=document.All("key62").value
End Sub 
Sub SrAddUsr()
  ExistUsr=document.all("key50").value
  InsType=cstr(document.all("key49").value)
  UsrStr=Window.showModalDialog("RTCustAddUsr.asp?parm=" & existusr & "@" & instype   ,"Dialog","dialogWidth:410px;dialogHeight:400px;")
  if UsrStr<>False then
     UsrStrAry=split(UsrStr,"@")
     document.all("key50").value=UsrStrAry(0)
     document.all("REF01").value=UsrStrAry(1)     
  end if
End Sub

Sub Srpay()
  if document.all("key49").value = "1" then
     document.all("key54").value = 200
' 90/01/19�t�ӬI�u�O���Ū���t����rtsupp(��checkdata�ɶ�J;�Y�ӫȤ��Ƥw�C�L�I�u�O�h���ܧ�
'  elseif document.all("key49").value = "3" then
'         document.all("key54").value = 600
  else
     document.all("key54").value = 0
  end if
End Sub
Sub key59onchange()
	if document.all("KEY59").VALUE ="06" then
	   document.all("key62").value ="300"
	End if
End Sub
Sub key63onchange()
	if document.all("KEY63").VALUE ="06" then
	   document.all("key66").value ="300"
	End if
End Sub
Sub key75onchange()
	if document.all("KEY75").VALUE ="06" then
	   document.all("key78").value ="300"
	End if
End Sub
</script>                       
        <td  class="dataListHead" colspan="2" height="34" bgcolor="silver">
<%  dim seld1
    If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
       seld1=""
    Else
       seld1=" disabled "
    End If%>
            <input type="radio" name="rdo1" value="1"<%=seld1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual()">�˾��a�}�P�b��a�}
            <input type="radio" name="rdo2" value="1"<%=seld1%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual2()">���y�a�}�P�b��a�}</td>                           
        <td  class="dataListHead" height="34">HN�p�渹�X</td>
        <td  height="34" bgcolor="silver"><input type="text" name="key3" size="10" value="<%=dspKey(3)%>" maxlength="8" <%=fieldRole(1)%><%=fieldpg%><%=dataProtect%> class="dataListEntry"></td>

<%
	name=""
	if dspkey(101) <> "" then
		sqlxx=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
			 &"where rtemployee.emply='" & dspkey(101) & "' "
		rs.Open sqlxx,conn
		if rs.eof then
			name="(��H�ɧ䤣�ӭ��u)"
		else
			name=rs("cusnc")
		end if
		rs.close
	end if
%>
		<td WIDTH="15%" class="dataListHEAD" height="23">�G�u�}�o�H��</td>
		<td width="35%"><input type="text" name="key101"value="<%=dspKey(101)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text9">
			<input type="BUTTON" id="B101" name="B101" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C101" name="C101" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=name%></font></td></tr>

     </tr>                                 
      <tr>                            
        <td  class="dataListHead" height="32">�}�o����</td>
<% aryOption=Array("�`�Ѥ�","�Ӹˤ�")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
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
        <td  height="32" bgcolor="silver"><select size="1" name="key10" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                            
        <%=s%></select></td>                                     
        <td  class="dataListHead">�ӽФ��</td>                     
        <td  bgcolor="silver">
          <input type="text" name="key18" size="10" value="<%=dspKey(18)%>" <%=fieldpg%><%=fieldRole(1)%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B18"  name="B18" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td> 
        <td class="dataListHead" height="32">�u������</td>
<% aryOption=Array("HIBUILDING","ADSL")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then   
      For i = 0 To Ubound(aryOption)
          If dspKey(13)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(13) &""">" &dspKey(13) &"</option>"
   End If%>                                  
        <td height="32" bgcolor="silver"><select size="1" name="key13" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%></select></td>                                    
      </tr>                                    
      <tr>                                    
        <td class="dataListHead" height="21">�˾��Ӽh</td>                                    
        <td height="21" bgcolor="silver"><font size=2>�Ӱ�</font><input type="text" name="key14" size="4" value="<%=dspKey(14)%>" maxlength="4" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry"><font size=2>�h�A�˩��</font><input type="text" name="key15" size="4" value="<%=dspKey(15)%>"<%=fieldpg%> <%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"><font size=2>�h�A��</font><input type="text" name="key16" size="4" value="<%=dspKey(16)%>" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> maxlength="4" class="dataListEntry"><font size=2>��</font></td>                                 
 <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and flg = "Y" Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='J5' " 
       If len(trim(dspkey(91))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='J5' AND CODE='" & dspkey(91) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    's=s &"<option value=""" &"""" &sx &">(�ҷӧO)</option>"
    s=""
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(91) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    
'response.write "SW="& sw &"<br> accessMode=" & accessMode &"<br>formvalid="& formvalid &"<br>flg="&flg
   %>
        <td class="dataListHead"><font size=2>�ҷ����O�θ��X</font></td>
        <td height="21" >
			<select size="1" name="key91"<%=fieldpa%><%=FIELDROLE(1)%><%=fieldpg%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>	
			<input type="password" name="key71" size="12" value="<%=dspKey(71)%>" maxlength="11" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry">
        </td>
         <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and flg = "Y" Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L4' " 
       If len(trim(dspkey(93))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L4' AND CODE='" & dspkey(93) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�ĤG�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(93) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
      <td class="dataListHead"><font size=2>�ĤG�ҷ����O�θ��X</font></td>
        <td height="21" >
			<select size="1" name="key93"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>	
			<input type="password" name="key94" size="12" value="<%=dspKey(94)%>" maxlength="12" <%=fieldpg%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry" ID="Text7">
        </td></tr>
      
      <tr>                                    
        <td  class="dataListHead" height="21">COT PORT</td>
         <td height="21" ><input type="text" name="key72" size="10" value="<%=dspKey(72)%>" maxlength="10" <%=dataProtect%> class="dataListEntry"></TD>
        <td  height="21" class="dataListHead">MDF���X1</TD>
        <td  height="21"><input type="text" name="key73" size="15" value="<%=dspKey(73)%>" maxlength="15" <%=dataProtect%> class="dataListEntry"></td>                                 
        <td  height="21" class="dataListHead">MDF���X2</td>
        <td height="21"><input type="text" name="key74" size="15" value="<%=dspKey(74)%>" maxlength="15" <%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                       
      <tr>                                 
        <td  class="dataListHead" height="23">�s���覡</td>
<% aryOption=Array("�����","�p�q��","�����p�q","���֫�","��������","�p�q�����","ADSL","�����ADSL","�p�q��ADSL","������ADSL")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then 
      For i = 0 To Ubound(aryOption)
          If dspKey(11)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(11) &""">" &dspKey(11) &"</option>"
   End If%>                                 
        <td  height="23" bgcolor="silver"><select size="1" name="key11" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                 
        <%=s%></select></td>                                    
        <td  class="dataListHead" height="23">�ǿ�t�v</td>
<% aryOption=Array("128KBPS","512KBPS","2048KBPS","2M/384K","2M/128K")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then 
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
        <td height="23" bgcolor="silver"><select size="1" name="key12" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">                                                             
        <%=s%></select></td>

        <td  class="dataListHead" height="34">���r�n���ذe��</td>
        <td width="16%" height="32" bgcolor="silver">
          <input type="text" name="key100" size="10" value="<%=dspkey(100)%>" maxlength="10" <%=fieldpg%><%=fieldRole(8)%><%=dataProtect%> READONLY class=dataListEntry ID="Text8">
          <input type="button" id="B100"  name="B100" height="100%" width="100%" style="Z-INDEX: 1" value="...." Onclick="Srbtnonclick">
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C100" name="C100" style="Z-INDEX: 1" Onclick="Srclear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" ></td>

      </tr>                                    
      <tr>                                    
        <td  class="dataListHead" height="23">�p���q��</td>                                 
        <td height="23"><input type="text" name="key6" size="15" value="<%=dspkey(6)%>" maxlength="15" <%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="23">�ǯu�q��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key67" size="15" value="<%=dspkey(67)%>" maxlength="15" <%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="23">�p���H</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key68" size="10" value="<%=dspkey(68)%>" maxlength="20" <%=fieldpg%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                                 
        <td  class="dataListHead" height="23" bgcolor="silver">���q�q��</td>                                 
        <td  height="23"><input type="text" name="key4" size="15" value="<%=dspkey(4)%>" maxlength="15" <%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">����<input type="text" name="key5" size="5" value="<%=dspkey(5)%>" maxlength="5" <%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="23">��ʹq��</td>                                 
        <td height="23" bgcolor="silver"><input type="text" name="key7" size="15" value="<%=dspkey(7)%>" maxlength="15" <%=dataProtect%> class="dataListEntry"></td>
        <td  height="23" class="dataListHead" >�ӽХN��H</td>                     
        <td  height="23" bgcolor="silver">
        <%  dim OPT1, OPT2
            if len(trim(dspkey(86))) =0 and dspkey(42) <> "Y" then
               If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
                  OPT1=""
                  OPT2=""
               Else
                  OPT1=" disabled "
                  OPT2=" disabled "
               end if
            else
               OPT1=" disabled "
               OPT2=" disabled "
            End If
            If dspKey(86)="Y" Then OPT1=" checked "    
            If dspKey(86)="N" Then OPT2=" checked " %>                          
        <input type="radio" value="Y" <%=OPT1%> name="key86" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio1"><font size=2>�O</font>
        <input type="radio" value="N" <%=OPT2%> name="key86" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio2"><font size=2>�_</font></td>
      </tr>                                 
      <tr>                                 
        <td  class="dataListHead" height="23">�q�l�l��H�c</td>                                 
        <td  height="32" bgcolor="silver"><input type="text" name="key8" size="30" value="<%=dspkey(8)%>" maxlength="30" <%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="23">���ڦW��</td>                                 
        <td   height="23" bgcolor="silver"><input type="text" name="key69" size="15" value="<%=dspkey(69)%>" maxlength="50" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>                   
        <td  class="dataListHead" height="23">�����ҷӸ�</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key80" size="10" value="<%=dspkey(80)%>" maxlength="10" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>       
      </tr>                    
      <TR>
        <td  class="dataListHead" height="23">�O�d����email</td>                                 
        <td   height="23" bgcolor="silver"><input type="text" name="key81" size="8" value="<%=dspkey(81)%>" maxlength="8" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry"></td>       
        <td width="14%" class="dataListHEAD" height="25">���L�~���P�N��</td>       
       <%  dim CONSENT1, CONSENT2
    if len(trim(dspkey(88))) =0 and dspkey(67) <> "Y" then
       If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
          CONSENT1=""
          CONSENT2=""
       Else
          CONSENT1=" disabled "
          CONSENT2=" disabled "
       end if
    else
   '       freecode1=" disabled "
   '       freecode2=" disabled "
    End If
    If dspKey(88)="Y" Then CONSENT1=" checked "    
    If dspKey(88)="N" Then CONSENT2=" checked " %>                          
        <td width="14%" height="25" bgcolor="silver" >
        <input  type="radio" value="Y"  name="key88" <%=CONSENT1%><%=FIELDROLE(1)%> ID="Radio3"><font size=2>��</font>
        <input type="radio" name="key88" value="N" <%=CONSENT2%><%=FIELDROLE(1)%> ID="Radio4"><font size=2>�L</font></td>    
        <td  class="dataListHead" height="23">�~���P�N�ѽs��</td>                                 
        <td  height="32" bgcolor="silver"><input type="text" name="key89" size="10" value="<%=dspkey(89)%>" READONLY maxlength="10" <%=dataProtect%> class="dataListDATA" ID="Text2"></td>                                 
                 
      </tr>    
      <tr>                                 
        <td  class="dataListHead" height="23">�P�N�ѫ��ɤ�</td>         
        <td  height="32" bgcolor="silver" ><input type="text" name="key90" size="10" value="<%=dspkey(90)%>" readonly maxlength="30" <%=dataProtect%> class="dataListdata" ID="Text6"></td>                                 
 <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L2' " 
       If len(trim(dspkey(92))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L2' AND CODE='" & dspkey(92) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(92) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
        <td class="dataListHead"><font size=2>�Ȥ�D�u�վ�Ƶ�</font></td>
        <td height="21" colspan=3>
			<select size="1" name="key92" <%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>	
        </td></tr>      
      </tr>                
      <tr style="display:none">                                 
        <td style="display:none"  class="dataListHead" height="23">��J�H��</td>                                 
        <td style="display:none"  height="23" bgcolor="silver"><input type="text" name="key45" size="10" class="dataListData" value="<%=dspKey(45)%>" readonly><%=EusrNc%></td>                                 
        <td style="display:none"  class="dataListHead" height="23">��J���</td>                                 
        <td style="display:none" colspan="3" height="23" bgcolor="silver"><input type="text" name="key46" size="15" class="dataListData" value="<%=dspKey(46)%>" readonly></td>                                 
      </tr>                                 
      <tr style="display:none">                                 
        <td style="display:none"  class="dataListHead" height="23">���ʤH��</td>                                 
        <td style="display:none"  height="23" bgcolor="silver"><input type="text" name="key47" size="10" class="dataListData" value="<%=dspKey(47)%>" readonly><%=UUsrNc%></td>                                 
        <td style="display:none"  class="dataListHead" height="23">���ʤ��</td>                                 
        <td style="display:none" colspan="3" height="23" bgcolor="silver"><input type="text" name="key48" size="15" class="dataListData" value="<%=dspKey(48)%>" readonly></td>                                 
      </tr>                                 
    </table>                            
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none">                           
      <tr>                         
        <td  class="dataListHead">�I�u�t��</td>                     
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�G�I�u�t�Ӥ�fieldrole�쬰4(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
<%  s=""
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldPb &fieldRole(1) &dataProtect))<1 and flg = "Y" Then 
       sql="SELECT RTSuppCty.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTSuppCty ON RTObj.CUSID = RTSuppCty.CUSID INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID RIGHT OUTER JOIN " _
          &"RTCmty ON RTSuppCty.CUTID = RTCmty.CUTID " _
          &"WHERE (RTObjLink.CUSTYID = '04') and rtcmty.comq1=" & dspkey(0)
       s="<option value="""">&nbsp;</option>" & vbcrlf      
    Else
       sql="SELECT RTObj.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN RTSupp ON RTObj.CUSID = RTSupp.CUSID " _
          &"WHERE RTSupp.CUSID='" &dspKey(17) &"' "
    End If
    rs.Open sql,conn
    If rs.Eof Then 
       s="<option value="""" selected>&nbsp;</option>"
    else
       sx=""
       Do While Not rs.Eof
          If rs("CusID")=dspKey(17) Then sx=" selected "
          s=s &"<option value=""" &rs("CusID") &"""" &sx &">" &rs("SHORTNC") &"</option>" & vbcrlf
          rs.MoveNext
          sx=""
       Loop
    end if
    rs.Close
%>
        <select name="key17" <%=fieldRole(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%><%=fieldPb%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select></td>       
        <td width="17%" class="dataListHead">�q���o�]���</td>                     
        <td width="17%" colspan="1" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(70)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->            
          <input type="text" name="key70" size="10" value="<%=dspKey(70)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%> class="dataListEntry" maxlength="10"></td>                                               
        
        <td width="14%" class="dataListHead">�o�]���</td>                     
        <td width="18%" colspan="1" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(19)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key19" size="10" value="<%=dspKey(19)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%> class="dataListEntry" maxlength="10">
          <input type="button" id="B19"  name="B19" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>          </td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�w�˪�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key20" size="10" class="dataListData" value="<%=dspKey(20)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�w�˪�C�L��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key21" size="10" class="dataListData" value="<%=dspKey(21)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�C�L�H��</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key22" size="10" class="dataListData" value="<%=dspKey(22)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">���u���</td>                    
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(230)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key23" size="10" value="<%=dspKey(23)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="17%" class="dataListHead">�������</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(24)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key24" size="10" value="<%=dspKey(24)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B24"  name="B24" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                     
        <td width="14%" class="dataListHead">�J�b���</td>                     
        <td width="18%">
          <input type="text" name="key25" size="10" value="<%=dspKey(25)%>"   class="dataListdata" readonly maxlength="10">
          <input type="button" id="B25"  name="B25" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�������B</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key26" size="10" value="<%=dspKey(26)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="17%" class="dataListHead">�ꦬ���B</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(27)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key27" size="10" value="<%=dspKey(27)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="14%" class="dataListHead">�M�P���</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key28" size="10" value="<%=dspKey(28)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B28"  name="B28" height="100%" width="100%" style="Z-INDEX: 1" value="...." ONCLICK="SRBTNONCLICK">
          ���J<input type="text" name="key85" size="1" maxlength="2" value="<%=dspkey(85)%>" <%=fieldRole(1)%> class="dataListEntry"></td>
      </tr>
      <tr>
        <td width="14%" class="dataListHead">�_�ˤ��</td>
        <td width="18%" bgcolor="silver">
          <input type="text" name="key95" size="10" value="<%=dspKey(95)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B95" name="B95" height="100%" width="100%" style="Z-INDEX: 1" value="...." ONCLICK="SRBTNONCLICK"></td>
		<td width="14%" class="dataListHead">�w����_��</td>
        <td width="18%" bgcolor="silver">		
          <input type="text" name="key96" size="1" maxlength="2" value="<%=dspkey(96)%>" <%=fieldRole(1)%> class="dataListEntry"></td>
        <td width="20%" class="dataListHead">&nbsp;</td>                    
        <td width="18%" bgcolor="silver">&nbsp;</td>
      </tr>
      <tr>
        <td width="20%" class="dataListHead">�O�Ҫ�</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key97" size="10" value="<%=dspKey(97)%>" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"</td>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L6' " 
       If len(trim(dspkey(98))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L6' AND CODE='" & dspkey(98) &"' " 
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &"></option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(98) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
        <td width="20%" class="dataListHead">�O�Ҫ��~��</td>                    
        <td width="18%" bgcolor="silver">
          <select name="key98" <%=fieldRole(1)%><%=dataProtect%><%=fieldpg%><%=fieldPg%> size="1"    
                  maxlength="8" class="dataListEntry"><%=s%></select></td>
        <td width="20%" class="dataListHead">�O�Ҫ��Ǹ�</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key99" size="15" value="<%=dspKey(99)%>" <%=fieldPg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>
      </tr>
      <tr>                       
        <td width="20%" class="dataListHead">���ڪ�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key29" size="10" class="dataListData" value="<%=dspKey(29)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�C�L�H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key30" size="10" class="dataListData" value="<%=dspKey(30)%>" readonly></td>                     
        <td width="14%" class="dataListHead">���ڤ��</td>                     
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(31)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key31" size="10" value="<%=dspKey(31)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%>  class="dataListEntry" maxlength="10">
          <input type="button" id="B31"  name="B31" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�]�Ȧ��ڽT�{��</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key32" size="10" class="dataListData" value="<%=dspKey(32)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�]�ȽT�{�H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key33" size="10" class="dataListData" value="<%=dspKey(33)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�����p����</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key34" size="10" value="<%=dspKey(34)%>" readonly  class="dataListdata" maxlength="10"></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�M�P��]����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(35)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key35" size="72" value="<%=dspKey(35)%>" <%=fieldPa%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�����u��]</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(36)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key36" size="72" value="<%=dspKey(36)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�ڪ�帹</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key37" size="10" class="dataListData" value="<%=dspKey(37)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�I�ڪ���</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key38" size="10" class="dataListData" value="<%=dspKey(38)%>" readonly></td>                     
        <td width="14%" class="dataListHead">�C�L�H��</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key39" size="10" class="dataListData" value="<%=dspKey(39)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�ڷ|�p�f�ֽT�{��</td>                    
        <td width="18%" bgcolor="silver"><input type="text" name="key40" size="10" class="dataListData" value="<%=dspKey(40)%>" readonly></td>                     
        <td width="17%" class="dataListHead">�|�p�f�֤H��</td>                     
        <td width="17%" bgcolor="silver"><input type="text" name="key41" size="10" class="dataListData" value="<%=dspKey(41)%>" readonly></td>                     
        <td width="14%" class="dataListHead">���׽X</td>                     
        <td width="18%" bgcolor="silver"><input type="text" name="key42" size="10" class="dataListData" value="<%=dspKey(42)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u�Ƶ�����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(44)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
         <input type="text" name="key44" size="72" value="<%=dspKey(44)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="50" style="color:red"><</td>
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u���ҥN�X</td>                    
        <td width="18%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gfieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
        <%
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa  &fieldRole(5) &dataProtect))<1 and flg = "Y" Then 
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='A6' " 
    Else
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='A6' and code='" &dspKey(43) &"' "
    End If
    rs.Open sql,conn
    s=""
    If rs.Eof Then s="<option value="""" selected>&nbsp;</option>"
    sx=""
    Do While Not rs.Eof
       If rs("code")=dspKey(43) Then sx=" selected "
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(43)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->   
        <select name="key43" <%=fieldRole(5)%><%=dataProtect%><%=fieldpg%><%=fieldPa%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>

        <td width="17%" class="dataListHead">�w�˭����O</td>
<%' if userlevel=1 then
  '    aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��")      
  '    aryOptionV=Array("0","1","2")
  ' elseif userlevel=4 then
  '    aryOption=Array("","�޳N���w��","�o�]")
  '    aryOptionV=Array("0","2","3")
  ' elseif userlevel=31 then
      aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��","�o�]")
      aryOptionV=Array("0","1","2","3")   
  ' end if
   s=""
   If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldRole(1) &dataProtect)) < 1 and flg = "Y" Then
      For i = 0 To Ubound(aryOption)
          If dspKey(49)=aryOptionV(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOptionV(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   else
      s="<option value=""" &dspKey(49) &""">" &aryOption(dspKey(49))&"</option>"
   End If%>                    
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(49)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->      
        <td width="17%" bgcolor="silver"><select size="1" onChange="Srpay()" name="key49" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry">
          <%=s%></select></td>                     
        <td width="14%" class="dataListHead">
        <input type="button" name="EMPLOY" <%=fieldpg%><%=fieldPa%><%=fieldPb%> class=keyListButton <%=fieldpf%> value="�˾����u"></td>                     
        <td width="18%" bgcolor="silver">
  <% 
    Usrary=split(dspkey(50),";")
    qrystrng=""
    s1=""
    existusr=""
    if Ubound(Usrary) >= 0 then
       existUsr="("
       for i=0 to Ubound(usrary)
           existUsr=existUsr & "'" & usrary(i) & "',"
       next
       existUsr=mid(existUsr,1,len(existUsr)-1)
       existUsr=existUsr & ")"
       qrystring=" and rtemployee.emply in " & existusr
    end if
    if len(trim(qrystring)) < 1 then
       qrystring=" and rtemployee.emply='*' "
    end if
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08'" _
          & qrystring
    rs.Open sql,conn
    Do While Not rs.Eof
       s1=s1 & rs("cusnc") & ";"
       rs.MoveNext
    Loop
    if trim(len(s1)) > 0 then 
       s1=mid(s1,1,len(s1)-1)
    else
       dspkey(50)=""
       s1=""
    end if 
    rs.Close
    conn.Close   
    set rs=Nothing   
    set conn=Nothing
   %>       
          <input type="text" name="key50" size="14" value="<%=dspKey(50)%>"  class="dataListData"  readonly maxlength="50" style="display:none">
          <input type="text" name="ref01" size="10" value="<%=S1%>"  class="dataListData"  readonly maxlength="50">
          </td>                   
      </tr>                                     
      <tr>            
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�G�w�w�˾���/��/����fieldrole�쬰6(�Y�~�ȻP�޳N)�A�{�אּ1(�Y�ȪA)
      -->           
        <td width="20%" class="dataListHead">�w�w�˾����</td>                    
        <td width="18%" bgcolor="silver">
          <input type="text" name="key51" size="10" value="<%=dspKey(51)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B51"  name="B51" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                     
        <td width="17%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="17%" bgcolor="silver">
          <input type="text" name="key52" size="10" value="<%=dspKey(52)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                     
        <td width="14%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="18%" bgcolor="silver">
          <input type="text" name="key53" size="10" value="<%=dspKey(53)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                   
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�зǬI�u�O</td>                    
        <td width="18%" bgcolor="silver">
        <input type="text" name="key54" size="10" class="dataListData" value="<%=dspKey(54)%>" readonly ></td>                     
        <td width="17%" class="dataListHead">�I�u�ɧU�O</td>                     
        <td width="17%" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(55)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key55" size="10" value="<%=dspKey(55)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>                     
        <td width="32%" colspan="2">�@</td>                     
      </tr>                                     
      <tr>                       
        <td width="20%" class="dataListHead">�I�u�ɧU�O����</td>                    
        <td width="83%" colspan="5" bgcolor="silver">
      <!-- 
       90/03/01�ȪA���ߩӿ�o�]�~�ȡA�Gdspkey(56)��fieldrole�쬰5(�Y�޳N)�A�{�אּ1(�Y�ȪA)
      -->             
          <input type="text" name="key56" size="50" value="<%=dspKey(56)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> class="dataListEntry" maxlength="25"></td>                     
      </tr>                                     
    </table>
<table width="100%"><tr><td width="100%">&nbsp;</td></tr>                                                                                                   
  </div>                               
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrReadExtDB()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn
    extDB(0)=rs("CusNC")
   ' extDB(1)=rs("CutID1")
   ' extDB(2)=rs("TownShip1")
   ' extDB(3)=rs("RAddr1")
   ' extDB(4)=rs("RZone1")
   ' extDB(5)=rs("CutID2")
   ' extDB(6)=rs("TownShip2")
   ' extDB(7)=rs("RAddr2")
   ' extDB(8)=rs("RZone2")
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
'------ RTObj ---------------------------------------------------
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
       End If
    End If

    rs("CusNC")=extDB(0)
    rs("ShortNC")=Left(extDB(0),5)
   ' rs("CutID1")=extDB(1)
   ' rs("TownShip1")=extDB(2)
   ' rs("RAddr1")=extDB(3)
   ' rs("RZone1")=extDB(4)
   ' rs("CutID2")=extDB(5)
   ' rs("TownShip2")=extDB(6)
   ' rs("RAddr2")=extDB(7)
   ' rs("RZone2")=extDB(8)
    rs("Eusr")=dspKey(45)
    rs("Edat")=dspKey(46)
    rs("Uusr")=dspKey(47)
    rs("Udat")=dspKey(48)
    rs.Update
    rs.Close
'------ RTObjLink -----------------------------------------------
    rs.Open "SELECT * FROM RTObjLink WHERE CustYID='05' AND CusID='" &dspKey(1) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
          rs("CustYID")="05"
       End If
    End If
    rs("Eusr")=dspKey(45)
    rs("Edat")=dspKey(46)
    rs("Uusr")=dspKey(47)
    rs("Udat")=dspKey(48)
    rs.Update
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include virtual="/Webap/include/checkid.inc" -->
<!-- #include virtual="/Webap/include/companyid.inc" -->
<!-- #include file="RTGetCmtyDesc.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->