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
   SET RSZZ=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM hbcmtyarrangehardware WHERE comq1=" & KEY(0) & " and comtype='" & key(1)  & "' and prtno='" & key(2) & "' and entryno=" & key(3) 
   sqlZZ="select * FROM hbcmtyarrangeSNDWORK WHERE comq1=" & KEY(0) & " and comtype='" & key(1)  & "' and prtno='" & key(2) & "' "

   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   RSZZ.OPEN SQLZZ,CONNxx
   endpgm="1"
   '��]�Ʃ��ө|���@�o�ɡA���i�@�o����
   IF ISNULL(RSXX("DROPDAT"))  THEN
      ENDPGM="3"
   '���u��w���׮ɡA���i����]�Ʃ��ӧ@�o����
   elseif LEN(TRIM(RSZZ("CLOSEDAT"))) > 0 then
      endpgm="6"
   '���u��w�@�o�ɡA���i����]�Ʃ��ӧ@�o����
   elseif LEN(TRIM(RSZZ("DROPDAT"))) > 0 then
      endpgm="4"      
   '������p��ήw�s�p�⤣���ťաA���i����@�o����
   elseif LEN(TRIM(RSZZ("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSZZ("STOCKCLOSEYM"))) <> 0 then
      endpgm="5"
   ELSE
      sqlyy="select max(seq) as seq FROM hbcmtyarrangehardwarelog WHERE comq1=" & KEY(0) & " and comtype='" & key(1) & "'  and prtno='" & key(2) & "'  and entryno=" & key(3) 
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("seq"))) > 0 then
         seq=rsyy("seq") + 1
      else
         seq=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into hbcmtyarrangehardwarelog " _
           &"SELECT  COMQ1, COMTYPE, PRTNO, ENTRYNO, " & SEQ & ", getdate(), 'R', '" & V(0) & "', PRODNO, ITEMNO, QTY, DROPDAT, DROPREASON, WAREHOUSE, ASSETNO,  DROPUSR, UNIT, EUSR, EDAT, UUSR, UDAT " _
           &" FROM hbcmtyarrangehardware where comq1=" & key(0) & " and comtype='" & key(1) & "' and prtno='" & key(2) & "'  and entryno=" & key(3) 
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update hbcmtyarrangehardware set DROPdat=NULL,DROPUSR='' where comq1=" & KEY(0) & " and comtype='" & key(1)  & "' and prtno='" & key(2) & "'  and entryno=" & key(3) 
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM hbcmtyarrangehardwarelog WHERE comq1=" & key(0) & " and comtype='" & key(1) & "' and prtno='" & key(2) & "' AND ENTRYNO=" & dspkey(3) & " and seq=" & seq
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
      end if
   END IF
   RSXX.CLOSE
   RSZZ.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "��u���u��]�Ʃ��ӧ@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��]�Ƹ�Ʃ|���@�o�ɡA���i�@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="6" then
       msgbox "����u���u��w���u���סA�]�Ʃ��Ӥ��i�@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "����u���u��w�뵲�A�]�Ʃ��Ӥ��i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="4" then
       msgbox "����u���u��w�@�o�A�]�Ʃ��Ӥ��i�@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    else
       msgbox "�L�k�����u���u��]�Ƨ@�o����@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylinesndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>