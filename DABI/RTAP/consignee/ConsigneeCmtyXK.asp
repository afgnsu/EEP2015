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
  functionOptName="�ȡ@��"
  functionOptProgram="ConsigneeCustXK.asp"
  functionOptPrompt="N;N"
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
  '   accessMode="I"
  'End IF
  DSN="DSN=RTLib"
  formatName="�Ǹ�;���ϦW��;�i�Ѹ˽d��;�i�ظm;�����;���i�ظm��];�ӽФ�;�M�P��" 
  sqlDelete="SELECT rtsparqaDslCMTYX.CUTYID, rtsparqaDslCMTYX.COMN, " _
           &"rtsparqaDslCMTYX.SETUPADDR,rtsparqaDslCMTYX.agree,rtsparqaDslCMTYX.survydat,remark, " _
           &"SUM(CASE WHEN rtsparqaDslCustx.cusid IS NOT NULL OR rtsparqaDslCustx.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtsparqaDslCustx.DROPDAT IS NOT NULL and rtsparqaDslCustx.FINISHDAT IS NULL THEN 1 ELSE 0 END) " _           
           &"FROM rtsparqaDslCMTYX LEFT OUTER JOIN rtsparqaDslCustx ON rtsparqaDslCMTYX.CUTYID = rtsparqaDslCustx.COMQ1 " _
           &"WHERE (rtsparqaDslCMTYX.COMN <> '*') " _
           &"GROUP BY  rtsparqaDslCMTYX.CUTYID, rtsparqaDslCMTYX.COMN, " _
           &"rtsparqaDslCMTYX.SETUPADDR, " _
           &"rtsparqaDslCMTYX.agree,rtsparqaDslCMTYX.survydat,rtsparqaDslCMTYX.remark " _
           &"ORDER BY  rtsparqaDslCMTYX.comn "
  dataTable="rtsparqaDslCMTYX"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="ConsigneeCustK.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=480,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="ConsigneeCmtyXS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  
  If searchQry="" Then
    ' searchQry=" RTCUSTADSLCMTY.CUTYID<>0 and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' "
     searchQry=" rtsparqaDslCMTYX.Consignee ='" &Session("UserID")& "' AND rtsparqaDslCMTYX.CUTYID<>0  "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
  sqllist="SELECT rtsparqaDslCMTYX.CUTYID, rtsparqaDslCMTYX.COMN, " _
           &"rtsparqaDslCMTYX.SETUPADDR,rtsparqaDslCMTYX.agree,rtsparqaDslCMTYX.survydat,remark, " _
           &"SUM(CASE WHEN rtsparqaDslCustx.cusid IS NOT NULL OR rtsparqaDslCustx.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtsparqaDslCustx.DROPDAT IS NOT NULL and rtsparqaDslCustx.FINISHDAT IS NULL THEN 1 ELSE 0 END) " _                
           &"FROM rtsparqaDslCMTYX LEFT OUTER JOIN rtsparqaDslCustx ON rtsparqaDslCMTYX.CUTYID = rtsparqaDslCustx.COMQ1 " _
           &"WHERE " &  searchqry  _
           &" GROUP BY  rtsparqaDslCMTYX.CUTYID, rtsparqaDslCMTYX.COMN, " _
           &"rtsparqaDslCMTYX.SETUPADDR, " _
           &"rtsparqaDslCMTYX.agree,rtsparqaDslCMTYX.survydat,rtsparqaDslCMTYX.remark " _
           &"ORDER BY  rtsparqadslcmtyX.comn "
 
'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
