<!--#include virtual="/WebAP/include/PMSOWC4.inc" -->
<%
Sub srSpec()
    title="HI-Building�~�Z��Ƥ��R"
    diaProgram="Dialogc.asp"
    diaWidth=450
    diaHeight=450
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTTEST1 where �Ұ�" & sql  
    defaultRowField="�Ұ�;����;�u�{�v"
    defaultColumnField="�Ȥ����O"
    defaultFilterField="�I�u�H��;�I�u�H������"
    fieldFormatName="�Ȥ�W��"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
End Sub
%>