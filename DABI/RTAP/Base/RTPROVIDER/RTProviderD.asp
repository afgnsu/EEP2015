
<%@ Transaction = required %>

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
                 ' ��{�������ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp")
                     if i<>0 AND I <> 52 and i <> 54 and i <> 59 then rs.Fields(i).Value=dspKey(i)
                     '���ظm�P�N�ѤΦX���Ѥ��{�s�s���̤j��(�ᤩ�s�s���ɨ�̤��s�����ۦP���G
                     if i=52 or i=54 or i=59 then
                        temp52=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(agreeno) AS agreeno from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("agreeno"))) > 0 then
                           temp52="BA" & right("00000" & cstr(cint(mid(rsc("agreeno"),3,5))+1),5)
                        else
                           temp52="BA00001"
                        end if
                        temp52A=mid(temp52,3,5)
                        '----
                        temp54=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(contractno) AS contractno from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("contractno"))) > 0 then
                           temp54="BB" & right("00000" & cstr(cint(mid(rsc("contractno"),3,5))+1),5)
                        else
                           temp54="BB00001"
                        end if
                        temp54A=mid(temp54,3,5)        
                        '----
                        temp59=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(remitno) AS remitno from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("remitno"))) > 0 then
                           temp59="BC" & right("00000" & cstr(cint(mid(rsc("REMITNO"),3,5))+1),5)
                        else
                           temp59="BC00001"
                        end if
                        temp59A=mid(temp59,3,5)                                
                     '----   
                       maxtemp=temp52A
                       if temp54A > maxtemp then maxtemp=temp54A
                       if temp59A > maxtemp then maxtemp=temp59A
                                       
                       if dspkey(51)="Y" AND LEN(TRIM(DSPKEY(52)))=0 then dspkey(52)="BA" & maxtemp
                       if dspkey(53)="Y" AND LEN(TRIM(DSPKEY(54)))=0 then dspkey(54)="BB" & maxtemp
                       if dspkey(58)="Y" AND LEN(TRIM(DSPKEY(59)))=0 then dspkey(59)="BC" & maxtemp                       
                       rs.Fields(i).Value=dspKey(i)
                     end if                                       
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtADSLcmty/RTCmtyd.asp")
                     if i<>0  AND i <> 36 and i<> 38 and i<> 43 then rs.Fields(i).Value=dspKey(i)                
                     '���ظm�P�N�ѤΦX���Ѥ��{�s�s���̤j��(�ᤩ�s�s���ɨ�̤��s�����ۦP���G
                     if i=36 or i=38 or i=43 then
                     '   response.write "I=" & I & "<BR>"
                        temp36=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(agreeno) AS agreeno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("agreeno"))) > 0 then
                           temp36="AA" & right("00000" & cstr(cint(mid(rsc("agreeno"),3,5))+1),5)
                        else
                           temp36="AA00001"
                        end if
                        temp36A=mid(temp36,3,5)
                        '----
                        temp38=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(contractno) AS contractno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("contractno"))) > 0 then
                           temp38="AB" & right("00000" & cstr(cint(mid(rsc("contractno"),3,5))+1),5)
                        else
                           temp38="AB00001"
                        end if
                        temp38A=mid(temp38,3,5)        
                        '----
                        temp43=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(remitno) AS remitno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("remitno"))) > 0 then
                           temp43="AC" & right("00000" & cstr(cint(mid(rsc("remitno"),3,5))+1),5)
                        else
                           temp43="AC00001"
                        end if
                        temp43A=mid(temp43,3,5)                                
                     '----                   
                       maxtemp=temp36A
                       if temp38A > maxtemp then maxtemp=temp38A
                       if temp43A > maxtemp then maxtemp=temp43A
                                       
                       if dspkey(35)="Y" AND LEN(TRIM(DSPKEY(36)))=0 then dspkey(36)="AA" & maxtemp
                       if dspkey(37)="Y" AND LEN(TRIM(DSPKEY(38)))=0 then dspkey(38)="AB" & maxtemp
                       if dspkey(42)="Y" AND LEN(TRIM(DSPKEY(43)))=0 then dspkey(43)="AC" & maxtemp                     
                       rs.Fields(i).Value=dspKey(i)
                     end if                          
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmtyADSL/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)    
                 ' ��{�����t��ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtsparqADSLcmty/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)                         

                 ' ��{�����Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(2)���۰ʷm�����(max+1)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcmty/RTCustD.asp")
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
                      rs.fields(i).value=dspkey(i)
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(2)���۰ʷm�����(max+1)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcmtyADSL/RTCustD.asp")
                     if i=2 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcustADSL where  cusid='" & dspkey(1) & "'"
                        rsc.open sqlstr2,conn
                        if len(rsc("entryno")) > 0 then
                           dspkey(i)=rsc("entryno") + 1
                        else
                           dspkey(i)=1
                        end if
                        rsc.close
                      end if
                      rs.fields(i).value=dspkey(i)         
                 ' ��{�����ȶD��ƺ��@�@�~��,�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcmty/RTFAQD.asp")  
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

                      rs.Fields(i).Value=dspKey(i)
                 ' ��{�����ȶD�B�z���I������,�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcmty/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                   
                 ' ��{�����Ȥ�򥻸�ƺ��@(�~��),�]��dspkey(1)���۰ʷm�����(max+1)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtCUSTTEMP/RTCustD.asp")
                     if i=1 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcusttemp where  cusid='" & dspkey(0) & "'"
                        rsc.open sqlstr2,conn
                        if len(rsc("entryno")) > 0 then
                           dspkey(i)=rsc("entryno") + 1
                        else
                           dspkey(i)=1
                        end if
                        rsc.close
                      end if
                      rs.fields(i).value=dspkey(i)          
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustadsl/RTCustd.asp")
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
                   
                      if i=77 then
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
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustadslBRANCH/RTCustd.asp")
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
                   
                      if i=77 then
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
                 ' ��{�����t��ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(76)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtsparqadslcmty/RTCustd.asp")
                      if i=2 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtsparqadslcust where  cusid='" & dspkey(1) & "'"
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
                        sqlstr2="select max(orderno) AS orderno from rtsparqadslcust where  orderno like '" & area & "%'"
                        rsc.open sqlstr2,conn
                        if len(rsc("orderno")) > 0 then
                           dspkey(i)=area & right("000000" & cstr(cint(mid(rsc("orderno"),2,6)) + 1),6)
                        else
                           dspkey(i)=area & "000001"
                        end if
                        rsc.close
                      end if       
                      
                      rs.Fields(i).Value=dspKey(i)             
                '        response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"             
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~(���ϤU�s�W)��,�]��dspkey(78)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtADSLCMTY/RTCustd.asp")
                      if i=2 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcustadsl where  cusid='" & dspkey(1) & "'"
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

                      if i=78 then
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
                    '  response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"
                      rs.Fields(i).Value=dspKey(i)                                          
                 ' ��{����ADSL�ȶD��ƺ��@�@�~��,�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcustadsl/RTFAQD.asp")  
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
                 ' ��{����ADSL�ȶD��ƺ��@�@�~��(���ϤU),�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtADSLCMTY/RTFAQD.asp")  
                      response.write "AAA"
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
                      rs.Fields(i).Value=dspKey(i)                                                 
                 ' ��{����ADSL�ȶD�B�z���I������,�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcustadsl/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)            
                 ' ��{����ADSL�ȶD�B�z���I������(���ϤU),�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtADSLCMTY/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                
                 ' ��{����ADSL�ȶD�B�z���I������(���ϤU),�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rtcustadslbranch/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                                                      
                 ' ��{����ADSL�Ȥ�(��B�B�W��)�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/singlecustadsl/RTCustd.asp")
                      if i=1 then
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from singlecustadsl where  cusid='" & dspkey(0) & "'"
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
                   
                      if i=77 then
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
                        sqlstr2="select max(orderno) AS orderno from singlecustadsl where  orderno like '" & area & "%'"
                        rsc.open sqlstr2,conn
                        if len(rsc("orderno")) > 0 then
                           dspkey(i)=area & right("000000" & cstr(cint(mid(rsc("orderno"),2,6)) + 1),6)
                        else
                           dspkey(i)=area & "000001"
                        end if
                        rsc.close
                      end if       
                      
                      rs.Fields(i).Value=dspKey(i)    
                 ' ��{����ADSL(��B�B-�W��)�ȶD��ƺ��@�@�~��,�]��dspkey(0)���۰ʷm�����(yymmdd+SEQ)�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/singlecustadsl/RTFAQD.asp")  
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
                      rs.Fields(i).Value=dspKey(i)                        
                 ' ��{�������ݥ�Ĺ,�]��dspkey(2)��IDENTIFY���A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/RTSS365/RTDELIVERCUST/RTTELVISITD.asp")  
                  '    response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"
                      if i<>2 then rs.Fields(i).Value=dspKey(i)                
                 ' ��{����ADSL(��B�B-�W��)�ȶD�B�z���I������,�]��dspkey(1)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/singlecustadsl/RTFaqprocessD.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)               
                 ' ��{����"���ڦ@�ε{����" ,�]��dspkey(3)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/commpgm/cbbncustrcvamt/RTcustrcvamtd.asp")
                     if i<>3 then rs.Fields(i).Value=dspKey(i)                                    
                 ' ��{�������ϭ��j�T�����@��,�]��dspkey(2)��seqno�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/base/rthbadslcmty/RTcmtymsgd.asp")
                     if i<>2 then
                        rs.Fields(i).Value=dspKey(i)     
                     else    
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(entryno) AS entryno from rtcmtymsg where  comq1=" & dspkey(0) & " and kind='" & dspkey(1) & "' " 
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("ENTRYNO"))) > 0 then
                           dspkey(i)=rsc("ENTRYNO") + 1
                        else
                           dspkey(i)=1
                        end if
                        rs.Fields(i).Value=dspKey(i)   
                     end if           
                 case else
                 'response.write "i=" & i & ";dspkey(i)=" & dspkey(i) & "<Br>"
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
                 ' ��{�������ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp")
                     if i<>0 AND I <> 52 and i <> 54 AND i <> 59 then rs.Fields(i).Value=dspKey(i)
                     '���ظm�P�N�ѤΦX���Ѥ��{�s�s���̤j��(�ᤩ�s�s���ɨ�̤��s�����ۦP���G
                     if i=52 or i=54 or i=59 then
                        temp52=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(agreeno) AS agreeno from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("agreeno"))) > 0 then
                           temp52="BA" & right("00000" & cstr(cint(mid(rsc("agreeno"),3,5))+1),5)
                        else
                           temp52="BA00001"
                        end if
                        temp52A=mid(temp52,3,5)
                        '----
                        temp54=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(contractno) AS contractno from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("contractno"))) > 0 then
                           temp54="BB" & right("00000" & cstr(cint(mid(rsc("contractno"),3,5))+1),5)
                        else
                           temp54="BB00001"
                        end if
                        temp54A=mid(temp54,3,5)        
                        '----
                        temp59=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(REMITNO) AS REMITNO from rtcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("REMITNO"))) > 0 then
                           temp59="BC" & right("00000" & cstr(cint(mid(rsc("remitno"),3,5))+1),5)
                        else
                           temp59="BC00001"
                        end if
                        temp59A=mid(temp59,3,5)                                
                     '----                   
                        maxtemp=temp52A
                        if temp54A > maxtemp then maxtemp=temp54A
                        if temp59A > maxtemp then maxtemp=temp59A
                                       
                        if dspkey(51)="Y" AND LEN(TRIM(DSPKEY(52)))=0 then dspkey(52)="BA" & maxtemp
                        if dspkey(53)="Y" AND LEN(TRIM(DSPKEY(54)))=0 then dspkey(54)="BB" & maxtemp
                        if dspkey(58)="Y" AND LEN(TRIM(DSPKEY(59)))=0 then dspkey(59)="BC" & maxtemp                       

                       rs.Fields(i).Value=dspKey(i)
                     end if                                        
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtADSLcmty/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)         
                     '���ظm�P�N�ѤΦX���Ѥ��{�s�s���̤j��(�ᤩ�s�s���ɨ�̤��s�����ۦP���G
                     if i=36 or i=38 or i=43 then
                        temp36=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(agreeno) AS agreeno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("agreeno"))) > 0 then
                           temp36="AA" & right("00000" & cstr(cint(mid(rsc("agreeno"),3,5))+1),5)
                        else
                           temp36="AA00001"
                        end if
                        temp36A=mid(temp36,3,5)
                        '----
                        temp38=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(contractno) AS contractno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("contractno"))) > 0 then
                           temp38="AB" & right("00000" & cstr(cint(mid(rsc("contractno"),3,5))+1),5)
                        else
                           temp38="AB00001"
                        end if
                        temp38A=mid(temp38,3,5)      
                        '----
                        temp43=""
                        Set rsc=Server.CreateObject("ADODB.Recordset")
                        sqlstr2="select max(remitno) AS remitno from rtcustadslcmty "
                        rsc.open sqlstr2,conn
                        if len(trim(rsc("remitno"))) > 0 then
                           temp43="AC" & right("00000" & cstr(cint(mid(rsc("remitno"),3,5))+1),5)
                        else
                           temp43="AC00001"
                        end if
                        temp43A=mid(temp43,3,5)                                
                     '----                   
                       maxtemp=temp36A
                       if temp38A > maxtemp then maxtemp=temp38A
                       if temp43A > maxtemp then maxtemp=temp43A
                                       
                       if dspkey(35)="Y" AND LEN(TRIM(DSPKEY(36)))=0 then dspkey(36)="AA" & maxtemp
                       if dspkey(37)="Y" AND LEN(TRIM(DSPKEY(38)))=0 then dspkey(38)="AB" & maxtemp
                       if dspkey(42)="Y" AND LEN(TRIM(DSPKEY(43)))=0 then dspkey(43)="AC" & maxtemp       
                       rs.Fields(i).Value=dspKey(i)
                     end if                                                     
                 ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmtyADSL/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)            
                 ' ��{�����t��ADSL���ϰ򥻸�ƺ��@�@�~��,�]��dspkey(0)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtsparqADSLcmty/RTCmtyd.asp")
                     if i<>0 then rs.Fields(i).Value=dspKey(i)                                       
                 ' ��{�����ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcmty/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)               
                 ' ��{����adsl�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtadslcmty/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                           
                 ' ��{����adsl�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustadslbranch/RTfaqprocessd.asp")
                     if i<>1 then rs.Fields(i).Value=dspKey(i)                                                   
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSL/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)  
                 ' ��{����ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSLBRANCH/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
                     response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)        
                 ' ��{�����t��ADSL�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtsparqADSLcust/RTcustd.asp")
                     'if i<>76 then rs.Fields(i).Value=dspKey(i)  
                     'response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)                                             
                 ' ��{����ADSL(��B�B-�W��)�Ȥ�򥻸�ƺ��@�@�~��,�]��dspkey(77)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/base/rtcustADSL/RTcustd.asp")
                     'if i<>77 then rs.Fields(i).Value=dspKey(i)  
               '      response.write "I=" & i & ";VALUE=" & dspkey(i) & "<BR>"
                     rs.Fields(i).Value=dspKey(i)     
               ' ��{�������ݥ�Ĺ��ƺ��@�@�~��,�]��dspkey(2)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
                 case ucase("/webap/rtap/RTSS365/rtDELIVERCUST/RTTELVISITD.asp")
                     if i<>2 then rs.Fields(i).Value=dspKey(i)                
               ' ��{����"���ڦ@�ε{����" ,�]��dspkey(3)��identify�A�G���h�J�ȡ]�ѵ{�������)   
                 case ucase("/webap/rtap/commpgm/cbbncustrcvamt/RTcustrcvamtd.asp")
                     if i<>3 then rs.Fields(i).Value=dspKey(i)                        
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
    ' ��{����HB���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
    runpgm=Request.ServerVariables("PATH_INFO")
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcmty/RTCmtyd.asp") then
       rs.open "select max(comq1) AS comq1 from rtcmty",conn
       if not rs.eof then
          dspkey(0)=rs("comq1")
       end if
       rs.close
    end if
    ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
        'response.write "accessmode=" & accessmode &";sw=" & sw & "<BR>"
    if accessmode ="A" then
       runpgm=Request.ServerVariables("PATH_INFO")
       if ucase(runpgm)=ucase("/webap/rtap/base/rtADSLcmty/RTCmtyd.asp") then
          rs.open "select max(CUTYID) AS cutyid from rtCUSTADSLcmty",conn
          if not rs.eof then
             dspkey(0)=rs("CUTYID")
          end if
          rs.close
       end if
    end if    
    ' ��{����ADSL���ϰ򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(0)Ū�X�ܵe��
    runpgm=Request.ServerVariables("PATH_INFO")
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcmtyADSL/RTCmtyd.asp") then
       rs.open "select max(comq1) AS comq1 from rtcmtyADSL",conn
       if not rs.eof then
          dspkey(0)=rs("comq1")
       end if
       rs.close
    end if    
   ' ��{�����ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcmty/RTfaqprocessd.asp") then
       rs.open "select max(entryno) AS entryno from rtfaqd1",conn
       if not rs.eof then
          dspkey(1)=rs("entryno")
       end if
       rs.close
    end if    
   ' ��{����ADSL�ȶD�B�z���I������,�]��dspkey(1)��identify���A�G���h�J�ȡ]��sql�ۦ沣��)
    if ucase(runpgm)=ucase("/webap/rtap/base/rtcustadslbranch/RTfaqprocessd.asp") then
       rs.open "select max(entryno) AS entryno from rtfaqd1",conn
       if not rs.eof then
          dspkey(1)=rs("entryno")
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
    ' ��{����adsl�Ȥ�򥻸�ƺ��@�@�~��,�Nsql�ۦ沣�ͤ�identify��dspkey(77)Ū�X�ܵe��
   ' runpgm=Request.ServerVariables("PATH_INFO")
   ' if ucase(runpgm)=ucase("/webap/rtap/base/rtcustadsl/RTCustd.asp") then
   '    rs.open "select max(orderno) AS orderno from rtcustadsl",conn
   '    if not rs.eof then
   '       dspkey(77)=rs("orderno")
   '    end if
   '    rs.close
   ' end if    
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
<input type="text" name="sw" value="<%=sw%>" style="display:none;" ID="Text1">
<input type="text" name="reNew" value="N" style="display:none;" ID="Text2">
<input type="text" name="rwCnt" value="<%=rwCnt%>" style="display:none;" ID="Text3">
<input type="text" name="accessMode" value="<%=accessMode%>" style="display:none;" ID="Text4">
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
<!-- #include virtual="/Webap/include/employeeref.inc" -->

<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=1
  title="�����Ӱ򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CUSID,TEL,FAX,email,RURL,STAFFCNT,boss," _
             &"eusr,edat,uusr,udat,CONT,CONTTEL " _
             &"FROM RTprovider WHERE cusid='*' "
  sqlList="SELECT CUSID,TEL,FAX,email,RURL,STAFFCNt,boss," _
             &"eusr,edat,uusr,udat,CONT,CONTTEL " _
             &"FROM RTprovider WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  userDefineSave="Yes"  
  userdefineactivex="Yes"  
  extDBField=15
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(trim(dspkey(5))) = 0 then dspkey(5)=0
    If len(trim(dspKey(0))) < 1 Then
       formValid=False
       message="�п�J�����Ӳνs"
    elseif len(trim(extdb(0))) < 1 Then
       formValid=False
       message="�п�J�����ӦW��"
    elseif len(trim(extdb(1))) < 1 Then
       formValid=False
       message="�п�J������²��"
    elseif not IsNumeric(dspkey(5))  Then
       formValid=False
       message="���q�H�Ƥ����T"
    End If        
End Sub
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
   Sub Srcounty3onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("ext2").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("ext3").value =  trim(Fusrid(0))
          document.all("ext5").value =  trim(Fusrid(1))
       End if       
       end if   
   End Sub           
   Sub Srcounty7onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("ext6").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("ext7").value =  trim(Fusrid(0))
          document.all("ext9").value =  trim(Fusrid(1))
       End if       
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
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="21%" class=dataListHead>�����Ӳνs</td><td width="79%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0" <%=keyprotect%> size="10" 
           value="<%=dspKey(0)%>" maxlength="8" ></td>
       </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(7))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(7)=V(0)
                extdb(10)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(7))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(8)=datevalue(now())
       extdb(11)=datevalue(now())
    else
        if len(trim(dspkey(9))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(9)=V(0)
                extdb(12)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(9))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(7))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(10)=datevalue(now())
        extdb(13)=datevalue(now())
    end if

'-----EXTDB DATA RETRIVE
DIM conn,rs,dsn,sql
SET conn=server.CreateObject("ADODB.Connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
SQL="SELECT CUSNC,SHORTNC,CUTID1,TOWNSHIP1,RADDR1,RZONE1,CUTID2," _ 
   &"TOWNSHIP2,RADDR2,RZONE2,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobj where CUSID ='" & dspkey(0) & "'"
conn.Open dsn
rs.Open sql,conn
if not rs.EOF then
   If sw="E" Or (accessMode="A" And sw="") Then 
      if sw="E" then extdb(13)=datevalue(now())
      if sw="" and accessMode="A" then extdb(11)=datevalue(now())
   else
      extdb(0)=rs("cusnc")
      extdb(1)=rs("shortnc")
      extdb(2)=rs("cutid1")
      extdb(3)=rs("township1")
      extdb(4)=rs("raddr1")
      extdb(5)=rs("rzone1")
      extdb(6)=rs("cutid2")
      extdb(7)=rs("township2")
      extdb(8)=rs("raddr2")
      extdb(9)=rs("rzone2")
      extdb(10)=rs("eusr")
      if len(trim(rs("edat"))) > 0 then extdb(11)=datevalue(rs("edat"))
      extdb(12)=rs("uusr")
      if len(trim(rs("udat"))) > 0 then extdb(13)=datevalue(rs("udat")) 
   end if
else
end if
rs.close
%>
<table border="1" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���q�W��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="ext0" <%=dataprotect%> maxlength=50 size=40 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(0)%>"></td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">²��</font></td>
    <td width="20%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="ext1" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(1)%>"></td>
    �@</td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���q�q��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key1"  <%=dataprotect%> maxlength=15 size=15 style="TEXT-ALIGN: left" value
            ="<%=dspkey(1)%>">�@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�ǯu�q��</font></td>
    <td width="20%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key2" <%=dataprotect%> maxlength=15 size=15 style="TEXT-ALIGN: left" value
            ="<%=dspkey(2)%>">�@</td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���q���}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="key4" <%=dataprotect%> maxlength=30 size=30 style="TEXT-ALIGN: left" value
            ="<%=dspkey(4)%>">�@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�q�l�l��</font></td>
    <td width="20%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key3" <%=dataprotect%> maxlength=30 size=25 style="TEXT-ALIGN: left" value
            ="<%=dspkey(3)%>">�@</td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�t�d�H</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key6" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(6)%>">
    �@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���q�H��</font>�@</td>
    <td width="20%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="key5" <%=dataprotect%> maxlength=5 size=5 style="TEXT-ALIGN: left" value
            ="<%=dspkey(5)%>">�@</td>
  </tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�p���H��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key11" <%=dataprotect%> maxlength=12 size=12 style="TEXT-ALIGN: left" value
            ="<%=dspkey(11)%>">
    �@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�p���q��</font>�@</td>
    <td width="20%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="key12" <%=dataprotect%> maxlength=15 size=15 style="TEXT-ALIGN: left" value
            ="<%=dspkey(12)%>">�@</td>
  </tr>  
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���q�a�}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(extDB(2))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty3onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & extdb(2) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(2) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="ext2"<%=dataProtect%> size="1" class="dataListEntry" ID="Select1"><%=s%></select>
        <input type="text" name="ext3" size="8" value="<%=extDB(3)%>" maxlength="10" readonly <%=dataProtect%> class="dataListEntry" ID="Text5"><font size=2>(�m��)                 
         <input type="button" id="B3"  name="B3"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX3%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C3"  name="C3"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="ext4" size="30" value="<%=extDB(4)%>" maxlength="60" <%=dataProtect%> class="dataListEntry" ID="Text6"></td>                                 
        <td width="10%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="20%" height="25" bgcolor="silver"><input type="text" name="ext5" size="10" value="<%=EXTDB(5)%>" maxlength="5" <%=dataProtect%> class="dataListdata" readonly ID="Text7"></td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">�q�T�a�}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(extDB(6))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX7=" onclick=""Srcounty7onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & extdb(6) & "' " 
       SXX7=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(6) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="ext6"<%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>
        <input type="text" name="ext7" size="8" value="<%=extDB(7)%>" maxlength="10" readonly <%=dataProtect%> class="dataListEntry" ID="Text8"><font size=2>(�m��)                 
         <input type="button" id="B7"  name="B7"   width="100%" style="Z-INDEX: 1"  value="..." <%=SXX7%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="Img1"  name="C3"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="ext8" size="30" value="<%=extDB(8)%>" maxlength="60" <%=dataProtect%> class="dataListEntry" ID="Text9"></td>                                 
        <td width="10%" class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td width="20%" height="25" bgcolor="silver"><input type="text" name="ext9" size="10" value="<%=EXTDB(9)%>" maxlength="5" <%=dataProtect%> class="dataListdata" readonly ID="Text10"></td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">��J�H��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key7" <%=dataprotect%> maxlength=6 size=6 style="TEXT-ALIGN:  left" 
     value="<%=dspkey(7)%>" readOnly><%=EusrNc%>�@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">��J���</font></td>
    <td width="20%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key8"  maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(8)%>"  readOnly>�@</td>
  </tr>
  <tr>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���ʤH��</font></td>
    <td width="35%" bgcolor="#C0C0C0">
    <input class=dataListEntry  name="key9" readOnly size=6 maxlength=6 style="TEXT-ALIGN: left "
            value="<%=dspkey(9)%>"><%=UUsrNC%>�@</td>
    <td width="10%" bgcolor="#008080"><font color="#FFFFFF">���ʤ��</font></td>
    <td width="20%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key10" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(10)%>" readOnly>�@</td>
    <input class=dataListEntry name="ext10" maxlength=6 size=6    
            style="TEXT-ALIGN: left" value="<%=extdb(10)%>" style="display:none">
    <input class=dataListEntry name="ext11" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=extdb(11)%>" style="display:none">  
    <input class=dataListEntry name="ext12" maxlength=6 size=6    
            style="TEXT-ALIGN: left" value="<%=extdb(12)%>" style="display:none">  
      <input class=dataListEntry name="ext13" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=extdb(13)%>" style="display:none">
  </tr>
</table>
<% conn.close
   set rs=nothing
   set conn=nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'--------------SAVE RTOBJ FILE
DIM conn,rs,dsn,sql
SET conn=server.CreateObject("ADODB.Connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
SQL="SELECT cusid,CUSNC,SHORTNC,CUTID1,TOWNSHIP1,RADDR1,RZONE1,CUTID2," _ 
   &"TOWNSHIP2,RADDR2,RZONE2,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobj where CUSID ='" & dspkey(0) & "'"
conn.Open dsn
rs.Open sql,conn,3,3
if not rs.EOF then  
   '--�ѩ��H�򥻸���ɫY�@�θ��,���קK��Ʀ]���o�ϥΪ̿�J�ɭP���lose
   '--�{�H;�G�P�_��ϥΪ̦���J��ƮɦA���N�쥻���
   '===========
   '--?????�O�_�|�y�����N��ƲM��,�o�S�L�k���N���{�H�o��??????
   '+++�A�Ҽ{
   rs("cusnc")    =extdb(0)
   rs("shortnc")  =extdb(1)
   rs("cutid1")   =extdb(2)
   rs("township1")=extdb(3)
   rs("raddr1")   =extdb(4)
   rs("rzone1")   =extdb(5)
   rs("cutid2")   =extdb(6)
   rs("township2")=extdb(7)
   rs("raddr2")   =extdb(8)
   rs("rzone2")   =extdb(9)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
else
   rs.addnew
   rs("cusid")    =dspkey(0)
   rs("cusnc")    =extdb(0)
   rs("shortnc")  =extdb(1)
   rs("cutid1")   =extdb(2)
   rs("township1")=extdb(3)
   rs("raddr1")   =extdb(4)
   rs("rzone1")   =extdb(5)
   rs("cutid2")   =extdb(6)
   rs("township2")=extdb(7)
   rs("raddr2")   =extdb(8)
   rs("rzone2")   =extdb(9)
   rs("eusr")     =dspkey(7)
   rs("edat")     =dspkey(8)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
end if
rs.close
'-----save RTOBJLINK
SQL="SELECT cusid,custyid,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobjLink where CUSID ='" & dspkey(0) & "' and custyid='03' " 
rs.Open sql,conn,3,3
if not rs.EOF then
   rs("eusr")     =dspkey(7)
   rs("edat")     =dspkey(8)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
else
   rs.addnew
   rs("cusid")    =dspkey(0)
   rs("custyid")  ="03"  
   rs("eusr")     =dspkey(7)
   rs("edat")     =dspkey(8)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
end if     
rs.close
conn.close
set rs=nothing
set conn=nothing
objectcontext.setcomplete
End Sub
' -------------------------------------------------------------------------------------------- 
%>
