<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq 0809�M�׺޲z�t��"
  title="�t��VoIP�ȤᲧ��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="Y;N;Y;Y;Y;Y"
  'functionOptName="���ʧ@�o"
  'functionOptProgram="RTSparq499CustChgDrop.asp"
  'functionOptPrompt ="Y"
  functionoptopen   ="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Ȥ�N��;����;���ʶ���;���ʫe�W��;���ʫ�W��;���ʻ���;���ʤ��"
  sqlDelete ="SELECT CUSID, ENTRYNO, CODENC, OCUSNC, NCUSNC, MODIFYDESC, a.EDAT  "_
			&"FROM   RTSparq0809CustChg a "_
			&"inner join RTCode b on a.MODIFYCODE = b.CODE and b.KIND ='M7' "_
            &"where	 a.cusid='*' "
     
  dataTable="RTSparqVoIPCustChg"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="RTSparq0809CustChgD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20

  searchFirst=false
 ' response.Write "k0=" & aryparmkey(0) & ";k1=" & aryparmkey(1) & ";k2=" & aryparmkey(2)
  'searchQry="a.cusid='" & aryparmkey(0) &"' "
  searchProg="self"
  'searchShow=FrGetCmtyDesc(aryParmKey(0))
  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  
  sqllist   ="SELECT CUSID, ENTRYNO, CODENC, OCUSNC, NCUSNC, MODIFYDESC, a.EDAT "_
			&"FROM   RTSparq0809CustChg a "_
			&"inner join RTCode b on a.MODIFYCODE = b.CODE and b.KIND ='M7' "_
            &"where a.cusid='" & aryparmkey(0) &"' " _
'response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
