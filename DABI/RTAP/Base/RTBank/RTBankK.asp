<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi-Building�޲z�t��"
  title="�Ȧ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="����"
  functionOptProgram="RTbankbranchk.asp"
  functionOptPrompt="N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�Ȧ�N��;�Ȧ�W��;�Ȧ����O;�����"
  sqlDelete="SELECT RTBank.HEADNO AS Expr1, RTBank.HEADNC AS Expr2, " _
           &"RTCode.CODENC AS Expr3, COUNT(*) " _
           &"AS Expr5 " _
           &"FROM RTBank INNER JOIN RTCode ON RTBank.BANKTYPE = RTCode.CODE LEFT OUTER JOIN " _
           &"RTBankBranch ON RTBank.HEADNO = RTBankBranch.HEADNO " _
           &"WHERE         (RTCode.KIND = 'G1') and rtbank.headno='*' " _
           &"GROUP BY  RTBank.HEADNO, RTBank.HEADNC, RTCode.CODENC, RTBank.SHORTNC " 
  dataTable="RTBank"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTBankD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
  searchProg="RTBankS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  If searchQry="" Then
     searchQry=" and RTBank.HEADNO<>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTBank.HEADNO AS Expr1, RTBank.HEADNC AS Expr2, " _
           &"RTCode.CODENC AS Expr3, COUNT(*) " _
           &"AS Expr5 " _
           &"FROM RTBank INNER JOIN RTCode ON RTBank.BANKTYPE = RTCode.CODE LEFT OUTER JOIN " _
           &"RTBankBranch ON RTBank.HEADNO = RTBankBranch.HEADNO " _
           &"WHERE         (RTCode.KIND = 'G1') and rtbank.headno<>'*' " & searchQry & " " _
           &"GROUP BY  RTBank.HEADNO, RTBank.HEADNC, RTCode.CODENC " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>