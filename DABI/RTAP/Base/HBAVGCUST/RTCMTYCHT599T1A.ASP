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
  functionOptName="�T�w�y�q;�p�q�y�q;��~��;�~�ȭ�;�ީe�|;�ȡ@��"
  functionOptProgram="/WEBAP/RTAP/BASE/RTCMTY/rtcmtyflow.asp;/WEBAP/RTAP/BASE/RTCMTY/rtcmtyflow2.asp;/WEBAP/RTAP/BASE/RTCMTY/RTCmtyBusK.asp;/WEBAP/RTAP/BASE/RTCMTY/RTCmtySaleK.asp;/WEBAP/RTAP/BASE/RTCMTY/RTCmtySpK.asp;/WEBAP/RTAP/BASE/RTCMTY/RTCustK.asp"
  functionOptPrompt="N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Ǹ�;none;���ϦW��;�M�u�s��;����IP;����;�W�Ҥ��;none;none; " _
            &"���O������;�M�P��;�{����ƦX�p;�}�o��v%;�����u��;�w���u��;������;none;T1�}�q��;�g�P��"
  sqlDelete="SELECT RTCmty.COMQ1 , RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
           &"RTCmty.APPLYCNT,RTcmty.T1PETITION,RTCmty.Schdat,RTcmty.T1Apply " _
           &"FROM RTCmty INNER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
           &"WHERE (((RTCmty.COMQ1)=0)) "
  dataTable="RTCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="/WEBAP/RTAP/BASE/RTCMTY/RTCmtyD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
    'Ū���ȦsKEY
  KEYXX=SPLIT(SESSION("search3"),";")
  searchProg="RTCMTYCHT599T1AS.ASP"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTCmty.ComQ1<>0 AND RTCmty.T1APPLY IS NOT NULL AND RTCmty.RCOMDROP IS null AND RTCmty.CONNECTTYPE='01' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  if len(trim(keyxx(0)))> 0 then
     searchQry3=" HAVING SUM(CASE WHEN RTCUST.DOCKETdat IS NOT NULL AND rtcust.DROPDAT IS NULL THEN 1 ELSE 0 END) " & KEYXX(0) & " " & KEYXX(1)
  else
     SEARCHQRY3=""
  END IF  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Ū���n�J�b�����s�ո��
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="='A1'"
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076" or Ucase(emply)="T90089" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
    If searchShow="����" Then
         sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end),  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end), " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _   
         &"Sum(CASE when docketDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                  
         &"RTcmty.T1PETITION,RTcmty.T1Apply,CASE WHEN ( RTCODE.CODENC = '' or RTCODE.CODENC is null ) THEN CASE WHEN RTCMTY.CUTID IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCMTY.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' " _
         &"WHEN RTCMTY.cutid IN ('05', '06', '07', '08') OR ( RTCMTY.cutid = '03' AND RTCMTY.township IN ('�T�l��', '�a�q��')) THEN '���' " _
         &"WHEN RTCMTY.cutid IN ('09', '10', '11', '12', '13') THEN '�x��' WHEN RTCMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END " _ 
         &"FROM RTArea INNER JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID  and RTArea.AREATYPE='1' and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
         &"RTVCmtyGroup RIGHT OUTER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTVCmtyGroup.COMQ1 = RTCmty.COMQ1  ON  " _
         &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN RTCODE ON RTCMTY.comtype=RTCODE.CODE AND RTCODE.KIND='B3' LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
         &"WHERE RTCmty.ComQ1<>0 AND RTCmty.T1APPLY IS NOT NULL AND RTCmty.RCOMDROP IS null AND RTCmty.CONNECTTYPE='01' AND " & searchQry &" " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY,CASE WHEN ( RTCODE.CODENC = '' or RTCODE.CODENC is null ) THEN CASE WHEN RTCMTY.CUTID IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCMTY.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' " _
         &"WHEN RTCMTY.cutid IN ('05', '06', '07', '08') OR ( RTCMTY.cutid = '03' AND RTCMTY.township IN ('�T�l��', '�a�q��')) THEN '���' " _
         &"WHEN RTCMTY.cutid IN ('09', '10', '11', '12', '13') THEN '�x��' WHEN RTCMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END " _         
         & SEARCHQRY3 & " " _
         &"ORDER BY RTCmty.COMN "       
    Else
         sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip ,RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
         &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
         &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
         &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
         &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
         &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
         &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
         &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _   
         &"Sum(CASE when DOCKETDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                  
         &"RTcmty.T1PETITION,RTcmty.T1Apply,CASE WHEN ( RTCODE.CODENC = '' or RTCODE.CODENC is null ) THEN CASE WHEN RTCMTY.CUTID IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCMTY.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' " _
         &"WHEN RTCMTY.cutid IN ('05', '06', '07', '08') OR ( RTCMTY.cutid = '03' AND RTCMTY.township IN ('�T�l��', '�a�q��')) THEN '���' " _
         &"WHEN RTCMTY.cutid IN ('09', '10', '11', '12', '13') THEN '�x��' WHEN RTCMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END  " _
         &"FROM RTArea inner JOIN " _
         &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and RTArea.AREATYPE='1' and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
         &"RTVCmtyGroup RIGHT OUTER JOIN " _
         &"RTCust RIGHT OUTER JOIN " _         
         &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTVCmtyGroup.COMQ1 = RTCmty.COMQ1  ON " _
         &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID LEFT OUTER JOIN RTCODE ON RTCMTY.comtype=RTCODE.CODE AND RTCODE.KIND='B3' " _ 
         &"WHERE RTCmty.ComQ1<>0 AND RTCmty.T1APPLY IS NOT NULL AND RTCmty.RCOMDROP IS null AND RTCmty.CONNECTTYPE='01' AND "& searchQry &" " _
         &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, t1no,netip,RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
         &"RTCmty.T1APPLY,CASE WHEN ( RTCODE.CODENC = '' or RTCODE.CODENC is null ) THEN CASE WHEN RTCMTY.CUTID IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCMTY.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' " _
         &"WHEN RTCMTY.cutid IN ('05', '06', '07', '08') OR ( RTCMTY.cutid = '03' AND RTCMTY.township IN ('�T�l��', '�a�q��')) THEN '���' " _
         &"WHEN RTCMTY.cutid IN ('09', '10', '11', '12', '13') THEN '�x��' WHEN RTCMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END " _        
         & SEARCHQRY3 & " " _
         &"ORDER BY RTCmty.COMN "       
    End If  
  'end if
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