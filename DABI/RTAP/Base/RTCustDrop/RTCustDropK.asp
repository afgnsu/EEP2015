<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�h��/�M�P�Ȥ��Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3) & ";Y;Y"  
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;�Ȥ�W��;�榸;�}�o����;�ӽФ�;���u��;�h����;�ϥ�/����<br>�ɶ�(��);�p���q��;���q�q��;�~�ȭ�"
   sqlDelete="SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO,rtcmty.comn, RTObj.cusNC, " _
         &"RTCust.ENTRYNO,RTCust.CUSTYPE, RTCust.RCVD,rtcust.finishdat,rtcust.dropdat, " _
         &"CASE WHEN RTCUST.finishdat IS NOT NULL AND RTcust.dropdat IS NOT NULL THEN ((Datediff(mi, RTCUST.finishdat, RTcust.dropdat)/1440)) " _
         &"WHEN RTCUST.rcvd IS NOT NULL AND RTcust.dropdat IS NOT NULL THEN ((Datediff(mi, RTCUST.rcvd, RTcust.dropdat)/1440)) " _
         &"ELSE '' END, " _     
         &"RTCust.HOME, " _
         &"RTCust.OFFICE + ' ' + RTCust.EXTENSION AS Office, RTObj_1.CUSNC " _
		 &"FROM RTAreaCty INNER JOIN RTArea ON RTAreaCty.AREAID = RTArea.AREAID and (rtarea.areatype='3') "_
		 &"RIGHT OUTER JOIN RTCmty ON RTAreaCty.CUTID = RTCmty.CUTID "_
		 &"INNER JOIN RTVCmtyGroup ON RTVCmtyGroup.COMQ1=RTCmty.COMQ1 "_
		 &"INNER JOIN RTCust ON RTCmty.COMQ1= RTCust.COMQ1 "_
		 &"INNER JOIN RTObj ON RTObj.CUSID = RTCust.CUSID "_
		 &"Left OUTER JOIN RTObj RTObj_1 ON RTVCmtyGroup.CUSID = RTObj_1.CUSID "_
		 &"LEFT OUTER JOIN RTCode ON RTCust.SETTYPE = RTCode.CODE  and (RTCode.KIND = 'A7') "_
         &"ORDER BY rtcmty.comn,rtobj.cusnc, RTCust.ENTRYNO " 
  dataTable="RTCust"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=3
  dataProg="/webap/rtap/base/rtcmty/RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="rtcustdrops.asp"
  searchFirst=False
  If searchQry="" Then
     searchQry=" (rtcust.dropdat is not null) "
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID=" in('C1','C2')"
         case "P"
            DAreaID=" in('C1','C2')"
         case "C"
            DAreaID="='C3'"         
         case "K"
            DAreaID="='C4'"         
         case else
            DareaID="='*'"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89008" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"  

  sqllist="SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO,rtcmty.comn, RTObj.cusNC, " _
         &"RTCust.ENTRYNO,RTCust.CUSTYPE, RTCust.RCVD,rtcust.finishdat,rtcust.dropdat, " _
         &"CASE WHEN RTCUST.finishdat IS NOT NULL AND RTcust.dropdat IS NOT NULL THEN ((Datediff(mi, RTCUST.finishdat, RTcust.dropdat)/1440)) " _
         &"WHEN RTCUST.rcvd IS NOT NULL AND RTcust.dropdat IS NOT NULL THEN ((Datediff(mi, RTCUST.rcvd, RTcust.dropdat)/1440)) " _
         &"ELSE '' END, " _     
         &"RTCust.HOME, " _
		 &"RTCust.OFFICE + ' ' + RTCust.EXTENSION AS Office, RTObj_1.CUSNC "_
		 &"FROM RTAreaCty INNER JOIN RTArea ON RTAreaCty.AREAID = RTArea.AREAID and (rtarea.areatype='3') and (rtareacty.areaid " & DAREAID & ") "_
		 &"RIGHT OUTER JOIN RTCmty ON RTAreaCty.CUTID = RTCmty.CUTID "_
		 &"INNER JOIN RTVCmtyGroup ON RTVCmtyGroup.COMQ1=RTCmty.COMQ1 "_
		 &"INNER JOIN RTCust ON RTCmty.COMQ1= RTCust.COMQ1 "_
		 &"INNER JOIN RTObj ON RTObj.CUSID = RTCust.CUSID "_
		 &"Left OUTER JOIN RTObj RTObj_1 ON RTVCmtyGroup.CUSID = RTObj_1.CUSID "_
		 &"LEFT OUTER JOIN RTCode ON RTCust.SETTYPE = RTCode.CODE  and (RTCode.KIND = 'A7') "_
         &"WHERE " & searchqry _
         &"ORDER BY rtcmty.comn,rtobj.cusnc, RTCust.ENTRYNO "
  'Response.Write "sql=" & SQLLIST
End Sub
%>
