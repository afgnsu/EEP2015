<!--#include virtual="/webap/rtap/rtanalysis/sales/PMSOWCT.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
Sub srSpec()
 '---�I�s STORE PROCEDURE "USP_HBADSLMONTHSCORE" ����RTCUSTTOT
 '---910703 ���sql�]�w�ɶ�����procedure�A���ѵ{���I�s
 '---910703 modify start
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
 '910703 modify end
 '------------------------------------------------------------ 
    title="���P�~�Z ���R"
    unit="��Ƴ��:(��) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    'parmSQL="SELECT * FROM RTCUSTTOT where temply='" & V(0) & "' order by �~,�� "
    '---910703�קאּ���D����H��
    parmSQL="SELECT * FROM RTCUSTTOT  where ��b�k��='����' order by �~,�� "    
    defaultRowField="�~�ȲէO;�~;��"
    defaultColumnField="�Ȥ��;���"
    defaultFilterField="��b�k��"
    fieldFormat="#,##0"
    fieldTotal="�W���"
    fieldTotalBase="�W��" 
    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1"
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
   ' defaultexpandrow="�~;��"
    defaultexpandcolumn="�Ȥ��"
    defaultexpandrow=""
  '  defaultexpandcolumn=""    
End Sub
%>