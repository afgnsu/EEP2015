<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�D�u���׬��u��]�Ʋ��ʸ�Ƭd��"
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
  formatName="none;none;none;none;none;����;���ʤ�;�������O;���ʤH��;�]�ƦW��/�W��;�ƶq;�@�o��;�X�f�ܮw;�겣�s��;�b�ڽs��;�������b�ڤ�"
  sqlDelete="SELECT   RTlessorCmtyLineFaqHARDWARELOG.comq1,RTlessorCmtyLineFaqHARDWARELOG.lineq1, " _
           &"RTlessorCmtyLineFaqHARDWARELOG.FAQNO,RTlessorCmtyLineFaqHARDWARELOG.PRTNO, RTlessorCmtyLineFaqHARDWARELOG.seq,RTlessorCmtyLineFaqHARDWARELOG.seq2, RTlessorCmtyLineFaqHARDWARELOG.CHGDAT, " _
           &"RTCode.CODENC, RTObj.CUSNC, RTProdH.PRODNC+'--'+ RTProdD1.SPEC, RTlessorCmtyLineFaqHARDWARELOG.QTY, RTlessorCmtyLineFaqHARDWARELOG.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTlessorCmtyLineFaqHARDWARELOG.ASSETNO,RTlessorCmtyLineFaqHARDWARELOG.BATCHNO,RTlessorCmtyLineFaqHARDWARELOG.TARDAT FROM RTProdD1 RIGHT OUTER JOIN RTlessorCmtyLineFaqHARDWARELOG LEFT OUTER JOIN " _
           &"HBwarehouse ON RTlessorCmtyLineFaqHARDWARELOG.WAREHOUSE = HBwarehouse.WAREHOUSE ON  RTProdD1.PRODNO = RTlessorCmtyLineFaqHARDWARELOG.PRODNO AND " _
           &"RTProdD1.ITEMNO = RTlessorCmtyLineFaqHARDWARELOG.ITEMNO LEFT OUTER JOIN RTProdH ON RTlessorCmtyLineFaqHARDWARELOG.PRODNO = RTProdH.PRODNO " _
           &"LEFT OUTER JOIN RTCode ON RTlessorCmtyLineFaqHARDWARELOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTlessorCmtyLineFaqHARDWARELOG.CHGUsR = RTEmployee.EMPLY WHERE RTlessorCmtyLineFaqHARDWARELOG.comq1 = 0 "
  dataTable="RTlessorCmtyLineFaqHARDWARELOG"
  userDefineDelete="Yes"
  numberOfKey=6
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
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyH ON " _
       &"RTCounty.CUTID = RTLessorCmtyH.CUTID  " _
       &"where RTLessorCmtyH.comq1=" & ARYPARMKEY(0) 
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorCmtyLine.CUTID  " _
       &"where RTLessorCmtyLine.comq1=" & ARYPARMKEY(0) & " and RTLessorCmtyLine.lineq1=" & ARYPARMKEY(1)
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township")
     if rsyy("village") <> "" then
         COMaddr= COMaddr & rsyy("village") & rsyy("cod1")
     end if
     if rsyy("NEIGHBOR") <> "" then
         COMaddr= COMaddr & rsyy("NEIGHBOR") & rsyy("cod2")
     end if
     if rsyy("STREET") <> "" then
         COMaddr= COMaddr & rsyy("STREET") & rsyy("cod3")
     end if
     if rsyy("SEC") <> "" then
         COMaddr= COMaddr & rsyy("SEC") & rsyy("cod4")
     end if
     if rsyy("LANE") <> "" then
         COMaddr= COMaddr & rsyy("LANE") & rsyy("cod5")
     end if
     if rsyy("ALLEYWAY") <> "" then
         COMaddr= COMaddr & rsyy("ALLEYWAY") & rsyy("cod7")
     end if
     if rsyy("NUM") <> "" then
         COMaddr= COMaddr & rsyy("NUM") & rsyy("cod8")
     end if
     if rsyy("FLOOR") <> "" then
         COMaddr= COMaddr & rsyy("FLOOR") & rsyy("cod9")
     end if
     if rsyy("ROOM") <> "" then
         COMaddr= COMaddr & rsyy("ROOM") & rsyy("cod10")
     end if
  else
     COMaddr=""
  end if
  RSYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTlessorCmtyLineFaqHARDWARELOG.comq1=" & aryparmkey(0) & " and RTlessorCmtyLineFaqHARDWARELOG.lineq1=" &  aryparmkey(1) & " and FAQNO='" & aryparmkey(2) & "' and RTlessorCmtyLineFaqHARDWARELOG.prtno='" & aryparmkey(3) & "' AND RTlessorCmtyLineFaqHARDWARELOG.seq=" & ARYPARMKEY(4)
     searchShow="�D�u�J"& aryparmkey(0) & "-" & aryparmkey(1) & ",���ϦW�١J" & COMN & ",��}�J" & COMADDR & ",���u�渹�J" & aryparmkey(3) & ",�����J" & ARYPARMKEY(4)
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T93168" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
         sqlList="SELECT     RTlessorCmtyLineFaqHARDWARELOG.comq1,RTlessorCmtyLineFaqHARDWARELOG.lineq1, " _
           &"RTlessorCmtyLineFaqHARDWARELOG.FAQNO,RTlessorCmtyLineFaqHARDWARELOG.PRTNO, RTlessorCmtyLineFaqHARDWARELOG.seq, RTlessorCmtyLineFaqHARDWARELOG.SEQ2, RTlessorCmtyLineFaqHARDWARELOG.CHGDAT, " _
           &"RTCode.CODENC, RTObj.CUSNC, RTProdH.PRODNC+'--'+ RTProdD1.SPEC, RTlessorCmtyLineFaqHARDWARELOG.QTY, RTlessorCmtyLineFaqHARDWARELOG.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTlessorCmtyLineFaqHARDWARELOG.ASSETNO,RTlessorCmtyLineFaqHARDWARELOG.BATCHNO,RTlessorCmtyLineFaqHARDWARELOG.TARDAT FROM RTProdD1 RIGHT OUTER JOIN RTlessorCmtyLineFaqHARDWARELOG LEFT OUTER JOIN " _
           &"HBwarehouse ON RTlessorCmtyLineFaqHARDWARELOG.WAREHOUSE = HBwarehouse.WAREHOUSE ON  RTProdD1.PRODNO = RTlessorCmtyLineFaqHARDWARELOG.PRODNO AND " _
           &"RTProdD1.ITEMNO = RTlessorCmtyLineFaqHARDWARELOG.ITEMNO LEFT OUTER JOIN RTProdH ON RTlessorCmtyLineFaqHARDWARELOG.PRODNO = RTProdH.PRODNO " _
           &"LEFT OUTER JOIN RTCode ON RTlessorCmtyLineFaqHARDWARELOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTlessorCmtyLineFaqHARDWARELOG.CHGUsR = RTEmployee.EMPLY  " _
           &"where " & searchqry

  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>