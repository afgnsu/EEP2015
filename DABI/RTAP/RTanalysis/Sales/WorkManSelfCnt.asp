<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building ���u�~�Z--�U�~�ȭ��ۦ�w�� �ƶq ���R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGa.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where " & sql _
          & " and ���u���p='�w���u' and �I�u�H�����O='�~�Ȧۦ�w��' order by �g "
    defaultRowField="�Ұ�;�w�ˤu�{�v;�������O;����"
    defaultColumnField="�~;��;�g"
    defaultFilterField="�I�u�t��;�I�u�H�����O"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
    defaultexpandrow="�Ұ�;�w�ˤu�{�v"
    defaultexpandcolumn="�~"
End Sub
%>