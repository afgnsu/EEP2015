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
    title="�U��׽u�ơB��Ʋέp"
    unit="���:(�u�ơB���) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTCustALL order by �~,�� "
    defaultRowField="���;�Ұ�;�~;��"
    defaultColumnField=""
    defaultFilterField="���g�P;�~��"
    'fieldFormat="#,##0"
    fieldTotal="�i�u;�M�u;�W��(�u);������;�h����;�W��(��)"
    fieldTotalBase="�i�u��;�M�u��;�u�Ʋ���;������;�h����;��Ʋ���"
    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1;1;1;1;1;1;1"
    fieldTotalShow="True;True;True;True;True;True;True"
    defaultcharttype="0"
    defaultchartlabel="2"
   ' defaultexpandrow="�~;��"
    defaultexpandcolumn=""
    defaultexpandrow=""
  '  defaultexpandcolumn=""    
End Sub
%>
