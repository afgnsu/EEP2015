<!-- #include virtual="/WebUtilityV3/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLIB"
  numberOfKey=1
  title="�~���Ұϸ�ƺ��@"
  formatName="�ҰϥN�X;�ҰϦW��;�Ұ����O;��J�H��;��J���;���ʤH��;���ʤ��"
  sqlFormatDB="SELECT areaid,areanc,areatype,eusr,edat,uusr,udat FROM rtarea WHERE rtarea.areatype='1' and rtarea.areaid='*' ;"
  sqlList="SELECT areaid,areanc,areatype,eusr,edat,uusr,udat " _
         &"FROM rtarea WHERE areatype='1' and "
  userDefineData="Yes"
  userDefineKey="Yes"
  datatable="rtarea"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'RECORD CHECK
    set conn=server.CreateObject("ADODB.connection")
    set rs=server.CreateObject("ADODB.recordset")
    DSN="DSN=Rtlib"
    sql="select * from rtarea where areaid='" & dspkey(0) & "'"
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
       message="�п�J�ҰϥN�X"
    End If
    If dspKey(1)="" Then
       formValid=False
       message="�п�J�ҰϦW��"
    End If
    If dspKey(2)="" Then
       formValid=False
       message="�п�J�Ұ����O"
    End If
End Sub

Sub SrGetUserDefineKey() 
if  accessmode="U" then
   s=FrGetAreaDesc(dspkey(0))
end if%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="35%" class=dataListHead>�ҰϥN�X</td><td width="65%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0"
                 <%=keyProtect%> size="2" value="<%=dspKey(0)%>" maxlength="2"></td></tr>
      </table>
<%End Sub

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
    
'    Select case dspkey(2)
'     case "1"
'       status1="Checked"
'     case "2"
'       status2="Checked"
'     case else
'       status1="Checked"
'       status2=""
'    End Select
    if dspkey(2)="1" then status1="checked"
    if dspmode="�s�W" then status1="checked"
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(3))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(3)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(3))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(4)=datevalue(now())
    else
        if len(trim(dspkey(5))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(5)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(5))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(3))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(6)=datevalue(now())    
    end if
%>   
     <table border=1 cellPadding=0 cellSpacing=0 width="100%" align=center>
     <tr><td width="35%" class=dataListHead><%=aryKeyName(1)%></td>
     <td width="65%" bgcolor=silver><input class=dataListEntry name="key1" <%=dataprotect%> maxlength=12 size=12 style="TEXT-ALIGN:left" 
     value="<%=dspkey(1)%>"></td></tr>
     <tr><td width="35%" class=dataListHead><%=aryKeyName(2)%></td><td width="65%" bgcolor=silver><INPUT id=radio1 <%=status1%> name=key2  readonly type=radio value="1">�~���Ұ�</tr> 
     <tr><td width="35%" class=dataListHead><%=aryKeyName(3)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key3" maxlength=20 style="TEXT-ALIGN:  left"  value="<%=dspkey(3)%>" readOnly><%=EusrNc%></td></tr>
     <tr><td width="35%" class=dataListHead><%=aryKeyName(4)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key4" maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(4)%>" 
  readOnly></td></tr>   
     <tr><td width="35%" class=dataListHead><%=aryKeyName(5)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry  name="key5" readOnly maxlength=20 style="TEXT-ALIGN: left "
            value="<%=dspkey(5)%>"><%=UUsrNC%></td></tr>    
     <tr><td width="35%" class=dataListHead><%=aryKeyName(6)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key6" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(6)%>" readOnly></td></tr></table></TABLE>

<%End Sub%>

<!-- #include file="RTGetAreaDesc.inc" -->