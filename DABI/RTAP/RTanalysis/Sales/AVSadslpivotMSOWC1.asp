<!--#include virtual="/webap/rtap/rtanalysis/sales/PMSOWCTavs.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
Sub srSpec()
 '---�I�s STORE PROCEDURE "USP_HBADSLMONTHSCORE" ����RTCUSTTOT
 '---910703 ���sql�]�w�ɶ�����procedure�A���ѵ{���I�s
 '---910703 modify start
    KEY=REQUEST("KEY")
    KEYARY=SPLIT(KEY,";")
    'RESPONSE.WRITE "KEY0=" & KEYARY(0) & ";KEY1=" & KEYARY(1)
    IF LEN(TRIM(KEYARY(0)))=0 THEN KEYARY(0)="1900/01/01 00:00:00"
    IF LEN(TRIM(KEYARY(1)))=0 THEN KEYARY(1)="3999/12/31 23:59:59"
    logonid=session("userid")
    Call SrGetEmployeeRef(Rtnvalue,1,logonid)
    V=split(rtnvalue,";")  
    Set connXX=Server.CreateObject("ADODB.Connection")  
    DSNXX="DSN=RtLib"
    
    connXX.Open DSNXX
    strSP="USP_RTAVSCUSTOT " & V(0) & ",'" & KEYARY(0) & "','" & KEYARY(1) & "'"
   
    'Response.Write "STRSP=" & STRSP
    'RESPONSE.END
    Set ObjRS = connXX.Execute(strSP)      
    connXX.Close
    SET CONNXX=NOTHING 
 '910703 modify end
 '------------------------------------------------------------ 
    title="�F��AVS499�~�Z�έp��"
    unit="��Ƴ��:(��) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    'parmSQL="SELECT * FROM RTCUSTTOT where temply='" & V(0) & "' order by �~,�� "
    '---910703�קאּ���D����H��
    parmSQL="SELECT * FROM RTAVSCUSTOT WHERE EUSR='" & V(0) & "'  order by ��b�k��,�~�ȲէO,��� "    
    defaultRowField="�~;��;�g;��b�k��;�~�ȲէO;�~�ȭ�"
    defaultColumnField=""
    defaultFilterField=""
    fieldFormat="#,##0"
    fieldTotal="�`�e�u��;�`�}�q��;�����;�ӽФ�;���u��;������;�h����"
    fieldTotalBase="�e��u��;�}�q�u��;������;�ӽФ��;���u���;�������;�h�����" 
    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="1;1;1;1;1;1;1"
    fieldTotalShow="True;True;True;True;True;True;True"
    defaultcharttype="0"
    defaultchartlabel="2"
   ' defaultexpandrow="�~;��"
    defaultexpandcolumn=""
    defaultexpandrow="�~;��;�g"
  '  defaultexpandcolumn=""    
End Sub
%>