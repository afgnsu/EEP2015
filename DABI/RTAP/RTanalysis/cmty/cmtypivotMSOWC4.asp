<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building�Ȥ��Ƥ��R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGC.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where �Ұ�" & sql 
    defaultChartType="0"
    defaultChartLabel="1"
    defaultRowField="�Ұ�;�ʧO;����"
    defaultColumnField="�Ȥ����O;���u���p"
    defaultFilterField="�I�u�t��;�w�ˤu�{�v"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultexpandrow="�Ұ�"
    defaultexpandcolumn=""
End Sub
%>