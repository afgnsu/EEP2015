<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq VoIP�޲z�t��"
  title="Sparq VoIP�Τ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
 ' V=split(SrAccessPermit,";")
 ' AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'functionOptName="���u��;�q�ܩ���; �@ �o ;�@�o����;��������;  �h  ��  "
  'functionOptProgram="KTSCUSTSNDWORKK.asp;KTSCUSTtK.asp;KTSCUSTCANCEL.asp;KTSCUSTCANCELRTN.asp;KTSCUSTCHGK.asp;KTSCUSTDROPK.asp"
  'functionOptPrompt="N;N;Y;Y;Y;N"
  functionOptName=""  
  functionOptProgram=""
  functionOptPrompt=""
 ' If V(1)="Y" then
 '    accessMode="U"
 ' Else
     accessMode="I"
 ' End IF
  DSN="DSN=RTLib"
  formatName="�Τ�N��;�Τ�W��;VoIP�q�ܸ��X;�˾�����;�~�ȭ�;�g�P��;�ӽФ�;���u��;���u��;������;�h����;�@�o��"
  sqlDelete="SELECT	a.CUSID, a.CUSNC, a.VOIPTEL, isnull(b.CUTNC , '')+a.TOWNSHIP2, d.CUSNC, isnull(e.shortnc, ''), "_
		   &"		a.APPLYDAT, a.WRKRCVDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT "_
		   &"FROM	RTSparqVoIPCust a "_
		   &"		left outer join RTCounty b on a.CUTID2 = b.CUTID "_
		   &"		left outer join RTEmployee c inner join RTObj d on c.CUSID = d.CUSID on c.EMPLY = a.SALESID "_
		   &"		left outer join RTObj e on e.cusid = a.consignee "_
		   &"WHERE	CUSID ='*' "_
		   &"order by a.CUSID "

  dataTable="RTSparqVoIPCust"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="ConsigneeSparqVoIPCustD.asp"
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
  searchProg="ConsigneeSparqVoIPCustS.asp"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" and a.CUSID<>'' AND a.CANCELDAT IS NULL and a.consignee='"  & Session("UserID")& "' "
     searchShow="�����Τ�(���t�@�o)"
  ELSE
     SEARCHFIRST=FALSE
  End If
  sqlList="SELECT	a.CUSID, a.CUSNC, a.VOIPTEL, isnull(b.CUTNC , '')+a.TOWNSHIP2, d.CUSNC, isnull(e.shortnc, ''), "_
		   &"		a.APPLYDAT, a.WRKRCVDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT "_
		   &"FROM	RTSparqVoIPCust a "_
		   &"		left outer join RTCounty b on a.CUTID2 = b.CUTID "_
		   &"		left outer join RTEmployee c inner join RTObj d on c.CUSID = d.CUSID on c.EMPLY = a.SALESID "_
		   &"		left outer join RTObj e on e.cusid = a.consignee "_
		   &"where a.consignee='" & Session("UserID")& "' " & searchqry _
		   &" order by a.CUSID "		   
          
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>