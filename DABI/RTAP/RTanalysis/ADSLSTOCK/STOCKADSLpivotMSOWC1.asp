<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="ADSL��ӱM��--�~�ȲէO�~�Z���R"
    unit="��Ƴ��:(��) "
    diaProgram="DIALOGC.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="SELECT * FROM ADSLV1 where " & sql & " order by ����g "
    defaultRowField="�Ұ�;�~�ȭ�"
    defaultColumnField="�~�ȲէO"
    defaultFilterField="�������G"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="3"
    defaultexpandrow=""
    defaultexpandcolumn=""
End Sub
%>