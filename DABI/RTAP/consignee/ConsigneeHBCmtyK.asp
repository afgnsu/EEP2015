<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if

Sub SrEnvironment()
  on error resume next
  company="���T�e�W�����ѥ��������q"
  system="Hi-Building�޲z�t��"
  title="Hi-Building���ϤΫȤ��Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  'V=split(SrAccessPermit,";")
  'AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  buttonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�ȡ@��"
  functionOptProgram="ConsigneeHBCustK.asp"
  functionOptPrompt="N;N"
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
     accessMode="I"
  'End IF
  DSN="DSN=RTLib"
  formatName="�Ǹ�;none;���ϦW��;�M�u�s��;����IP;����;�W��<br>���;�Ӹˤ�;�`�Ѥ�; " _
            &"���O<br>������;�M�P<BR>��;�{����<br>�ƦX�p;�}�o<br>��v%;����<BR>�u��;�w��<BR>�u��;none;T1�}�q��"
  sqlDelete="SELECT RTCmty.COMQ1 , RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
           &"RTCmty.APPLYCNT,RTcmty.T1PETITION,RTCmty.Schdat,RTcmty.T1Apply " _
           &"FROM RTCmty INNER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
           &"WHERE (((RTCmty.COMQ1)=0)) "
  dataTable="RTCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="None"
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
  searchProg="ConsigneeHBCmtyS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  
  If searchQry="" Then
    ' searchQry=" RTCUSTADSLCMTY.CUTYID<>0 and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' "
     searchQry=" and RTCmty.COMTYPE ='" &Session("COMTYPE")& "' "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
         sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip ,RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
         &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
         &"FROM RTArea INNER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and RTArea.AREATYPE='1' RIGHT OUTER JOIN " _
         &"RTVCmtyGroup RIGHT OUTER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _         
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTVCmtyGroup.COMQ1 = RTCmty.COMQ1  ON " _
         &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _ 
         &"WHERE RTCmty.COMTYPE ='" &Session("COMTYPE")& "' " & searchQry &" " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, t1no,netip,RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY " _                  
         &"ORDER BY RTCmty.COMN "       
 
'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
