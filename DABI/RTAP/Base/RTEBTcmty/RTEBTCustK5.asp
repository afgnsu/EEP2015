<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="�F��AVS�Τ�X���פ�|�������h���d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="  �h  ��  ;ú�ڰO��;���v����"
  functionOptProgram="rtEBTCUSTDROPK.asp;rtEBTCUSTPAYK.asp;rtEBTCUSTLOGK.asp"
  functionOptPrompt="N;N;N"
  functionoptopen="1;2;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;�D�u�W��;�Τ�;AVS�X����;none;�˾��a�};�s���q��;none;�ӽФ�;none;none;���u��;������;���ɤ�;�X���פ�;�h����;���J;���X;�h�����O"
  sqlDelete="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1)))  as comqline,rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4), right(RTEBTCUST.AVSNO,11), " _
           &"(RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 " _
           &"<> '' THEN RTEBTCUST.VILLAGE1 + RTEBTCUST.COD11 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 " _
           &"+ RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
           &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 " _
           &"<> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
           &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN " _
           &"RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END) AS raddr, " _
           &"RTEBTCUST.CONTACTTEL, RTCode_2.CODENC, " _
           &"RTEBTCUST.APPLYDAT, RTEBTCUST.APPLYTNSDAT, RTEBTCUST.APPLYAGREE, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT,rtebtcust.endbillingdat, RTEBTCUST.DROPDAT, " _
           &"rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVEFROMlineQ1))), " _
           &"rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVETOlineQ1))) " _
           &"FROM RTEBTCUST LEFT OUTER JOIN RTCode RTCode_1 ON RTEBTCUST.DIALERPAYTYPE = RTCode_1.CODE " _
           &"AND RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUST.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'G6' LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID " _
           &"LEFT OUTER JOIN RTCODE RTCODE_3 ON RTEBTCUST.CASETYPE = RTCODE_3.CODE AND RTCODE_3.KIND='H5' "

  dataTable="rtebtcust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTebtCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=550,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="rtebtcusts5.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCust.ComQ1<>0 "
     searchShow="����"
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
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=rtLIB"
  sqlxx="select * from RTEmployee where emply='" & emply & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  IF not rsxx.EOF then
     if rsxx("dept")="B400" THEN Dareaid="<>'*'"
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"   or Ucase(emply)="T91129"  or Ucase(emply)="T89031"  or Ucase(emply)="T92134" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
 ' if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  if userlevel=31 then DAreaID="<>'*'"
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
  'if userlevel=2 then
  '�~�ȧU�zor�ȪA�H��
  '  If searchShow="����" Then
  '       sqlList="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1)))  as comqline,rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4),  right(RTEBTCUST.AVSNO,11),  " _
  '         &"(RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 " _
  '         &"<> '' THEN RTEBTCUST.VILLAGE1 + RTEBTCUST.COD11 ELSE '' END + CASE WHEN " _
  '         &"RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
  '         &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 " _
  '         &"+ RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
  '         &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 " _
  '         &"<> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
  '         &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 " _
  '         &"ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
  '         &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN " _
  '         &"RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
  '         &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END) AS raddr, " _
  '         &"RTEBTCUST.CONTACTTEL, RTCode_2.CODENC, " _
  '         &"RTEBTCUST.APPLYDAT, RTEBTCUST.APPLYTNSDAT, RTEBTCUST.APPLYAGREE, " _
  '         &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT " _
  '         &"FROM RTEBTCUST LEFT OUTER JOIN RTCode RTCode_1 ON RTEBTCUST.DIALERPAYTYPE = RTCode_1.CODE " _
  '         &"AND RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUST.PAYTYPE = RTCode_2.CODE " _
  '         &"AND RTCode_2.KIND = 'G6' LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID inner join rtebtcmtyh on " _
  '         &"rtebtcust.comq1=rtebtcmtyh.comq1 inner join rtebtcmtyline on rtebtcust.comq1=rtebtcmtyline.comq1 and " _
  '         &"rtebtcust.lineq1=rtebtcmtyline.lineq1 " _ 
  '         &"where " & searchqry
  '  Else
         sqlList="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1))) as comqline,rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4),  right(RTEBTCUST.AVSNO,11),RTCODE_3.CODENC,  " _
           &"(RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 " _
           &"<> '' THEN RTEBTCUST.VILLAGE1 + RTEBTCUST.COD11 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 " _
           &"+ RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
           &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 " _
           &"<> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
           &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN " _
           &"RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END) AS raddr, " _
           &"RTEBTCUST.CONTACTTEL, RTCode_2.CODENC, " _
           &"RTEBTCUST.APPLYDAT, RTEBTCUST.APPLYTNSDAT, RTEBTCUST.APPLYAGREE, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT,rtebtcust.endbillingdat, RTEBTCUST.DROPDAT, " _
           &"case when RTEBTCUST.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTEBTCUST.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVETOlineQ1))) else '' end,  " _
           &" CASE WHEN SUM(CASE WHEN RTEBTCUSTDROP.CUSID <> '' AND RTEBTCUSTDROP.CUSID IS NOT NULL THEN 1 ELSE 0 END) > 0 THEN 'Y' ELSE '' END " _
           &"FROM RTEBTCUST LEFT OUTER JOIN RTCode RTCode_1 ON RTEBTCUST.DIALERPAYTYPE = RTCode_1.CODE " _
           &"AND RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUST.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'G6' LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID  inner join rtebtcmtyh on " _
           &"rtebtcust.comq1=rtebtcmtyh.comq1 inner join rtebtcmtyline on rtebtcust.comq1=rtebtcmtyline.comq1 and " _
           &"rtebtcust.lineq1=rtebtcmtyline.lineq1 INNER JOIN RTAREATOWNSHIP ON RTEBTCMTYLINE.CUTID=RTAREATOWNSHIP.CUTID AND " _
           &"RTEBTCMTYLINE.TOWNSHIP=RTAREATOWNSHiP.TOWNSHIP " _ 
           &"LEFT OUTER JOIN RTCODE RTCODE_3 ON RTEBTCUST.CASETYPE = RTCODE_3.CODE AND RTCODE_3.KIND='H5' LEFT OUTER JOIN " _
           &"RTEBTCUSTDROP ON RTEBTCUST.COMQ1 = RTEBTCUSTDROP.COMQ1 AND RTEBTCUST.LINEQ1 = RTEBTCUSTDROP.LINEQ1 AND " _
           &"RTEBTCUST.CUSID = RTEBTCUSTDROP.CUSID AND RTEBTCUSTDROP.DROPDAT IS NULL " _
           &"where " & searchqry & " AND RTAREATOWNSHIP.AREAID " & DAREAID & " and rtebtcust.endbillingdat is not null and rtebtcust.dropdat is null " _
           &"GROUP BY  RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1))),rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4),  right(RTEBTCUST.AVSNO,11),RTCODE_3.CODENC,  " _
           &"(RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 " _
           &"<> '' THEN RTEBTCUST.VILLAGE1 + RTEBTCUST.COD11 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 " _
           &"+ RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
           &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 " _
           &"<> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
           &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN " _
           &"RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END) , " _
           &"RTEBTCUST.CONTACTTEL, RTCode_2.CODENC, " _
           &"RTEBTCUST.APPLYDAT, RTEBTCUST.APPLYTNSDAT, RTEBTCUST.APPLYAGREE, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT,rtebtcust.endbillingdat, RTEBTCUST.DROPDAT, " _
           &"case when RTEBTCUST.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTEBTCUST.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTEBTCUST.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTEBTCUST.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTEBTCUST.MOVETOlineQ1))) else '' end  " _
           &"ORDER BY RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,LEFT(RTEBTCUST.CUSnc,4)"
   ' End If  
  'end if
 ' response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>