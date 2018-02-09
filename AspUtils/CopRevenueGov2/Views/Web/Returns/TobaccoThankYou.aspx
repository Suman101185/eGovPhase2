<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.TobaccoThankYouModel>" %>

<html>
<head>
<TITLE></TITLE>
<script ID="clientEventHandlersJS" type="text/javascript" LANGUAGE="javascript">

function DisplayTobaccoThankYou() {
	
	//loadXmlFiles();
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '', 'COUPON_FORM CPN_FORM', '');
	$('#ispProgressScreen').css("display","none");


	$('#lblNameTY').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0));	//lblName.innerText
	$('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0));
	$('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ADJUSTMENT_REF_NO', '', 0));
	
	$('#divTobaccoThankYou').css("display","block");
	this.focus();
	$('#AppMessage').html('');
	$('#AppMessage').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');

}		//DisplayThankyou
 
function DoThankYou() {
var sEmailMsg;

	if (txaComments.value != '') {
		sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>';
		sEmailMsg += '<p>The following comments or feedback was submitted by: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>';
		sEmailMsg += '<p>Company: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>' ;
		sEmailMsg += '<p>E-mail address: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESSEMAIL', '', 0) + '</p><br>';
		sEmailMsg += '<p><strong>Message: </strong></p>';
		sEmailMsg += '<p>' + txaComments.value + '</p>';
		
		sEmailMsg = sEmailMsg.replace('>', '&GT&');
		sEmailMsg = sEmailMsg.replace('<', '&LT&');
		 
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0);
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0);

		ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, '../MailPIN', '');
		
	}		//if

	parent.DocWin.location.href = '../Acct/ApplyMain';
}		//DoThankYou


function DoPrintCoupon() {
	
	
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'TOBACCO', 'COUPON_FORM CPN_FORM', '');
	
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '27', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblNameTY').text(), 'COUPON_FORM CPN_NAME', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlTobacco, 'TOBACCO_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '2012', "COUPON_FORM CPN_YEAR", "");
	ispDisplayProgress('', 'Creating Tobacco Tax Coupon');
	SetupPassFields();
	
	parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;

}		//DoPrintCoupon

</script>

</head>
<BODY>

<DIV Id="divTobaccoThankYou" Name="divTobaccoThankYou" style="DISPLAY: none; VISIBILTY: visible">
<table cellSpacing="0" cellPadding="1" width="95%" border="0"
		 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
    <td width=75%>
      <p id=hdrThankYou name=hdrThankYou class="lblTextBlack">
				Your Return is now being processed. <br>

				Print a copy of this page for your records.<br>
				Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> Tobacco Tax Return online.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:15px; MARGIN-BOTTOM: 0px" >Name: 
				<label class='lblTextBlack' id='lblNameTY'></label></p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px; MARGIN-BOTTOM: 0px" >Account No.: 
				<label class='lblTextBlack' id='lblAcctNo'></label>.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px">Your Confirmation number is
				<label class='lblTextBlack' id=lblConfirmNo></label>.</p>
			<center><p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Payment Options</b></p></center>
			 <% Html.RenderAction("CCPage", "CreditCard"); %>
			<p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Coupon</b> - 

				<input class="btnNormal" id="btnPrintCoupon" name="btnPrintCoupon" type="button" value="Print Coupon" onclick="DoPrintCoupon()">
 Attach a check for	the amount due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
			<p class='lblTextBlack' style="MARGIN-TOP:15px; MARGIN-LEFT:30px">Philadelphia Department
				of Revenue<br>
				P.O. Box 53250<br>
				Philadelphia, PA 19105-0389</p></td>
	  <td></td></tr>
  </table>
<table cellSpacing="0" cellPadding="0" width="80%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=20>
		<td><p class=lblTextBlack>We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
				<TEXTAREA id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></TEXTAREA>
  <tr height=20 valign="bottom">
		<td align="middle"><p><input class="btnNormal" id="btnTobaccoThankYou" name="btnTobaccoThankYou"
			  type="submit" value="Thank You" onclick="DoThankYou()">
			  </p></td></tr>
</table>
</DIV>
   
</BODY>
</html>
