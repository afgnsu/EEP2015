<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�M�ץΤ�޲z�t��"
  title="�M�ץΤ��������I�b�ک��Ӭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  functionoptopen=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�Τ�;none;�b�ڽs��;none;�|�p���;none;�߱b<br>�~��;���ئW��;��/�t;����(�I)<br>���B;�w�R�P<br>���B;���R�b<br>���B;���ͤ�;�R�b��;�@�o��;�@�o��]"
  sqlDelete="SELECT     RTPrjCustARDTL.TYY,RTPrjCustARDTL.TMM,RTPrjcmtyh.comn,RTPrjcust.cusnc,RTPrjCustARDTL.CUSID, RTPrjCustARDTL.BATCHNO, " _
                        &"  RTPrjCustARDTL.SEQ, " _
                        &"  RTPrjCustARDTL.L14 + '-' + RTPrjCustARDTL.L23 AS Expr2, " _
                        &"  RTAccountNo.ACNAMEC, RTPrjCustARDTL.ITEMNC, " _
                        &"  RTPrjCustARDTL.PORM, RTPrjCustARDTL.AMT, " _
                        &"  RTPrjCustARDTL.REALAMT, " _
                        &"  RTPrjCustARDTL.AMT - RTPrjCustARDTL.REALAMT AS Expr1, " _
                        &"  RTPrjCustARDTL.CDAT, RTPrjCustARDTL.MDAT, " _
                        &"  RTPrjCustARDTL.CANCELDAT, RTPrjCustARDTL.CANCELMEMO " _
           &"FROM           RTPrjCustARDTL LEFT OUTER JOIN " _
                        &"  RTAccountNo ON RTPrjCustARDTL.L14 = RTAccountNo.L14 AND " _
                        &"  RTPrjCustARDTL.L23 = RTAccountNo.L23 " _
           &"where RTPrjCustARDTL.cusid='' "
  dataTable="RTPrjCustARDTL"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="self"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
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
  '----
 
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTPrjCustARDTL.TYY=" & ARYPARMKEY(0) & " AND RTPrjCustARDTL.TMM=" & ARYPARMKEY(1) & " "
     searchShow="�b�ڻ{�C�~��J" & ARYPARMKEY(0) & "/" & right("00" + ARYPARMKEY(1),2)
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31  then DAreaID="<>'*'"
  
    sqlList="SELECT         RTPrjCustARDTL.TYY,RTPrjCustARDTL.TMM,RTPrjcmtyh.comn,RTPrjcust.cusnc, RTPrjCustARDTL.CUSID, RTPrjCustARDTL.BATCHNO, " _
                        &"  RTPrjCustARDTL.SEQ, " _
                        &"  RTPrjCustARDTL.L14 + '-' + RTPrjCustARDTL.L23 AS Expr2, " _
                        &"  RTAccountNo.ACNAMEC,convert(varchar(4),RTPrjCustARDTL.syy)+'/'+convert(varchar(2),RTPrjCustARDTL.smm), RTPrjCustARDTL.ITEMNC, " _
                        &"  RTPrjCustARDTL.PORM, RTPrjCustARDTL.AMT, " _
                        &"  RTPrjCustARDTL.REALAMT, " _
                        &"  RTPrjCustARDTL.AMT - RTPrjCustARDTL.REALAMT AS Expr1, " _
                        &"  RTPrjCustARDTL.CDAT, RTPrjCustARDTL.MDAT, " _
                        &"  RTPrjCustARDTL.CANCELDAT, RTPrjCustARDTL.CANCELMEMO " _
           &"FROM           RTPrjCustARDTL LEFT OUTER JOIN " _
                        &"  RTAccountNo ON RTPrjCustARDTL.L14 = RTAccountNo.L14 AND " _
                        &"  RTPrjCustARDTL.L23 = RTAccountNo.L23 LEFT OUTER JOIN RTPrjCUST ON RTPrjCustARDTL.CUSID=RTPrjCUST.CUSID LEFT OUTER JOIN " _
                        &"  RTPrjCMTYH ON RTPrjCUST.COMQ1=RTPrjCMTYH.COMQ1 " _
           &"where RTPrjCustARDTL.L14='4642' AND RTPrjCustARDTL.L23<> '' and RTPrjCustARDTL.canceldat is null AND " & searchqry & " ORDER BY RTPrjCustARDTL.CUSID,RTPrjCustARDTL.SEQ "


  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>