<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select Version,sdate,edate from RTSalesGroupRef where " _
      &"version=(select MAX(version) FROM RTSalesGroupRef WHERE areaid='" & aryparmkey(0) & "' and groupid='" & aryparmkey(1) & "' and emply='" & aryparmkey(2) & "')"
   conn.Open DSN
   rs.Open sql,conn,3,3
   '-----��R���������p���ɮפ����Ұ�/�էO/�~�ȭ����̤j������=>��ܤ����̷s�����ʬ����A�G����i�R��
   If len(trim(rs("version"))) > 0 or rs("version")=0 then
      MAXNO=rs("version")
      '----�����ӵ����ʤ��_��������~�פΤ��(�����ˬd�뵲�����ɪ����--�Y�I����edate is null��ܸӵ���ƥثe���ͮĤ��A�H�t�Τ�����I���)
      if not IsNull(rs("SDATE")) then
         SYY=datepart("yyyy",rs("SDate"))
         SMM=right("0" & datepart("m",rs("Sdate")),2)
         SYYMM=SYY & SMM
      else
         SYY=0
         SMM=0
      End if
      if not IsNull(rs("EDATE")) then
         EYY=datepart("yyyy",rs("EDate"))
         EMM=right("0" & datepart("m",rs("Edate")),2)
         EYYMM=EYY & EMM
      else
         EYY=right("0" & datepart("yyyy",now()),2)
         EMM=right("0" & datepart("m",now()),2)
         EYYMM=EYY & EMM
      End if
      '------------
      if cstr(aryparmkey(3)) < cstr(maxno) then
         errmsg=maxno
         endpgm="2"
      else
         '----�ˬd�Ӫ�����ͮĤ���ܺI�������A�O�_�����뵲�O��(�H�ҰϤΦ~�פ���ܤ뵲������Ū���뵲����)
         Set rs2=server.CreateObject("ADODB.Recordset")
         sql2="SELECT COUNT(*) AS CNT FROM RTClosingCTl " _
             &"WHERE LTRIM(STR(cyy)) + RIGHT('0' + LTRIM(STR(cmm)), 2) >= '" & Syymm & "' AND " _
             &"LTRIM(STR(cyy)) + RIGHT('0' + LTRIM(STR(cmm)), 2) <= '" & EYYMM & "' AND closing = 'Y' "
         rs2.Open sql2,conn           
         '---�ӵ����ʸ�Ƥ��w���뵲�O���ɡA���i�R��
         if rs2("cnt") > 0 then
            endpgm="3"
         '---���`�A�R�����]�ͮĤ�ܺI��餤�L�뵲�O���^
         else
            endpgm="1"
         end if
         rs2.close
         set rs2=nothing
       end if
    end if
    rs.close
    set rs=nothing    
    '----�R�����
    if endpgm="1" then
       sql="delete  from  RTSalesGroupRef where areaid='" & aryparmkey(0) & "' and groupid='" & aryparmkey(1) & "' and " _
          &"emply='" & aryparmkey(2) & "' and version=" & aryparmkey(3)
       conn.Execute sql 
    end if
    conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�~�ȲէO�P�~�ȭ����Y��Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    elseif frm1.htmlfld.value="2" then 
        msgbox "���~�ȭ��w���̷s�����ʪ���(������:'" & frm1.htmlfld1.value & "')" & "�бq�̪�@�����ʧR��" 
    elseif frm1.htmlfld.value="3" then 
       msgbox "�Ӳ��ʪ������ͮĤ���ܺI�������A�w����뵲�B�z�A�G���i�R��" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTFaqDropK.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>