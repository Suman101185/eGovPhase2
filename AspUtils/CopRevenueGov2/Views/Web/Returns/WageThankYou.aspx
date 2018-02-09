<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.WageThankYouModel>" %>

<script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/javascript">

function DisplayWageThankYou() {

	if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2002') {
		$('#lblName').text( $('#lblName_02').text());
		$('#lblAcctNo').text( $('#lblAcctId_02').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2003') {
		$('#lblName').text($('#lblName_03').text());
		$('#lblAcctNo').text( $('#lblAcctId_03').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2004') {
		$('#lblName').text($('#lblName_04').text());
		$('#lblAcctNo').text($('#lblAcctId_04').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2005') {
		$('#lblName').text( $('#lblName_05').text());
		$('#lblAcctNo').text( $('#lblAcctId_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2006') {
		$('#lblName').text($('#lblName_05').text());
		$('#lblAcctNo').text( $('#lblAcctId_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2007') {
		$('#lblName').text( $('#lblName_05').text());
		$('#lblAcctNo').text( $('#lblAcctId_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2008') {
		$('#lblName').text( $('#lblName_08').text());
		$('#lblAcctNo').text( $('#lblAcctId_08').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2009') {
		$('#lblName').text( $('#lblName_08').text());
		$('#lblAcctNo').text( $('#lblAcctId_08').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0) ==	'12/31/2010') {
		$('#lblName').text( $('#lblName_08').text());
		$('#lblAcctNo').text( $('#lblAcctId_08').text());
	} else {
		$('#lblName').text( $('#lblEntityName').text());
		$('#lblAcctNo').text( $('#lblAcctId').text());
	}		//if
	$('#lblConfirmNo').text( 
			parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ADJ_REFNO_CONTROL', '', 0));
	$('#divWageThankYou').css('display', 'block');
	this.focus();
	parent.gsInstructionItem = '';
	$('#AppMessage').html('');
	$('#AppHeader').html( txtHeader + '<Font class=hdrMedium>|thank you</Font>');
	$('#ccFeeText').text( 'A user fee of 2.49% will be charged in addition to the amount of tax due.');
}		//DisplayThankyou


function DoThankYou() {
var sEmailMsg;
	if (txaComments.value != '') {
		sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>';
		sEmailMsg += '<p>The following comments or feedback was submitted by: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>';
		sEmailMsg += '<p>Company: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>';
		sEmailMsg += '<p>E-mail address: ';
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0) + '</p><br>';
		sEmailMsg += '<p><strong>Message: </strong></p>';
		sEmailMsg += '<p>' + txaComments.value + '</p>';
		
		sEmailMsg = ispReplace(sEmailMsg, '>', '&GT&');
		sEmailMsg = ispReplace(sEmailMsg, '<', '&LT&');
		
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0);
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0);

		oEmail = parent.$g.getXmlDocObj();
		
		ispCallXMLForm(parent.$g.xmlEmail, oEmail, '../MailPIN', '');
	}		//if
    //parent.DocWin.location.href = '../Acct/ApplyMain';
	parent.setFrameUrl('Acct/ApplyMain');
}		//if

//EOGVWEB-69 EDD Added function to print coupon
function DoPrintCoupon() {
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'WAGE', 'COUPON_FORM CPN_FORM', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '1', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
  parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS NAME', '', '0'), 'COUPON_FORM CPN_NAME', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, lblName.innerText, 'COUPON_FORM CPN_ADDR', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'WAGE_INFO PERIOD', '', 0).substr(6,4), "COUPON_FORM CPN_YEAR", "");
	ispDisplayProgress('', 'Creating Wage Tax Coupon');
	SetupPassFields();
	parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
}		//DoPrintCoupon

function ispReplace(sInput, sFind, sReplace){
	return sInput.replace(sFind, sReplace);
}

</script>



<DIV Id="divWageThankYou" Name="divWageThankYou" style="DISPLAY: none; VISIBILTY: visible">
<table cellSpacing="0" cellPadding="1" width="95%" border="0"
		 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
    <td width=75%>
      <p id=hdrThankYou name=hdrThankYou class="lblTextBlack">
				Your Return is now being processed. <br>
				You may want to print a copy of this page for your records.<br>
				Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%>
				Wage Tax Reconciliation Return Online.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:15px; MARGIN-BOTTOM: 0px" >Name: 
				<label class='lblTextBlack' id='lblName'></label></p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px; MARGIN-BOTTOM: 0px" >Account No.: 
				<label class='lblTextBlack' id='lblAcctNo'></label>.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px">Your Confirmation number is 
				<label class='lblTextBlack' id='lblConfirmNo'></label>.</p>
			<center><p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Payment Options</b></p></center>
			 <% Html.RenderAction("CCPage", "CreditCard"); %>
			<p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Coupon</b> - 

			<input class="btnNormal" id="btnPrintCoupon" name="btnPrintCoupon" type="button" value="Print Coupon" onclick="DoPrintCoupon()">
Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
			<p class='' style="MARGIN-TOP:15px; MARGIN-LEFT:30px">
				Philadelphia Department of Revenue<br>
				P.O. Box 1670<br>
				Philadelphia, PA 19105-1670</p>
			<p class=''><b>Other</b> - if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.<br>
				Mail the W-2's with your check. If no tax was due, still mail the W-2's to the above 
				address.</p></td>
</table>
<table cellSpacing="0" cellPadding="0" width="80%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=20>
		<td><p class=lblTextBlack>We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
				<TEXTAREA id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></TEXTAREA>
  <tr height=20 valign="bottom">
		<td align="middle"><p><input class="btnNormal" id="btnWageThankYou" name="btnWageThankYou"
			  type="submit" value="Thank You" onclick="DoThankYou()">
			  </p></td></tr>
</table>
</DIV>


