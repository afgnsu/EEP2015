<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="��~��;�~�ȭ�;�ީe�|;�ȡ@��"
  functionOptProgram="RTCmtyBusK.asp;RTCmtySaleK.asp;RTCmtySpK.asp;RTCustK.asp"
  functionOptPrompt="N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;����<br>�Ǹ�;���ϦW��;����;�W��<br>���;�Ӹˤ�;�`�Ѥ�; " _
            &"���O<br>������;�M�P<BR>��;�{����<br>�ƦX�p;�}�o<br>��v%;����<BR>�u��;�w��<BR>�u��;�ӽФ�;T1�}�q��"
  sqlDelete="SELECT RTCmty.COMQ1 , RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
           &"RTCmty.APPLYCNT,RTcmty.T1PETITION,RTCmty.Schdat,RTcmty.T1Apply " _
           &"FROM RTCmty INNER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
           &"WHERE (((RTCmty.COMQ1)=0)) "
  dataTable="RTCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTCmtyD.asp"
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
  searchProg="RTCmtyS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" RTCmty.ComQ1=0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89020" or Ucase(emply)="T89018" OR  _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="P92010" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"
  if userlevel=2 then
    If searchShow="����" Then
    sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"Sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end),  " _
         &"Sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
         &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
         &"FROM RTEmployee INNER JOIN " _
         &"RTCmtySale ON RTEmployee.CUSID = RTCmtySale.CUSID INNER JOIN " _
         &"RTCounty INNER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _               
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTCounty.CUTID = RTCmty.CUTID INNER JOIN " _
         &"RTArea INNER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and rtarea.areaid" & DareaID & " ON " _
         &"RTCmty.CUTID = RTAreaCty.CUTID ON RTCmtySale.COMQ1 = RTCmty.COMQ1 " _
         &"WHERE RTArea.AREATYPE='1' AND " &searchQry &" and rtemployee.netid='" & Request.ServerVariables("LOGON_USER") & "' " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY " _
         &"ORDER BY RTCmty.COMN "
    Else
    sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
         &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
         &"FROM RTCounty INNER JOIN " _
         &"RTCmtySale INNER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _         
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTCmtySale.COMQ1 = RTCmty.COMQ1 ON " _
         &"RTCounty.CUTID = RTCmty.CUTID INNER JOIN " _
         &"RTArea INNER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and rtarea.areaid" & DareaID & " ON " _
         &"RTCmty.CUTID = RTAreaCty.CUTID INNER JOIN " _
         &"RTEmployee ON RTCmtySale.CUSID = RTEmployee.CUSID " _
         &"WHERE RTArea.AREATYPE='1' and " &searchQry & " "  _
         &"and rtemployee.netid='" & Request.ServerVariables("LOGON_USER") & "' " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY " _                  
         &"ORDER BY RTCmty.COMN "
    End If
  else
    If searchShow="����" Then
    sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end),  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end), " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
         &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
         &"FROM RTArea RIGHT OUTER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID  and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
         &"RTCmtySale RIGHT OUTER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTCmtySale.COMQ1 = RTCmty.COMQ1 and rtcmtysale.exdat IS NULL ON  " _
         &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
         &"WHERE RTArea.AREATYPE='1' AND " &searchQry &" " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY " _         
         &"ORDER BY RTCmty.COMN "
    Else
    sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
         &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
         &"FROM RTArea RIGHT OUTER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID  and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
         &"RTCmtySale RIGHT OUTER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _         
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTCmtySale.COMQ1 = RTCmty.COMQ1 and rtcmtysale.exdat IS NULL ON " _
         &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _ 
         &"WHERE RTArea.AREATYPE='1' and " &searchQry &" " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY " _                  
         &"ORDER BY RTCmty.COMN "
    End If  
  end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(1)) > 0 Then
     delSql="DELETE  FROM RTCmtyBus WHERE COMQ1 IN " &extDeleList(1) &" " 
     conn.Execute delSql
     delSql="DELETE  FROM RTCmtySale WHERE COMQ1 IN " &extDeleList(1) &" "
     conn.Execute delSql
     delSql="DELETE  FROM RTCmtySp WHERE COMQ1 IN " &extDeleList(1) &" "
     conn.Execute delSql
  End If
  conn.Close
End Sub
%>