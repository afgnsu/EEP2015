<%@ Language=VBScript%>
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<% 
   'showopt="Y;Y;Y;Y"��ܹ�ܤ�����n��ܪ�����(�~�Ȥu�{�v;�ȪA�H��;�޳N��;�t��)
    showopt=split(request("showopt"),";")
    userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
    Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
    'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
    'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
    '�ȪA��:B400,�޳N��:B500,�x�_�~�ȳ�:B100,�x��:B300,����:B200
    Domain=Mid(Emply,1,1)
    set conn=server.CreateObject("ADODB.Connection")
    set rs=server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLib"
    Conn.Open DSN
    
if showopt(0)="Y" then    
    'Ū�����������Ұ�
    sql="SELECT RTCounty.CUTID, RTCounty.CUTNC, " _
       &"RTArea.AREAID, RTArea.AREANC " _
       &"FROM RTCounty INNER JOIN " _
       &"RTAreaCty ON RTCounty.CUTID = RTAreaCty.CUTID INNER JOIN " _
       &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID AND " _
       &"RTArea.AREATYPE = '1' " _
       &"WHERE (RTCounty.CUTID = '" & showopt(4) & "') "
    rs.Open sql,conn
    if not rs.EOF then
       salesarea=rs("areaid")
    else
       salesarea=""
    end if
    rs.close
    '�_��
    '----���ζ�(�_���j)�]�Ұϩ|���T�{�G�����C�Ҧ��~�ȦW��
   ' if salesarea="A1" and emply <> "T92134" and emply <> "T89038" then
       '---�~�ȱư��H��
     sql="SELECT DISTINCT  RTAreaTownShip.CUTID, RTAreaTownShip.TOWNSHIP, " _
       &"RTSalesGroupREF.EMPLY, RTObj.CUSNC, RTCounty.CUTNC " _
       &"FROM RTSalesGroupREF INNER JOIN " _
       &"RTAreaTownShip ON " _
       &"RTSalesGroupREF.GROUPID = RTAreaTownShip.GROUPID AND " _
       &"RTSalesGroupREF.AREAID = RTAreaTownShip.AREAID INNER JOIN " _
       &"RTEmployee ON RTSalesGroupREF.EMPLY = RTEmployee.EMPLY INNER JOIN " _
       &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTCounty ON RTAreaTownShip.CUTID = RTCounty.CUTID INNER JOIN " _
       &"RTSalesGroup ON RTAreaTownShip.AREAID = RTSalesGroup.AREAID AND " _
       &"RTAreaTownShip.GROUPID = RTSalesGroup.GROUPID " _
       &"where RTAreaTownShip.CUTID ='" & showopt(4) & "' and RTAreaTownShip.TOWNSHIP='" & showopt(5) & "'" _
       &"GROUP BY  RTAreaTownShip.CUTID, RTAreaTownShip.TOWNSHIP, " _
       &"RTSalesGroupREF.EMPLY, RTObj.CUSNC, RTCounty.CUTNC  "
   ' else 
   '    SQL="SELECT RTEmployee.EMPLY, RTObj.CUSNC, RTAreaSales.AREAID " _
   '       &"FROM RTAreaSales INNER JOIN " _
   '       &"RTEmployee ON RTAreaSales.CUSID = RTEmployee.EMPLY INNER JOIN " _
   '       &"RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
   '       &"WHERE (RTAreaSales.AREAID ='" & salesarea & "')  "
   ' end if
 '   Response.Write sql
    '�x�_
' IF Domain="T" then
'    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
'          &"FROM RTEmployee INNER JOIN " _
'          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
'          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
'          &"and (rtemployee.dept='B100' or (rtemployee.dept='B600' and authlevel=2)) and tran2<>'10' "    
    '�x��
' elseif Domain="C" then 
'     sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
'          &"FROM RTEmployee INNER JOIN " _
'          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
'          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
'          &"and rtemployee.dept='B300' and tran2<>'10'  "   
    '����
' elseIF Domain="K" then
'     sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
'          &"FROM RTEmployee INNER JOIN " _
'          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
'          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
'          &"and rtemployee.dept='B200' and tran2<>'10'  "   
    '��L(���D����)
' else
'     sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
'          &"FROM RTEmployee INNER JOIN " _
'          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
'          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
'          &"and rtemployee.dept='*' "   
' end if
    rs.Open sql,conn
    s1=""
    Do While Not rs.Eof
       s1=s1 &"<option value=""" &rs("emply") &""">" & rs("emply") & "--" & rs("cusnc") & "</option>"
       rs.MoveNext
    Loop
    rs.Close
end if

if showopt(2)="Y" then
    '---�޳N�ư��H��
    '�x�_
 if Domain="T" then
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          &"and rtemployee.dept ='B500' "    
    '��L(���D��޳N�����) 
 else
     sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          &"and rtemployee.dept ='*' "     
 end if
    rs.Open sql,conn
    s2=""
    Do While Not rs.Eof
       s2=s2 &"<option value=""" &rs("emply") &""">" & rs("emply") & "--" & rs("cusnc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
end if

if showopt(1)="Y" then
    '---�ȪA�ư��H��
    '�x�_
 if Domain="T" or Domain="C" then
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          &"and ( rtemployee.dept='B400' or (rtemployee.dept='B600' and rtemployee.authlevel in ('5','1','4')))  and tran2<>'10' "     
    '����
 elseif Domain="K" then
    sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          &"and rtemployee.dept='B200' and rtemployee.authlevel in ('5','1','4')  and tran2<>'10' "   
 else
     sql="SELECT RTEmployee.emply, RTObj.CUSNC " _
          &"FROM RTEmployee INNER JOIN " _
          &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
          &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
          &"and rtemployee.dept='*' " 
 end if
    rs.Open sql,conn
    s4=""
    Do While Not rs.Eof
       s4=s4 &"<option value=""" &rs("emply") &""">" & rs("emply") & "--" & rs("cusnc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close    
end if

if showopt(3)="Y" then    
    '---�ư��t��
    '�x�_
 if Domain="T" then 
    sql="SELECT DISTINCT RTSuppCty.CUSID , RTObj.SHORTNC " _
       &"FROM RTSuppCty INNER JOIN " _
       &"RTAreaCty ON RTSuppCty.CUTID = RTAreaCty.CUTID INNER JOIN " _
       &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID INNER JOIN " _
       &"RTObj ON RTSuppCty.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID AND RTObjLink.CUSTYID = '04' " _
       &"WHERE (RTArea.AREATYPE = '2') AND (RTArea.AREAID IN ('B1', 'B2')) " _
       &"ORDER BY shortnc " 
 elseif Domain="C" then 
     sql="SELECT DISTINCT RTSuppCty.CUSID , RTObj.SHORTNC " _
       &"FROM RTSuppCty INNER JOIN " _
       &"RTAreaCty ON RTSuppCty.CUTID = RTAreaCty.CUTID INNER JOIN " _
       &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID INNER JOIN " _
       &"RTObj ON RTSuppCty.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID AND RTObjLink.CUSTYID = '04' " _
       &"WHERE (RTArea.AREATYPE = '2') AND (RTArea.AREAID IN ('B3')) " _
       &"ORDER BY shortnc " 
 elseif Domain="K" then 
     sql="SELECT DISTINCT RTSuppCty.CUSID , RTObj.SHORTNC " _
       &"FROM RTSuppCty INNER JOIN " _
       &"RTAreaCty ON RTSuppCty.CUTID = RTAreaCty.CUTID INNER JOIN " _
       &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID INNER JOIN " _
       &"RTObj ON RTSuppCty.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID AND RTObjLink.CUSTYID = '04' " _
       &"WHERE (RTArea.AREATYPE = '2') AND (RTArea.AREAID IN ('B4', 'B5')) " _
       &"ORDER BY shortnc " 
 else
     sql="SELECT DISTINCT RTSuppCty.CUSID , RTObj.SHORTNC " _
       &"FROM RTSuppCty INNER JOIN " _
       &"RTAreaCty ON RTSuppCty.CUTID = RTAreaCty.CUTID INNER JOIN " _
       &"RTArea ON RTAreaCty.AREAID = RTArea.AREAID INNER JOIN " _
       &"RTObj ON RTSuppCty.CUSID = RTObj.CUSID INNER JOIN " _
       &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID AND RTObjLink.CUSTYID = '04' " _
       &"WHERE (RTArea.AREATYPE = '2') AND (RTArea.AREAID IN ('*')) " _
       &"ORDER BY shortnc " 
 end if
    rs.Open sql,conn
    s3=""
    Do While Not rs.Eof
       s3=s3 &"<option value=""" &rs("cusid") &""">" & rs("cusid") & "--" & rs("shortnc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close    
end if

    conn.Close   
    set rs=Nothing   
    set conn=Nothing
%>
<HTML>
<HEAD>
<META name=VI60_DTCScriptingPlatform content="Server (ASP)">
<META name=VI60_defaultClientScript content=VBScript>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>�w���H����ܲM��</TITLE>
</HEAD>
<BODY style="BACKGROUND: lightblue">
<SCRIPT LANGUAGE="VBScript">
  Sub lstOrder1_onclick()
      selno=lstorder1.selectedIndex
      if selno >=0 then
         window.document.all("cmdtext").value= lstOrder1(selno).innerHTML
         window.document.all("cmdtext1").value=lstOrder1(selno).value
         window.document.all("cmdtext2").value="1"         
      end if
  End Sub
  Sub lstOrder2_onclick()
      selno=lstorder2.selectedIndex
      if selno >= 0 then
         window.document.all("cmdtext").value= lstOrder2(selno).innerHTML
         window.document.all("cmdtext1").value=lstOrder2(selno).value
         window.document.all("cmdtext2").value="2"      
      end if
  End Sub
  Sub lstOrder3_onclick()
      selno=lstorder3.selectedIndex
      if selno >= 0 then
         window.document.all("cmdtext").value= lstOrder3(selno).innerHTML
         window.document.all("cmdtext1").value=lstOrder3(selno).value
         window.document.all("cmdtext2").value="3"      
      end if
  End Sub    
  Sub lstOrder4_onclick()
      selno=lstorder4.selectedIndex
      if selno >= 0 then
         window.document.all("cmdtext").value= lstOrder4(selno).innerHTML
         window.document.all("cmdtext1").value=lstOrder4(selno).value
         window.document.all("cmdtext2").value="4"      
      end if
  End Sub      
  
  Sub cmdSure_onClick()
    ReturnValue=""
    if len(trim(window.document.all("cmdtext").value)) = 0 then
       msgbox "�п�ܦw���H��!",vbokonly,"���~�T������"
    else    
       returnvalue= window.document.all("cmdtext1").value &";"& window.document.all("cmdtext").value &";"& window.document.all("cmdtext2").value & ";" & "Y"
       window.close
    end if
  End Sub

  Sub cmdCancel_onClick()
      returnvalue=""
      window.close
  End Sub

</SCRIPT>
<Fieldset
 STYLE="HEIGHT: 390px; LEFT: 16px; POSITION: absolute; TOP: 15px; WIDTH: 570px" ID=select0>
<LEGEND>�w���H�����</LEGEND> 

<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 16px; POSITION: absolute; TOP: 20px; WIDTH: 135px" ID=select1>
<LEGEND>�~�Ȥu�{�v</LEGEND>
<SELECT id=lstOrder1 size=5 
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 110px" >
<%=s1%>
</SELECT>
</FIELDSET>&nbsp; 

<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 155px; POSITION: absolute; TOP: 20px; WIDTH: 125px" ID=select1>
<LEGEND>�ȪA�H��</LEGEND>
<SELECT id=lstOrder4 size=5 
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 100px" >
<%=s4%>
</SELECT>
</FIELDSET>&nbsp; 

<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 285px; POSITION: absolute; TOP: 20px; WIDTH: 125px" ID=select2>
<LEGEND>�޳N�o�i��</LEGEND>
<SELECT id=lstOrder2 size=5 
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 100px">
<%=s2%>
</SELECT>
</FIELDSET>&nbsp; 

<FIELDSET
 STYLE="HEIGHT: 308px; LEFT: 415px; POSITION: absolute; TOP: 20px; WIDTH: 125px" ID=select3>
<LEGEND>�t��</LEGEND>
<SELECT id=lstOrder3 size=5 
style="HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 26px; WIDTH: 100px">
<%=s3%>
</SELECT>

</FIELDSET>&nbsp;&nbsp; 
</FIELDSET>&nbsp;&nbsp; 
<font style="LEFT: 30px; POSITION: absolute; TOP: 360px">�ثe��ܤH�� </font>
<INPUT id=cmdtext style="LEFT: 130px; POSITION: absolute; TOP: 360px" size=30 type=text readonly>
<INPUT id=cmdtext1 style="LEFT: 130px; POSITION: absolute; TOP: 360px; display:none" size=30 type=text readonly>
<INPUT id=cmdtext2 style="LEFT: 130px; POSITION: absolute; TOP: 360px; display:none" size=30 type=text readonly>
<INPUT id=cmdCancel style="LEFT: 490px; POSITION: absolute; TOP: 360px" type=button value=����> 
<INPUT id=cmdSure style="LEFT: 436px; POSITION: absolute; TOP: 360px" type=button value=�T�w>
</BODY>

</HTML>
