<!--#include virtual="/webap/rtap/rtanalysis/sales/PMSOWCTavs2.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
Sub srSpec()
 '---�I�s STORE PROCEDURE "USP_HBADSLMONTHSCORE" ����RTCUSTTOT
 '---910703 ���sql�]�w�ɶ�����procedure�A���ѵ{���I�s
 '---910703 modify start
    KEY=REQUEST("KEY")
    KEYARY=SPLIT(KEY,";")
    IF LEN(TRIM(KEYARY(0)))=0 THEN KEYARY(0)="1911/01/01 00:00:00"
    IF LEN(TRIM(KEYARY(1)))=0 THEN KEYARY(1)="9999/12/31 23:59:59"
    logonid=session("userid")
    Call SrGetEmployeeRef(Rtnvalue,1,logonid)
    V=split(rtnvalue,";")  
    Set connXX=Server.CreateObject("ADODB.Connection")  
    DSNXX="DSN=RtLib"
    
    connXX.Open DSNXX
    strSP="USP_RTAVSsalesscore " & V(0) & ",'" & KEYARY(0) & "','" & KEYARY(1) & "'"
   ' Response.Write "STRSP=" & STRSP
    Set ObjRS = connXX.Execute(strSP)      
    connXX.Close
    SET CONNXX=NOTHING 
 '910703 modify end
 '------------------------------------------------------------ 
    title="�F��AVS499�~�ȤH���˾��έp��"
    unit="��Ƴ��:(��) "
    diaProgram=""
    diaWidth=550
    diaHeight=400
    parmDSN="RTLib"
    'parmSQL="SELECT * FROM RTCUSTTOT where temply='" & V(0) & "' order by �~,�� "
    '---910703�קאּ���D����H��
    parmSQL="SELECT �˾��~,�˾���,�˾��H��,�Τ�W��,�X���s��,���ϦW��,�D�u�Ǹ�,�˾���,�Τ�}�o�էO,�g FROM RTAVSsalesscoreTOT WHERE EUSR='" & V(0) & "'  "    
    defaultRowField="�˾��~;�˾���;�g;�˾��H��"
    defaultColumnField=""
    defaultFilterField=""
    fieldFormat="#,##0"
    fieldTotal="�Τ��"
    fieldTotalBase="�Τ�W��" 
    
'------ 1:Sum 2:Count 3:Min 4:Max
    fieldTotalFunction="2"
    fieldTotalShow="True"
    defaultcharttype="0"
    defaultchartlabel="2"
   ' defaultexpandrow="�~;��"
    defaultexpandcolumn=""
    defaultexpandrow="�˾��~;�˾���;�g"
  '  defaultexpandcolumn=""    
End Sub
%>