<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building ���u�~�Z--(�Ұ�/����/�~�ȭ�)��Ƥ��R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGa.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where " & sql & " and ���u���p='�w���u' order by �g "
    defaultRowField="�Ұ�;�������O;�Ȥ����O;�~�ȭ�;����"
    defaultColumnField="�~;�u;��;�g;��"
    defaultFilterField="���u���p"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultcharttype="12"
    defaultchartlabel="2"
    defaultexpandrow="�Ұ�;�������O"
    defaultexpandcolumn="�~"
End Sub
%>