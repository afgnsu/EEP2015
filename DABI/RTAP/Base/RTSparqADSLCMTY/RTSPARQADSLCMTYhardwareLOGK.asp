<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL�D�u���u��w�˳]�Ʋ��ʸ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;����;���ʤ�;�������O;���ʤH��;�]�ƦW��/�W��;�ƶq;�@�o��;�X�f�ܮw;�겣�s��"
  sqlDelete="SELECT       RTSPARQADSLCMTYHARDWARELOG.CUTYID, " _
           &"RTSPARQADSLCMTYHARDWARELOG.PRTNO, RTSPARQADSLCMTYHARDWARELOG.ENTRYNO, RTSPARQADSLCMTYHARDWARELOG.SEQ, RTSPARQADSLCMTYHARDWARELOG.CHGDAT, " _
           &"RTCode.CODENC, RTObj.CUSNC, RTProdH.PRODNC+'--'+ RTProdD1.SPEC, RTSPARQADSLCMTYHARDWARELOG.QTY, RTSPARQADSLCMTYHARDWARELOG.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTSPARQADSLCMTYHARDWARELOG.ASSETNO FROM RTProdD1 RIGHT OUTER JOIN RTSPARQADSLCMTYHARDWARELOG LEFT OUTER JOIN " _
           &"HBwarehouse ON RTSPARQADSLCMTYHARDWARELOG.WAREHOUSE = HBwarehouse.WAREHOUSE ON  RTProdD1.PRODNO = RTSPARQADSLCMTYHARDWARELOG.PRODNO AND " _
           &"RTProdD1.ITEMNO = RTSPARQADSLCMTYHARDWARELOG.ITEMNO LEFT OUTER JOIN RTProdH ON RTSPARQADSLCMTYHARDWARELOG.PRODNO = RTProdH.PRODNO " _
           &"LEFT OUTER JOIN RTCode ON RTSPARQADSLCMTYHARDWARELOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTSPARQADSLCMTYHARDWARELOG.CHGUR = RTEmployee.EMPLY WHERE RTSPARQADSLCMTYHARDWARELOG.CUTYID = 0 "
  dataTable="RTSPARQADSLCMTYHARDWARELOG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="None"
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
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTSPARQADSLCMTY  where CUTYID=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     TELEADDR=RSYY("TELEADDR")
  else
     COMN=""
     TELEADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSPARQADSLCMTYHARDWARELOG.CUTYID=" & aryparmkey(0)  & " and RTSPARQADSLCMTYHARDWARELOG.prtno='" & aryparmkey(1) & "' AND RTSPARQADSLCMTYHARDWARELOG.ENTRYNO=" & ARYPARMKEY(2)
     searchShow="���ϡJ"& aryparmkey(0) & ",�W�١J" & COMN & ",��}�J" & COMADDR & ",���u�渹�J" & aryparmkey(1) & ",�����J" & ARYPARMKEY(2)
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
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT       RTSPARQADSLCMTYHARDWARELOG.CUTYID, " _
           &"RTSPARQADSLCMTYHARDWARELOG.PRTNO, RTSPARQADSLCMTYHARDWARELOG.ENTRYNO, RTSPARQADSLCMTYHARDWARELOG.SEQ, RTSPARQADSLCMTYHARDWARELOG.CHGDAT, " _
           &"RTCode.CODENC, RTObj.CUSNC, RTProdH.PRODNC+'--'+ RTProdD1.SPEC, RTSPARQADSLCMTYHARDWARELOG.QTY, RTSPARQADSLCMTYHARDWARELOG.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTSPARQADSLCMTYHARDWARELOG.ASSETNO FROM RTProdD1 RIGHT OUTER JOIN RTSPARQADSLCMTYHARDWARELOG LEFT OUTER JOIN " _
           &"HBwarehouse ON RTSPARQADSLCMTYHARDWARELOG.WAREHOUSE = HBwarehouse.WAREHOUSE ON  RTProdD1.PRODNO = RTSPARQADSLCMTYHARDWARELOG.PRODNO AND " _
           &"RTProdD1.ITEMNO = RTSPARQADSLCMTYHARDWARELOG.ITEMNO LEFT OUTER JOIN RTProdH ON RTSPARQADSLCMTYHARDWARELOG.PRODNO = RTProdH.PRODNO " _
           &"LEFT OUTER JOIN RTCode ON RTSPARQADSLCMTYHARDWARELOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTSPARQADSLCMTYHARDWARELOG.CHGUR = RTEmployee.EMPLY  " _
           &"where " & searchqry
    Else
         sqlList="SELECT       RTSPARQADSLCMTYHARDWARELOG.CUTYID, " _
           &"RTSPARQADSLCMTYHARDWARELOG.PRTNO, RTSPARQADSLCMTYHARDWARELOG.ENTRYNO, RTSPARQADSLCMTYHARDWARELOG.SEQ, RTSPARQADSLCMTYHARDWARELOG.CHGDAT, " _
           &"RTCode.CODENC, RTObj.CUSNC, RTProdH.PRODNC+'--'+ RTProdD1.SPEC, RTSPARQADSLCMTYHARDWARELOG.QTY, RTSPARQADSLCMTYHARDWARELOG.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTSPARQADSLCMTYHARDWARELOG.ASSETNO FROM RTProdD1 RIGHT OUTER JOIN RTSPARQADSLCMTYHARDWARELOG LEFT OUTER JOIN " _
           &"HBwarehouse ON RTSPARQADSLCMTYHARDWARELOG.WAREHOUSE = HBwarehouse.WAREHOUSE ON  RTProdD1.PRODNO = RTSPARQADSLCMTYHARDWARELOG.PRODNO AND " _
           &"RTProdD1.ITEMNO = RTSPARQADSLCMTYHARDWARELOG.ITEMNO LEFT OUTER JOIN RTProdH ON RTSPARQADSLCMTYHARDWARELOG.PRODNO = RTProdH.PRODNO " _
           &"LEFT OUTER JOIN RTCode ON RTSPARQADSLCMTYHARDWARELOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTSPARQADSLCMTYHARDWARELOG.CHGUR = RTEmployee.EMPLY  " _
           &"where " & searchqry
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>