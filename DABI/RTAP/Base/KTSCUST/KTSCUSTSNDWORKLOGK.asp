<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="KTS�޲z�t��"
  title="KTS�˾����u�沧�ʸ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;����;���ʤ��;�������O;���ʤH��;���u��;�@�o��;���ʭ�];���u����;�����u����;�����p��~��"
  sqlDelete="SELECT KTSCUSTSNDWORKLOG.CUSID, KTSCUSTSNDWORKLOG.PRTNO, " _
           &"KTSCUSTSNDWORKLOG.ENTRYNO,KTSCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"KTSCUSTSNDWORKLOG.SENDWORKDAT, KTSCUSTSNDWORKLOG.DROPDAT, " _
           &"KTSCUSTSNDWORKLOG.DROPDESC, KTSCUSTSNDWORKLOG.CLOSEDAT, KTSCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"KTSCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"KTSCUSTSNDWORKLOG ON RTCode.CODE = KTSCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY where KTSCUSTSNDWORKLOG.CUSID=''"
  dataTable="KTSCUSTSNDWORKLOG"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
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
     searchQry=" KTSCUSTSNDWORKLOG.CUSID='" & ARYPARMKEY(0) & "' and KTSCUSTSNDWORKLOG.prtno='" & aryparmkey(1) & "' "
     searchShow="���u�渹�J" & aryparmkey(1)
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
  if userlevel=31  then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT  KTSCUSTSNDWORKLOG.CUSID,KTSCUSTSNDWORKLOG.PRTNO, " _
           &"KTSCUSTSNDWORKLOG.ENTRYNO, " _
           &"KTSCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"KTSCUSTSNDWORKLOG.SENDWORKDAT, KTSCUSTSNDWORKLOG.DROPDAT, " _
           &"KTSCUSTSNDWORKLOG.DROPDESC, KTSCUSTSNDWORKLOG.CLOSEDAT, KTSCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"KTSCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"KTSCUSTSNDWORKLOG ON RTCode.CODE = KTSCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry & " order by KTSCUSTSNDWORKLOG.entryno "
    Else
         sqlList="SELECT  KTSCUSTSNDWORKLOG.CUSID, KTSCUSTSNDWORKLOG.PRTNO, " _
           &"KTSCUSTSNDWORKLOG.ENTRYNO, " _
           &"KTSCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"KTSCUSTSNDWORKLOG.SENDWORKDAT, KTSCUSTSNDWORKLOG.DROPDAT, " _
           &"KTSCUSTSNDWORKLOG.DROPDESC, KTSCUSTSNDWORKLOG.CLOSEDAT, KTSCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"KTSCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"KTSCUSTSNDWORKLOG ON RTCode.CODE = KTSCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry & " order by KTSCUSTSNDWORKLOG.entryno "
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>