<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="KTS�޲z�t��"
  title="KTS�Τ�˾����u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �C �L ;���u����;�����u����;���ת���; �@ �o ;�@�o����;���v����"
  functionOptProgram="/RTap/Base/KTSCust/KTSCustSndWrkP.asp;KTSCUSTSNDWORKF.asp;KTSCUSTSNDWORKUF.asp;KTSCUSTSNDWORKFR.asp;KTSCUSTSNDWORKdrop.asp;KTSCUSTSNDWORKdropc.asp;KTSCUSTSNDWORKLOGK.asp"
  functionOptPrompt="N;Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;���u�渹;���u���;�C�L�H��;�w�w�I�u��;��ڬI�u��;���u���פ�;�����u����;�@�o��;���������;�����f�֤�;�w�s�����;�w�s�f�֤�"
  sqlDelete="SELECT KTSCUSTSNDWORK.CUSID, KTSCUSTSNDWORK.PRTNO, KTSCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"KTSCUSTSNDWORK.CLOSEDAT,KTSCUSTSNDWORK.UNCLOSEDAT,KTSCUSTSNDWORK.DROPDAT,KTSCUSTSNDWORK.BONUSCLOSEYM, KTSCUSTSNDWORK.BONUSFINCHK, KTSCUSTSNDWORK.STOCKCLOSEYM, KTSCUSTSNDWORK.STOCKFINCHK " _
           &"FROM KTSCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON KTSCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON KTSCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON KTSCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON KTSCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON KTSCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY "
  dataTable="KTSCUSTSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="KTSCUSTSNDWORKD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="self"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" KTSCUSTSNDWORK.CUSID='" & aryparmkey(0) & "' "
     searchShow="�Τ�s���J"& aryparmkey(0) 
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
            DAreaID="='A1'"
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
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT KTSCUSTSNDWORK.CUSID, KTSCUSTSNDWORK.PRTNO, KTSCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN KTSCUSTSNDWORK.ASSIGNCONSIGNEE <>'' THEN KTSCUSTSNDWORK.ASSIGNCONSIGNEE ELSE RTOBJ_1.CUSNC END,CASE WHEN KTSCUSTSNDWORK.REALCONSIGNEE <>'' THEN KTSCUSTSNDWORK.REALCONSIGNEE ELSE RTOBJ_3.CUSNC END, " _
           &"KTSCUSTSNDWORK.CLOSEDAT,KTSCUSTSNDWORK.UNCLOSEDAT,KTSCUSTSNDWORK.DROPDAT,KTSCUSTSNDWORK.BONUSCLOSEYM, KTSCUSTSNDWORK.BONUSFINCHK, KTSCUSTSNDWORK.STOCKCLOSEYM, KTSCUSTSNDWORK.STOCKFINCHK " _
           &"FROM KTSCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON KTSCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON KTSCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON KTSCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON KTSCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON KTSCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY " _
            &"where " & searchqry
    Else
         sqlList="SELECT KTSCUSTSNDWORK.CUSID, KTSCUSTSNDWORK.PRTNO, KTSCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN KTSCUSTSNDWORK.ASSIGNCONSIGNEE <>'' THEN KTSCUSTSNDWORK.ASSIGNCONSIGNEE ELSE RTOBJ_1.CUSNC END,CASE WHEN KTSCUSTSNDWORK.REALCONSIGNEE <>'' THEN KTSCUSTSNDWORK.REALCONSIGNEE ELSE RTOBJ_3.CUSNC END, " _
           &"KTSCUSTSNDWORK.CLOSEDAT,KTSCUSTSNDWORK.UNCLOSEDAT,KTSCUSTSNDWORK.DROPDAT,KTSCUSTSNDWORK.BONUSCLOSEYM, KTSCUSTSNDWORK.BONUSFINCHK, KTSCUSTSNDWORK.STOCKCLOSEYM, KTSCUSTSNDWORK.STOCKFINCHK " _
           &"FROM KTSCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON KTSCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON KTSCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON KTSCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON KTSCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON KTSCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
