<!--#include virtual="/WEBAP/INCLUDE/PMSOWCT.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
Sub srSpec()
 '---�I�s STORE PROCEDURE "USP_HBCUSTDROPEXEC" ����HBCUSTDROPEXEC
    logonid=session("userid")
    Call SrGetEmployeeRef(Rtnvalue,1,logonid)
    V=split(rtnvalue,";")  
    Set connXX=Server.CreateObject("ADODB.Connection")  
    DSNXX="DSN=RtLib"
    
    connXX.Open DSNXX
    strSP="USP_HBCUSTDROPEXEC " & V(0)
    Set ObjRS = connXX.Execute(strSP)      
    connXX.Close
    SET CONNXX=NOTHING 
 '910703 modify end
 '------------------------------------------------------------ 
    title="�h�����_������v�ƭ� ���R"
    unit="��Ƴ��:(��) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    'parmSQL="SELECT * FROM RTCUSTTOT where temply='" & V(0) & "' order by �~,�� "
    '---910703�קאּ���D����H��
    parmSQL="SELECT * FROM HBCUSTDROPEXEC WHERE FLAG='" & V(0) & "' " 
    defaultRowField="�ϰ�;���;���A"
    defaultColumnField="�~;��"
    defaultFilterField=""
    fieldFormat="#,##0"
    fieldTotal="�����;����h;�^����;�ݩ��`��"
    fieldTotalBase="�����;����h��;�^����;������h��" 
'   fieldFormatName="�Τ�"    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1;1;1;1"
    fieldTotalShow="True;True;True;True"
    defaultcharttype="0"
    defaultchartlabel="2"
   ' defaultexpandrow="�~;��"
    defaultexpandcolumn=""
    defaultexpandrow=""
  '  defaultexpandcolumn=""    
End Sub
%>