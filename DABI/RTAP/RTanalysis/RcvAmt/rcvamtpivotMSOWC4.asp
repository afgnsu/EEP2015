<!--#include virtual="/WEBAP/INCLUDE/PMSOWC.inc" -->
<%
Sub srSpec()
    title="HI-Building RT,ADSL �˾��O���ڪ��B���R"
    unit="���B���:�s�x����"
    diaProgram="DIALOGC.ASP"
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    parmSQL="usp_RTReceiptEIS " & sql
    defaultRowField="���;��b�k��;�Ȥ�}�o"
    defaultColumnField="���u�~;���u��"
    defaultFilterField=""
    fieldFormat="#,##0"
    fieldTotal="���B(�d��)"
    fieldTotalBase="���ڪ��B"
    'fieldTotalBase="�ꦬ���B" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1"
    fieldFormat="#,##0.00"     
    fieldTotalShow="True"
    defaultcharttype="12"
    defaultchartlabel="2"
    defaultexpandrow="���"
    'defaultexpandcolumn="���u�~"
End Sub
%>