<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if

Sub SrEnvironment()
  on error resume next
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  'V=split(SrAccessPermit,";")
  'AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  buttonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�g�P�Ȥ�"
  functionOptProgram="consigneecmty3k.asp"
  functionOptPrompt="N"
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
     accessMode="I"
  'End IF
  DSN="DSN=RTLib"
  formatName="none;�g�P��;�ӽФ�;�w�M�P;�w���u;�w����;�w�h��" 
  sqlDelete="SELECT RTSPARQADSLCMTY.CONSIGNEE,CASE WHEN RTOBJ.SHORTNC IS NULL " _
         &"THEN '���T' ELSE RTOBJ.SHORTNC END, " _
         &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR " _
         &"rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.DROPDAT IS NOT NULL AND " _
         &"rtsparqadslcust.FINISHDAT IS NULL THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL OR " _
         &"rtsparqadslcust.finishdat <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR " _
         &"rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.FINISHdat IS NOT NULL AND " _
         &"rtsparqadslcust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
         &"FROM RTSparqAdslCmty LEFT OUTER JOIN " _
         &"rtsparqadslcust ON " _
         &"RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 LEFT OUTER JOIN " _
         &"RTOBJ ON RTSPARQADSLCMTY.CONSIGNEE = RTOBJ.CUSID " _
         &"WHERE RTSparqAdslCmty.CUTYID = 0 " _
         &"GROUP BY  RTSPARQADSLCMTY.CONSIGNEE,RTSPARQADSLCMTY.SHORTNC "
  dataTable="RTSparqAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=400,height=300,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=15
  searchProg="self"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  
  If searchQry="" Then
     searchQry=" RTSPARQADSLCMTY.CUTYID<>0 and rtSPARQADSLCMTY.RCOMDROP IS NULL "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
  sqllist="SELECT  RTSPARQADSLCMTY.CONSIGNEE,CASE WHEN RTOBJ.SHORTNC IS NULL " _
         &"THEN '���T' ELSE RTOBJ.SHORTNC END, " _
         &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR " _
         &"rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.DROPDAT IS NOT NULL AND " _
         &"rtsparqadslcust.FINISHDAT IS NULL THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL OR " _
         &"rtsparqadslcust.finishdat <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR " _
         &"rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN rtsparqadslcust.FINISHdat IS NOT NULL AND " _
         &"rtsparqadslcust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
         &"FROM RTSparqAdslCmty LEFT OUTER JOIN " _
         &"rtsparqadslcust ON " _
         &"RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 LEFT OUTER JOIN " _
         &"RTOBJ ON RTSPARQADSLCMTY.CONSIGNEE = RTOBJ.CUSID " _
         &"WHERE " &  searchqry & " " _
         &"GROUP BY   RTSPARQADSLCMTY.CONSIGNEE,RTOBJ.SHORTNC " 
'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
