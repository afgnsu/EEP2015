<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τᬣ�u�@�~(�ݬ��u�˾�)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���u��;���[�A��;���v����"
  functionOptProgram="rtebtcustSNDWORKK.asp;rtebtcustEXTK.asp;rtEBTcmtylineLOGK.asp"
  functionOptPrompt="N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;�D�u�W��;�Τ�;�X���s��;�˾��a�};�s���q��;none;�ӽФ�;���u�渹;���u��;������;���ɤ�;�g�P��"  
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
           &"RTEBTCUST.APPLYDAT, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT, RTObj.SHORTNC " _
           &"FROM RTEBTCUST LEFT OUTER JOIN RTCode RTCode_1 ON RTEBTCUST.DIALERPAYTYPE = RTCode_1.CODE " _
           &"AND RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUST.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'G6' LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID " _
           &"LEFT OUTER JOIN RTEBTCmtyLine ON RTEBTCUST.COMQ1=RTEBTCmtyLine.COMQ1 AND RTEBTCUST.LINEQ1=RTEBTCmtyLine.LINEQ1 " _
           &"LEFT OUTER JOIN RTObj ON RTEBTCmtyLine.CONSIGNEE = RTObj.CUSID "
           
  dataTable="rtebtcust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTebtCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=550,scrollbars=yes"
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
  searchProg="rtebtcusts3.asp"
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
     searchQry=" AND RTEBTCust.ComQ1<>0 and rtebtcust.avsno <> '' and rtebtcust.finishdat is null and rtebtcust.dropdat is null "
     searchShow="�����J�w���o�X���s���B�����u�B���h�����ݸ˾��Τ� "
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
  '�����D�ޥiŪ���������
   ' if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
	' Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
	' Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
    ' DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  'if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
 ' if userlevel=31 then DAreaID="<>'*'"
 '�~�ȧU�zor�ȪA�H��
  'else
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
  '         &"where  RTEBTCust.ComQ1<>0 and rtebtcust.avsno <> '' and rtebtcust.finishdat is null and rtebtcust.dropdat is null " & searchqry
  '  Else
         sqlList="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1))) as comqline,rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4),  right(RTEBTCUST.AVSNO,11),  " _
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
           &"RTEBTCUST.APPLYDAT, rtebtcustsndwork.prtno, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT, RTObj.SHORTNC " _
           &"FROM RTEBTCUST LEFT OUTER JOIN RTCode RTCode_1 ON RTEBTCUST.DIALERPAYTYPE = RTCode_1.CODE " _
           &"AND RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUST.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'G6' LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID  inner join rtebtcmtyh on " _
           &"rtebtcust.comq1=rtebtcmtyh.comq1 inner join rtebtcmtyline on rtebtcust.comq1=rtebtcmtyline.comq1 and " _
           &"rtebtcust.lineq1=rtebtcmtyline.lineq1  LEFT OUTER JOIN RTAREATOWNSHIP ON RTEBTCMTYLINE.CUTID=RTAREATOWNSHIP.CUTID AND " _
           &"RTEBTCMTYLINE.TOWNSHIP=RTAREATOWNSHiP.TOWNSHIP left outer join rtebtcustsndwork on rtebtcust.comq1=rtebtcustsndwork.comq1 " _ 
           &"and rtebtcust.lineq1=rtebtcustsndwork.lineq1 and rtebtcust.cusid=rtebtcustsndwork.cusid and rtebtcustsndwork.dropdat is null  and rtebtcustsndwork.unclosedat is null " _ 
           &"LEFT OUTER JOIN RTObj ON RTEBTCmtyLine.CONSIGNEE = RTObj.CUSID " _           
           &"where  RTEBTCust.ComQ1<>0 and rtebtcust.avsno <> '' and rtebtcust.finishdat is null and rtebtcust.dropdat is null and rtebtcust.canceldat is null " & searchqry & " AND RTAREATOWNSHIP.AREAID " & DAREAID & " " _
           &"GROUP BY RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1,RTEBTCUST.CUSID,rtrim(ltrim(convert(char(6),RTEBTCUST.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTEBTCUST.lineQ1))),rtebtcmtyh.comn,LEFT(RTEBTCUST.CUSnc,4),  right(RTEBTCUST.AVSNO,11),  " _
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
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END), " _
           &"RTEBTCUST.CONTACTTEL, RTCode_2.CODENC, " _
           &"RTEBTCUST.APPLYDAT, rtebtcustsndwork.prtno, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, RTEBTCUST.TRANSDAT, RTObj.SHORTNC, RTObj.SHORTNC "
  '  End If  
  'end if
  'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>