<%@ Language=VBScript%>
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%  '---exist(0):�w��ܤ����u�}�C;exist(1):�w�˭����O
    Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
    'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
    'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
    '�ȪA��:B400,�޳N��:B500,�x�_�~�ȳ�:B100,�x��:B300,����:B200
    Domain=Mid(Emply,1,1)
    Exist=split(request("parm"),"@")
    set conn=server.CreateObject("ADODB.Connection")
    set rs=server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLib"
    Conn.Open DSN
    Usrary=split(exist(0),";")
    usr=""
    if Ubound(Usrary) >= 0 then
       existUsr="("
       for i=0 to Ubound(usrary)
           existUsr=existUsr & "'" & usrary(i) & "',"
       next
       existUsr=mid(existUsr,1,len(existUsr)-1)
       existUsr=existUsr & ")"
       usr=" and rtemployee.emply not in " & existUsr    
    else
       usr=""
    end if
    '--�w�˭����O:("")�����,("1")�~�Ȧۦ�w��,("2")�޳N���w��,("3")�t�Ӧw��
    select case exist(1)
      case "1"
         if Domain="T" or Domain="P" then
            usr=usr & " and rtemployee.authlevel in ('2') and rtemployee.tran2<>'10' and (rtemployee.dept ='B100' or rtemployee.dept ='B600') "
         elseif Domain="C" then
            usr=usr & " and rtemployee.authlevel in ('2') and rtemployee.tran2<>'10' and rtemployee.dept='B300' "     
         elseif Domain="K" then
            usr=usr & " and rtemployee.authlevel in ('2') and rtemployee.tran2<>'10' and rtemployee.dept='B200' "  
         else
            usr=usr & " and rtemployee.authlevel in ('2') and rtemployee.tran2<>'10' and rtemployee.dept='*' "           
         end if                  
      case "2"
         if Domain="T" or Domain="P" then
            usr=usr & " and rtemployee.tran2<>'10' and rtemployee.dept in ('B700', 'B701')  "
         else
            usr=usr & " and rtemployee.tran2<>'10' and rtemployee.dept='*'  "
         end if
      case else
       '255:�ت��O���n�e�{������u�ѿ��(���i�j��256==>tinyint maxnumber)
         usr=usr & " and rtemployee.dept='*' "
    end select
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          & usr            
    rs.Open sql,conn
    s1=""
    Do While Not rs.Eof
       s1=s1 &"<option value=""" &rs("emply") &""">" &rs("cusnc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
    
    sql=""
    usr=""
    If UBound(UsrAry) >= 0 Then 
       usr=" rtemployee.emply IN " & existusr
    else
       usr=" rtemployee.emply ='*'"
    end if
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
       &"FROM RTEmployee INNER JOIN " _
       &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' AND " _
       & usr 
    rs.Open sql,conn
    s2=""
    Do While Not rs.Eof
       s2=s2 &"<option value=""" &rs("emply") &""">" &rs("cusnc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
    conn.Close   
    set rs=Nothing   
    set conn=Nothing
%>
<HTML>
<HEAD>
<META name=VI60_DTCScriptingPlatform content="Server (ASP)">
<META name=VI60_defaultClientScript content=VBScript>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>�w�˭��u��ܲM��</TITLE>
</HEAD>
<BODY style="BACKGROUND: lightblue">
<SCRIPT LANGUAGE="VBScript">
  ReturnValue=""
  Sub cmdSure_onClick
    sel=""
    selname=""
    For i = 0 To lstOrder2.Length - 1
      sel=sel & lstOrder2(i).value & ";"
      selname=selname & lstorder2(i).innertext & ";"
    Next
    if len(sel) > 0 then
       returnValue=mid(sel,1,len(sel)-1) & "@" & mid(selname,1,len(selname)-1)
    else
       returnvalue="" & "@" & ""
    end if
    window.close
  End Sub

  Sub lstOrder1_add(valuetext)
    str=split(valuetext,";")
    Set objent=Document.CreateElement("OPTION")
    objent.Text=str(1)
    objent.Value=str(0)
    lstOrder1.Add objent
  End Sub
  
  Sub lstOrder2_add(valuetext)
    str=split(valuetext,";")
    Set objent=Document.CreateElement("OPTION")
    objent.Text=str(1)
    objent.Value=str(0)
    lstOrder2.Add objent
  End Sub

  Sub cmdRight_onclick()
      j=lstOrder1.Length - 1
      For i=0 to j
          if lstOrder1(i).selected then
             lstOrder2_add(lstOrder1(i).value & ";" & lstorder1(i).innertext)
          end if
      Next
      For i=J to 0 step -1
          if lstOrder1(i).selected then
             lstOrder1.remove lstOrder1.SelectedIndex
          end if
      Next      
  End Sub
  
  Sub cmdLeft_onclick()
      j=lstOrder2.Length - 1
      For i=0 to j
          if lstOrder2(i).selected then
             lstOrder1_add(lstOrder2(i).value & ";" & lstorder2(i).innertext)
          end if
      Next  
      For i=J to 0 step -1
          if lstOrder2(i).selected then
             lstOrder2.remove lstOrder2.SelectedIndex
          end if
      Next            
  End Sub
 
  Sub cmdCancel_onClick()
      returnvalue=false
      window.close
  End Sub

</SCRIPT>
<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 16px; POSITION: absolute; TOP: 15px; WIDTH: 153px" ID=select1>
<LEGEND>�i��ܭ��u</LEGEND>
<SELECT id=lstOrder1 size=5  multiple
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 126px">
<%=s1%>
</SELECT>
</FIELDSET>&nbsp; 

<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 234px; POSITION: absolute; TOP: 15px; WIDTH: 150px" ID=select2>
<LEGEND>�w��ܭ��u</LEGEND>
<SELECT id=lstOrder2 size=5  multiple
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 126px">
<%=s2%>
</SELECT>

</FIELDSET>&nbsp;&nbsp; 
<INPUT TYPE="button" VALUE=" >"
       ID="cmdRight" STYLE    ="HEIGHT: 24px; LEFT: 181px; POSITION: absolute; TOP: 86px; WIDTH: 40px"> 
<INPUT id=cmdCancel style="LEFT: 182px; POSITION: absolute; TOP: 227px" type=button value=����> 
<INPUT TYPE="button" VALUE=" <"
       ID="cmdLeft" STYLE    ="HEIGHT: 24px; LEFT: 181px; POSITION: absolute; TOP: 128px; WIDTH: 40px"> 
<INPUT id=cmdSure style="LEFT: 182px; POSITION: absolute; TOP: 266px" type=button value=�T�w>
</BODY>

</HTML>
