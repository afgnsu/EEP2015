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
 '  On Error Resume Next
   sqlxx="select * FROM RTSPARQADSLCMTYSNDWORK WHERE CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��˾������餣���ťծɡA��ܥD�u���u��w���סA���i�@�o
   IF LEN(TRIM(RSXX("closeDAT"))) <> 0 OR LEN(TRIM(RSXX("UncloseDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("dropdat"))) <> 0 then
      endpgm="4"
   ELSE
      sqlyy="select max(entryno) as entryno FROM RTSPARQADSLCMTYSNDWORKLOG WHERE CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTSPARQADSLCMTYSNDWORKLOG " _
           &"SELECT   CUTYID, PRTNO, " & ENTRYNO & ", getdate(), 'C','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, " _
           &"ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, " _
           &"ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3, " _
           &"REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT,'�D�u���u��@�o', " _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, " _
           &"PRTDAT,EUSR,EDAT,UUSR,UDAT,CLOSEUSR,DROPUSR,UNCLOSEDAT,FINISHDAT " _
           &"FROM RTSPARQADSLCMTYSNDWORK where CUTYID=" & key(0) & " and prtno='" & key(1) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTSPARQADSLCMTYSNDWORK set dropdat=getdate(),dropdesc='�D�u���u��@�o' where CUTYID=" & KEY(0) & " and prtno='" & key(1) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTSPARQADSLCMTYSNDWORKlog WHERE CUTYID=" & key(0)  & " and prtno='" & key(1) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
      end if
   END IF
   IF ENDPGM="1" THEN
      FROMEMAIL="MIS@CBBN.COM.TW"
      Set jmail = Server.CreateObject("Jmail.Message")
      jmail.charset="BIG5"
      jmail.from = "MIS@cbbn.com.tw"
      Jmail.fromname="�t��Sparq*�t�γq��"
      jmail.Subject = "ADSL�D�u���u��J" & KEY(1) & "�A�@�o�q��"
      jmail.priority = 1  
      body="<html><body><table border=1 width=""50%""><tr><td colspan=2>" _
      &"<H3 align=center>�t��ADSL�D�u���u��@�o�q��</h3></td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ϥD�u�Ǹ�</td><td bgcolor=pink align=left>" &KEY(0) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���u�渹</td><td bgcolor=pink align=left>" &KEY(1) &"</td></tr>" _
      &"</table></body></html>"     
      jmail.HTMLBody = BODY
      'JMail.AddRecipient "anita@cbbn.com.tw","�t���`���f"
      JMail.AddRecipient "mis@cbbn.com.tw","��T��"
      'JMail.AddRecipient "brian@cbbn.com.tw","�u�ȵ��f"
      jmail.Send( "118.163.60.171" )              
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
       msgbox "�D�u���u��@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����u��w���u/�����u���סA���i�@�o(���@�o�Х��M���˾����u��)�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����u��w�@�o�A���i���а���@�o�@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k���欣�u��@�o�@�~,���~�T���G" & "  " & frm1.htmlfld1.value
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