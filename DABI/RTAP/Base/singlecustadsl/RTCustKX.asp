<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�q���޳N;�M�P�q��;�ȶD�B�z"
  functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Ȥ�N��;none;�Ȥ�W��;�ӽг渹;���ϦW��;�ӽФ�;�^�Ф��;�Ѽ�;�˾��a�};�p���q��"
   sqlDelete="SELECT singlecustadsl.CUSID, singlecustadsl.ENTRYNO, RTObj.SHORTNC,singlecustadsl.orderno,singlecustadsl.HOUSENAME, " _
         &"singlecustadsl.RCVD,singlecustadsl.REPLYDATE,CASE WHEN singlecustadsl.RCVD IS NOT NULL AND singlecustadsl.REPLYDATE IS NOT NULL " _
         &"THEN ltrim(str(Datediff(mi, singlecustadsl.RCVD, singlecustadsl.REPLYDATE)/1440)) " _
         &"WHEN singlecustadsl.RCVD IS NOT NULL AND singlecustadsl.REPLYDATE IS NULL " _
         &"THEN ltrim(str(Datediff(mi, singlecustadsl.RCVD, GETDATE())/1440)) ELSE 0 END, " _
         &"RTCOUNTY.CUTNC + singlecustadsl.TOWNSHIP2 + singlecustadsl.RADDR2, " _
         &"singlecustadsl.HOME " _
         &"FROM singlecustadsl INNER JOIN " _
         &"RTObj ON singlecustadsl.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON singlecustadsl.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON singlecustadsl.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON singlecustadsl.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE singlecustadsl.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, singlecustadsl.TOWNSHIP2, singlecustadsl.RADDR2,rtobj.shortnc "
  dataTable="singlecustadsl"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchFirst=false
  searchqry="singlecustadsl.cutid2='" & aryparmkey(0) & "' and singlecustadsl.township2='" & aryparmkey(1) & "' and singlecustadsl.housename='" & aryparmkey(2) & "' "
  If searchQry="" Then
     searchShow="����"
     searchQry="singlecustadsl.CUSID<>'*' "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  sqllist="SELECT singlecustadsl.CUSID, singlecustadsl.ENTRYNO, RTObj.SHORTNC,singlecustadsl.orderno,singlecustadsl.HOUSENAME, " _
         &"singlecustadsl.RCVD,singlecustadsl.REPLYDATE,CASE WHEN singlecustadsl.RCVD IS NOT NULL AND singlecustadsl.REPLYDATE IS NOT NULL " _
         &"THEN ltrim(str(Datediff(mi, singlecustadsl.RCVD, singlecustadsl.REPLYDATE)/1440)) " _
         &"WHEN singlecustadsl.RCVD IS NOT NULL AND singlecustadsl.REPLYDATE IS NULL " _
         &"THEN ltrim(str(Datediff(mi, singlecustadsl.RCVD, GETDATE())/1440)) ELSE 0 END, " _
         &"RTCOUNTY.CUTNC + singlecustadsl.TOWNSHIP2 + singlecustadsl.RADDR2, " _
         &"singlecustadsl.HOME " _
         &"FROM singlecustadsl INNER JOIN " _
         &"RTObj ON singlecustadsl.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON singlecustadsl.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON singlecustadsl.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON singlecustadsl.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " _
         &"ORDER BY RTCOUNTY.CUTNC, singlecustadsl.TOWNSHIP2, singlecustadsl.RADDR2,rtobj.shortnc "
 ' Response.Write "sql=" & SQLLIST
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
'         SelSql="select cusid from singlecustadsl where cusid=" & cusidary(i) 
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
