<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�Τ��������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �R  �b ;�R�b����;�b�ک���;�W�ӥ��R(Excel)"
  functionOptProgram="RTLessorCustARClear.asp;RTLessorCustARClearK.asp;RTLessorCustARDTLK.ASP;RTLessorCustArCSXls.asp"
  functionOptPrompt="Y;N;N;N"
  functionoptopen="2;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�b�ڽs��;����;�Ȥ�;AR/AP;����;���R<br>���B;�w�R<br>���B;���R<br>���B;�R�b��;�R�b��;�R�߶��@;�R�߶��G;none;���ͤ�;�@�o��;�@�o��;�@�o��];�h����"
  sqlDelete="SELECT  RTLessorCustAR.CUSID, RTLessorCustAR.BATCHNO, RTLessorCmtyH.COMN,RTLessorCust.CUSNC," _
                &" RTCode.CODENC, RTLessorCustAR.PERIOD,RTLessorCustAR.AMT,RTLessorCustAR.REALAMT," _
                &"RTLessorCustAR.AMT - RTLessorCustAR.REALAMT AS DIFFAMT, RTLessorCustAR.MDAT, RTObj_1.CUSNC AS MUSR, " _
                &"RTLessorCustAR.COD1, RTLessorCustAR.COD2,RTLessorCustAR.COD3, RTLessorCustAR.CDAT, " _
                &"RTLessorCustAR.CANCELDAT, RTObj_2.CUSNC AS CANCELUSR, " _
                &", RTLessorCustAR.CANCELMEMO, RTLessorCust.dropdat " _
                &"FROM    RTLessorCmtyH RIGHT OUTER JOIN RTLessorCust ON RTLessorCmtyH.COMQ1 = RTLessorCust.COMQ1 " _
                &"RIGHT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = " _
                &"RTObj_2.CUSID RIGHT OUTER JOIN RTLessorCustAR ON RTEmployee_2.EMPLY = RTLessorCustAR.CANCELUSR " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                &"RTObj_1.CUSID ON RTLessorCustAR.MUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTCode ON RTLessorCustAR.ARTYPE = RTCode.CODE AND RTCode.KIND = 'N2' ON RTLessorCust.CUSID = " _
                &"RTLessorCustAR.CUSID " _
                &"WHERE RTLessorCustAR.cusid='' "
  dataTable="RTLESSORCUSTLOG"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=350,height=250,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="500"
  diaHeight="500"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorcustARS1.ASP"
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
     searchQry="  (RTLessorCustAR.AMT <> RTLessorCustAR.REALAMT) and RTLessorCustAR.canceldat is null "
     searchShow="�������R�P�b��"
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
  
         sqlList="SELECT  RTLessorCustAR.CUSID, RTLessorCustAR.BATCHNO, RTLessorCmtyH.COMN,RTLessorCust.CUSNC," _
                &"RTCode.CODENC, RTLessorCustAR.PERIOD,RTLessorCustAR.AMT,RTLessorCustAR.REALAMT, " _
                &"RTLessorCustAR.AMT - RTLessorCustAR.REALAMT AS DIFFAMT, RTLessorCustAR.MDAT, RTObj_1.CUSNC AS MUSR," _
                &"RTLessorCustAR.COD1, " _
                &"case when RTLessorCustAR.COD2 like '�W��%' then '<font color =blue>'+RTLessorCustAR.COD2+'</font>' " _
				&"		when RTLessorCustAR.COD2 like '�h��%' then '<font color =red>'+RTLessorCustAR.COD2+'</font>' " _
				&"		when RTLessorCustAR.COD2 like '�H�Υd%' then '<font color =green>'+RTLessorCustAR.COD2+'</font>' " _
				&"else RTLessorCustAR.COD2 end, " _
                &"RTLessorCustAR.COD3, RTLessorCustAR.CDAT, RTLessorCustAR.CANCELDAT, RTObj_2.CUSNC AS CANCELUSR, " _
                &"RTLessorCustAR.CANCELMEMO, RTLessorCust.dropdat " _
                &"FROM    RTLessorCmtyH RIGHT OUTER JOIN RTLessorCust ON RTLessorCmtyH.COMQ1 = RTLessorCust.COMQ1 " _
                &"RIGHT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = " _
                &"RTObj_2.CUSID RIGHT OUTER JOIN RTLessorCustAR ON RTEmployee_2.EMPLY = RTLessorCustAR.CANCELUSR " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                &"RTObj_1.CUSID ON RTLessorCustAR.MUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTCode ON RTLessorCustAR.ARTYPE = RTCode.CODE AND RTCode.KIND = 'N2' ON RTLessorCust.CUSID = " _
                &"RTLessorCustAR.CUSID " _
                &"WHERE " & searchqry & " " _ 
                &"ORDER BY  RTLessorCustAR.CDAT desc" 


  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>