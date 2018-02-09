<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<HTML>
<HEAD>
<link rel="stylesheet" TYPE="text/css" href="../Content/Styles/Font.css">
<link rel="stylesheet" TYPE="text/css" href="../Content/Styles/Object.css">
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<TITLE></TITLE>



<script type="text/javascript" language='JavaScript'>
//<!---
var txtHeader = 'Taxpayer Information'

function setInitFocus() {

	parent.NavWin.ClearImages()
	AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|Payment history</Font>'
	AppError.innerText = ''
	divPayments.style.display = 'block'

}		//setInitFocus

//--->
</script>
</HEAD>
<BODY onload='setInitFocus()'><% Html.RenderAction("AppHeader", "INC"); %>
<div id=divPayments style="DISPLAY: block; VISIBILITY: visible">
	<table class=tblNormal cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" width="90%">
	<TR Class=rowHeader>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Postmark</p></TD>
		<TD width="10%" Class='celLeft'><p class=lblTblHeaderCenter>Amount</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Posted</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Account</p></TD>
		<TD width="10%" Class='celLeft'><p class=lblTblHeaderCenter>Account ID</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Period</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Principal</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Interest/ Penalty</p></TD>
		<TD width="10%" Class=celLeft><p class=lblTblHeaderCenter>Other</p></TD>
		<TD width="10%" Class=celRightLeft><p class=lblTblHeaderCenter>Total</p></TD>
	</TR>
	<TR Class=rowDataEven>
		<TD Class=celLeft><P class=lblTblDataCenter>05/05/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$850.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>05/12/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>Net Profits</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>04/01/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$500.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$500.00</P></TD>
	</TR>
	<TR Class=rowDataOdd>
		<TD Class=celLeft><P class=lblTblDataCenter>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>&nbsp;</P></TD>
		<TD Class=celLeft nowrap><P class=lblTblDataLeft>Business Privilege</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>04/01/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$350.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$350.00</P></TD>
	</TR>
	<TR Class=rowDataEven>
		<TD Class=celLeft><P class=lblTblDataCenter>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>&nbsp;</P></TD>
	</TR>
	<TR Class=rowDataOdd>
		<TD Class=celLeft><P class=lblTblDataCenter>04/03/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$1,070.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>04/09/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>Net Profits</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>03/01/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$720.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$720.00</P></TD>
	</TR>
	<TR Class=rowDataEven>
		<TD Class=celLeft><P class=lblTblDataCenter>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>&nbsp;</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>Business Privilege</P></TD>
		<TD Class=celLeft><P class=lblTblDataLeft>4877544</P></TD>
		<TD Class=celLeft><P class=lblTblDataCenter>03/01/2002</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$350.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celLeft><P class=lblTblDataRight>$0.00</P></TD>
		<TD Class=celRightLeft><P class=lblTblDataRight>$350.00</P></TD>
	</TR>
	<TR>
		<TD colspan=6>&nbsp;</TD>
	</TR>
	<TR>
		<TD colspan=8>&nbsp;</TD>
		<TD ><INPUT class=btnNormal id=btnBack type=button value=Back onclick="history.back()"></TD>
		<TD >&nbsp;</TD>
	</TR>
</table>
</div>
</BODY>
</HTML>
