<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�Τ�ȪA�沧�ʬd��"
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
  formatName="none;none;none;����;���O;���ʤ�;���ʤH��;�ӹq��;����;�@�K�@�@�@�@�@�@�@�@�@�@�n;none;none;none;none;���u���;none;���u�渹;���u����;�ȪA<br>�^�Ф�;�^�ФH��;�ȪA����;���׭�;�@�o��;none;none;none;�B�z<br>�Ѽ�"
  sqlDelete="SELECT  RTlessorCmtyLineFaqHLog.COMQ1,RTlessorCmtyLineFaqHLog.LINEQ1, RTlessorCmtyLineFaqHLog.FAQNO,RTlessorCmtyLineFaqHLog.entryno,rtcode_7.codenc,RTlessorCmtyLineFaqHLog.chgdat,rtobj_7.cusnc, RTlessorCmtyLineFaqHLog.RCVDAT, RTCode.CODENC, " _
                      &"  LEFT(RTlessorCmtyLineFaqHLog.MEMO, 12) AS Expr6, RTlessorCmtyLineFaqHLog.CONTACTTEL, RTlessorCmtyLineFaqHLog.MOBILE,  " _
                      &"  RTlessorCmtyLineFaqHLog.EMAIL,  " _
                      &"  RTlessorCmtyLineFaqHLog.SNDWORK, RTObj_4.CUSNC,  " _
                      &"  RTlessorCmtyLineFaqHLog.SNDPRTNO, RTlessorCmtyLineFaqHLog.PRTDAT, RTlessorCmtyLineFaqHLog.SNDCLOSEDAT,  " _
                      &"  RTlessorCmtyLineFaqHLog.CALLBACKDAT, RTObj_5.CUSNC AS Expr1,  " _
                      &"  RTlessorCmtyLineFaqHLog.FINISHDAT, RTObj_6.CUSNC AS Expr2,  " _
                      &"  RTlessorCmtyLineFaqHLog.CANCELDAT, RTObj_1.CUSNC AS Expr3,  " _
                      &"  RTObj_2.CUSNC AS Expr4,  " _
                      &"  RTObj_3.CUSNC AS Expr5 " _
                &"  FROM  RTEmployee RTEmployee_5 INNER JOIN " _
                      &"  RTObj RTObj_5 ON RTEmployee_5.CUSID = RTObj_5.CUSID RIGHT OUTER JOIN " _
                      &"  RTlessorCmtyLineFaqHLog ON  " _
                      &"  RTEmployee_5.EMPLY = RTlessorCmtyLineFaqHLog.CALLBACKUSR LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_4 INNER JOIN " _
                      &"  RTObj RTObj_4 ON RTEmployee_4.CUSID = RTObj_4.CUSID ON  " _ 
                      &"  RTlessorCmtyLineFaqHLog.SNDUSR = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_3 INNER JOIN " _
                      &"  RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.UUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_2 INNER JOIN " _
                      &"  RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.EUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_1 INNER JOIN " _
                      &"  RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.CANCELUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                      &"  RTObj RTObj_6 INNER JOIN " _
                      &"  RTEmployee RTEmployee_6 ON RTObj_6.CUSID = RTEmployee_6.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.FUSR = RTEmployee_6.EMPLY LEFT OUTER JOIN " _
                      &"  RTCode ON RTlessorCmtyLineFaqHLog.SERVICETYPE = RTCode.CODE AND  " _
                      &"  RTCode.KIND = 'N4'"  _
                      &"  where RTlessorCmtyLineFaqHLog.comq1=0 "
  dataTable="RTlessorCmtyLineFaqHLog"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=350,height=160,scrollbars=yes"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyH ON " _
       &"RTCounty.CUTID = RTLessorCmtyH.CUTID RIGHT OUTER JOIN RTlessorCmtyLine ON RTLessorCmtyH.COMQ1 = RTlessorCmtyLine.COMQ1 " _
       &"where RTlessorCmtyLine.comq1=" & ARYPARMKEY(0) 
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorCmtyLine.CUTID " _
       &"where RTlessorCmtyLine.comq1=" & ARYPARMKEY(0) & " and RTlessorCmtyLine.lineq1=" & ARYPARMKEY(1) 
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
     searchQry=" RTlessorCmtyLineFaqHLog.comq1=" & aryparmkey(0) & " and RTlessorCmtyLineFaqHLog.lineq1=" & aryparmkey(1) & "  and RTlessorCmtyLineFaqHLog.faqno='" & aryparmkey(2) & "'"
     searchShow="�D�u�Ǹ��J"& ARYPARMKEY(0)  &"-" & ARYPARMKEY(1)  & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR
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
  
         sqlList="SELECT  RTlessorCmtyLineFaqHLog.comq1,RTlessorCmtyLineFaqHLog.lineq1, RTlessorCmtyLineFaqHLog.FAQNO,RTlessorCmtyLineFaqHLog.entryno,rtcode_7.codenc,RTlessorCmtyLineFaqHLog.chgdat,rtobj_7.cusnc, RTlessorCmtyLineFaqHLog.RCVDAT, RTCode.CODENC, " _
                      &"  LEFT(RTlessorCmtyLineFaqHLog.MEMO, 15) AS Expr6,RTlessorCmtyLineFaqHLog.CONTACTTEL, RTlessorCmtyLineFaqHLog.MOBILE,  " _
                      &"  RTlessorCmtyLineFaqHLog.EMAIL, RTlessorCmtyLineFaqHLog.PRTDAT,  " _
                      &"  RTlessorCmtyLineFaqHLog.SNDWORK, RTObj_4.CUSNC,  " _
                      &"  RTlessorCmtyLineFaqHLog.SNDPRTNO, RTlessorCmtyLineFaqHLog.SNDCLOSEDAT,  " _
                      &"  RTlessorCmtyLineFaqHLog.CALLBACKDAT, RTObj_5.CUSNC AS Expr1,  " _
                      &"  RTlessorCmtyLineFaqHLog.FINISHDAT, RTObj_6.CUSNC AS Expr2,  " _
                      &"  RTlessorCmtyLineFaqHLog.CANCELDAT, RTObj_1.CUSNC AS Expr3,  " _
                      &"   RTObj_2.CUSNC AS Expr4,  " _
                      &"  RTObj_3.CUSNC AS Expr5,case when RTlessorCmtyLineFaqHLog.finishdat is null then datediff(dd,RTlessorCmtyLineFaqHLog.rcvdat,getdate())+1 else datediff(dd,RTlessorCmtyLineFaqHLog.rcvdat,RTlessorCmtyLineFaqHLog.finishdat)+1 end " _
                &"  FROM  RTEmployee RTEmployee_5 INNER JOIN " _
                      &"  RTObj RTObj_5 ON RTEmployee_5.CUSID = RTObj_5.CUSID RIGHT OUTER JOIN " _
                      &"  RTlessorCmtyLineFaqHLog ON  " _
                      &"  RTEmployee_5.EMPLY = RTlessorCmtyLineFaqHLog.CALLBACKUSR LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_4 INNER JOIN " _
                      &"  RTObj RTObj_4 ON RTEmployee_4.CUSID = RTObj_4.CUSID ON  " _ 
                      &"  RTlessorCmtyLineFaqHLog.SNDUSR = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_3 INNER JOIN " _
                      &"  RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.UUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_2 INNER JOIN " _
                      &"  RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.EUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
                      &"  RTEmployee RTEmployee_1 INNER JOIN " _
                      &"  RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.CANCELUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                      &"  RTObj RTObj_6 INNER JOIN " _
                      &"  RTEmployee RTEmployee_6 ON RTObj_6.CUSID = RTEmployee_6.CUSID ON  " _
                      &"  RTlessorCmtyLineFaqHLog.FUSR = RTEmployee_6.EMPLY LEFT OUTER JOIN " _
                      &"  RTCode ON RTlessorCmtyLineFaqHLog.SERVICETYPE = RTCode.CODE AND  " _
                      &"  RTCode.KIND = 'N4' left outer join RTcode rtcode_7 on RTlessorCmtyLineFaqHLog.chgcode=rtcode_7.code and rtcode_7.kind='G2' "  _
                      &"  LEFT OUTER JOIN RTemployee rtemployee_7 on RTlessorCmtyLineFaqHLog.chgusr=rtemployee_7.emply left outer join " _
                      &"  rtobj rtobj_7 on rtemployee_7.cusid=rtobj_7.cusid " _
                      &"  where RTlessorCmtyLineFaqHLog.comq1=" & aryparmkey(0) & " and RTlessorCmtyLineFaqHLog.lineq1=" & aryparmkey(1) & " and RTlessorCmtyLineFaqHLog.faqno='" & aryparmkey(2) & "' and " & searchqry

 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>