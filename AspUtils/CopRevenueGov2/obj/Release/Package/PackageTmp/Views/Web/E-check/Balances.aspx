<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<HTML>
<HEAD>

<link REL="stylesheet" TYPE="text/css" href="../Content/Styles/Font.css">
<link REL="stylesheet" TYPE="text/css" href="../Content/Styles/Object.css">
<TITLE></TITLE>

<script language="JavaScript" type="text/javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script language="javascript" type="text/javascript" src="../Content/Scripts/ispFunctions.js"></script>

<script language="JavaScript" type="text/javascript">
//<!---
var txtHeader = 'Taxpayer Information'

function setInitFocus() {

	parent.NavWin.ClearImages()
	AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|account balance</Font>'
	AppError.innerText = ''
	divPayments.style.display = 'block'

}		//setInitFocus

function ValidateBalDate(obj){
	AppError.innerText = ''
	if (obj.value != ""){
		var strBD = ispValidateDate(obj.value)

		if (strBD == false){
			AppError.innerText = 'Invalid date'
		}else{
			obj.value = strBD
		}
	}

}
//--->
</script>
</HEAD>
<BODY onload='setInitFocus()'>
    <%
        Html.RenderAction("AppHeader","INC")
    %>
<div id=divPayments style="DISPLAY: block; VISIBILITY: visible">
<table class=tblNormal cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" width="90%">
  <tr>
	<td align=left nowrap> 
		<label class="lblInstrNormal">From</label>
		<input class=inpNormal id=txtFromDate onchange="ValidateBalDate(txtFromDate)" maxlength=10 
	   style="WIDTH: 68px; HEIGHT: 22px" size=9>
		<label class="lblInstrNormal">Thru </label>
		<input class=inpNormal width="50%" id=txtToDate onchange="ValidateBalDate(txtToDate)" maxlength=10 
	   style="WIDTH: 68px; HEIGHT: 22px" size=9></td>
	</tr>
  <tr>
	<td align=left>&nbsp;</td>
	</tr></table>

<table class=tblNormal cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" width="90%">
	<TR Class=rowHeader>
		<TD width="14%" Class=celLeft><p class=lblTblHeaderCenter>Account</p></TD>
		<TD width="15%" Class='celLeft'><p class=lblTblHeaderCenter>Account ID</p></TD>
		<TD width="14%" Class=celLeft><p class=lblTblHeaderCenter>Principal</p></TD>
      <TD width="14%" Class=celLeft><P class=lblTblHeaderCenter>Interest</P></TD>
		<TD width="14%" Class=celLeft><p class=lblTblHeaderCenter>Penalty</p></TD>
		<TD width="14%" Class=celLeft><p class=lblTblHeaderCenter>Other</p></TD>
		<TD width="14%" Class=celRightLeft><p class=lblTblHeaderCenter>Balance</p></TD>
    <P></P>
	</TR>
	<TR Class=rowDataEven>
		<TD Class=celLeft nowrap><P class=lblTblDataLeft>Net Profits</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$500.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$150.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$262.50</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$912.50</P></TD>
	</TR>
	<TR Class=rowDataOdd>
		<TD Class=celLeft nowrap><P class=lblTblDataLeft>Business Privilege</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$250.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$75.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$131.25</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$456.25</P></TD>
	</TR>
	<TR Class=rowDataEven>
		<TD Class=celLeft nowrap><P class=lblTblDataLeft>Use/Occupancy</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>7510381</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$125.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$20.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$43.74</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$188.74</P></TD>
	</TR>
	<TR>
		<TD colspan=6>&nbsp;</TD>
	</TR>
	<TR>
		<TD colspan=6>&nbsp;</TD>
		<TD ><INPUT class=btnNormal id=btnBack type=button value=Back onclick="history.back()"></TD>
	</TR>
</table>
</div>
</BODY>
</HTML>
