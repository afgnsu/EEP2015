<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building ���u�~�Z--�I�u���O(�~��/�޳N��/�t��)�w�ˤ�v ���R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGa.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where " & sql & " and ���u���p='�w���u' order by �g "
    defaultRowField="�������O;�I�u�H�����O;�Ұ�;����"
    defaultColumnField="�~;��;�g"
    defaultFilterField="�I�u�t��;�w�ˤu�{�v"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
    defaultcharttype="12"
    defaultchartlabel="1"
    defaultexpandrow="�������O"
    defaultexpandcolumn="�~"
End Sub
%>