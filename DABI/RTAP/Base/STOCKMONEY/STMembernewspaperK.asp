<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="���¤W��޲z�t��"
  title="�����|���q�l���q�\��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  functionoptopen=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
  formatName="none;none;none;����;�_�l�q�\��;�����q�\��;�j������"
  sqlDelete="SELECT STMemberNewsPaper.MEMBERID, STMemberNewsPaper.NEWSPAPERKIND,STMemberNewsPaper.NEWSPAPERCODE, STCode.CODENC, " _
           &"STMemberNewsPaper.STRDAT, STMemberNewsPaper.ENDDAT, STMemberNewsPaper.CLOSEFLAG " _
           &"FROM STMemberNewsPaper LEFT OUTER JOIN STCode ON STMemberNewsPaper.NEWSPAPERKIND = STCode.KIND AND " _
           &"STMemberNewsPaper.NEWSPAPERCODE = STCode.CODE "

  dataTable="STMEMBERNEWSPAPER"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=50
  searchProg="self"
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
     searchQry=" STMEMBERnewspaper.MEMBERID='" & aryparmkey(0) & "'"
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqlList="SELECT STMemberNewsPaper.MEMBERID, STMemberNewsPaper.NEWSPAPERKIND,STMemberNewsPaper.NEWSPAPERCODE, STCode.CODENC, " _
           &"STMemberNewsPaper.STRDAT, STMemberNewsPaper.ENDDAT, STMemberNewsPaper.CLOSEFLAG " _
           &"FROM STMemberNewsPaper LEFT OUTER JOIN STCode ON STMemberNewsPaper.NEWSPAPERKIND = STCode.KIND AND " _
           &"STMemberNewsPaper.NEWSPAPERCODE = STCode.CODE  where " & SEARCHQRY  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>