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
 '  On Error Resume Next
   '����ݬ��u��w�p��w�s��A���i�@�o��(stockcloseym<>'')
   sqlxx="select * FROM RTSPARQADSLCMTYsndwork WHERE CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' "
   rsxx.Open sqlxx,connxx
   STOCKCLOSE=rsxx("stockcloseym")
   RSXX.CLOSE
   if STOCKCLOSE <> "" then
     endpgm="4"
   else
     sqlxx="select * FROM RTSPARQADSLCMTYhardware WHERE CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' and entryno=" & key(2)
     RSXX.OPEN SQLXX,CONNxx
     endpgm="1"
     '�w�@�o
     IF LEN(TRIM(RSXX("dropdat"))) <> 0 THEN
      ENDPGM="3"
     ELSE
      sqlyy="select max(seq) as seq FROM RTSPARQADSLCMTYhardwarelog WHERE CUTYID=" & KEY(0)  & " and prtno='" & key(1) & "' and entryno=" & key(2)
      rsyy.Open sqlyy,connxx
      if len(trim(rsyy("seq"))) > 0 then
         seq=rsyy("seq") + 1
      else
         seq=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTSPARQADSLCMTYhardwarelog " _
           &"SELECT  CUTYID, PRTNO, ENTRYNO," & SEQ & ", GETDATE(),'D','" & V(0) & "', PRODNO, ITEMNO, QTY, DROPDAT, '�]�Ƨ@�o', WAREHOUSE, ASSETNO,DROPUSR, UNIT " _
           &"FROM RTSPARQADSLCMTYHARDWARE where CUTYID=" & key(0)  & " and prtno='" & key(1) & "' AND ENTRYNO=" & KEY(2)
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTSPARQADSLCMTYHARDWARE set dropdat=getdate(),dropREASON='�]�Ƨ@�o' where CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' and entryno=" & key(2)
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTSPARQADSLCMTYhardwarelog WHERE CUTYID=" & key(0)  & " and prtno='" & key(1) & "' and entryno=" & key(2) & " AND seq=" & seq
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
       end if
     END IF
   end if
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
       msgbox "�]�Ʀw�˸�Ƨ@�o���\",0
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
    elseIF frm1.htmlfld.value="4" then
       msgbox "���ݬ��u��w����w�s�p��@�~�A���i�@�o�]�Ʃ���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k����]�Ʀw�˸�Ƨ@�o,���~�T���G" & "  " & frm1.htmlfld1.value
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