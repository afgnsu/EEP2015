<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�U���X���޲z�t��"
  title="�X���D�ɾ��v���ʸ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="none;�X���s��;����;��H�N�X;��H;�ʽ�;�j���O;�p���O;�X���_��;�X������;���ʤ�;���ʧO;���ʭ�"
  sqlDelete="SELECT       HBContractHlog.CTNO, " _
         &"               HBContractHlog.CONTRACTNO + '-' + CONVERT(varchar(4), " _
         &"               HBContractHlog.VOLUME) + '-' + CONVERT(varchar(3), " _
         &"               HBContractHlog.PAGECNT) AS Expr1,HBContractHlog.ENTRYNO, HBContractHlog.CTOBJECT, " _
         &"               HBContractHlog.CTOBJNAME, HBContractTreeH.PROPERTYNM, " _
         &"               HBContractTreeL1.CATEGORY1NM, HBContractTreeL2.CATEGORY2NM, " _
         &"               HBContractHlog.CTSTRDAT, HBContractHlog.CTENDDAT, " _
         &"               HBContractHlog.TRANSDAT, RTCode_1.CODENC, RTObj.CUSNC " _
         &"FROM           HBContractHlog INNER JOIN " _
         &"               RTCode ON HBContractHlog.RCVORPAY = RTCode.CODE AND " _
         &"               RTCode.KIND = 'F7' INNER JOIN " _
         &"               HBContractTreeL1 ON " _
         &"               HBContractHlog.CTTree1 = HBContractTreeL1.CATEGORY1 AND " _
         &"               HBContractHlog.CTproperty = HBContractTreeL1.PROPERTYID INNER JOIN " _
         &"               RTCode RTCode_1 ON HBContractHlog.TRANSCODE = RTCode_1.CODE AND " _
         &"               RTCode_1.KIND = 'G2' INNER JOIN " _
         &"               RTEmployee ON HBContractHlog.TRANSUSR = RTEmployee.EMPLY INNER JOIN " _
         &"               RTObj ON RTEmployee.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"               HBContractTreeL2 ON " _
         &"               HBContractHlog.CTproperty = HBContractTreeL2.PROPERTYID AND " _
         &"               HBContractHlog.CTTree1 = HBContractTreeL2.CATEGORY1 AND " _
         &"               HBContractHlog.CTTree2 = HBContractTreeL2.CATEGORY2 LEFT OUTER JOIN " _
         &"               HBContractTreeH ON " _
         &"               HBContractHlog.CTproperty = HBContractTreeH.PROPERTYID " _
         &"WHERE (HBCONTRACTHLOG.CTNO = 0) "  _
         &"ORDER BY HBCONTRACTHLOG.CONTRACTNO ,HBCONTRACTHLOG.volume,hbCONTRACTHLOG.pagecnt "
  dataTable="HBCONTRACTHLOG"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=500,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
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
  searchFirst=false
  If searchQry="" Then
     searchQry=" and HBCONTRACTHLOG.CTNO <> 0 "
     searchShow="����"
  End If
  sqlList="SELECT         HBContractHlog.CTNO, " _
         &"               HBContractHlog.CONTRACTNO + '-' + CONVERT(varchar(4), " _
         &"               HBContractHlog.VOLUME) + '-' + CONVERT(varchar(3), " _
         &"               HBContractHlog.PAGECNT) AS Expr1,HBContractHlog.ENTRYNO, HBContractHlog.CTOBJECT, " _
         &"               HBContractHlog.CTOBJNAME, HBContractTreeH.PROPERTYNM, " _
         &"               HBContractTreeL1.CATEGORY1NM, HBContractTreeL2.CATEGORY2NM, " _
         &"               HBContractHlog.CTSTRDAT, HBContractHlog.CTENDDAT, " _
         &"               HBContractHlog.TRANSDAT, RTCode_1.CODENC, RTObj.CUSNC " _
         &"FROM           HBContractHlog INNER JOIN " _
         &"               RTCode ON HBContractHlog.RCVORPAY = RTCode.CODE AND " _
         &"               RTCode.KIND = 'F7' INNER JOIN " _
         &"               HBContractTreeL1 ON " _
         &"               HBContractHlog.CTTree1 = HBContractTreeL1.CATEGORY1 AND " _
         &"               HBContractHlog.CTproperty = HBContractTreeL1.PROPERTYID INNER JOIN " _
         &"               RTCode RTCode_1 ON HBContractHlog.TRANSCODE = RTCode_1.CODE AND " _
         &"               RTCode_1.KIND = 'G2' INNER JOIN " _
         &"               RTEmployee ON HBContractHlog.TRANSUSR = RTEmployee.EMPLY INNER JOIN " _
         &"               RTObj ON RTEmployee.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"               HBContractTreeL2 ON " _
         &"               HBContractHlog.CTproperty = HBContractTreeL2.PROPERTYID AND " _
         &"               HBContractHlog.CTTree1 = HBContractTreeL2.CATEGORY1 AND " _
         &"               HBContractHlog.CTTree2 = HBContractTreeL2.CATEGORY2 LEFT OUTER JOIN " _
         &"               HBContractTreeH ON " _
         &"               HBContractHlog.CTproperty = HBContractTreeH.PROPERTYID " _
         &"WHERE HBCONTRACTHLOG.CTNO =" & ARYPARMKEY(0) & " " _
         &"ORDER BY HBCONTRACTHLOG.CONTRACTNO ,HBCONTRACTHLOG.volume,hbCONTRACTHLOG.pagecnt "
'Response.Write "SQL=" &sqllist           
 session("FIRSTPROCESS")="Y"
 session("comq1xx")=""
 session("comnxx")=""
 session("comtypexx")=""
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>