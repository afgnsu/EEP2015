<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building ���u�~�Z--(�~/�u/��/�g/��)��Ƥ��R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGa.ASP"
    diaWidth=600
    diaHeight=450
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where " & sql & " and ���u���p='�w���u' order by �g "
    defaultRowField="�~;�u;��;�g;��"
    defaultColumnField="�������O;�Ұ�;�Ȥ����O;�~�ȭ�"
    defaultFilterField="�I�u�t��;�I�u�H�����O"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
    defaultexpandrow="�~"
    defaultexpandcolumn="�������O"
End Sub
%>