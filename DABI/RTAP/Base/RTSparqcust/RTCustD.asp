<%
  Dim fieldRole,fieldPa,fieldPb,fieldpc,fieldpd,fieldpe
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  
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
               ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(76)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtSPARQcust/RTCustd.asp")
                      if i=1 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcustadsl where  cusid='" & dspkey(0) & "'"
                        rsc.open sqlstr2,conn
                        if not rsc.eof then
                           if len(trim(rsc("entryno"))) > 0 then
                              dspkey(i)=rsc("entryno") + 1
                           else
                              dspkey(i)=1
                           end if
                        else
                           dspkey(i)=1
                        end if
                        rsc.close
                      end if          
                   
                      if i=76 then
                        logonid=session("userid")
                        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                        V=split(rtnvalue,";") 
                        area=mid(v(0),1,1)
                        '---���A�Ȥ��ߤ��a�ϧO�אּ"U"(�����N��B600)
                        Call SrGetEmployeeRef(Rtnvalue,5,logonid)
                        V=rtnvalue
                        if trim(V) = "B600" then
                           AREA="U"
                        end if
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(orderno) AS orderno from rtcustadsl where  orderno like '" & area & "%'"
                        rsc.open sqlstr2,conn
                        if len(rsc("orderno")) > 0 then
                           dspkey(i)=area & right("000000" & cstr(cint(mid(rsc("orderno"),2,6)) + 1),6)
                        else
                           dspkey(i)=area & "000001"
                        end if
                        rsc.close
                      end if       
                      
                      rs.Fields(i).Value=dspKey(i)               
         ' ��{����ADSL�ȶD��ƺ��@�@�~��,�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcustadslBRANCH/RTFAQD.asp")  
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
                         '   response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"
                      rs.Fields(i).Value=dspKey(i)                         
                 case ucase("/webap/rtap/base/rtcustadslbranch/RTFaqprocessD.asp")
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
                 case ucase("/webap/rtap/base/rtcustadslbranch/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                                                   
                 case ucase("/webap/rtap/base/rtcustADSLBRANCH/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
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
   ' ��{����ADSL�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcustadslbranch/RTfaqprocessd.asp") then
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
  numberOfKey=2
  title="�t��ADSL�Ȥ�򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  'sqlFormatDB="SELECT * FROM RTCust WHERE Comq1=0 "
  sqlFormatDB="SELECT CUSID, ENTRYNO, comq1,STOCKID,BRANCH,BUSSMAN,BUSSID,SEX,BIRTHDAY, " _
             &"cutid1,township1,raddr1,rzone1,cutid2,township2,raddr2,rzone2, " _
             &"cutid3,township3,raddr3,rzone3,SPEED,LINETYPE,USEKIND, " _
             &"HOUSETYPE,HOUSENAME,HOUSEQTY,exttel,HOME,FAX,CONTACT,OFFICE, EXTENSION, MOBILE, EMAIL, " _
             &"VOUCHER, EUSR,EDAT,UUSR,UDAT,PROFAC,SNDINFODAT, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR,  " _
             &"FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO,  " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, " _
             &"UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, " _
             &"ACCCFMUSR, ENDCOD, NOTE,OPERENVID, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, " _
             &"SETFEEDESC,orderno,Lookdat,formaldat,deliverdat,socialid,agree,haveroom,homestat, " _
             &"LOOKDESC,CHTSIGNDAT,SENDWORKING,WORKINGREPLY,cusno,transdat,holdemail,proposer,SPHNNO,ip,cotport,paytype,freecode  " _
             &"FROM rtsparqADSLcust where cusid='*'"
           
  sqllist    ="SELECT CUSID, ENTRYNO,COMQ1,STOCKID,BRANCH,BUSSMAN,BUSSID,SEX,BIRTHDAY, " _
             &"cutid1,township1,raddr1,rzone1,cutid2,township2,raddr2,rzone2, " _
             &"cutid3,township3,raddr3,rzone3,SPEED,LINETYPE,USEKIND, " _
             &"HOUSETYPE,HOUSENAME,HOUSEQTY,exttel,HOME,FAX,CONTACT,OFFICE, EXTENSION, MOBILE, EMAIL, " _
             &"VOUCHER, EUSR,EDAT,UUSR,UDAT,PROFAC,SNDINFODAT, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR,  " _
             &"FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO,  " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, " _
             &"UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, " _
             &"ACCCFMUSR, ENDCOD, NOTE,OPERENVID, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, " _
             &"SETFEEDESC,orderno,Lookdat,formaldat,deliverdat,socialid,agree,haveroom,homestat, " _
             &"LOOKDESC,CHTSIGNDAT,SENDWORKING,WORKINGREPLY,cusno,transdat,holdemail,proposer,SPHNNO,ip,cotport,paytype,freecode " _
             &"FROM rtsparqADSLcust where "
 ' Response.write "SQL=" & SQLlist
 ' Response.end            
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userDefineRead="Yes"
  userDefineSave="Yes"
  userdefineactivex="Yes"  
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'------���ϧǸ�---�T�w(�ѤW�h�{���ǤJ) 
   ' dspkey(90)=SESSION("comq1")
'------���ϦW��---�T�w(�Ѫ��ϧǸ�Ū��)
    Set connxx=Server.CreateObject("ADODB.Connection")  
    Set rsxx=Server.CreateObject("ADODB.Recordset")
    DSNXX="DSN=RTLIB"
    connxx.Open DSNxx
    sqlXX="SELECT COMN,consignee FROM RTsparqAdslCmty where cutyid=" & dspkey(2)
    rsxx.Open sqlxx,connxx
    s=""
    If rsxx.Eof Then
       message="���ϥN��:" &dspkey(2) &"�b���ϰ򥻸�Ƥ��䤣��"
       formvalud=false
       consigneeXX=""       
    Else 
       dspkey(25)=rsxx("ComN") 
       consigneeXX=rsXX("consignee")    
    End If
    rsxx.Close
    Set rsxx=Nothing
    connxx.Close
    Set connxx=Nothing    
    if len(trim(dspkey(71))) = 0 then dspkey(71)=0
    if len(trim(dspkey(72))) = 0 then dspkey(72)=0
'-------�榸------------------------------
    If Not IsNumeric(dspKey(1)) Then dspKey(1)=0
'-------���------------------------------
    If Not IsNumeric(dspKey(26)) or len(trim(dspkey(26))) = 0 Then dspKey(26)=0    
'--------------- -------------------------
    If Not IsNumeric(dspKey(49)) Then dspKey(49)=0   '�������B
    If Not IsNumeric(dspKey(50)) Then dspKey(50)=0   '�ꦬ���B 
    If Not IsNumeric(dspKey(68)) Then dspKey(68)=3   '�w�����O
    If Not IsNumeric(dspKey(73)) Then dspKey(73)=0   '�зǬI�u�O
    If Not IsNumeric(dspKey(74)) Then dspKey(74)=0   '�I�u�ɧU�O   
    If Not IsNumeric(dspKey(71)) Then dspKey(71)=0   '�˾�(��)
    If Not IsNumeric(dspKey(72)) Then dspKey(72)=0   '�˾�(��)     
    If len(trim(dspkey(0))) < 1 then
       message="�ФJ�Ȥ�N�X"
       formValid=False
    elseIf dspKey(71) > 24 Or dspKey(72) > 59 Then
       message="�п�J���T�w�w�˾��ɶ�"
       formValid=False
    elseif len(trim(extdb(0))) < 1 then
       message="�п�J�Ȥ�W��"
       formValid=False    
    'elseif len(trim(dspkey(6)))=0 and len(trim(Consigneexx)) = 0 then
     '  message="�����ɤ��g�P�����P�~�ȭ����i�P�ɪť�!"
     '  formValid=False
    elseif not Isdate(dspkey(8)) and len(dspkey(8)) > 0 then
       message="�X�ͤ�����~"
       formValid=False            
    elseif not Isdate(dspkey(41)) and len(dspkey(41))  > 0 then
       message="�q���o�]������~"
       formValid=False     
    elseif not Isdate(dspkey(42)) and len(dspkey(42))  > 0 then
       message="�o�]������~"
       formValid=False            
    elseif not Isdate(dspkey(46)) and len(dspkey(46))  > 0 then
       message="���u������~"
       formValid=False     
    elseif not Isdate(dspkey(47)) and len(dspkey(47))  > 0 then
       message="����������~"
       formValid=False             
    elseif not IsNumeric(dspkey(49)) and len(dspkey(49))  > 0 then
       message="�������B���~"
       formValid=False           
    elseif not IsNumeric(dspkey(50)) and len(dspkey(50))  > 0 then
       message="�ꦬ���B���~"
       formValid=False             
    elseif not Isdate(dspkey(51)) and len(dspkey(51))  > 0 then
       message="�M�P������~"
       formValid=False             
    elseif not Isdate(dspkey(54)) and len(dspkey(54))  > 0 then
       message="���ڤ�����~"
       formValid=False          
    elseif not Isdate(dspkey(70)) and len(dspkey(70))  > 0 then
       message="�w�w�˾�������~"
       formValid=False          
    elseif not IsNumeric(dspkey(71)) and len(dspkey(71))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False          
    elseif not IsNumeric(dspkey(72)) and len(dspkey(72))  > 0 then
       message="�w�w�˾��ɶ����~"
       formValid=False              
    elseif not IsNumeric(dspkey(74)) and len(dspkey(74))  > 0 then
       message="�I�u�ɧU���B���~"
       formValid=False                     
    elseif (dspkey(68)="1" or dspkey(68)="2" ) and dspkey(40) <> "" then
       message="�w�ˤH����(�~��)��(�޳N��)��,�I�u�t�ӥ����ť�"
       formvalid=false
    elseif (dspkey(68)="3" ) and dspkey(40) = "" then
       message="�w�ˤH����(�t��)��,�I�u�t�Ӥ��o�ť�"
       formvalid=false       
    elseif (dspkey(68)="1" ) and dspkey(49) = "" then
       message="�w�ˤH����(�~��)��,�w�w�w�ˤH�����o�ť�"
       formvalid=false              
    End If
    if dspkey(7) <> "F" and dspkey(7) <>"M" then dspkey(7)=""
    if dspkey(96) <> "Y" and dspkey(96) <>"N" then dspkey(96)=""   
    if dspkey(95) <> "Y" and dspkey(95) <>"M" then dspkey(95)=""         
'�t�ӼзǬI�u�O(�I�u�t�Ӥ����ťաA�B�L�I�ڦC�L�帹�ɡA�l�i�ܧ�^
    if len(trim(dspkey(40))) > 0 and len(trim(dspkey(60))) = 0 then
       Dim Connsupp,Rssupp,sqlsupp,dsn
       Set connsupp=server.CreateObject("ADODB.Connection")
       Set rssupp=Server.CreateObject("ADODB.RecordSet")
       DSN="DSN=RTLIB"
       Sqlsupp="select * from RtSupp where cusid='" & dspkey(40) & "'"
       connsupp.open DSN
       rssupp.open sqlsupp,connsupp,1,1
       if rssupp.eof then
          dspkey(73) = 0
       else
          dspkey(73) = rssupp("STDFee")
       end if
    end if
 '���ڦW�٬��ťծɡA
   IF len(trim(dspkey(35))) = 0 then
      dspkey(35)=extdb(0)
   end if
 '�ӽХN��H���ťծɡA�w�]��"N"
   IF len(trim(dspkey(91))) = 0 then
      dspkey(91)="N"
   end if   
 '�O�_�i�ظm���,�Y�Dy��n��,�w�]���ť�
   if trim(dspkey(81)) <>"Y" and trim(dspkey(81)) <>"N" then
      dspkey(81)=""
   end if
'---�ˬd HN���X�O�_������ dspkey(89)---------
   IF LEN(TRIM(dspkey(88))) > 0 THEN
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx
      
	  if LEN(TRIM(DSPKEY(1))) =0 then
		 DSPKEY(1) =1
	  end if   
      sqlXX="SELECT count(*) AS CNT FROM RTsparqAdslcust where cusno='" & trim(dspkey(88)) & "' and not (cusid='" & dspkey(0) & "' and entryno=" & dspkey(1) & ")"
      rsxx.Open sqlxx,connxx
      s=""
      If RSXX("CNT") > 0 Then
         message="HN���X�w�s�bADSL�Ȥ�A���i���ƿ�J!"
         formvalid=false
      End If
      rsxx.Close
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing    
   end IF
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(38)=V(0)
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
   Sub SrSelonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
       prog="RTFaQFinishUsrx.asp"
       CUTID=document.all("key13").value
       town=document.all("key14").value
       'showopt="Y;Y;Y;Y"��ܹ�ܤ�����n��ܪ�����(�~�Ȥu�{�v;�ȪA�H��;�޳N��;�t��)
       if clickkey="KEY6" then
          showopt="Y;N;N;N" & ";" & cutid & ";" & town
       else
          showopt="N;N;N;N;;"
       end if
       prog=prog & "?showopt=" & showopt
       FUsr=Window.showModalDialog(prog,"Dialog","dialogWidth:590px;dialogHeight:480px;")  
      'Fusrid(0)=���פH���u���μt�ӥN��  fusrid(1)=�u����W�@�e�����q�X����W��(�L�䥦�@��) fusrid(2)="1"���~��"2"���޳N"3"���t��"4"���ȪA(�@����Ʀs������줧�̾�)
       IF FUSR <> "" THEN
       FUsrID=Split(Fusr,";")    
       if Fusrid(3) ="Y" then
         '�t�Ө�8��,��l��6��   
         if Fusrid(2)="3"  then 
            document.all(clickkey).value =  left(Fusrid(0),8)
         else
            document.all(clickkey).value =  left(Fusrid(0),6)
         end if 
       End if
       END IF
    '   Set winP=window.Opener
    '   Set docP=winP.document
    '   docP.all("keyform").Submit
    '   winP.focus()             
    '   window.close
   End Sub    
   Sub Srbranchonclick()
       prog="RTGetBRANCHD.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE 
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key4").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub      
   Sub SrbranchMANonclick()	
       prog="RTGetBRANCHMAND.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE & ";" & document.all("KEY4").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key5").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub     
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
   End Sub    
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
   End Sub   
   Sub Srcounty18onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY17").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key18").value =  trim(Fusrid(0))
          document.all("key20").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub             
   Sub SrBUSonclick()
       prog="RTOBJSTOCKBRANCHBUSSD.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE & ";" & document.all("KEY4").VALUE
       FUsr=Window.open(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       Window.form.Submit
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
   
   Sub SrCmtysel()
       Dim ClickID,prog
       prog="RTCmtySelK.asp"
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid
       CuTID2=document.all("key13").value
       township2=document.all("key14").value
       prog=prog & "?PARM=" & CutID2 & ";" & township2
       Fcmty=window.showModalDialog(prog,"Dialog","dialogWidth:590px;dialogHeight:480px;scroll:Yes")  
       document.all("key25").value=Fcmty
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
%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
</table>

<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr>
    <td width="10%" class=dataListHead>���ϧǸ�</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key2" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="6"
               value="<%=dspKey(2)%>" readonly class=dataListEntry></td>
    <td width="10%" class=dataListHead>�Ȥ�N��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key0" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(0)%>" class=dataListEntry></td>
    <td width="10%" class=dataListHead>�Ȥ�榸</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key1" readonly
               style="text-align:left;" maxlength="6" size="5"
               value="<%=dspKey(1)%>" class=dataListdata></td>
    <td width="10%" bgcolor="orange" >����s��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key76" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(76)%>" class=dataListdata style="color:red"></td>
 <td width="10%" BGCOLOR=#BDB76B>���ɳ������</td>
    <td width="10%" colspan="7" bgcolor=#DCDCDC>
        <input type="text" name="key89" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;color:red" maxlength="10" size="10"
               value="<%=dspKey(89)%>" readonly  class=dataListData></td>               
    </tr>
</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(36))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(36)=V(0)
      '          extdb(46)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(36))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(37)=datevalue(now())
    else
        if len(trim(dspkey(38))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(38)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(38))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(36))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(39)=datevalue(now())
    end if  
' -------------------------------------------------------------------------------------------- 
    IF len(trim(dspkey(35))) = 0 then
      dspkey(35)=extdb(0)
    end if
    Dim conn,rs,s,sx,sql,t
    '���׽X(�������줣�i�ק�)
    If dspKey(65)="Y" Then
       fieldPa=" class=""dataListData"" readonly "
       fieldPc=""
       fieldpd=""       
       fieldpe=""      
       fieldpf=""              
    Else
       fieldPa=""
       fieldPc=" Onclick=""Srbtnonclick"" "
       fieldpd=" onclick=""SrSelOnClick"" "       
       fieldpe=" onclick=""SrClear"" "     
       fieldpf=" onclick=""Srcmtysel"" "           
    End If    
    '�w�त�عq�H������==>�������protect(�������)  
    if len(trim(dspkey(89))) > 0 then
       fieldPc=""
       fieldpd=""       
       fieldpe=""      
       fieldpf=""         
       fieldPg=" class=""dataListData"" readonly "
       fieldph=""
       fieldpi=""       
    else
       fieldPc=" Onclick=""Srbtnonclick"" "
       fieldpd=" onclick=""SrSelOnClick"" "       
       fieldpe=" onclick=""SrClear"" "     
       fieldpf=" onclick=""Srcmtysel"" " 
       fieldPg=""               
       fieldph=" onclick=""SrBranchonclick()"" "       
       fieldpi=" onclick=""SrBranchmanonclick()"" "       
    end if
    '���ڪ�w�C�L�Φw�˭����O���o�](�Ϊť�)�ɡA���i���w�˭��u�s�A���i���w�ˤH����ơ]�Y�w�˭��u�sdisable)
  ' If Len(Trim(dspKey(50))) > 0  Then
  '    fieldPb=" class=""dataListData"" readonly "
  ' Else
  '    fieldPb=""
  ' End If
    if dspkey(65)="Y" or Len(Trim(dspKey(50))) > 0  then
       fieldPbx=""       
    else
       fieldPbx="SrAddusr()"
    end if        
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'"><font size=2>�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'"><font size=2>�o�]�w��</span>                                      
  <div class=dataListTagOn> 
<table width="100%" ><tr><td width="100%">&nbsp;</td></tr>                                                      
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag1" height="354">  
    <tr>
        <td width="15%" class="dataListSEARCH" height="25">��b�N��</td>
        <td width="18%" height="25" bgcolor="silver"> 
        <input type="text" name="key27" size="10" maxlength="10" readonly value="<%=dspkey(27)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata">
        #<input type="text" name="key92" size="3" maxlength="3" readonly value="<%=dspkey(92)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata"></td> 
        <td width="15%" class="dataListSEARCH" height="25">�Τ�IP</td>
        <td width="18%"  height="25" bgcolor="silver"> 
        <input type="text" name="key93" size="18" maxlength="15"  value="<%=dspkey(93)%>"<%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListentry"></td> 
         <td width="15%" class="dataListSEARCH" height="25">HomePNA Port</td>
        <td width="18%"  height="25" bgcolor="silver"> 
        <input type="text" name="key94" size="15" maxlength="15" value="<%=dspkey(94)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListentry">
    </TR>
    <tr>
        <td width="15%" class="dataListHead" height="25">�����Ҧr��</td>
        <td width="18%" height="25" bgcolor="silver"> 
        <input type="text" name="key80" size="10" maxlength="10" value="<%=dspkey(80)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td> 
        <td width="12%" class="dataListHead" height="25">�t�իȤ�N�X</td>       
        <td width="17%" height="25" bgcolor="silver"> 
        <input type="text" name="key88" size="10" maxlength="10" value="<%=dspkey(88)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td> 
        <td width="14%" bgcolor="orange"  height="25" ><FONT SIZE=2>�O�d����E-MAIL(��HN���X)</FONT></td>       
        <td width="20%" height="25" bgcolor="silver"> 
        <input type="text" name="key90" size="8" maxlength="8" value="<%=dspkey(90)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" style="color:red"></td>                         
    </tr>
    <tr>                   
        <td STYLE="DISPLAY:NONE" width="15%" class="dataListHead" height="25">�g�P��</td>                                      
        <td STYLE="DISPLAY:NONE" width="30%" height="25" bgcolor="silver">
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 and  len(trim(dspkey(89)))=0 Then 
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID,RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '02')  "
       s="<option value="""" >(�g�P��)</option>"
    Else
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID,RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '02')  and rtobj.cusid='" & dspkey(3) & "' "
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�g�P��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CUSID")=dspkey(3) Then sx=" selected "
       s=s &"<option value=""" &rs("CUSID") &"""" &sx &">" &rs("SHORTNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>
           <select STYLE="DISPLAY:NONE" size="1" name="key3" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry">                                            
              <%=s%>
           </select>
        <input type="HIDDEN" name="key4" size="10" value="<%=dspkey(4)%>" maxlength="12" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" readonly><font size=2>    
         <input type="HIDDEN" id="B4"  name="B4"   width="100%" style="Z-INDEX: 1"  value="..." <%=fieldph%> >  
         <!-- <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C4"  name="C4"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" > 
         -->
        </td>                              
        <td STYLE="DISPLAY:NONE" width="8%" class="dataListHead" height="25">��~��</td>
        <td STYLE="DISPLAY:NONE" width="16%" height="25" bgcolor="silver">
        <input type="hidden" name="key5" size="8" value="<%=dspkey(5)%>" maxlength="12" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" readonly>
         <input type="hidden" id="B5"  name="B5"   width="100%" style="Z-INDEX: 1"  value="..." <%=fieldpi%>  >                  
        <!--  <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C5"  name="C5"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    
        -->
        </td>     
<% 
   %>               
        <td width="8%" class="dataListHead" height="25">�~�ȭ�</td>                              
        <td width="16%" height="25" bgcolor="silver" >
      <input type="text" name="key6" size="6" maxlength="50" readonly value="<%=dspkey(6)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%> class="dataListEntry" >
     <input type="button" id="B6"  name="B6"   width="100%" style="Z-INDEX: 1"  value="..." <%=fieldpd%>  >
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C6"  name="C6"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >        
        </TD>
        <td width="17%" class="dataListsearch" height="25">������</td>       
       <%  dim freecode1, freecode2
    if len(trim(dspkey(96))) =0 and dspkey(67) <> "Y" then
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
    If dspKey(96)="Y" Then freecode1=" checked "    
    If dspKey(96)="N" Then freecode2=" checked " %>                          
        <td width="16%" height="25" bgcolor="silver" >
        <input type="radio" value="Y"  name="key96" <%=FREECODE1%><%=FIELDROLE(1)%>><font size=2>�O</font>
        <input type="radio" name="key96" value="N" <%=FREECODE2%><%=FIELDROLE(1)%>><font size=2>�_</font></td>         
        <td width="17%" class="dataListsearch" height="25">ú�O�覡</td>       
       <%  dim PAYTYPE1, PAYTYPE2
    if len(trim(dspkey(95))) =0 and dspkey(67) <> "Y" then
       If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
          PAYTYPE1=""
          PAYTYPE2=""
          PAYTYPE3=""
       Else
          PAYTYPE1=" disabled "
          PAYTYPE2=" disabled "
          PAYTYPE3=" disabled "
       end if
    else
   '       freecode1=" disabled "
   '       freecode2=" disabled "
    End If
    If dspKey(95)="M" Then PAYTYPE1=" checked "    
    If dspKey(95)="Y" Then PAYTYPE2=" checked " 
    If dspKey(95)="H" Then PAYTYPE3=" checked " %>                                
        <td width="16%" height="25" bgcolor="silver" >
			<input type="radio" value="M"  name="key95" <%=PAYTYPE1%><%=FIELDROLE(1)%>><font size=2>��ú</font>
			<input type="radio" name="key95" value="Y" <%=PAYTYPE2%><%=FIELDROLE(1)%>><font size=2>�~ú</font>
			<input type="radio" name="key95" value="H" <%=PAYTYPE3%><%=FIELDROLE(1)%><font size=2>�~����ú</font>        
        </td></TR>
      <tr>                                      
        <td width="15%" class="dataListHead" height="25">�Ȥ�W��</td>                                      
        <td width="30%" height="25" bgcolor="silver">
          <input type="text" name="ext0" size="28" maxlength="50" value="<%=extdb(0)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                              
        <td width="8%" class="dataListHead" height="25">�ʧO</td>
<%  dim sexd1, sexd2
    if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
       If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
          sexd1=""
          sexd2=""
       Else
          sexd1=" disabled "
          sexd2=" disabled "
       end if
    else
          sexd1=" disabled "
          sexd2=" disabled "
    End If
    If dspKey(7)="M" Then sexd1=" checked "    
    If dspKey(7)="F" Then sexd2=" checked " %>                          
        <td width="16%" height="25" bgcolor="silver">
        <input type="radio" value="M" <%=sexd1%> name="key7" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtec%>><font size=2>�k</font>
        <input type="radio" name="key7" value="F" <%=sexd2%><%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>><font size=2>�k</font></td>                              
        <td width="8%" class="dataListHead" height="25">�X�ͤ��</td>                              
        <td width="16%" height="25" bgcolor="silver">
          <input type="text" name="key8" size="10" value="<%=dspkey(8)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class=dataListEntry>
          <input type="button" id="B8"  name="B8" height="70%" width="70%" style="Z-INDEX: 1" value="..." <%=fieldpc%>></td>                              
      </tr>                              
      <tr>                              
        <td width="15%" class="dataListHead" height="25">�b��(�q�T)�a�}</td>                              
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and len(trim(dspkey(89)))=0 Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(9))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
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
         <select size="1" name="key9"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        <input type="text" name="key10" size="8" value="<%=dspkey(10)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B10"  name="B10"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX10%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key11" size="32" value="<%=dspkey(11)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key12" size="10" value="<%=dspkey(12)%>" maxlength="5" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="25">�˾��a�}</td>                                 
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(13))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX14=" onclick=""Srcounty14onclick()"" "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(13) & "' " 
       sXX14=""
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
        <select name="key13" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1"  style="text-align:left;" maxlength="8" class="dataListEntry">
        <%=s%></select>
        <input type="text" name="key14" size="8" value="<%=dspkey(14)%>" maxlength="10" readonly <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B14"  name="B14"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX14%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    
        <input type="text" name="key15" size="32" value="<%=dspkey(15)%>" maxlength="60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key16" size="10" value="<%=dspkey(16)%>" maxlength="5"<%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>
      <tr>                                 
        <td width="15%" class="dataListHead" height="25">���y�a�}</td>                                 
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(17))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if    
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"        
       sxx18=" onclick=""Srcounty18onclick()"" "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(17) & "' " 
       sxx18=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(17) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key17" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>
        <input type="text" name="key18" size="8" value="<%=dspkey(18)%>" maxlength="10" readonly <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B18"  name="B18"   width="100%" style="Z-INDEX: 1"  value="..." <%=sxx18%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C18"  name="C18"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
        <input type="text" name="key19" size="32" value="<%=dspkey(19)%>" maxlength="60" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                     
        <td width="8%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="16%" height="25" bgcolor="silver"><input type="text" name="key20" size="10" value="<%=dspkey(20)%>" maxlength="5" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                
      <tr>          
<script language="vbscript">
Sub SrAddrEqual()
  Dim i,objOpt
  document.All("key13").value=document.All("key9").value
  document.All("key14").value=document.All("key10").value
  document.All("key15").value=document.All("key11").value
  document.All("key16").value=document.All("key12").value
End Sub 
Sub SrAddrEqual2()
  document.All("key17").value=document.All("key9").value
  document.All("key18").value=document.All("key10").value
  document.All("key19").value=document.All("key11").value
  document.All("key20").value=document.All("key12").value
End Sub 
Sub SrAddUsr()
  ExistUsr=document.all("key69").value
  InsType=cstr(document.all("key68").value)
  UsrStr=Window.showModalDialog("RTCustAddUsr.asp?parm=" & existusr & "@" & instype   ,"Dialog","dialogWidth:410px;dialogHeight:400px;")
  if UsrStr<>False then
     UsrStrAry=split(UsrStr,"@")
     document.all("key69").value=UsrStrAry(0)
     document.all("REF01").value=UsrStrAry(1)     
  end if
End Sub

Sub Srpay()
  if document.all("key68").value = "1" then
     document.all("key73").value = 200
  else
     document.all("key73").value = 0
  end if
end sub
</script>                       
        <td width="35%" class="dataListHead" colspan="6" height="34" bgcolor="silver">
<%  dim seld1
    if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
       If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
          seld1=""
       Else
          seld1=" disabled "
       End If
    else
        seld1=" disabled "
    end if
    %>
            <input type="radio" name="rdo1" value="1"<%=seld1%><%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual()">�˾��a�}�P�b��a�}
            <input type="radio" name="rdo2" value="1"<%=seld1%><%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual2()">���y�a�}�P�b��a�}</td>                                 

      </tr>                                 
      <tr>                            
        <td width="15%" class="dataListHead" height="25">�ӽФ��</td>
 <td width="30%" height="25" bgcolor="silver">
<% aryOption=Array("�g�٫�","�����","�ӷ~��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and len(trim(dspkey(89)))=0 Then 
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
   <select size="1" name="key23" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">                                            
        <%=s%>
   </select>
   </td>    
        <td width="8%" class="dataListHead" height="23">�ӽгt��</td>
<% aryOption=Array("512/64Kbps")
   s=""
   If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then 
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
        <td width="16%" height="23" bgcolor="silver"><select size="1" name="key21" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">                                                             
        <%=s%></select></td>      
        <td width="8%" class="dataListHead" height="25">�u������</td>
<% aryOption=Array("ADSL")
   s=""
   If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then   
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
        <td width="16%" height="25" bgcolor="silver"><select size="1" name="key22" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%></select></td>                                                                         
     </tr>                     
      <tr>                            
        <td width="15%" class="dataListHead" height="25">���d���</td>
         <td width="30%" height="25" bgcolor="silver">       
          <input type="text" name="key77" size="10" value="<%=dspKey(77)%>"  <%=fieldpg%><%=fieldpa%><%=FIELDROLE(3)%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B77"  name="B77" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpc%>>
          <%  dim rdo1, rdo2
              if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
                 If Len(Trim(fieldRole(3) &dataProtect)) < 1 Then
                    rdo1=""
                    rdo2=""
                 Else
                    rdo1=" disabled "
                    rdo2=" disabled "
                 end if
              else
                 rdo1=" disabled "
                 rdo2=" disabled "
              End If
             ' If Trim(dspKey(81))="" Then dspKey()="Y"
              If trim(dspKey(81))="Y" Then 
                 rdo1=" checked "    
              elseIf trim(dspKey(81))="N" Then 
                 rdo2=" checked " 
              end if
             %>
        <input type="radio" value="Y" <%=rdo1%> name="key81" <%=fieldpg%><%=fieldRole(3)%><%=dataProtect%>><font size=2>�i�ظm
        <input type="radio" value="N" <%=rdo2%>  name="key81" <%=fieldpg%><%=fieldRole(3)%><%=dataProtect%>><font size=2>�L�k�ظm
          </td> 
        <td width="8%" class="dataListHead" height="25">���d���G</td>
         <td width="16%"  height="25" bgcolor="silver">       
         <% aryOption=Array("","���q�H��","�L�q�H��","�L�q�H�c")
            s=""
            If Len(Trim(fieldRole(3) &dataProtect)) < 1 and len(trim(dspkey(89)))=0 Then 
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
            End If%>               
         <select size="1" name="key82" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(3)%><%=dataProtect%> class="dataListEntry">                                            
           <%=s%>
         </select>
         <% aryOption=Array("","���","�W��","����")
            s=""
            If Len(Trim(fieldRole(3) &dataProtect)) < 1 and len(trim(dspkey(89)))=0 Then 
               For i = 0 To Ubound(aryOption)
                   If dspKey(83)=aryOption(i) Then
                      sx=" selected "
                   Else
                      sx=""
                   End If
                   s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
               Next
            Else
                   s="<option value=""" &dspKey(83) &""">" &dspKey(83) &"</option>"
            End If%>               
         <select size="1" name="key83" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(3)%><%=dataProtect%> class="dataListEntry">                                            
           <%=s%>
         </select>         
         </td>
          <td width="8%" class="dataListHead">�����ӽФ�</td>                     
          <td width="16%"  bgcolor="silver">
          <input type="text" name="key78" size="10" value="<%=dspKey(78)%>"  <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B78"  name="B78" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpc%>></td> 
      </tr>
      <tr>
        <td width="15%"  class="dataListHead" height="34">���d�ɥR����</td>  
        <td width="30%"  colspan="3" height="21" bgcolor="silver">
        <input type="text" name="key84" style="text-align:left;" maxlength="300" size="60"
               value="<%=dspKey(84)%>"<%=FIELDROLE(3)%> class=dataListentry style="color:red">
        </td>
        <td width="8%"   bgcolor="ORANGE"  height="34">�e����</td>                                 
        <td width="16%"  height="34" bgcolor="silver">
          <input type="text" name="key79" size="10" value="<%=dspKey(79)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <input type="button" id="B79"  name="B79" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpc%>></td>       
      </tr>            
      <tr style="display:none">
        <td width="15%"  bgcolor="ORANGE"  height="34">CHTñ�֤��</td>  
        <td width="30%"  height="21" bgcolor="silver">
        <input type="text" name="key85" style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(85)%>" class=dataListentry >
          <input type="button" id="B85"  name="B85" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=fieldpc%>>               
        </td>
        <td width="8%"   bgcolor="ORANGE" height="34">�e��B�B���</td>                                 
        <td width="16%"  height="34" bgcolor="silver">
          <input type="text" name="key86" size="10" value="<%=dspKey(86)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <input type="button" id="B86"  name="B86" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpc%>></td>       
        <td width="8%"   bgcolor="ORANGE" height="34">���o�����q�ܤ�</td>                                 
        <td width="16%"  height="34" bgcolor="silver">
          <input type="text" name="key87" size="10" value="<%=dspKey(87)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <input type="button" id="B87"  name="B87" height="100%" width="100%" style="Z-INDEX: 1" value="..."  <%=fieldpc%>></td>                 
      </tr>                                            
      <tr>                                    
        <td width="15%" class="dataListHead" height="21">��v����</td>                                    
        <td width="30%"  colspan="5" height="21" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and len(trim(dspkey(89)))=0 Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' " 
       If len(trim(dspkey(24))) < 1 Then
          sx=" selected " 
        '  s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
        '  s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' AND CODE='" & dspkey(24) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(24) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key24" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%>
   </select><font size=2>
   &nbsp;���ϦW��<input type="text" name="key25" size="15" MAXLENGTH="30" value="<%=dspKey(25)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(3)%><%=dataProtect%> readonly class="dataListEntry">
        <!--
        <input type="button" id="B25"  name="B25"   width="100%" style="Z-INDEX: 1"  value="..." <%=fieldpf%>  >
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C25"  name="C25"   style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >        
          -->
   �@<input type="text" name="key26" size="4" value="<%=dspKey(26)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> maxlength="4" class="dataListEntry">��</td>                                 
      </tr>                                 
      <tr>                                    
        <td width="15%" class="dataListHead" height="23">�p���q��</td>                                 
        <td width="30%" height="23"><input type="text" name="key28" size="15" value="<%=dspkey(28)%>" maxlength="15" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="23">�ǯu�q��</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key29" size="15" value="<%=dspkey(29)%>" maxlength="15" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="23">�p���H</td>                                 
        <td width="16%" height="23" bgcolor="silver"><input type="text" name="key30" size="10" value="<%=dspkey(30)%>" maxlength="20" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="23" bgcolor="silver">���q�q��</td>                                 
        <td width="30%" height="23"><input type="text" name="key31" size="15" value="<%=dspkey(31)%>" maxlength="15" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
        <font size=2>����<input type="text" name="key32" size="5" value="<%=dspkey(32)%>" maxlength="5" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="23">��ʹq��</td>                                 
        <td width="16%"  height="23" bgcolor="silver"><input type="text" name="key33" size="15" value="<%=dspkey(33)%>" maxlength="15" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" height="23" class="dataListHead" >�ӽХN��H</td>                     
        <td width="16%" height="23" bgcolor="silver">
        <%  dim OPT1, OPT2
            if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
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
            If dspKey(91)="Y" Then OPT1=" checked "    
            If dspKey(91)="N" Then OPT2=" checked " %>                          
        
        <input type="radio" value="Y" <%=OPT1%> name="key91" <%=fieldpg%><%=fieldpa%><%=dataProtec%>><font size=2>�O</font>
        <input type="radio" value="N" <%=OPT2%> name="key91" <%=fieldpg%><%=fieldpa%><%=dataProtect%>><font size=2>�_</font></td>                              
            
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="25">�q�l�l��H�c</td>                                 
        <td width="30%" height="25" bgcolor="silver"><input type="text" name="key34" size="30" value="<%=dspkey(34)%>" maxlength="30" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td width="8%" class="dataListHead" height="23">���ڦW��</td>                                 
        <td width="16%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key35" size="15" value="<%=dspkey(35)%>" maxlength="50" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
        <font size=2>(�ťծɹw�]���Ȥ�W��)</font></td>                   
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="23" style="display:none">��J�H��</td>                                 
        <td width="30%" height="23" bgcolor="silver" style="display:none"><input type="text" name="key36" size="10" class="dataListData" value="<%=dspKey(36)%>" readonly style="display:none"><%=EusrNc%></td>                                 
        <td width="8%" class="dataListHead" height="23" style="display:none">��J���</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver" style="display:none"><input type="text" name="key37" size="15" class="dataListData" value="<%=dspKey(37)%>" readonly style="display:none"></td>                                 
      </tr>                                 
      <tr>                                 
        <td width="15%" class="dataListHead" height="23" style="display:none">���ʤH��</td>                                 
        <td width="30%" height="23" bgcolor="silver" style="display:none"><input type="text" name="key38" size="10" class="dataListData" value="<%=dspKey(38)%>" readonly style="display:none"><%=UUsrNc%></td>                                 
        <td width="8%" class="dataListHead" height="23" style="display:none">���ʤ��</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver" style="display:none"><input type="text" name="key39" size="15" class="dataListData" value="<%=dspKey(39)%>" readonly style="display:none"></td>                                 
      </tr>
     
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none">                           
      <tr>                         
        <td width="15%" class="dataListHead">�I�u�t��</td>                     
        <td width="15%" bgcolor="silver">
<%
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldPb &fieldRole(1) &dataProtect))<1 Then 
       sql="SELECT RTObj.CUSID, RTObj.SHORTNC " _
          &"FROM RTObj RIGHT OUTER JOIN " _
          &"RTConsignee ON RTObj.CUSID = RTConsignee.CUSID "
    Else
       sql="SELECT RTObj.CUSID, RTObj.SHORTNC " _
          &"FROM RTSparqADSLcust LEFT OUTER JOIN " _
          &"RTObj ON RTSparqADSLcust.PROFAC = RTObj.CUSID " _
          &"WHERE RTobj.CUSID='" &dspKey(40) &"' "
    End If
   ' Response.Write "SQL=" & SQL & "<BR>"
    rs.Open sql,conn
    s=""
    If rs.Eof Then 
       s="<option value="""" selected>&nbsp;</option>"
    else
       sx=""
       s="<option value="""">&nbsp;</option>" & vbcrlf      
       Do While Not rs.Eof
          If rs("CusID")=dspKey(40) Then sx=" selected "
          s=s &"<option value=""" &rs("CusID") &"""" &sx &">" &rs("SHORTNC") &"</option>" & vbcrlf
          rs.MoveNext
          sx=""
       Loop
    end if
    rs.Close
%>
        <select name="key40" <%=fieldRole(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%><%=fieldPb%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select></td> 
        <td width="15%" class="dataListHead">�q���o�]���</td>                     
        <td width="15%" colspan="1" bgcolor="silver">
          <input type="text" name="key41" size="10" value="<%=dspKey(41)%>" readonly <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%> class="dataListdata" maxlength="10"></td>                                               
        <td width="15%" class="dataListHead">�o�]���</td>                     
        <td width="15%" colspan="1" bgcolor="silver">
          <input type="text" name="key42" size="10" value="<%=dspKey(42)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%> class="dataListEntry" maxlength="10">
          <input type="button" id="B42"  name="B42" height="100%" width="100%" style="Z-INDEX: 1" value="..." <%=fieldpc%>>          </td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�w�˪�帹</td>                    
        <td width="15%" bgcolor="silver"><input type="text" name="key43" size="10" class="dataListData" value="<%=dspKey(43)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�w�˪�C�L��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key44" size="10" class="dataListData" value="<%=dspKey(44)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�C�L�H��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key45" size="10" class="dataListData" value="<%=dspKey(45)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">���u���</td>                    
        <td width="15%" bgcolor="silver">
          <input type="text" name="key46" size="10" value="<%=dspKey(46)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" ></td>                     
        <td width="15%" class="dataListHead">�������</td>   
        <td width="15%" bgcolor="silver">                  
         <input type="text" name="key47" size="10" readonly value="<%=dspKey(47)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" maxlength="10">
        <td width="15%" class="dataListHead">�J�b���</td>                     
        <td width="15%">
          <input type="text" name="key48" size="10" value="<%=dspKey(48)%>"   class="dataListdata" readonly maxlength="10">
          <input type="button" id="B48"  name="B48" height="100%" width="100%" style="Z-INDEX: 1" value="..." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�������B</td>                    
        <td width="15%" bgcolor="silver">
          <input type="text" name="key49" size="10" value="<%=dspKey(49)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="15%" class="dataListHead">�ꦬ���B</td>                     
        <td width="15%" bgcolor="silver">
        <input type="text" name="key50" size="10" value="<%=dspKey(50)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td width="15%" class="dataListHead">�M�P���</td>                     
        <td width="15%" bgcolor="silver">
          <input type="text" name="key51" size="10" value="<%=dspKey(51)%>" <%=fieldPa%><%=fieldPb%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" >
          <input type="button" id="B51"  name="B51" height="100%" width="100%" style="Z-INDEX: 1" value="..." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">���ڪ�帹</td>                    
        <td width="15%" bgcolor="silver"><input type="text" name="key52" size="10" class="dataListData" value="<%=dspKey(52)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�C�L�H��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key53" size="10" class="dataListData" value="<%=dspKey(53)%>" readonly></td>                     
        <td width="15%" class="dataListHead">���ڤ��</td>                     
        <td width="15%" bgcolor="silver">
         <input type="text" name="key54" size="10" value="<%=dspKey(54)%>" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" maxlength="10">
          <input type="button" id="B54"  name="B54" height="100%" width="100%" style="Z-INDEX: 1" value="..." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�]�Ȧ��ڽT�{��</td>                    
        <td width="15%" bgcolor="silver"><input type="text" name="key55" size="10" class="dataListData" value="<%=dspKey(55)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�]�ȽT�{�H��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key56" size="10" class="dataListData" value="<%=dspKey(56)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�����p����</td>                     
        <td width="15%" bgcolor="silver">
          <input type="text" name="key57" size="10" value="<%=dspKey(57)%>" readonly  class="dataListdata" maxlength="10"></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�M�P��]����</td>                    
        <td width="15%" colspan="5" bgcolor="silver">
          <input type="text" name="key58" size="70" value="<%=dspKey(58)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�����u��]</td>                    
        <td width="15%" colspan="5" bgcolor="silver">
          <input type="text" name="key59" size="70" value="<%=dspKey(59)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�I�ڪ�帹</td>                    
        <td width="15%" bgcolor="silver"><input type="text" name="key60" size="10" class="dataListData" value="<%=dspKey(60)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�I�ڪ���</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key61" size="10" class="dataListData" value="<%=dspKey(61)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�C�L�H��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key62" size="10" class="dataListData" value="<%=dspKey(62)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�I�ڷ|�p�f�ֽT�{��</td>                    
        <td width="15%" bgcolor="silver"><input type="text" name="key63" size="10" class="dataListData" value="<%=dspKey(63)%>" readonly></td>                     
        <td width="15%" class="dataListHead">�|�p�f�֤H��</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key64" size="10" class="dataListData" value="<%=dspKey(64)%>" readonly></td>                     
        <td width="15%" class="dataListHead">���׽X</td>                     
        <td width="15%" bgcolor="silver"><input type="text" name="key65" size="10" class="dataListData" value="<%=dspKey(65)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�I�u�Ƶ�����</td>                    
        <td width="15%" colspan="5" bgcolor="silver">
          <input type="text" name="key66" size="70" value="<%=dspKey(66)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�I�u���ҥN�X</td>                    
        <td width="15%" bgcolor="silver">
        <%
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa  &FIELDROLE(1) &dataProtect))<1 and len(trim(dspkey(90)))=0 Then 
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='C4' " 
    Else
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='C4' and code='" &dspKey(67) &"' "
    End If
    rs.Open sql,conn
    s=""
    If rs.Eof Then s="<option value="""" selected>&nbsp;</option>"
    sx=""
    Do While Not rs.Eof
       If rs("code")=dspKey(67) Then sx=" selected "
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
        <select name="key67" <%=FIELDROLE(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>

        <td width="15%" class="dataListHead">�w�˭����O</td>
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
   If Len(Trim(fieldPa &fieldRole(1) &dataProtect)) > 0 or len(trim(dspkey(89)))> 0 Then
      s="<option value=""" &dspKey(68) &""">" &aryOption(dspKey(68)) &"</option>"
      SXX=""
   Else
      For i = 0 To Ubound(aryOption)
          If dspKey(68)=aryOptionV(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOptionV(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
      sxx=" onclick=""SrAddUsr()"" "
   End If%>                    
        <td width="15%" bgcolor="silver"><select size="1" onChange="Srpay()" name="key68" <%=fieldpg%><%=fieldPa%><%=fieldPb%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <%=s%></select></td>                     
        <td width="15%" class="dataListHead">
        <input type="button" name="EMPLOY" <%=fieldpg%><%=fieldPa%><%=fieldPb%> class=keyListButton <%=SXX%> value="�˾����u"></td>                     
        <td width="15%" bgcolor="silver">
  <% 
    Usrary=split(dspkey(69),";")
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
          & qrystring _
          &" order by cusnc "
    rs.Open sql,conn
    Do While Not rs.Eof
       s1=s1 & rs("cusnc") & ";"
       rs.MoveNext
    Loop
    if trim(len(s1)) > 0 then 
       s1=mid(s1,1,len(s1)-1)
    else
       dspkey(69)=""
       s1=""
    end if 
    rs.Close
    conn.Close   
    set rs=Nothing   
    set conn=Nothing
   %>       
          <input type="text" name="key69" size="14" value="<%=dspKey(69)%>"  class="dataListData"  readonly maxlength="50" style="display:none">
          <input type="text" name="ref01" size="10" value="<%=S1%>"  class="dataListData"  readonly maxlength="50">
          </td>                   
      </tr>                                     
      <tr>            
        <td width="15%" class="dataListHead">�w�w�˾����</td>                    
        <td width="15%" bgcolor="silver">
          <input type="text" name="key70" size="10" value="<%=dspKey(70)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B70"  name="B71" height="100%" width="100%" style="Z-INDEX: 1" value="..." <%=fieldpc%>></td>                     
        <td width="15%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="15%" bgcolor="silver">
          <input type="text" name="key71" size="10" value="<%=dspKey(71)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                     
        <td width="15%" class="dataListHead">�w�w�˾��ɶ�(��)</td>                     
        <td width="15%" bgcolor="silver">
          <input type="text" name="key72" size="10" value="<%=dspKey(72)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="2"></td>                   
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�зǬI�u�O</td>                    
        <td width="15%" bgcolor="silver">
        <input type="text" name="key73" size="10" class="dataListData" value="<%=dspKey(73)%>" readonly ></td>                     
        <td width="15%" class="dataListHead">�I�u�ɧU�O</td>                     
        <td width="15%" bgcolor="silver">
        <input type="text" name="key74" size="10" value="<%=dspKey(74)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>                     
        <td width="15%" colspan="2">�@</td>                     
      </tr>                                     
      <tr>                       
        <td width="15%" class="dataListHead">�I�u�ɧU�O����</td>                    
        <td width="15%" colspan="5" bgcolor="silver">
          <input type="text" name="key75" size="70" value="<%=dspKey(75)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="25"></td>                     
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
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(0) &"' ",conn
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
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(0) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(0)
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
    rs("Eusr")=""
    rs("Edat")=now()
    rs("Uusr")=""
    rs("Udat")=now()
    rs.Update
    rs.Close
'------ RTObjLink -----------------------------------------------
    rs.Open "SELECT * FROM RTObjLink WHERE CustYID='05' AND CusID='" &dspKey(0) &"' ",conn,3,3
    'Response.Write RS.EOF
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(0)
          rs("CustYID")="05"
       End If
    End If
    rs("Eusr")=""
    rs("Edat")=now()
    rs("Uusr")=""
    rs("Udat")=now()
    rs.Update
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="rtgetBRANCHBUSS.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include file="RTGetCmtyDesc.inc" -->