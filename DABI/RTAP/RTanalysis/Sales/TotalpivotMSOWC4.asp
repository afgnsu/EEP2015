<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building �~�Z(�`�~�Z)�ƶq ���R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGC.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where " & sql & " order by �g "
    defaultRowField="�~;��;�g;��"
    defaultColumnField="�������O;T1�}�q���p;�Ȥ����O;���u���p"
    defaultFilterField="�I�u�H�����O;�Ұ�"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
    defaultexpandrow="�~"
    defaultexpandcolumn="�������O"
End Sub
%>