<!--#include virtual="/WebAP/include/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building �����~���~�Z��Ƥ��R"
    diaProgram="Dialogc.asp"
    diaWidth=450
    diaHeight=450
    parmDSN="RTLib"
    parmSQL="SELECT * FROM RTSalesV2 where �Ұ�" & sql& " and ���u���p='�w���u' "  
    defaultRowField="�Ұ�;����"
    defaultColumnField="��~��"
    defaultFilterField="�I�u�t��;�I�u�H�����O"
    fieldFormatName="�Ȥ�W��"
    fieldFormat="#,##0"
    fieldTotal="�X�p���"
    fieldTotalBase="�Ȥ�W��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
    defaultexpandrow=""
    defaultexpandcolumn=""    
End Sub
%>