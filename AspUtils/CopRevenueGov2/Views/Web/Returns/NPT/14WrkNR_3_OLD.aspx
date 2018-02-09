<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title></title>
    <style type="text/css" >.inpNormal, .inpReadOnlyRt, .inpError { text-align: right; }</style>
</head>
<body onload=LoadError("Page4")>
   <DIV id=NPT_Page4 style="DISPLAY: none; VISIBILTY: hidden" Name="NPT_Page4">
<TABLE class=tblShowBorder id=TABLE1 style="MARGIN-LEFT: 4%" cellSpacing=0 
cellPadding=0 width="90%" border=0>
  
  <TR height=0>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD>
    <TD width="5%"></TD></TR>
  <TR class=rowDataEven>
    <TD colSpan=20><LABEL class=lblInstrNormal><U>Worksheet NR-3:</U> Computation of apportionment factors to be
    applied to apportionable net income of certain <u>non-residents</u> of Philadelphia.</LABEL></TD>
  
  <TR class=rowDataOdd>
    <TD colSpan=10><LABEL class=lblInstrNormal><b>Calculation of Average Values of Real and Tangible Property
    Used in Business:</b></LABEL></TD>
    <TD align=center colSpan=5><b>Column A<br>Philadelphia</b></td>
    <TD align=center colSpan=5><b>Column B<br>Total Everywhere</b></td>

  
  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>1.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Inventories of Raw Materials, Work in Process and Finished Goods.</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_1a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
    <td colSpan=2></td>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_1b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
	<TD colSpan=1></TD></TR>  
  
  <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>2.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Land & Building Owned (At average original cost).</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_2a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
    <td colSpan=2></td>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_2b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
	<TD colSpan=1></TD></TR>  
 
  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>3.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Machinery & Equipment Owned (At average original cost).</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_3a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
    <td colSpan=2></td>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_3b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
	<TD colSpan=1></TD></TR>  
      
  <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>4.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Other Tangible Assets Owned (At average original cost).</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_4a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
    <td colSpan=2></td>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_4b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
	<TD colSpan=1></TD></TR>  

  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>5.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Rented Property (At 8 times the net annual rental).</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_5a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
    <td colSpan=2></td>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_5b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD>
	<TD colSpan=1></TD></TR>              

  <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>6.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Total average value of property used <b>WITHIN PHILADELPHIA</b>.</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_6a 
      style="WIDTH: 100%"></LABEL></TD>
    <td colSpan=2></td>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_6b 
      style="WIDTH: 100%">XXXXXXXXXXXXXXX</LABEL></TD>
	<TD colSpan=1></TD></TR>  
      
  <TR class=rowDataEven>      
    <TD><LABEL class=lblInstrNormal>7.</LABEL></TD>
    <TD colSpan=10><LABEL class=lblInstrNormal>Total average value of property used <b>EVERYWHERE</b>.</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_7a 
      style="WIDTH: 100%">XXXXXXXXXXXXXXX</LABEL></TD>
    <td colSpan=2></td>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_7b 
      style="WIDTH: 100%"></LABEL></TD>
	<TD colSpan=1></TD></TR>    

  <TR class=rowDataOdd>
    <TD colSpan=20><LABEL class=lblInstrNormal><b>Computation of Apportionment Factors:</b></LABEL></TD></tr>

  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>8A.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Total Average Value of Philadelphia Property from Column A,
    Line 6 above</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_8a 
      style="WIDTH: 100%"></LABEL></TD></TR> 

  <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>8B.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Total Average Value of Property Everywhere from Column B, Line 7 above</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_8b 
      style="WIDTH: 100%"></LABEL></TD></TR> 

  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>8C.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia Property Factor (Line 8A divided by Line 8B)</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_8c 
      style="WIDTH: 100%"></LABEL></TD></TR>

 <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>9A.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia Payroll</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_9a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD></TR> 

 <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>9B.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Payroll Everywhere</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_9b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD></TR> 

  <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>9C.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia Payroll Factor (Line 9A divided by Line 9B)</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_9c 
      style="WIDTH: 100%"></LABEL></TD></TR>
      
 <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>10A.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia receipts before BIR Statutory Exclusion</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_10a style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD></TR> 

 <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>10B.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Gross Receipts Everywhere</LABEL> </TD>
    <TD colSpan=3><INPUT class=inpNormal id=txtNPT_Page4_10b style="WIDTH: 100%" 
      onfocus=SetFocus() maxLength=10 onchange=ValidateWorksheet("Page4")></TD></TR> 

  <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>10C.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia Receipts Factor (Line 10A divided by Line 10B)</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_10c 
      style="WIDTH: 100%"></LABEL></TD></TR>      
      
 <TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>11.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>TOTAL FACTORS (Total of Lines 8C, 9C, and 10C)</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_11 
      style="WIDTH: 100%"></LABEL></TD></TR>     
      
  <TR class=rowDataEven>
    <TD style="vertical-align:top"><LABEL class=lblInstrNormal>12.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Philadelphia apportionment factor (Line 11 divided by applicable number of factors)<br /> Enter factor on Worksheet B, Line 5</LABEL> </TD>
    <TD colSpan=3 style="vertical-align:top"><LABEL class=inpReadOnlyRt id=lblNPT_Page4_12 
      style="WIDTH: 100%"></LABEL></TD></TR>
      
	<%--<TR class=rowDataOdd>
    <TD><LABEL class=lblInstrNormal>13.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Enter factor on Worksheet B, Line 5</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_13 
      style="WIDTH: 100%"></LABEL></TD></TR>   
      
   <TR class=rowDataEven>
    <TD><LABEL class=lblInstrNormal>14.</LABEL></TD>
    <TD colSpan=16><LABEL class=lblInstrNormal>Multiply Line 13 times Line 12. Enter here and on Worksheet B, Page 2, Line 5</LABEL> </TD>
    <TD colSpan=3><LABEL class=inpReadOnlyRt id=lblNPT_Page4_14 
      style="WIDTH: 100%"></LABEL></TD></TR>--%>
</TABLE>
<P></P>
<TABLE style="MARGIN-LEFT: 4%" width="90%" border=0>
  <TR>
    <TD><INPUT language=javascript id=btnGoToPage1 onclick=ShowPage("WrkB","Page4") type=button value="Return to Worksheet B"></TD>
  </TR>
</TABLE>
</DIV><!--NPT_Page4-->
</body>
</html>
