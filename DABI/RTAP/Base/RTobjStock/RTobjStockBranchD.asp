<!-- #include virtual="/WebUtilityV3/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=2
  title="�Ҩ餽�q����򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CUSID,BRANCH,EUSR,EDAT,UUSR,UDAT FROM rtbranch WHERE cusid='*' "
  sqlList="SELECT * FROM RTBranch WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=0
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    If len(trim(dspKey(0))) < 1 Then
       formValid=False
       message="�п�J�Ҩ餽�q�N�X"
    End If
    If len(trim(dspKey(1))) < 1 Then
       formValid=False
       message="�п�J����W��"
    End If
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()
s=FrGetStockDesc(aryParmKey(0))%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="30%" class=dataListHead>�Ҩ餽�q�N�X</td><td width="30%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0"
                 readonly size="10" value="<%=dspKey(0)%>" maxlength="10" ></td>
           <td width="30%" class=dataListHead>����W��</td><td width="30%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key1" <%=keyprotect%> size="12"
                 value="<%=dspKey(1)%>" maxlength="12" ></td>
       </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
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
     <tr><td width="35%" class=dataListHead>��J�H��</td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key2" maxlength=6 size=6 style="TEXT-ALIGN:  left"  value="<%=dspkey(2)%>" readOnly><%=EusrNc%></td></tr>
     <tr><td width="35%" class=dataListHead>��J���</td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key3" maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=datevalue(dspkey(3))%>" 
  readOnly></td></tr>   
     <tr><td width="35%" class=dataListHead>���ʤH��</td><td width="65%" bgcolor=silver>
     <input class=dataListEntry  name="key4" readOnly maxlength=6 size=6 style="TEXT-ALIGN: left "
            value="<%=dspkey(4)%>"><%=UUsrNC%></td></tr>    
     <tr><td width="35%" class=dataListHead>���ʤ��</td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key5" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(5)%>" readOnly></td></tr></table></TABLE>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include file="RTGetStockDesc.inc" -->