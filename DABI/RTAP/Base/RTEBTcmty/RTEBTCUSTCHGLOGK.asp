<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="元訊寬頻網路股份有限公司"
  system="東森AVS管理系統"
  title="AVS用戶報竣異動資料查詢"
  buttonName=" 新增 ; 刪除 ; 結束 ;重新整理;頁數;功能選項"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
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
  formatName="none;none;none;none;項次;主線;異動日期;異動類別;異動人員;用戶異動申請日;作廢日;申請確認日;申請轉檔日;申請轉檔批號;異動完成日;異動回報確認日;異動回報轉檔日;回報轉檔批號"
  sqlDelete="SELECT       RTEBTCUSTCHGLOG.COMQ1, RTEBTCUSTCHGLOG.LINEQ1, " _
           &"RTEBTCUSTCHGLOG.CUSID, RTEBTCUSTCHGLOG.ENTRYNO, " _
           &"RTEBTCUSTCHGLOG.SEQ, rtrim(convert(char(6),RTEBTCUSTCHGLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTCHGLOG.lineQ1))  as comqline, RTEBTCUSTCHGLOG.CHGDAT, RTCode.CODENC, " _
           &"RTObj.CUSNC, RTEBTCUSTCHGLOG.APPLYDAT, " _
           &"RTEBTCUSTCHGLOG.DROPDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSCHKDAT, RTEBTCUSTCHGLOG.TRANSDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSNO, RTEBTCUSTCHGLOG.FINISHDAT, " _
           &"RTEBTCUSTCHGLOG.FINISHCHKDAT,RTEBTCUSTCHGLOG.FINISHTNSDAT,RTEBTCUSTCHGLOG.FINISHTNSNO fROM RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTEBTCUSTCHGLOG ON  RTEmployee.EMPLY = RTEBTCUSTCHGLOG.CHGUSR LEFT OUTER JOIN " _
           &"RTCode ON RTEBTCUSTCHGLOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' " _
           &"where RTEBTCUSTCHGLOG.COMQ1=0 ORDER BY  RTEBTCUSTCHGLOG.SEQ "
  dataTable="RTEBTCUSTLOG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="下列資料將被刪除，請按確認刪除之，或按取消。"
  diaButtonName=" 確認刪除 ; 取消 "
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
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTEBTCMTYline LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYline.CUTID1=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
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
  sqlYY="select * from RTEBTCUST  where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1) & " AND CUSID='" & ARYPARMKEY(2) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     CUSNC=rsYY("CUSNC")
  else
     CUSNC=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCUSTCHGLOG.ComQ1=" & aryparmkey(0) & " and RTEBTCUSTCHGLOG.lineq1=" & aryparmkey(1) & " AND RTEBTCUSTCHGLOG.CUSID='" & ARYPARMKEY(2) & "' "
     searchShow="主線︰"& aryparmkey(0)& "-" & aryparmkey(1) & ",社區︰" & COMN & ",主線位址︰" & COMADDR & ",用戶序號︰" & aryparmkey(2) & ",用戶名稱︰" & CUSNC
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  '讀取登入帳號之群組資料
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:為業務工程師==>只能看所屬社區資料
  'DOMAIN:'T','C','K'北中南轄區人員(客服,技術)只能看所屬轄區資料
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
  '高階主管可讀取全部資料
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '資訊部管理員可讀取全部資料
  'if userlevel=31 then DAreaID="<>'*'"
  
  '由於分公司搬家尚未申請到線路，故客服先開放所有區域權限，一律讓台北客服處理
  if userlevel=31  then DAreaID="<>'*'"
  
    If searchShow="全部" Then
         sqlList="SELECT       RTEBTCUSTCHGLOG.COMQ1, RTEBTCUSTCHGLOG.LINEQ1, " _
           &"RTEBTCUSTCHGLOG.CUSID, RTEBTCUSTCHGLOG.ENTRYNO, " _
           &"RTEBTCUSTCHGLOG.SEQ, rtrim(convert(char(6),RTEBTCUSTCHGLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTCHGLOG.lineQ1))  as comqline, RTEBTCUSTCHGLOG.CHGDAT, RTCode.CODENC, " _
           &"RTObj.CUSNC, RTEBTCUSTCHGLOG.APPLYDAT, " _
           &"RTEBTCUSTCHGLOG.DROPDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSCHKDAT, RTEBTCUSTCHGLOG.TRANSDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSNO, RTEBTCUSTCHGLOG.FINISHDAT, " _
           &"RTEBTCUSTCHGLOG.FINISHCHKDAT,RTEBTCUSTCHGLOG.FINISHTNSDAT,RTEBTCUSTCHGLOG.FINISHTNSNO fROM RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTEBTCUSTCHGLOG ON  RTEmployee.EMPLY = RTEBTCUSTCHGLOG.CHGUSR LEFT OUTER JOIN " _
           &"RTCode ON RTEBTCUSTCHGLOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' " _
           &"where " & searchqry & " ORDER BY seq "
    Else
         sqlList="SELECT       RTEBTCUSTCHGLOG.COMQ1, RTEBTCUSTCHGLOG.LINEQ1, " _
           &"RTEBTCUSTCHGLOG.CUSID, RTEBTCUSTCHGLOG.ENTRYNO, " _
           &"RTEBTCUSTCHGLOG.SEQ, rtrim(convert(char(6),RTEBTCUSTCHGLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTCHGLOG.lineQ1))  as comqline, RTEBTCUSTCHGLOG.CHGDAT, RTCode.CODENC, " _
           &"RTObj.CUSNC, RTEBTCUSTCHGLOG.APPLYDAT, " _
           &"RTEBTCUSTCHGLOG.DROPDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSCHKDAT, RTEBTCUSTCHGLOG.TRANSDAT, " _
           &"RTEBTCUSTCHGLOG.TRANSNO, RTEBTCUSTCHGLOG.FINISHDAT, " _
           &"RTEBTCUSTCHGLOG.FINISHCHKDAT,RTEBTCUSTCHGLOG.FINISHTNSDAT,RTEBTCUSTCHGLOG.FINISHTNSNO fROM RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTEBTCUSTCHGLOG ON  RTEmployee.EMPLY = RTEBTCUSTCHGLOG.CHGUSR LEFT OUTER JOIN " _
           &"RTCode ON RTEBTCUSTCHGLOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' " _
           &"where " & searchqry & " ORDER BY seq "
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>