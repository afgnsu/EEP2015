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
   sqlxx="select * FROM KTSCUST WHERE CUSID='" & KEY(0) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��|���@�o�ɡA���i����@�o����
   IF ISNULL(RSXX("CANCELDAT")) THEN
      ENDPGM="3"
   ELSE
      sqlyy="select max(entryno) as entryno FROM KTSCUSTlog WHERE CUSID='" & KEY(0) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into KTSCUSTlog " _
           &"SELECT   CUSID, " & ENTRYNO & ", getdate(), 'R','" &  v(0) & "', " _
           &"CUSNC, SOCIALID,BUSINESSTYPE, COTEL11, COTEL12, COFAX11, COFAX12, COEMAIL, CUTID1, " _
           &"TOWNSHIP1, RADDR1, RZONE1, CUTID2, TOWNSHIP2, RADDR2, RZONE2,  CUTID3, TOWNSHIP3, RADDR3, RZONE3, COBOSS, BOSSSOCIALID, " _
           &"COCONTACTMAN, COCONTACTTEL11, COCONTACTTEL12, COCONTACTTEL13,COCONTACTFAX11, COCONTACTFAX12, COCONTACTMOBILE, " _
           &"COCONTACTEMAIL, APFORMAPPLYDAT, APPLYDAT, APPLYTNSDAT,CONTRACTSTRDAT, NCICAPPLYREPLYDAT, NCICCUSID, NCICOPENDAT, " _
           &"FINISHDAT, DOCKETDAT, TRANSDAT, CANCELDAT, CANCELUSR, DROPDAT,  NCICDROPFLAG, RUNONCEBILLDAT, RUNONCESALESDAT, CONSIGNEE1, " _
           &"CONSIGNEE2, EMPLY, EUSR, EDAT, UUSR, UDAT, LISTTELDETAIL,  SERVICE0809,CBBNPULLDAT,CBBNPULLUSR  " _
           &"FROM KTSCUST where  CUSID='" & KEY(0) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update KTSCUST set CANCELDAT=NULL,CANCELUSR='' where CUSID='" & KEY(0) & "'"
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM KTSCUSTlog WHERE CUSID='" & KEY(0) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            '���u���סA����s�Τ�D��FINISHDAT
           ' SQLXX=" update KTSCUST set FINISHdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where CUSID='" & KEY(0) & "' "
           ' connxx.Execute SQLXX
           ' If Err.number > 0 then
           '    endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
           '    errmsg=cstr(Err.number) & "=" & Err.description
           '    sqlyy="delete * FROM KTSCUSTlog WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' AND ENTRYNO=" & ENTRYNO
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
       msgbox "KTS�Τ�@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Τ�|���@�o�A���i����@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�o�Ͳ��`�A�L�k����KTS�Τ�@�o����@�~�A�гq����T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=KTSCUSTCANCELRTN.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>