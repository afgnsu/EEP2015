<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   conn.Open DSN
   ' conn.BEGINTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
   sqlxx="select * FROM RTLessorAVSCUSTsndwork WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
   sqlYY="select * FROM RTLessorAVSCUST WHERE CUSID='" & KEY(0) & "' "
   RSYY.Open SQLYY,conn
   ENDPGM=""
   IF RSYY.EOF THEN
      ENDPGM="6"
   ELSE
      BATCHNOX=RSYY("BATCHNO")
  '    IF LEN(TRIM(RSYY("strbillingDAT"))) > 0 or LEN(TRIM(RSYY("newbillingDAT"))) > 0 THEN ENDPGM="7"
   END IF
   RSYY.CLOSE
   '�ˬd�����b���ɬO�_�w�R�b
   sqlyy="select * FROM RTLessorAVSCUSTAR WHERE CUSID='" & KEY(0) & "' AND BATCHNO='" & BATCHNOX & "'"
   rsyy.open sqlyy,conn
   if rsyy.eof THEN
   ELSE
      if len(trim(rsyy("mdat")))>0 OR RSYY("REALAMT") > 0 then
      '�����b�ڤw�R�b���i���ת���
         endpgm="8"
      end if
   end if
   RSyy.CLOSE   
   
   IF ENDPGM="" THEN
     RSXX.OPEN SQLXX,conn
     endpgm="1"
     '�ȦsBATCHNO
     BATCHNOXX=RSXX("BATCHNO")
     '��w�@�o�ɡA���i���槹�u���שΥ����u����
     'IF2S
     IF not isnull(RSXX("DROPDAT")) THEN
        ENDPGM="4"
     elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
        endpgm="5"
     elseif isnull(RSXX("CLOSEDAT")) and isnull(RSXX("UNCLOSEDAT")) then
        endpgm="3"      
     ELSE
        '�I�sstore procedure��s�����ɮ�
        strSP="usp_RTLessorAVSCustARSndworkFR " & "'" & key(0) & "'" & ",'" & key(1) & "','" & V(0) & "'" & ",'" & batchnoxx & "'" 
       ' response.write strSP
        Set ObjRS = conn.Execute(strSP)
        If Err.number = 0 then
           ENDPGM="1"
           ERRMSG=""
         'conn.CommitTrans
        else
           ENDPGM="2"
           errmsg=cstr(Err.number) & "=" & Err.description
         'conn.rollbackTrans
        end if         
     END IF
     RSXX.CLOSE
   END IF

   conn.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   set conn=nothing
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City�Τ�˾����u�槹�u/�����u���ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���˾����u��|�����סA���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���˾����u��w�@�o�A���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="5" then
       msgbox "���˾����u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="6" then
       msgbox "�L�k��즹�˾����u�椧�Τ�D�ɸ�ơA�нT�{AVS-City�Τ�D�ɸ�ƥ��`" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="7" then
       msgbox "�Τ�w�}�l�p�O�A���i���槹�u���ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="8" then
       msgbox "�����b�ڤw�R�b�A���i���ת���(�з|�p�H���@�o�R�b�O��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    else
       msgbox "�L�k����˾����u�槹�u���ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScustsndworkfr.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>