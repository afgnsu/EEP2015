<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�Τ᪫�~��γ���Ӹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
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
  formatName="��γ渹;����;���~�s��;���~���O;�W��;��μƶq;���;�Ƶ�"
  sqlDelete="SELECT RTLessorAVSCustRCVHardwareDTL.RCVPRTNO, RTLessorAVSCustRCVHardwareDTL.ENTRYNO, " _
                     &"     RTLessorAVSCustRCVHardwareDTL.PRODNO + '-' + RTLessorAVSCustRCVHardwareDTL.ITEMNO " _
                      &"      AS Expr1, RTProdH.PRODNC, RTProdD1.SPEC, " _
                     &"      RTLessorAVSCustRCVHardwareDTL.QTY, RTCode.CODENC, " _
                  &"         RTLessorAVSCustRCVHardwareDTL.MEMO " _
 &" FROM             RTLessorAVSCustRCVHardwareDTL LEFT OUTER JOIN " _
               &"            RTCode ON RTLessorAVSCustRCVHardwareDTL.UNIT = RTCode.CODE AND " _
                 &"          RTCode.KIND = 'B5' LEFT OUTER JOIN " _
                &"           RTProdD1 ON " _
                &"           RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdD1.PRODNO AND " _
                 &"          RTLessorAVSCustRCVHardwareDTL.ITEMNO = RTProdD1.ITEMNO LEFT OUTER JOIN " _
                &"           RTProdH ON RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdH.PRODNO " _
                &" where RTLessorAVSCustRCVHardwareDTL.rcvprtno='' "
  dataTable="RTLessorAVSCustRCVHardwareDTL"
  userDefineDelete="Yes"
  numberOfKey=1
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
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorAVSCustRCVHardwareDTL.rcvprtno='" & aryparmkey(0) & "' "
     searchShow="��γ渹�J" & aryparmkey(0)
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
  if userlevel=31 then DAreaID="<>'*'"
  
    If searchShow="����" Then
          sqlList="SELECT RTLessorAVSCustRCVHardwareDTL.RCVPRTNO, RTLessorAVSCustRCVHardwareDTL.ENTRYNO, " _
                     &"     RTLessorAVSCustRCVHardwareDTL.PRODNO + '-' + RTLessorAVSCustRCVHardwareDTL.ITEMNO " _
                      &"      AS Expr1, RTProdH.PRODNC, RTProdD1.SPEC, " _
                     &"      RTLessorAVSCustRCVHardwareDTL.QTY, RTCode.CODENC, " _
                  &"         RTLessorAVSCustRCVHardwareDTL.MEMO " _
 &" FROM             RTLessorAVSCustRCVHardwareDTL LEFT OUTER JOIN " _
               &"            RTCode ON RTLessorAVSCustRCVHardwareDTL.UNIT = RTCode.CODE AND " _
                 &"          RTCode.KIND = 'B5' LEFT OUTER JOIN " _
                &"           RTProdD1 ON " _
                &"           RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdD1.PRODNO AND " _
                 &"          RTLessorAVSCustRCVHardwareDTL.ITEMNO = RTProdD1.ITEMNO LEFT OUTER JOIN " _
                &"           RTProdH ON RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdH.PRODNO " _
                &" where " & searchqry & " " _
                &"           order by RTLessorAVSCustRCVHardwareDTL.entryno  "
    Else
         sqlList="SELECT RTLessorAVSCustRCVHardwareDTL.RCVPRTNO, RTLessorAVSCustRCVHardwareDTL.ENTRYNO, " _
                  &"         RTLessorAVSCustRCVHardwareDTL.PRODNO + '-' + RTLessorAVSCustRCVHardwareDTL.ITEMNO " _
                  &"          AS Expr1, RTProdH.PRODNC, RTProdD1.SPEC, " _
                  &"         RTLessorAVSCustRCVHardwareDTL.QTY, RTCode.CODENC, " _
                  &"         RTLessorAVSCustRCVHardwareDTL.MEMO " _
 &" FROM             RTLessorAVSCustRCVHardwareDTL LEFT OUTER JOIN " _
                 &"          RTCode ON RTLessorAVSCustRCVHardwareDTL.UNIT = RTCode.CODE AND " _
                  &"         RTCode.KIND = 'B5' LEFT OUTER JOIN " _
                  &"         RTProdD1 ON " _
                   &"        RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdD1.PRODNO AND " _
                   &"        RTLessorAVSCustRCVHardwareDTL.ITEMNO = RTProdD1.ITEMNO LEFT OUTER JOIN " _
                   &"        RTProdH ON RTLessorAVSCustRCVHardwareDTL.PRODNO = RTProdH.PRODNO " _
                   &" where " & searchqry & " " _
                   &" order by RTLessorAVSCustRCVHardwareDTL.entryno  "

    End If  
   'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>