<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi Building�޲z�t��"
  title="���~�D�ɸ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="��  �~"
  functionOptProgram="RTProductDetailK.asp"
  functionOptPrompt="N"    
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="���~�s��;���~���O;�`�b���;���Ӭ��;���~�W��;�w�s����"
  sqlDelete="SELECT RTPRODH.PRODNO, RTCode.CODENC , RTPRODH.COUNTINGH, RTPRODH.COUNTINGD, " _
           &"RTPRODH.PRODNC,RTPRODH.STOCKCHECK FROM RTPRODH INNER JOIN " _
           &"RTCode ON RTPRODH.PRODTYP = RTCode.CODE AND RTCode.KIND = 'E2' " _
           &"WHERE  RTPRODH.PRODNO='*' "
  dataTable="RTPRODH"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTProductD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTPRODUCTS.asp"
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
     searchQry=" RTPRODH.PRODNO <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTPRODH.PRODNO, RTCode.CODENC , RTPRODH.COUNTINGH, RTPRODH.COUNTINGD, " _
         &"RTPRODH.PRODNC,RTPRODH.STOCKCHECK FROM RTPRODH INNER JOIN " _
         &"RTCode ON RTPRODH.PRODTYP = RTCode.CODE AND RTCode.KIND = 'E2' " _
         &"WHERE " &searchQry &" " _
         &"ORDER BY RTPRODH.PRODNO "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>