<!-- #include virtual="/WebUtilityV3/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLIB"
  numberOfKey=1
  title="��H���O��ƺ��@"
  formatName="���O�N�X;���O�W��;��J�H��;��J���;���ʤH��;���ʤ��"
  sqlFormatDB="SELECT CUSTYID,CUSTN,eusr,edat,uusr,udat FROM rtobjKind WHERE CUSTYID='*' ;"
  sqlList="SELECT CUSTYID,CUSTN,eusr,edat,uusr,udat " _
         &"FROM rtobjKind WHERE "
  userDefineData="Yes"
  userDefineKey="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'RECORD CHECK
    set conn=server.CreateObject("ADODB.connection")
    set rs=server.CreateObject("ADODB.recordset")
    DSN="DSN=Rtlib"
    sql="select * from rtobjKind where CUSTYID='" & dspkey(0) & "'"
    conn.Open dsn
    rs.Open sql,dsn,1,1
    if not rs.EOF and dspmode = "�s�W" then
       formvalid=False
       message="��ƭ���"
    end if
    rs.Close
    conn.Close
    set rs=nothing
    set conn=nothing    
'DATA CHECK    
    If dspKey(0)="" Then
       formValid=False
       message="�п�J���O�N�X"
    End If
    If dspKey(1)="" Then
       formValid=False
       message="�п�J���O�W��"
    End If
    'If dspKey(2)="" Then
    '   formValid=False
    '   message="�п�J�Ұ����O"
    'End If
End Sub

Sub SrGetUserDefineData()
'Get Employee Name and EmployID   
'-----------------------------------------------------------------
' OPT=1:��(logon user)Ū�����u�������
' OPT=2:��(�u��)Ū���������
'-----------------------------------------------------------------
' V(0)=Emply(�u��)
' V(1)=cusnc(��H�W��)
' V(2)=shortnc(��H²��)
'-----------------------------------------------------------------
    'Select case dspkey(2)
    ' case "1"
    '   status1="Checked"
    ' case "2"
    '   status2="Checked"
    ' case else
    '   status1=""
    '   status2=""
    'End Select
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(2))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(2)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(2))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(3)=datevalue(now())
    else
        if len(trim(dspkey(4))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(4)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(4))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(2))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(5)=datevalue(now())    
    end if
%>   
     <table border=1 cellPadding=0 cellSpacing=0 width="100%" align=center>
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(1)%></td>
     <td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key1" maxlength=12 size=12 style="TEXT-ALIGN:left" 
     value="<%=dspkey(1)%>">
     </td>
     </tr>
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(2)%></td>
     <!--
     <td width="65%" bgcolor=silver>
     <INPUT id=radio1 <%=status1%> name=key2 type=radio value="1">�~���Ұ�<INPUT id=radio2 name=key2 
      type=radio value="2" <%=status2%>>�I�u�Ұ�</td>
      </tr> 
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(3)%></td>
     -->
     <td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key2" maxlength=20 style="TEXT-ALIGN:  left"  value="<%=dspkey(2)%>" readOnly><%=EusrNc%></td>
     </tr>
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(3)%></td>
     <td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key3" maxlength=10 size=10 style="TEXT-ALIGN: left" value="<%=dspkey(3)%>" readOnly></td>
     </tr> 
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(4)%></td>
     <td width="65%" bgcolor=silver>
     <input class=dataListEntry  name="key4" maxlength=20 style="TEXT-ALIGN: left; dataProtect: "
            value="<%=dspkey(4)%>" readOnly><%=UUsrNC%></td>
     </tr>    
     <tr>
     <td width="35%" class=dataListHead><%=aryKeyName(5)%></td>
     <td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key5" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(5)%>" readOnly></td>
     </tr>
     </table>
     </TABLE>

<%End Sub%>

<%Sub SrGetUserDefineKey() %>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="35%" class=dataListHead>���O�N�X</td><td width="65%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0"
                 <%=keyProtect%> size="2" value="<%=dspKey(0)%>" maxlength="2"></td></tr>
      </table>
<%End Sub%>

