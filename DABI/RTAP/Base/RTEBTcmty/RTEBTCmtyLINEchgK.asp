<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u���ʥӽг���@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName=" �C �L ;���u����;���ʬ��u; �@ �o ;���v����"
  functionOptProgram="rtEBTcmtylineCHGPV.asp;rtEBTcmtylineCHGF.asp;rtEBTcmtylineCHGsndworkk.asp;rtEBTcmtylineCHGDROP.asp;rtEBTcmtylineCHGLOGK.asp"
  functionOptPrompt="Y;Y;N;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;���ʳ渹;���ʥӽФ�;���ʥӽЮѦC�L;none;���ʶ���;�s���ϥD�u;�s���ϦW��;���u��;�ӽмf�֤�;�ӽ����ɤ�;�ӽ����ɧ帹;EBT�^�Ф�;�^�Ъ��A;�@�o��"
  sqlDelete="SELECT         RTEBTCMTYLINECHG.COMQ1, RTEBTCMTYLINECHG.LINEQ1, " _
           &"RTEBTCMTYLINECHG.PRTNO,rtrim(convert(char(6),RTEBTcmtylineCHG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtylineCHG.lineQ1)),RTEBTCMTYLINECHG.PRTNO, RTEBTCMTYLINECHG.APPLYDAT, " _
           &"RTEBTCMTYLINECHG.PRTDAT, RTEBTCMTYLINECHG.PRTUSR, " _
           &"CASE WHEN RTEBTCMTYLINECHG.CHGCOD1 = 1 THEN '512K/64K��1.5M/384K' " _
           &"ELSE '' END + '��' + CASE WHEN RTEBTCMTYLINECHG.CHGCOD2 = 1 THEN '1.5M/384K��512K/64K' " _
           &"ELSE '' END + '��' + CASE WHEN RTEBTCMTYLINECHG.CHGCOD3 = 1 THEN '����' " _
           &"ELSE '' END,  CASE WHEN RTEBTCMTYLINECHG.NCOMQ1 > 0 THEN rtrim(CONVERT(char(6), " _
           &"RTEBTCMTYLINECHG.NCOMQ1)) + '-' + rtrim(CONVERT(char(6), " _
           &"RTEBTCMTYLINECHG.NLINEQ1)) ELSE '' END, RTEBTCMTYH.COMN AS Expr1, " _
           &"RTEBTCMTYLINECHG.UPDEBTCHKDAT, " _
           &"RTEBTCMTYLINECHG.UPDEBTTNSDAT, " _
           &"RTEBTCMTYLINECHG.UPDEBTTNSNO, RTEBTCMTYLINECHG.EBTREPLYDAT, " _
           &"RTEBTCMTYLINECHG.EBTREPLYSTS,RTEBTCMTYLINECHG.DROPDAT " _
           &"FROM             RTEBTCMTYLINECHG LEFT OUTER JOIN " _
           &"RTEBTCMTYH ON RTEBTCMTYLINECHG.NCOMQ1 = RTEBTCMTYH.COMQ1 " _
           &"WHERE RTEBTCMTYLINECHG.COMQ1=0 "
  dataTable="RTEBTCMTYLINECHG"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTebtCmtylineCHGD.asp"
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
  sqlYY="select * from RTEBTCMTYH LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     COMADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("RADDR")
  else
     COMN=""
     COMADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCMTYLINECHG.ComQ1=" & aryparmkey(0) & " AND RTEBTCMTYLINECHG.LINEQ1=" & aryparmkey(1)
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",���Ϧa�}�J" & COMADDR
  ELSE
     SEARCHFIRST=FALSE
  End If
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
  
       sqlList="SELECT         RTEBTCMTYLINECHG.COMQ1, RTEBTCMTYLINECHG.LINEQ1, " _
           &"RTEBTCMTYLINECHG.PRTNO,rtrim(convert(char(6),RTEBTcmtylineCHG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtylineCHG.lineQ1)),RTEBTCMTYLINECHG.PRTNO, RTEBTCMTYLINECHG.APPLYDAT, " _
           &"RTEBTCMTYLINECHG.PRTDAT, RTEBTCMTYLINECHG.PRTUSR, " _
           &"CASE WHEN RTEBTCMTYLINECHG.CHGCOD1 = 1 THEN '512K/64K��1.5M/384K' " _
           &"ELSE '' END + '��' + CASE WHEN RTEBTCMTYLINECHG.CHGCOD2 = 1 THEN '1.5M/384K��512K/64K' " _
           &"ELSE '' END + '��' + CASE WHEN RTEBTCMTYLINECHG.CHGCOD3 = 1 THEN '����' " _
           &"ELSE '' END,  CASE WHEN RTEBTCMTYLINECHG.NCOMQ1 > 0 THEN rtrim(CONVERT(char(6), " _
           &"RTEBTCMTYLINECHG.NCOMQ1)) + '-' + rtrim(CONVERT(char(6), " _
           &"RTEBTCMTYLINECHG.NLINEQ1)) ELSE '' END, RTEBTCMTYH.COMN AS Expr1, RTEBTCMTYLINECHG.FINISHDAT," _
           &"RTEBTCMTYLINECHG.UPDEBTCHKDAT, " _
           &"RTEBTCMTYLINECHG.UPDEBTTNSDAT, " _
           &"RTEBTCMTYLINECHG.UPDEBTTNSNO, RTEBTCMTYLINECHG.EBTREPLYDAT, " _
           &"RTEBTCMTYLINECHG.EBTREPLYSTS,RTEBTCMTYLINECHG.DROPDAT " _
           &"FROM             RTEBTCMTYLINECHG LEFT OUTER JOIN " _
           &"RTEBTCMTYH ON RTEBTCMTYLINECHG.NCOMQ1 = RTEBTCMTYH.COMQ1 " _
           &"WHERE  " & SEARCHQRY
                      
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>