<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="�F��AVS�Τ�X�������d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  functionoptopen=""
  'EMAIL���INDEX
  EMAILFIELDNO=11
  EMAILFIELDFLAG="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;�Τ�W��;ú�ں���;���u��;������;�ϥ�<br>���;�p���q��;��ʹq��;Email;�˾��a�};�g�P��"
  sqlDelete="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1, RTEBTCUST.CUSID, RTEBTCMTYH.COMN, RTEBTCUST.CUSNC, RTCode.CODENC, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, DATEDIFF(Month,RTEBTCUST.DOCKETDAT, GETDATE()) AS Expr1, RTEBTCUST.CONTACTTEL, " _
           &"RTEBTCUST.MOBILE, RTEBTCUST.EMAIL, RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 <> '' THEN RTEBTCUST.VILLAGE1 " _
           &"+ RTEBTCUST.COD11 ELSE '' END + CASE WHEN RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 + RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
           &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 <> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
           &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END, RTObj.SHORTNC " _
           &"FROM RTEBTCUST INNER JOIN RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTCode ON RTEBTCUST.PAYTYPE = RTCode.CODE AND RTCode.KIND = ' G6' LEFT OUTER JOIN RTEBTCMTYH ON RTEBTCUST.COMQ1 = RTEBTCMTYH.COMQ1 "

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
  searchProg="rtebtcusts7.asp"
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
     searchShow="�w�������h���Τ�"
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
        sqlList="SELECT RTEBTCUST.COMQ1, RTEBTCUST.LINEQ1, RTEBTCUST.CUSID, RTEBTCMTYH.COMN, SUBSTRING(RTEBTCUST.CUSNC,1,4), RTCode.CODENC, " _
           &"RTEBTCUST.FINISHDAT, RTEBTCUST.DOCKETDAT, DATEDIFF(Month,RTEBTCUST.DOCKETDAT, GETDATE()) AS Expr1, RTEBTCUST.CONTACTTEL, " _
           &"RTEBTCUST.MOBILE, RTEBTCUST.EMAIL, RTCounty.CUTNC + RTEBTCUST.TOWNSHIP1 + CASE WHEN RTEBTCUST.VILLAGE1 <> '' THEN RTEBTCUST.VILLAGE1 " _
           &"+ RTEBTCUST.COD11 ELSE '' END + CASE WHEN RTEBTCUST.NEIGHBOR1 <> '' THEN RTEBTCUST.NEIGHBOR1 + RTEBTCUST.COD12 " _
           &"ELSE '' END + CASE WHEN RTEBTCUST.STREET1 <> '' THEN RTEBTCUST.STREET1 + RTEBTCUST.COD13 ELSE '' END + CASE WHEN RTEBTCUST.SEC1 <> '' THEN " _
           &"RTEBTCUST.SEC1 + RTEBTCUST.COD14 ELSE '' END + CASE WHEN RTEBTCUST.LANE1 <> '' THEN RTEBTCUST.LANE1 + RTEBTCUST.COD15 ELSE '' END + CASE WHEN " _
           &"RTEBTCUST.ALLEYWAY1 <> '' THEN RTEBTCUST.ALLEYWAY1 + RTEBTCUST.COD16 ELSE '' END + CASE WHEN RTEBTCUST.NUM1 <> '' THEN RTEBTCUST.NUM1 + " _
           &"RTEBTCUST.COD17 ELSE '' END + CASE WHEN RTEBTCUST.FLOOR1 <> '' THEN RTEBTCUST.FLOOR1 + RTEBTCUST.COD18 ELSE '' END + CASE WHEN RTEBTCUST.ROOM1 " _
           &"<> '' THEN RTEBTCUST.ROOM1 + RTEBTCUST.COD19 ELSE '' END, RTObj.SHORTNC " _
           &"FROM RTEBTCUST INNER JOIN RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN RTCounty ON RTEBTCUST.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTCode ON RTEBTCUST.PAYTYPE = RTCode.CODE AND RTCode.KIND = 'G6' LEFT OUTER JOIN RTEBTCMTYH ON RTEBTCUST.COMQ1 = RTEBTCMTYH.COMQ1 " _
           &"where RTEBTCUST.docketdat is not null  and RTEBTCUST.dropdat is null AND " & SEARCHQRY & " order by DATEDIFF(Month,RTEBTCUST.DOCKETDAT, GETDATE()) DESC  " 
   ' End If  
  'end if
  'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>