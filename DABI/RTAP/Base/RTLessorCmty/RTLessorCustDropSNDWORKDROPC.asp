<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET") 
   SET RSYY=Server.CreateObject("ADODB.RECORDSET") 
   SET RSZZ=Server.CreateObject("ADODB.RECORDSET") 
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   sqlxx="select * FROM RTLessorCUSTDROPsndwork WHERE CUSID='" & KEY(0) & "' and ENTRYNO=" & key(1) & " and prtno='" & key(2) & "' "
   sqlYY="select * FROM RTLessorCUSTDROP WHERE CUSID='" & KEY(0) & "' and ENTRYNO=" & key(1) 
   sqlZZ="select MAX(prtno) AS XXPRTNO FROM RTLessorCUSTDROPsndwork WHERE CUSID='" & KEY(0) & "' and ENTRYNO=" & key(1) 
   RSXX.OPEN SQLXX,conn
   RSYY.OPEN SQLYY,conn
   RSZZ.OPEN SQLZZ,conn
   endpgm="1"
   '������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A����
   IF LEN(TRIM(RSXX("bonuscloseym"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("dropdat"))) = 0 or isnull(rsxx("dropdat")) then
      endpgm="4"
   ELSEIF LEN(TRIM(RSYY("SNDPRTNO"))) > 0 OR LEN(TRIM(RSYY("SNDWORK"))) > 0 THEN
      ENDPGM="5"
   '���䥦������u��s�b��(�B����渹�j�󥻳�渹�A�h�����\�@�o����)      
   ELSEIF RSZZ("XXPRTNO") > KEY(2) THEN
      ENDPGM="6"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustDROPSndworkDropC " & "'" & key(0) & "'," & key(1) & ",'" & key(2) & "','" & V(0) & "'" 
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
   RSYY.CLOSE
   RSZZ.CLOSE
   conn.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   SET RSZZ=NOTHING
   set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Τ������u��@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Τ������u��|���@�o�A���i����@�o����@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="5" then
       msgbox "��������u����ݰh����Ƥw�t�~���ͩ�����u��A�]��������欣�u��@�o����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="6" then
       msgbox "���䥦������u��s�b��(�B����渹�j�󥻳�渹�A�h�����\�@�o����)  �C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    else
       msgbox "�L�k����Τ������u��@�o����@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorcustDROPsndworkdropC.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>