<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq 499 �޲z�t��"
  title="�t��499�Ȥ��L����"
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
  formatName="���ʳ渹;���ʶ���;���ʤ��;�Ȥ�N�X;���ʫe�Ȥ�W;���ʫ�Ȥ�W;���ʻ���;"
  sqlDelete ="SELECT MODIFYNO, a.CUSID, CODENC, a.EDAT,  OCUSNC, NCUSNC, MODIFYDESC "_
			&"FROM   RTSparq499CustChgEtc a "_
			&"inner join RTCode b on a.MODIFYCODE = b.CODE and b.KIND ='M7' "_
            &"where	 a.cusid='*' "

  dataTable="RTSparq499CustChgEtc"
  userDefineDelete=""
  extTable=""
  numberOfKey=1
  dataProg="RTSparq499CustChgEtcD.asp"
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
  
  sqllist   ="SELECT MODIFYNO, CODENC, a.EDAT, a.CUSID, OCUSNC, NCUSNC, MODIFYDESC "_
			&"FROM   RTSparq499CustChgEtc a "_
			&"inner join RTCode b on a.MODIFYCODE = b.CODE and b.KIND ='M7' "_
            &"where a.cusid='" & aryparmkey(2) &"' "
'response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
