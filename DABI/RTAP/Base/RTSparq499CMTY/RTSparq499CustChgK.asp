<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq499 �޲z�t��"
  title="�t��ADSL499�w�����Ȥ�h��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="Y;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���ʧ@�o"
  functionOptProgram="RTSparq499CustChgDrop.asp"
  functionOptPrompt ="Y"
  functionoptopen   ="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;none;����;�D�u;�Ȥ�W��;���ʦW��;���ʤ��;���ʻ���;�������;���ɤ��;�@�o���"
  sqlDelete ="select a.COMQ1, a.LINEQ1, a.CUSID, a.MODIFYCODE, a.MODIFYDAT, "_
			&"		 a.COMQ1, a.LINEQ1, b.CUSNC, c.CODENC, a.MODIFYDAT, a.MODIFYDESC, a.DOCKETDAT, a.TRANSDAT, a.DROPDAT "_
			&"from 	 RTSparq499CustChg a "_
			&"		 inner join RTSparq499Cust b on a.COMQ1 = b.COMQ1 and a.LINEQ1 = b.LINEQ1 and a.CUSID = b.CUSID "_
			&"		 left outer join RTCode c on c.CODE = a.MODIFYCODE and c.KIND ='K3' "_
            &"where	 a.cusid='*' "_
            &"ORDER BY  a.MODIFYDAT "
     
  dataTable="RTSparq499CustChg"
  userDefineDelete=""
  extTable=""
  numberOfKey=5
  dataProg="RTSparq499CustChgD.asp"
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
  searchQry="a.comq1 =" & aryparmkey(0) & " and a.lineq1='" & aryparmkey(1) & "' and a.cusid='" & aryparmkey(2) &"' "
  searchProg="self"
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqllist   ="select a.COMQ1, a.LINEQ1, a.CUSID, a.MODIFYCODE, a.MODIFYDAT, "_
			&"		 a.COMQ1, a.LINEQ1, b.CUSNC, c.CODENC, a.MODIFYDAT, a.MODIFYDESC, a.DOCKETDAT, a.TRANSDAT, a.DROPDAT "_
			&"from 	 RTSparq499CustChg a "_
			&"		 inner join RTSparq499Cust b on a.COMQ1 = b.COMQ1 and a.LINEQ1 = b.LINEQ1 and a.CUSID = b.CUSID "_
			&"		 left outer join RTCode c on c.CODE = a.MODIFYCODE and c.KIND ='K3' "_
            &"where a.comq1=" & aryparmkey(0) & " and a.lineq1='" & aryparmkey(1) & "' and a.cusid='" & aryparmkey(2) &"' " _            
            &"ORDER BY  a.MODIFYDAT "
'response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
