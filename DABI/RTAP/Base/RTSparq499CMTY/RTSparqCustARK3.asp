<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t�պ޲z�t��"
  title="�t�ըC���������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����Τ�Excel��;�����Τ�;�w�R�Τ�;���R�Τ�"
  functionOptProgram="/Report/SparqADSL/RTSparqCustARK3Dxls.asp;RTSparqCustARK3D.ASP;RTSparqCustARK3D1.ASP;RTSparqCustARK3D2.ASP"
  functionOptPrompt="N;N;N;N"
  functionoptopen="1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�b��<BR>�~��;�b��<BR>���;��קO;�`���B;�w�R���B;���R���B;�`����;�w�R<BR>����;���R<BR>����"
  sqlDelete="SELECT TYY, TMM, 'Sparq399', sum(amt), sum(realamt), sum(amt)- sum(realamt), count(*), " &_
			"sum(case when MDAT is not null then 1 else 0 end), " &_
			"count(*) - sum(case when MDAT is not null then 1 else 0 end) " &_
			"FROM RTSparqAdslCustARDTL " &_
			"WHERE (CANCELDAT is null) " &_
			"GROUP BY TYY, TMM " &_                
  dataTable="RTSparqCustARDTL"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
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
  colSplit=2
  keyListPageSize=50
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
     searchQry="   "
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
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31  then DAreaID="<>'*'"
  
	sqlList="SELECT TYY, TMM, 'Sparq399', sum(amt), sum(realamt), sum(amt)- sum(realamt), count(*), " &_
			"		sum(case when MDAT is not null then 1 else 0 end), " &_
			"		count(*) - sum(case when MDAT is not null then 1 else 0 end) " &_
			"FROM RTSparqAdslCustARDTL " &_
			"WHERE (CANCELDAT is null) " &_
			"GROUP BY TYY, TMM " &_
			"union " &_
			"SELECT TYY, TMM, 'Sparq499', sum(amt), sum(realamt), sum(amt)- sum(realamt), count(*), " &_
			"		sum(case when MDAT is not null then 1 else 0 end), " &_
			"		count(*) - sum(case when MDAT is not null then 1 else 0 end) " &_
			"FROM RTSparq499CustARDTL " &_
			"WHERE (CANCELDAT is null) " &_
			"GROUP BY TYY, TMM " &_
			"ORDER BY TYY,TMM "

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>