<!--#include virtual="/WEBAP/INCLUDE/PMSOWCT.inc" -->
<!--#include virtual="/Webap/include/employeeref.inc" -->
<%
Sub srSpec()
 '---�I�s STORE PROCEDURE "USP_HBADSLMONTHSCORE" ����RTCUSTTOT
 '   logonid=session("userid")
 '   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
 '   V=split(rtnvalue,";")  
 '   Set connXX=Server.CreateObject("ADODB.Connection")  
 '   DSNXX="DSN=RtLib"
    
 '   connXX.Open DSNXX
 '   strSP="USP_HBADSLMONTHSCORE " & V(0)
 '   Set ObjRS = connXX.Execute(strSP)      
 '   connXX.Close
 '   SET CONNXX=NOTHING 
 '------------------------------------------------------------ 
    title="�U��׽u�ơB��Ʋέp(by�~�B��)"
    unit="���:(�u�ơB���) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTCustALL order by �~,�� "
    defaultRowField="�~;��"
    defaultColumnField="���"
    defaultFilterField="�Ұ�;���g�P;�~��"
    fieldTotal="�i�u;�M�u;����(�u);������;�h����;����(��)"
    fieldTotalBase="�i�u��;�M�u��;�u�Ʋ���;������;�h����;��Ʋ���"
    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1;1;1;1;1;1;1"
    fieldTotalShow="True;True;True;True;True;True;True"
    fieldFormat="#,##0"
    defaultcharttype="0"
    defaultchartlabel="3"
	defaultexpandcolumn=""
	defaultexpandrow=""
End Sub
%>
