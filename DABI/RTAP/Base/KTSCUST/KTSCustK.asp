<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="KTS�޲z�t��"
  title="KTS�Τ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���u��;�q�ܩ���; �@ �o ;�@�o����;  ��  ��  ;  �h  ��  ;ú�ڬd��"
  functionOptProgram="KTSCUSTSNDWORKK.asp;KTSCUSTtK.asp;KTSCUSTCANCEL.asp;KTSCUSTCANCELRTN.asp;KTSCUSTCHGK.asp;KTSCUSTDROPK.asp;KTSCUSTPAYK.asp"
  functionOptPrompt="N;N;Y;Y;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;��B�I;�Τ�W��;none;�˾��a�};none;�e��<BR>�ӽФ�;NCIC�s��;�˾�<BR>���u��;������;�X��<BR>�_���;�@�o��;�h����;�}�o<BR>�~��;�j�L;none;�ӽ�<BR>�q�ܼ�;�}�q<BR>�q�ܼ�;none"
  sqlDelete="SELECT KTSCUST.CUSID, KTSCUST.CUSNC, KTSCUST.SOCIALID,RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3 AS ADDR, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC, RTObj_3.SHORTNC, KTSCUST.consignee2, " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL AND KTSCUSTD1.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END), " _
           &"ktscust.NOTATION " _
           &"FROM KTSCUSTD1 RIGHT OUTER JOIN KTSCUST ON KTSCUSTD1.CUSID = KTSCUST.CUSID AND KTSCUSTD1.DROPDAT IS NULL AND " _
           &"KTSCUSTD1.CANCELDAT IS NULL LEFT OUTER JOIN RTObj RTObj_2 INNER JOIN RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUST.EMPLY = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON KTSCUST.CONSIGNEE2 = RTObj_1.CUSID LEFT OUTER JOIN " _
           &"RTObj RTObj_3 ON KTSCUST.CONSIGNEE1 = RTObj_3.CUSID LEFT OUTER JOIN RTCounty ON KTSCUST.CUTID3 = RTCounty.CUTID " _
           &"GROUP BY  KTSCUST.CUSID, KTSCUST.CUSNC, KTSCUST.SOCIALID, RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC,RTObj_3.SHORTNC, ktscust.consignee2,ktscust.NOTATION "

  dataTable="ktscust"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="KTSCustD.asp"
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
  colSplit=1
  keyListPageSize=25
  searchProg="KTSCUSTS.ASP"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" KTSCust.CUSID<>'' AND KTSCUST.CANCELDAT IS NULL "
     searchShow="�����Τ�(���t�@�o)"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="='A1'"
         case "P"
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
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT KTSCUST.CUSID," _
           &"CASE WHEN KTSCUST.CONSIGNEE1<>'' THEN RTOBJ_3.SHORTNC ELSE  case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
           &"CASE WHEN KTSCUST.cutid3 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
           &"WHEN  KTSCUST.cutid3 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
           &"ELSE RTCTYTOWN.operationname END  END," _
           &"SUBSTRING(KTSCUST.CUSNC,1,6)+'....', KTSCUST.SOCIALID,RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3 AS ADDR, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC, RTObj_3.SHORTNC, substring(KTSCUST.consignee2,1,5), " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL AND KTSCUSTD1.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL AND KTSCUSTD1.OPENDAT IS NOT NULL THEN 1 ELSE 0 END), " _
           &"ktscust.NOTATION " _
           &"FROM KTSCUSTD1 RIGHT OUTER JOIN KTSCUST ON KTSCUSTD1.CUSID = KTSCUST.CUSID AND KTSCUSTD1.DROPDAT IS NULL AND " _
           &"KTSCUSTD1.CANCELDAT IS NULL LEFT OUTER JOIN RTObj RTObj_2 INNER JOIN RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUST.EMPLY = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON KTSCUST.CONSIGNEE2 = RTObj_1.CUSID LEFT OUTER JOIN " _
           &"RTObj RTObj_3 ON KTSCUST.CONSIGNEE1 = RTObj_3.CUSID LEFT OUTER JOIN RTCounty ON KTSCUST.CUTID3 = RTCounty.CUTID " _
           &"left outer join rtctytown on KTSCUST.cutid3=rtctytown.cutid and KTSCUST.township3=rtctytown.township " _
           &"where " & searchqry & " " _
           &"GROUP BY  KTSCUST.CUSID," _
           &"CASE WHEN KTSCUST.CONSIGNEE1<>'' THEN RTOBJ_3.SHORTNC ELSE  case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
           &"CASE WHEN KTSCUST.cutid3 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
           &"WHEN  KTSCUST.cutid3 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
           &"ELSE RTCTYTOWN.operationname END  END," _
           &"SUBSTRING(KTSCUST.CUSNC,1,6)+'....', KTSCUST.SOCIALID, RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC, RTObj_3.SHORTNC, substring(KTSCUST.consignee2,1,5),ktscust.NOTATION " 
    Else
         sqlList="SELECT KTSCUST.CUSID," _
           &"CASE WHEN KTSCUST.CONSIGNEE1<>'' THEN RTOBJ_3.SHORTNC ELSE  case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
           &"CASE WHEN KTSCUST.cutid3 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
           &"WHEN  KTSCUST.cutid3 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
           &"ELSE RTCTYTOWN.operationname END  END," _
           &"SUBSTRING(KTSCUST.CUSNC,1,6)+'....', KTSCUST.SOCIALID,RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3 AS ADDR, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC, RTObj_3.SHORTNC,  substring(KTSCUST.consignee2,1,5), " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL AND KTSCUSTD1.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTD1.CUSID IS NOT NULL AND KTSCUSTD1.CANCELDAT IS NULL AND KTSCUSTD1.DROPDAT IS NULL AND KTSCUSTD1.OPENDAT IS NOT NULL THEN 1 ELSE 0 END), " _
           &"ktscust.NOTATION " _
           &"FROM KTSCUSTD1 RIGHT OUTER JOIN KTSCUST ON KTSCUSTD1.CUSID = KTSCUST.CUSID AND KTSCUSTD1.DROPDAT IS NULL AND " _
           &"KTSCUSTD1.CANCELDAT IS NULL LEFT OUTER JOIN RTObj RTObj_2 INNER JOIN RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
           &"KTSCUST.EMPLY = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON KTSCUST.CONSIGNEE2 = RTObj_1.CUSID LEFT OUTER JOIN " _
           &"RTObj RTObj_3 ON KTSCUST.CONSIGNEE1 = RTObj_3.CUSID LEFT OUTER JOIN RTCounty ON KTSCUST.CUTID3 = RTCounty.CUTID " _
           &"left outer join rtctytown on KTSCUST.cutid3=rtctytown.cutid and KTSCUST.township3=rtctytown.township " _
           &"where " & searchqry & " " _
           &"GROUP BY  KTSCUST.CUSID, " _
           &"CASE WHEN KTSCUST.CONSIGNEE1<>'' THEN RTOBJ_3.SHORTNC ELSE  case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
           &"CASE WHEN KTSCUST.cutid3 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
           &"WHEN  KTSCUST.cutid3 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
           &"ELSE RTCTYTOWN.operationname END  END," _
           &"SUBSTRING(KTSCUST.CUSNC,1,6)+'....', KTSCUST.SOCIALID, RTCounty.CUTNC + KTSCUST.TOWNSHIP3 + KTSCUST.RADDR3, " _
           &"KTSCUST.APFORMAPPLYDAT, KTSCUST.APPLYDAT, KTSCUST.NCICCUSID, KTSCUST.FINISHDAT, KTSCUST.DOCKETDAT, KTSCUST.CONTRACTSTRDAT, KTSCUST.CANCELDAT, " _
           &"KTSCUST.DROPDAT, RTObj_2.CUSNC, RTObj_3.SHORTNC,substring(KTSCUST.consignee2,1,5),ktscust.NOTATION " 
          
    End If  
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>