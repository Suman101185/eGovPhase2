
<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.SchoolThankYouModel>" %>



<html>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">

function DisplaySchoolThankYou() {

	if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2002') {
		//lblName.innerText = lblName_02.innerText
		$('#lblName').text( $('#lblName_02').text());		
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2003') {
		//lblName.innerText = lblName_03.innerText
		$('#lblName').text( $('#lblName_03').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2004') {
		//lblName.innerText = lblName_04.innerText
		$('#lblName').text( $('#lblName_04').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2005') {
		//lblName.innerText = lblName_05.innerText
		$('#lblName').text( $('#lblName_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2006') {
		//lblName.innerText = lblName_05.innerText
		$('#lblName').text( $('#lblName_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2007') {
		//lblName.innerText = lblName_05.innerText
		$('#lblName').text( $('#lblName_05').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2008') {
		//lblName.innerText = lblName_08.innerText
		$('#lblName').text( $('#lblName_08').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2009') {
		//lblName.innerText = lblName_08.innerText
		$('#lblName').text( $('#lblName_08').text());
	} else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) ==	'12/31/2010') {
		//lblName.innerText = lblName_08.innerText
		$('#lblName').text( $('#lblName_08').text());
	} else {
		//lblName.innerText = lblName_08.innerText
		$('#lblName').text( $('#lblName_08').text());
	}		//if
	
	$('#lblAcctNo').text( parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0))
	
	$('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO ADJUSTMENT_REF_NO', '', 0));
	//divSchoolThankYou.style.display = 'block'
	$('#divSchoolThankYou').css('display', 'block');
	//$('#TABLE1').css("display", 'none');
	this.focus();
	parent.gsInstructionItem = ''
	$('#AppMessage').html('');
	$('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
	//pHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|thank you</Font>'
	$('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');
}		//DisplayThankyou


function DoThankYou() {
var sEmailMsg
oEmail = parent.$g.getXmlDocObj();
	if (txaComments.value != '') {
		sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>'
		sEmailMsg += '<p>The following comments or feedback was submitted by: '
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>'
		sEmailMsg += '<p>Company: '
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>'
		sEmailMsg += '<p>E-mail address: '
		sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0) + '</p><br>'
		sEmailMsg += '<p><strong>Message: </strong></p>'
		sEmailMsg += '<p>' + txaComments.value + '</p>'
		
		sEmailMsg = sEmailMsg.replace('>', '&GT&');
		sEmailMsg = sEmailMsg.replace('<', '&LT&');
		
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'COMMENT', 'FUNCTION', '', 0)
		parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0)

		ispCallXMLForm(parent.$g.xmlEmail, oEmail, '../MailPIN', '')
	}		//if

	parent.DocWin.location.href = '../Acct/ApplyMain'
}		//DoThankYou

//EOGVWEB-69 EDD Added function to print coupon
function DoPrintCoupon() {
	//alert('assfsdf');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'SCHOOL', 'COUPON_FORM CPN_FORM', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '29', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblName').text(), 'COUPON_FORM CPN_NAME', '')	;
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
	parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0).substr(6,4), "COUPON_FORM CPN_YEAR", "");
	ispDisplayProgress('', 'Creating School Tax Coupon');
	SetupPassFields();
	parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
}		//DoPrintCoupon

function ispReplace(sInput, sFind, sReplace){
	ispReplace = sInput.replace(sFind, sReplace);
}

</script>

</head>
<BODY>

<DIV Id="divSchoolThankYou" Name="divSchoolThankYou" style="DISPLAY: none; VISIBILTY: visible">
<table cellSpacing="0" cellPadding="1" width="95%" border="0"
		 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
    <td width=75%>
      <p id=hdrThankYou name=hdrThankYou class="lblTextBlack">
				Your Return is now being processed. <br>
				You may want to print a copy of this page for your records.<br>
				Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> School Income Tax Return online.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:15px; MARGIN-BOTTOM: 0px" >Name: 
				<label class='lblTextBlack' id='lblName'></label></p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px; MARGIN-BOTTOM: 0px" >Account No.: 
				<label class='lblTextBlack' id='lblAcctNo'></label>.</p>
			<p class='lblTextBlack' style="MARGIN-TOP:0px">Your Confirmation number is
				<label class='lblTextBlack' id=lblConfirmNo></label>.</p>
			<center><p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Payment Options</b></p></center>

            <% Html.RenderAction("CCPage", "CreditCard"); %>

			<p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Coupon</b> - 
			<!--EGOVWEB-69 EDD Added the print coupon button-->
			<input class="btnNormal" id="btnPrintCoupon" name="btnPrintCoupon" type="button" value="Print Coupon" onclick="DoPrintCoupon()">
<!--			you can use the coupon from 
				the bottom of the paper tax return that was sent to you. --> Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
			<p class='lblTextBlack' style="MARGIN-TOP:15px; MARGIN-LEFT:30px">Philadelphia Department
				of Revenue<br>
				P.O. Box 389<br>
				Philadelphia, PA 19105-0389</p>
			<p class='lblTextBlack'><b>Other</b> - if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.</p></td>
	  <td></td></tr>
  </table>
<table cellSpacing="0" cellPadding="0" width="80%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=20>
		<td><p class=lblTextBlack>We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
				<TEXTAREA id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></TEXTAREA>
  <tr height=20 valign="bottom">
		<td align="middle"><p><input class="btnNormal" id="btnSchoolThankYou" name="btnSchoolThankYou"
			  type="submit" value="Thank You" onclick="DoThankYou()">
			  </p></td></tr>
</table>
</DIV>
   
</BODY>
</html>
