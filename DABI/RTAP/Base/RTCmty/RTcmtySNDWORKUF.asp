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
   sqlxx="select * FROM RTcmtysndwork WHERE COMQ1=" & KEY(0) & " and prtno='" & key(1) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   sndtype=""
   endpgm="1"
   '��w�@�o�ɡA���i���楼���u����
   IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
      ENDPGM="3"
   '����楼���u���׮ɡA�˾������饲���ť�
   elseif not ISNULL(RSXX("CLOSEDAT"))  then
      endpgm="7"                  
   '��˾����u�餣���ťծ�(�Τw�������שΤw�����u����)�A���i���楼���u����
   elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("FINISHDAT"))) <> 0 then
      endpgm="4"      
   ELSE
      sndtype=rsxx("sndtype")
      sqlyy="select max(entryno) as entryno FROM RTcmtysndworklog WHERE COMQ1=" & KEY(0) & " and prtno='" & key(1) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTcmtysndworklog " _ 
           &"SELECT   COMQ1, PRTNO, " & ENTRYNO & ", GETDATE() ,'UF','" & V(0) & "',SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, " _
           &"ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3, " _
           &"REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT,DROPDESC, CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT,STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, " _
           &"PRTDAT, EUSR, EDAT, UUSR, UDAT, CLOSEUSR, DROPUSR, UNCLOSEDAT,finishdat " _
           &"FROM RTcmtysndwork where COMQ1=" & key(0)  & " and prtno='" & key(1) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTcmtysndwork set UNCLOSEdat=getdate() ,CLOSEUSR='" & V(0) & "' where COMQ1=" & KEY(0) & " and prtno='" & key(1) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTcmtysndworklog WHERE COMQ1=" & key(0) & "' and prtno='" & key(1) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         'else
            '���u���סA�Y���зǤu�{�B�s���l�u�{�B���q�B���q�Υ[�˳]�ƥB�D�u�|�����q�̡A����s�D�u���q��adslapplydat
         '   IF sndtype ="OC" OR  sndtype ="OP" OR  sndtype ="ST" OR  sndtype ="CB" THEN
         '      SQLXX=" update RTEBTcmtyline set adslapplydat=getdate() ,UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND RTEBTcmtyline.ADSLAPPLYDAT IS NULL "
         '      connxx.Execute SQLXX
         '      If Err.number > 0 then
         '         endpgm="2"
         '      '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
         '         errmsg=cstr(Err.number) & "=" & Err.description
         '         sqlyy="delete * FROM RTEBTcmtylinesndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & "' and prtno='" & key(2) & "' AND ENTRYNO=" & ENTRYNO
         '         CONNXX.Execute sqlyy 
         '      ELSE
         '         endpgm="1"
         '         errmsg=""
         '      END IF
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
       msgbox "HI-Building�D�u���u�楼���u���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i���楼���u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "��˾����u�餣���ťծ�(�Τw�������שΤw�����u����)�A���i���楼���u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���D�u���u�w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���D�u���u�浲�׮ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "����楼���u���׮ɡA�˾������饲���ť�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                         
    else
       msgbox "�L�k����D�u���u�楼���u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
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