<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building �ȶD�ץ��Ƥ��R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGa.ASP"
    diaWidth=600
    diaHeight=450
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTfaqV1 where " & sql
    defaultRowField="�ȶD���~;�B�z�i��"
    defaultColumnField="���z�~;���z��"
    defaultFilterField="�˾����u;�˾��t��;�˾������O"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultcharttype="13"
    defaultchartlabel="2"
    defaultexpandrow=""
    defaultexpandcolumn="���z�~"
End Sub
%>