<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq VoIP�޲z�t��"
  title="Sparq VoIP�Τ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  ButtonEnable="Y;N;Y;Y;Y;Y"
  functionOptName=" �� �� "
  functionOptProgram="RTSparqVoIPCustChgK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;��B�I;NCIC<br>�Τḹ�X;�Τ�W��;VoIP<br>�q�ܸ��X;�˾�����;�~�ȭ�;�g�P��;�g�P�~��;�ӽФ�;���u��;���u��;������;�h����;�@�o��"
  sqlDelete="SELECT	a.CUSID, a.NCICCUSNO, a.CUSNC, a.VOIPTEL, isnull(b.CUTNC , '')+a.TOWNSHIP2, d.CUSNC, isnull(e.shortnc, ''), "_
		   &"		a.CONSIGNEESALE, a.APPLYDAT, a.WRKRCVDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT "_
		   &"FROM	RTSparqVoIPCust a "_
		   &"		left outer join RTCounty b on a.CUTID2 = b.CUTID "_
		   &"		left outer join RTEmployee c inner join RTObj d on c.CUSID = d.CUSID on c.EMPLY = a.SALESID "_
		   &"		left outer join RTObj e on e.cusid = a.consignee "_
		   &"WHERE	CUSID ='*' "_
		   &"order by a.NCICCUSNO "

  dataTable="RTSparqVoIPCust"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTSparqVoIPCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
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
  searchProg="RTSparqVoIPCustS.asp"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.CUSID<>'' "
     searchShow="�����Τ�(���t�@�o)"
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
            DAreaID="='A1'"
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
  'if Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1 or userlevel =5 or userlevel =9 then DAreaID="<>'*'"
  
    If searchShow="����" Then
	sqlList="SELECT	a.CUSID, " _
	     &"CASE WHEN a.CONSIGNEE<>'' THEN e.SHORTNC ELSE  " _
	     &"case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
       &"CASE WHEN a.cutid2 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
       &"WHEN   a.cutid2 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
       &"ELSE '�L�k�k��' END eLSE RTCTYTOWN.operationname END  END," _
	     &"a.NCICCUSNO, substring(a.CUSNC,1,6)+'....', a.VOIPTEL, isnull(b.CUTNC , '')+a.TOWNSHIP2, d.CUSNC, isnull(e.shortnc, ''), "_
		   &"		a.CONSIGNEESALE, a.APPLYDAT, a.WRKRCVDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT "_
		   &"FROM	RTSparqVoIPCust a "_
		   &"		left outer join RTCounty b on a.CUTID2 = b.CUTID "_
		   &"		left outer join RTEmployee c inner join RTObj d on c.CUSID = d.CUSID on c.EMPLY = a.SALESID "_
		   &"		left outer join RTObj e on e.cusid = a.consignee "_
		   &" left outer join rtctytown on a.cutid2=rtctytown.cutid and a.township2=rtctytown.township " _
		   &"where " & searchqry _
		   &" order by a.NCICCUSNO "		   
    Else 
	sqlList="SELECT	a.CUSID, " _
	     &"CASE WHEN a.CONSIGNEE<>'' THEN e.SHORTNC ELSE  " _
	     &"case when RTCTYTOWN.operationname=''  OR RTCTYTOWN.operationname IS NULL then " _
       &"CASE WHEN a.cutid2 IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
       &"WHEN   a.cutid2 IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
       &"ELSE '�L�k�k��' END eLSE RTCTYTOWN.operationname END  END," _
	     &"a.NCICCUSNO, substring(a.CUSNC,1,6)+'....', a.VOIPTEL, isnull(b.CUTNC , '')+a.TOWNSHIP2, d.CUSNC, isnull(e.shortnc, ''), "_
		   &"		CONSIGNEESALE, a.APPLYDAT, a.WRKRCVDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT "_
		   &"FROM	RTSparqVoIPCust a "_
		   &"		left outer join RTCounty b on a.CUTID2 = b.CUTID "_
		   &"		left outer join RTEmployee c inner join RTObj d on c.CUSID = d.CUSID on c.EMPLY = a.SALESID "_
		   &"		left outer join RTObj e on e.cusid = a.consignee "_
		   &" left outer join rtctytown on a.cutid2=rtctytown.cutid and a.township2=rtctytown.township " _
		   &"where " & searchqry _
		   &" order by a.NCICCUSNO "		   
          
    End If  
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>