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
   sqlxx="select * FROM KTSCUSTsndwork WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��w�@�o�ɡA���i���ư���
   IF NOT ISNULL(RSXX("DROPDAT")) THEN
      ENDPGM="3"
   elseif NOT ISNULL(RSXX("CLOSEDAT"))  OR NOT ISNULL(RSXX("UNCLOSEDAT")) then
      endpgm="4"
   elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
      endpgm="5"
   ELSE
      sqlyy="select max(entryno) as entryno FROM KTSCUSTsndworklog WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into KTSCUSTsndworklog " _
           &"SELECT   CUSID,PRTNO, " & ENTRYNO & ", getdate(), 'D','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'KTS�Τᬣ�u��@�o'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, PRODNO,ITEMNO, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR ,EUSR, EDAT, UUSR, UDAT  " _
           &"FROM KTSCUSTsndwork where  CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update KTSCUSTsndwork set DROPdat=getdate(),DROPUSR='" & V(0) & "' where CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM KTSCUSTsndworklog WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            '���u���סA����s�Τ�D��FINISHDAT
           ' SQLXX=" update KTSCUST set FINISHdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where CUSID='" & KEY(0) & "' "
           ' connxx.Execute SQLXX
           ' If Err.number > 0 then
           '    endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
           '    errmsg=cstr(Err.number) & "=" & Err.description
           '    sqlyy="delete * FROM KTSCUSTsndworklog WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' AND ENTRYNO=" & ENTRYNO
           '    CONNXX.Execute sqlyy 
           ' ELSE
               endpgm="1"
               errmsg=""
           ' END IF
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
       msgbox "KTS�Τ�˾����u��@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����u��w�@�o�A���i���ư��欣�u��@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����u��w���u���שΥ����u���סA���i�@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    else
       msgbox "�L�k���欣�u��@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=KTSCUSTSNDWORKDROP.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>