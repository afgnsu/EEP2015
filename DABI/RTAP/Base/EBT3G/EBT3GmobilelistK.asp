<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F�˦�ʹq�ܺ޲z�t��"
  title="��ʹq�ܸ��X��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" ��  �P ;���P����"
  functionOptProgram="EBT3Gmobilelistdrop.asp;EBT3Gmobilelistdropc.asp"
  functionOptPrompt="Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="��ʹq�ܸ��X;�ϥΤ�;�ϥΫȤ�;���X����~��;���P���"
  sqlDelete="SELECT EBT3GMOBILELIST.EBT3GMOBILENO, EBT3GMOBILELIST.USEDAT, EBT3GCUST.CUSNC, " _
           &"RTObj.CUSNC AS EMPLYNAME, EBT3GMOBILELIST.DROPMARKDAT " _
           &"FROM EBT3GCUST RIGHT OUTER JOIN EBT3GMOBILELIST ON EBT3GCUST.CUSID = EBT3GMOBILELIST.USECUSID LEFT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID ON EBT3GMOBILELIST.LOCKUSR = RTEmployee.EMPLY "

  dataTable="EBT3GMOBILELIST"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="EBT3GMOBILELISTD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=25
  searchProg="EBT3GMOBILELISTS.ASP"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" EBT3GMOBILELIST.EBT3GMOBILENO <> '' "
     searchShow="����"
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
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
         sqlList="SELECT EBT3GMOBILELIST.EBT3GMOBILENO, EBT3GMOBILELIST.USEDAT, EBT3GCUST.CUSNC, " _
           &"RTObj.CUSNC AS EMPLYNAME, EBT3GMOBILELIST.DROPMARKDAT " _
           &"FROM EBT3GCUST RIGHT OUTER JOIN EBT3GMOBILELIST ON EBT3GCUST.CUSID = EBT3GMOBILELIST.USECUSID LEFT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID ON EBT3GMOBILELIST.LOCKUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>