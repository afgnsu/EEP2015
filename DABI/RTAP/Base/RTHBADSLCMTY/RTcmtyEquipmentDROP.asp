<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
   endpgm="1"
   sqlxx="select * FROM RTCMTYEquipment WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and connecttype='" & key(2) & "' and seq=" & key(3)
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '�w�@�o
   IF LEN(TRIM(RSXX("canceldat"))) <> 0 THEN
      ENDPGM="3"
   ELSE
      sqlyy="select max(entryno) as entryno FROM RTCMTYEquipmentlog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and connecttype='" & key(2) & "' and seq=" & key(3)
      rsyy.Open sqlyy,connxx
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTCMTYEquipmentlog " _
           &"SELECT  COMQ1, LINEQ1, connecttype, seq," & entryno & ", GETDATE(),'D','" & V(0) & "', PRODNO, ITEMNO,unit, QTY, assetno,canceldat " _
           &"FROM RTCMTYEquipment where comq1=" & key(0) & " and lineq1=" & key(1) & " and connecttype='" & key(2) & "' AND seq=" & KEY(3)
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTCMTYEquipment set canceldat=getdate() where comq1=" & KEY(0) & " and lineq1=" & key(1) & " and connecttype='" & key(2) & "' and seq=" & key(3)
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTCMTYEquipmentlog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and connecttype='" & key(2) & "' and seq=" & key(3) & " AND entryno=" & entryno
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
       end if
     END IF
   RSXX.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�]�Ƹ�Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����]�Ƥw�@�o�A���i���Ч@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k����]�Ƹ�Ƨ@�o,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtyhardwaredrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>