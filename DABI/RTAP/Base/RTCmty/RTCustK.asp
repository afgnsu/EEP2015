<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�o�]�q��;�M�P�q��;�ȶD�B�z;��������;���v����;CALL-OUT;�M���D�u�վ�"
  functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP;RTCUSTCHGOPT.ASP;RTcusthbchgk.asp;/WEBAP/RTAP/BASE/HBCALLOUTPROJECT/RTCUSTOPTK.ASP;RTCUSTLINEADJFLGCLR.ASP"
  functionOptPrompt ="Y;Y;N;Y;Y;N;Y"
  functionoptopen   ="1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  '====================== history until 90/12/28=================================
  'formatName="none;�Ȥ�N��;�榸;�W��;�}�o����;�ӽФ�;�p���q��;���q�q��;�o�]��;���u��;�M�P���;�w�˭����O"
  ' sqlDelete="SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO, RTObj.SHORTNC, " _
  '       &"RTCust.CUSTYPE, RTCust.RCVD, RTCust.HOME, " _
  '       &"RTCust.OFFICE + ' ' + RTCust.EXTENSION AS Office,  " _
  '       &"RTCust.REQDAT,rtcust.finishdat,RTCUST.DROPDAT, RTCode.CODENC " _
  '       &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
  '       &"RTCounty ON RTCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN RTCode ON RTCust.SETTYPE = RTCode.CODE " _
  '       &"WHERE RTCust.COMQ1=0 AND (RTCode.KIND = 'A7') " _
  '       &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO " 
  '===============================================================================
  formatName="none;none;none;�Ȥ�W��;�Ȥ�IP;�ӽФ�;���u��;������;��h��;���;�p���q��;�˾��a�};�줽�ǹq��;�P�N�ѽs��;none;FTTB-HNNO;FTTB�e���"
  sqlDelete= "SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO, RTObj.SHORTNC, " &_
             "		RTCust.IP, RTCust.RCVD, RTCust.FINISHDAT, RTCust.DOCKETDAT, " &_
             "		RTCust.DROPDAT, RTCust.OVERDUE, RTCust.HOME, " &_
             "		IsNull(RTCounty.CUTNC,'') + RTCust.TOWNSHIP1 + RTCust.RADDR1, " &_
             "		RTCust.OFFICE + Case When RTCust.OFFICE<>'' and RTCust.EXTENSION <>'' then '#' else ' ' end + RTCust.EXTENSION AS Office,rtcust.consentno " &_
			 "FROM	RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " &_
			 "	    LEFT OUTER JOIN RTCounty ON RTCust.CUTID1 = RTCounty.CUTID " &_
             "WHERE RTCust.COMQ1=0 " &_
             "ORDER BY RTObj.SHORTNC,RTCust.CUSID, RTCust.ENTRYNO, RTCust.DOCKETDAT " 
  dataTable="RTCust"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=3
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20
  searchProg="rtcustS.asp"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTCust.CUSID<>'*' "
     searchShow="����"
  ELSE
     searchFirst=False
  End If  
 ' searchShow=FrGetCmtyDesc(aryParmKey(0))
  sqllist="SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO, RTObj.SHORTNC, " &_
          "		RTCust.IP, RTCust.RCVD, RTCust.FINISHDAT, RTCust.DOCKETDAT, " &_
          "		RTCust.DROPDAT, RTCust.OVERDUE, RTCust.HOME, " &_
          "		IsNull(RTCounty.CUTNC,'') + RTCust.TOWNSHIP1 + RTCust.RADDR1, " &_
          "		RTCust.OFFICE + Case When RTCust.OFFICE<>'' and RTCust.EXTENSION <>'' then '#' else ' ' end + RTCust.EXTENSION AS Office,rtcust.consentno,RTCODE.CODENC,  " &_
	      "    fttbcust.fttbcusno,fttbcust.snddat " & _
	      "FROM	RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " &_
		  "	    LEFT OUTER JOIN RTCounty ON RTCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN RTCODE ON RTCUST.CUSTLINEADJFLG=RTCODE.CODE AND RTCODE.KIND='L2' " &_
        "left outer join fttbcust on rtcust.comq1=fttbcust.comq1 and rtcust.cusid=fttbcust.cusid and rtcust.entryno=fttbcust.entryno " & _
          "WHERE "& searchqry &" and RTCust.COMQ1=" & aryParmKey(0) &" "&_
          "ORDER BY RTObj.SHORTNC,RTCust.CUSID, RTCust.ENTRYNO, RTCust.DOCKETDAT " 
  'Response.Write "sql=" & SQLLIST
  SESSION("COMQ1XX")=ARYPARMKEY(0)
  Dim conn,i,rsc,rs
  Set conn=Server.CreateObject("ADODB.Connection")
  Set rs=Server.CreateObject("ADODB.RecordSet")  
  DSN="DSN=RTLIB"
  sql="SELECT COMQ1,COMTYPE FROM RTCMTY WHERE COMQ1=" & ARYPARMKEY(0)
  conn.Open DSN  
  RS.Open SQL,CONN
  IF RS("COMTYPE") >="01" AND RS("COMTYPE") <="05" THEN
     SESSION("COMTYPEXX")="1"
  ELSE
     SESSION("COMTYPEXX")="4"
  END IF
End Sub
Sub SrRunUserDefineDelete()
'(1)900413:���קKadsl�Ȥ���@�{���Phb�Ȥ���@�{����R����(�]��H�Ҭ��Ȥ�'05')�ӳy��objlink��obj�L�kmatch,�]��obj��objlink�אּ���R��
'========900413 modify start
'  Dim conn,i,rsc,rs
'  Set conn=Server.CreateObject("ADODB.Connection")
'  Set rs=Server.CreateObject("ADODB.RecordSet")  
'  Set rsc=Server.CreateObject("ADODB.RecordSet")    
'  On Error Resume Next  
'  conn.Open DSN
'  If Len(extDeleList(2)) > 0 Then
'     CUSIDXX=replace(extDeleList(2),"(","")
'     CUSIDXX=replace(CUSIDXX,")","")     
'     CUSIDARY=split(cusidxx,",")
'     for i=0 to Ubound(cusidary)
'         SelSql="select cusid from rtcust where cusid=" & cusidary(i) 
'         rsc.open selsql,conn
'         if rsc.eof then
'            delSql="DELETE  FROM RTObjLink WHERE CUSTYID='05' AND CUSID = " &cusidary(i) &" "
'            conn.Execute delSql  
'            SelSql="Select cusid FROM RTObjLink WHERE  CUSID = " &cusidary(i) &" "
'            rs.Open selsql,conn
            '��objlink�w�L�ӹ�H�N�X�䥦���s��,�~�R����H�D��(�H�קK�ӹ�H���䥦��H
            '���O��,�o�N��H�D�ɧR�������~
'            if rs.EOF then                    
'               delSql="DELETE  FROM RTObj WHERE CUSID = " &cusidary(i) &" " 
'               conn.Execute delSql
'            end if
'            rs.close
'          End If
'          rsc.close
'      next
'   end if
'   conn.close
'   set rs=nothing
'   set rsc=nothing
'   set conn=nothing
'========900413 modify end   
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->