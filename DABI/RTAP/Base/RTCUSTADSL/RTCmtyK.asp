<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  '---�M��session�ܼ�
  session("CMTYNC")=""
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL(��ӱM��)��Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�Ȥ����"
  functionOptProgram="RTCUSTKX.ASP"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;����;�m��;���ϦW��;���"
   sqlDelete="SELECT DISTINCT " _
            &"rtcustadsl.cutid2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,count(*) " _
            &"FROM RTCustADSL INNER JOIN " _
            &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID " _
            &"GROUP BY rtcustadsl.cutid2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME " 
  dataTable="RTCUSTADSL"
  userDefineDelete=""
  extTable=""
  numberOfKey=3
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
  searchProg="RTCustSX.asp"
  searchFirst=false
  If searchQry="" Then
     searchShow="����"
     searchQry="RTCUSTADSL.cutid2<>'*' "
     searchQry2="HAVING COUNT(*) >=3 "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
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
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89018" or Ucase(emply)="T90076" or _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or  Ucase(emply)="T89020" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"
  '---����RTCUSTK.ASP�����O�ϥ�,��"Y"�ɪ�ܥ�RTCMTYK�I�s;���ťծɪ�ܪ����I�s!
  SESSION("FALG")="Y"
  sqllist="SELECT DISTINCT " _
         &"RTCustADSL.CUTID2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME, " _
         &"RTCounty.CUTNC, RTCustADSL.TOWNSHIP2 , " _
         &"RTCustADSL.HOUSENAME , COUNT(*) " _
         &"FROM RTCustADSL INNER JOIN " _
         &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID INNER JOIN " _
         &"RTAreaCty ON RTCounty.CUTID = RTAreaCty.CUTID INNER JOIN " _
         &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID AND AREATYPE = '1' " _
         &"WHERE " & searchqry & " AND RTAREACTY.AREAID " & DAreaid  & " and rtcustadsl.housename <> '' " _
         &"GROUP BY RTCustADSL.CUTID2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME, " _
         &"RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME, " _
         &"RTAreaCty.AREAID, RTArea.AREATYPE " _
         & searchqry2 
'  "SELECT DISTINCT " _
'            &"rtcustadsl.cutid2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,count(*) " _
'            &"FROM RTCustADSL INNER JOIN " _
'            &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID " _
'            &"where " & searchqry & " " _
'            &"GROUP BY rtcustadsl.cutid2, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME,RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.HOUSENAME " _
'            & searchqry2 
  'Response.Write "sql=" & SQLLIST
End Sub

Function SrGetCtyRef(CUTID)
    Dim conn,rs,sql
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
    sql="SELECT cutnc FROM RTCounty where cutid='" & cutid & "'" 
    rs.Open sql,conn
    If not rs.Eof Then
       SrGetctyref=rs("cutnc")
    end if
End function
%>
