<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τ�A�Ȳ��ʶi�׬d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����u��;���u����;���ʰO��"
  functionOptProgram="rtebtcustchgsndworkk2.asp;RTEBTCUSTCHGF.ASP;RTEBTCUSTCHGLOGK.ASP"
  functionOptPrompt="N;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;<CENTER>�D�u</CENTER>;<CENTER>���ϦW��</CENTER>;<CENTER>�Τ�<BR>�X���s��</CENTER>;<CENTER>�Τ�W</CENTER>;<CENTER>����<BR>�ӽФ�</CENTER>;<CENTER>���ʶ���</CENTER>;<CENTER>����<BR>�@�o��</CENTER>;<CENTER>��������<BR>�f�֤�</CENTER>;<CENTER>����<BR>���ɤ�</CENTER>;<CENTER>����<BR>���u��</CENTER>;<CENTER>���u<BR>�^����</CENTER>;<CENTER>�s����<BR>�D�u</CENTER>;<CENTER>�s����<BR>�W��</CENTER>;<CENTER>����<BR>���u��</CENTER>;<CENTER>���u��</CENTER>;<CENTER>�w�w<BR>������</CENTER>;<CENTER>���<BR>������</CENTER>"
  sqlDelete="SELECT RTEBTCUSTCHG.COMQ1, RTEBTCUSTCHG.LINEQ1, RTEBTCUSTCHG.CUSID, RTEBTCUSTCHG.ENTRYNO, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.COMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.LINEQ1)) AS Expr1, RTEBTCMTYH.COMN, " _
           &"RTEBTCUST.AVSNO, RTEBTCUST.CUSNC, RTEBTCUSTCHG.APPLYDAT," _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD1 = 1 THEN '�Τ���' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD2 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD3 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD4 = 1 THEN '�䥦' ELSE '' END, RTEBTCUSTCHG.DROPDAT, RTEBTCUSTCHG.TRANSCHKDAT, " _
           &"RTEBTCUSTCHG.TRANSDAT, RTEBTCUSTCHG.FINISHDAT, RTEBTCUSTCHG.FINISHCHKDAT, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.NCOMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.NLINEQ1)) AS Expr2, RTEBTCMTYH_1.COMN AS Expr3, " _
           &"RTEBTCUSTCHGSNDWORK.PRTNO, RTEBTCUSTCHGSNDWORK.SENDWORKDAT, case when RTObj.CUSNC is null then RTObj_1.SHORTNC else RTObj.CUSNC end, CASE when RTObj_2.CUSNC is null then  " _
           &"RTObj_3.SHORTNC else RTObj_2.CUSNC end " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN RTObj RTObj_1 INNER JOIN RTEBTCUSTCHGSNDWORK ON RTObj_1.CUSID = " _
           &"RTEBTCUSTCHGSNDWORK.ASSIGNCONSIGNEE ON RTObj_3.CUSID = RTEBTCUSTCHGSNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"RTEBTCUSTCHGSNDWORK.REALENGINEER = RTEmployee_1.EMPLY RIGHT OUTER JOIN RTEBTCUSTCHG INNER JOIN RTEBTCMTYH ON " _
           &"RTEBTCUSTCHG.COMQ1 = RTEBTCMTYH.COMQ1 INNER JOIN RTEBTCMTYLINE ON RTEBTCUSTCHG.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN RTEBTCUST ON RTEBTCUSTCHG.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCUST.LINEQ1 AND RTEBTCUSTCHG.CUSID = RTEBTCUST.CUSID LEFT OUTER JOIN " _
           &"RTEBTCMTYLINE RTEBTCMTYLINE_1 ON RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYLINE_1.COMQ1 AND " _
           &"RTEBTCUSTCHG.NLINEQ1 = RTEBTCMTYLINE_1.LINEQ1 LEFT OUTER JOIN RTEBTCMTYH RTEBTCMTYH_1 ON " _
           &"RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYH_1.COMQ1 ON RTEBTCUSTCHGSNDWORK.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
           &"RTEBTCUSTCHGSNDWORK.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUSTCHGSNDWORK.CUSID = RTEBTCUSTCHG.CUSID AND " _
           &"RTEBTCUSTCHGSNDWORK.ENTRYNO = RTEBTCUSTCHG.ENTRYNO AND RTEBTCUSTCHGSNDWORK.DROPDAT IS NULL LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTCHGSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
           &"WHERE RTEBTCUSTCHG.COMQ1 = 0 "
  dataTable="RTEBTCUSTCHG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="RTEBTCUSTCHGD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTEBTCUSTCHGs2.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCUSTCHG.ComQ1<>0 and RTEBTCUSTCHG.FINISHCHKDAT is null  and RTEBTCUSTCHG.dropDAT is null "
     searchShow="������ "
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT RTEBTCUSTCHG.COMQ1, RTEBTCUSTCHG.LINEQ1, RTEBTCUSTCHG.CUSID, RTEBTCUSTCHG.ENTRYNO, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.COMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.LINEQ1)) AS Expr1, RTEBTCMTYH.COMN, " _
           &"RTEBTCUST.AVSNO, RTEBTCUST.CUSNC, RTEBTCUSTCHG.APPLYDAT, " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD1 = 1 THEN '�Τ���' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD2 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD3 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD4 = 1 THEN '�䥦' ELSE '' END, RTEBTCUSTCHG.DROPDAT, RTEBTCUSTCHG.TRANSCHKDAT, " _
           &"RTEBTCUSTCHG.TRANSDAT, RTEBTCUSTCHG.FINISHDAT, RTEBTCUSTCHG.FINISHCHKDAT, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.NCOMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.NLINEQ1)) AS Expr2, RTEBTCMTYH_1.COMN AS Expr3, " _
           &"RTEBTCUSTCHGSNDWORK.PRTNO, RTEBTCUSTCHGSNDWORK.SENDWORKDAT, case when RTObj.CUSNC is null then RTObj_1.SHORTNC else RTObj.CUSNC end, CASE when RTObj_2.CUSNC is null then  " _
           &"RTObj_3.SHORTNC else RTObj_2.CUSNC end " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN RTObj RTObj_1 INNER JOIN RTEBTCUSTCHGSNDWORK ON RTObj_1.CUSID = " _
           &"RTEBTCUSTCHGSNDWORK.ASSIGNCONSIGNEE ON RTObj_3.CUSID = RTEBTCUSTCHGSNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"RTEBTCUSTCHGSNDWORK.REALENGINEER = RTEmployee_1.EMPLY RIGHT OUTER JOIN RTEBTCUSTCHG INNER JOIN RTEBTCMTYH ON " _
           &"RTEBTCUSTCHG.COMQ1 = RTEBTCMTYH.COMQ1 INNER JOIN RTEBTCMTYLINE ON RTEBTCUSTCHG.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN RTEBTCUST ON RTEBTCUSTCHG.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCUST.LINEQ1 AND RTEBTCUSTCHG.CUSID = RTEBTCUST.CUSID LEFT OUTER JOIN " _
           &"RTEBTCMTYLINE RTEBTCMTYLINE_1 ON RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYLINE_1.COMQ1 AND " _
           &"RTEBTCUSTCHG.NLINEQ1 = RTEBTCMTYLINE_1.LINEQ1 LEFT OUTER JOIN RTEBTCMTYH RTEBTCMTYH_1 ON " _
           &"RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYH_1.COMQ1 ON RTEBTCUSTCHGSNDWORK.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
           &"RTEBTCUSTCHGSNDWORK.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUSTCHGSNDWORK.CUSID = RTEBTCUSTCHG.CUSID AND " _
           &"RTEBTCUSTCHGSNDWORK.ENTRYNO = RTEBTCUSTCHG.ENTRYNO AND RTEBTCUSTCHGSNDWORK.DROPDAT IS NULL LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTCHGSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
           &"WHERE RTEBTCUSTCHG.COMQ1 <> 0 AND " & searchqry
    Else
         sqlList="SELECT RTEBTCUSTCHG.COMQ1, RTEBTCUSTCHG.LINEQ1, RTEBTCUSTCHG.CUSID, RTEBTCUSTCHG.ENTRYNO, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.COMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.LINEQ1)) AS Expr1, RTEBTCMTYH.COMN, " _
           &"RTEBTCUST.AVSNO, RTEBTCUST.CUSNC, RTEBTCUSTCHG.APPLYDAT, " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD1 = 1 THEN '�Τ���' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD2 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD3 = 1 THEN '����' ELSE '' END + '/' + " _
           &"CASE WHEN RTEBTCUSTCHG.CHGCOD4 = 1 THEN '�䥦' ELSE '' END, RTEBTCUSTCHG.DROPDAT, RTEBTCUSTCHG.TRANSCHKDAT, " _
           &"RTEBTCUSTCHG.TRANSDAT, RTEBTCUSTCHG.FINISHDAT, RTEBTCUSTCHG.FINISHCHKDAT, RTRIM(CONVERT(char(6), " _
           &"RTEBTCUSTCHG.NCOMQ1)) + '-' + RTRIM(CONVERT(char(6), RTEBTCUSTCHG.NLINEQ1)) AS Expr2, RTEBTCMTYH_1.COMN AS Expr3, " _
           &"RTEBTCUSTCHGSNDWORK.PRTNO, RTEBTCUSTCHGSNDWORK.SENDWORKDAT, case when RTObj.CUSNC is null then RTObj_1.SHORTNC else RTObj.CUSNC end, CASE when RTObj_2.CUSNC is null then  " _
           &"RTObj_3.SHORTNC else RTObj_2.CUSNC end " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN RTObj RTObj_1 INNER JOIN RTEBTCUSTCHGSNDWORK ON RTObj_1.CUSID = " _
           &"RTEBTCUSTCHGSNDWORK.ASSIGNCONSIGNEE ON RTObj_3.CUSID = RTEBTCUSTCHGSNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"RTEBTCUSTCHGSNDWORK.REALENGINEER = RTEmployee_1.EMPLY RIGHT OUTER JOIN RTEBTCUSTCHG INNER JOIN RTEBTCMTYH ON " _
           &"RTEBTCUSTCHG.COMQ1 = RTEBTCMTYH.COMQ1 INNER JOIN RTEBTCMTYLINE ON RTEBTCUSTCHG.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN RTEBTCUST ON RTEBTCUSTCHG.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCUSTCHG.LINEQ1 = RTEBTCUST.LINEQ1 AND RTEBTCUSTCHG.CUSID = RTEBTCUST.CUSID LEFT OUTER JOIN " _
           &"RTEBTCMTYLINE RTEBTCMTYLINE_1 ON RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYLINE_1.COMQ1 AND " _
           &"RTEBTCUSTCHG.NLINEQ1 = RTEBTCMTYLINE_1.LINEQ1 LEFT OUTER JOIN RTEBTCMTYH RTEBTCMTYH_1 ON " _
           &"RTEBTCUSTCHG.NCOMQ1 = RTEBTCMTYH_1.COMQ1 ON RTEBTCUSTCHGSNDWORK.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
           &"RTEBTCUSTCHGSNDWORK.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUSTCHGSNDWORK.CUSID = RTEBTCUSTCHG.CUSID AND " _
           &"RTEBTCUSTCHGSNDWORK.ENTRYNO = RTEBTCUSTCHG.ENTRYNO AND RTEBTCUSTCHGSNDWORK.DROPDAT IS NULL LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTCHGSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
           &"WHERE RTEBTCUSTCHG.COMQ1 <> 0 AND " & searchqry
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>