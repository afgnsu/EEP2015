<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="���¤W��޲z�t��"
  title="�D�|���q�l���q�\��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �j �� ;�����j��"
  functionOptProgram="STNONMEMBERNEWSPAPERSTOP.ASP;STNONMEMBERNEWSPAPERSTOPC.ASP"
  functionOptPrompt="Y;Y"
  functionoptopen="1;1"
  'EMAIL���INDEX
  EMAILFIELDNO=5  
  EMAILFIELDFLAG="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
  formatName="none;none;none;�W��;�q�l�����O;EMAIL;�q��;�_�l��;�פ��;�j������;�ǰe����"
  sqlDelete="SELECT  NonMemberNewspaper.EMAIL, NonMemberNewspaper.NEWSPAPERKIND,NonMemberNewspaper.NEWSPAPERCODE, " _
           &"NonMemberNewspaper.CUSNC, STCode.CODENC, NonMemberNewspaper.EMAIL AS Expr1, NonMemberNewspaper.TEL, " _
           &"NonMemberNewspaper.STRDAT, NonMemberNewspaper.ENDDAT, NonMemberNewspaper.CLOSEFLAG,NonMemberNewspaper.sndcnt " _
           &"FROM NonMemberNewspaper INNER JOIN STCode ON NonMemberNewspaper.NEWSPAPERKIND = STCode.KIND AND " _
           &"NonMemberNewspaper.NEWSPAPERCODE = STCode.CODE "

  dataTable="NONMEMBERNEWSPAPER"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="STNONMemberNEWSPAPERD.asp"
  datawindowFeature=""
  searchWindowFeature="width=400,height=200,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=600,height=350,scrollbars=yes"
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="STNONMemberNEWSPAPERS.asp"
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
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" NONMEMBERNEWSPAPER.EMAIL<>'' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqlList="SELECT  NonMemberNewspaper.EMAIL, NonMemberNewspaper.NEWSPAPERKIND,NonMemberNewspaper.NEWSPAPERCODE, " _
           &"NonMemberNewspaper.CUSNC, STCode.CODENC, NonMemberNewspaper.EMAIL AS Expr1, NonMemberNewspaper.TEL, " _
           &"NonMemberNewspaper.STRDAT, NonMemberNewspaper.ENDDAT, NonMemberNewspaper.CLOSEFLAG,NonMemberNewspaper.sndcnt  " _
           &"FROM NonMemberNewspaper INNER JOIN STCode ON NonMemberNewspaper.NEWSPAPERKIND = STCode.KIND AND " _
           &"NonMemberNewspaper.NEWSPAPERCODE = STCode.CODE  WHERE " & SEARCHQRY  & " ORDER BY STRDAT "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>