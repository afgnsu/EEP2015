<!--#include virtual="/WebUtility/MSOWC/PMSOWC4.inc" -->
<%
Sub srSpec()
    title="���־P���Ƥ��R"
    unit="�ƶq���:KG*100  &nbsp;&nbsp;���B���:�s�x���a��"
    diaProgram=""
    diaWidth=450
    diaHeight=450
    selYY=Right("00" &Request("selYY"),2)
    selMM=Right("00" &Request("selMM"),2)
    selDateS=selYY &selMM &"01"
    selDateE=selYY &selMM &"31"   
    parmDSN="dsn=coLib"
    parmSQL="SELECT Sdate, Dept, Stype, Ptype,  '�P��q' AS Item,Int(Sum(Sqty)/100) AS Amt " _
           &"FROM sale WHERE Code='05' AND Sdate BETWEEN '" &selDateS &"' AND '" &selDateE &"' " _
           &"GROUP BY Sdate,Dept,Stype,Ptype " _
           &"UNION SELECT Sdate,Dept,Stype,Ptype,'�P�f���J' AS Item ,Int(Sum(SinR)/1000) AS Amt " _
           &"FROM sale WHERE Code='05' AND Sdate BETWEEN '" &selDateS &"' AND '" &selDateE &"' " _
           &"GROUP BY Sdate,Dept,Stype,Ptype " _
           &"UNION SELECT Sdate,Dept,Stype,Ptype,'�P�f����' AS Item ,Int(Sum(CostR)/1000) AS Amt " _
           &"FROM sale WHERE Code='05' AND Sdate BETWEEN '" &selDateS &"' AND '" &selDateE &"' " _
           &"GROUP BY Sdate,Dept,Stype,Ptype "
    defaultChartType=0
    defaultChartLabel=0
    defaultFilterField="����"
    defaultRowField="����"
    defaultColumnField="���"
    fieldName="���;����;�P��O;���~��;����;��"
    fieldFormatName="��"
    fieldFormat="#,##0" 
    fieldTotal="�ȦX�p" 
    fieldTotalBase="��" 
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1"
    fieldTotalShow="True"
End Sub
%>