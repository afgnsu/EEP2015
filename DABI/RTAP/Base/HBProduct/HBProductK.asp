<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="��B�Ʒ~���~�Z�ؼ�"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & "Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptOpen="'"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�~��;���;�~�ȲէO;���~�W��;�ؼФ��;��ڤ��;�F���v(%);�ժ��m�W"
sqlDelete="SELECT RTTEAMGOAL.NYY , RTTEAMGOAL.NMM , RTSalesGroup.GROUPNC, RTProduct.PNAME, RTTEAMGOAL.GOAL, " _
         &"RTTEAMGOAL.ACTUAL,case when rtteamgoal.actual > 0 then round(RTTEAMGOAL.ACTUAL/RTTEAMGOAL.GOAL,2) * 100 else 0 end, RTObj.SHORTNC FROM RTObj RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTTEAMGOAL LEFT OUTER JOIN RTProduct ON RTTEAMGOAL.PRODUCT = RTProduct.PID LEFT OUTER JOIN " _
         &"RTSalesGroup ON RTTEAMGOAL.AREAID = RTSalesGroup.AREAID AND " _
         &"RTTEAMGOAL.GROUPID = RTSalesGroup.GROUPID ON RTEmployee.EMPLY = RTTEAMGOAL.TEAMLEADER " _
         &" order by RTSalesGroup.GROUPNC,RTTEAMGOAL.NYY,RTTEAMGOAL.NMM   "
  dataTable="RTTeamGoal"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=5
  dataProg="RTTeamGoalD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=520,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTTeamGoalS.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" RTSalesGroup.GROUPNC<>'*' " 
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT RTTEAMGOAL.NYY , RTTEAMGOAL.NMM , RTSalesGroup.GROUPNC, RTProduct.PNAME, RTTEAMGOAL.GOAL, " _
         &"RTTEAMGOAL.ACTUAL,case when rtteamgoal.actual > 0 then round(RTTEAMGOAL.ACTUAL/RTTEAMGOAL.GOAL,2) * 100 else 0 end , " _
         &"RTObj.SHORTNC FROM RTObj RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTTEAMGOAL LEFT OUTER JOIN RTProduct ON RTTEAMGOAL.PRODUCT = RTProduct.PID LEFT OUTER JOIN " _
         &"RTSalesGroup ON RTTEAMGOAL.AREAID = RTSalesGroup.AREAID AND " _
         &"RTTEAMGOAL.GROUPID = RTSalesGroup.GROUPID ON RTEmployee.EMPLY = RTTEAMGOAL.TEAMLEADER " _
         &"where " & searchqry _
         &" order by RTSalesGroup.GROUPNC,RTTEAMGOAL.NYY,  RTTEAMGOAL.NMM "
 ' Response.Write sqllist
End Sub
%>
