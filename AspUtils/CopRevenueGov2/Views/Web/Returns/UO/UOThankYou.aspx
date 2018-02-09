<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.UOThankYouModel>" %>


<!DOCTYPE html>

<html>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>

<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    function UOThankYouDisplay() {
        //frmePay.imgCards.src = '../../Images/ePay.gif'
        //$(frmePay.imgCards).attr("src", "../../../../Content/Images/ePay.gif");
        //xmlCC.src = '../../xml/CCBilling.xml'
        //xmlCCTemplate.src = '../../xml/CCBilling.xml'

        $('#lblNameTY').text($('#lblName').text())

        $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0));
        if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0) != '') {
            $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0));
        } else {
            $('#lblConfirmNo').text($('#lblAcctNo').text())
           
        }		//if Adjustment reference number
        $('#divUOThankYou').css("display", "block");

        this.focus()
        parent.MenuWin.gsInstructionItem = ''
        $('#AppMessage').html('');
        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
        $('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');
        var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD', '', 0);
        sPeriod = sPeriod.substr(0, 4);
        $('#lblFileYear').text(sPeriod + ' ');
    }		//DisplayThankyou



    function DoThankYou() {
        var sEmailMsg
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

            ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, 'MailPIN', '')
        }		//if
        //parent.DocWin.location.href = '../../Acct/ApplyMain'
        parent.setFrameUrl('Acct/ApplyMain');
    }		//DoThankYou

    //EOGVWEB-69 EDD Added function to print coupon
    function DoPrintCoupon() {
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'UO', 'COUPON_FORM CPN_FORM', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '84', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', '0'), 'COUPON_FORM CPN_NAME', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
        //Period for UO (YYYYMMDD) different from other types (MM/DD/YYYY) - Coupon needs (MM/DD/YYYY)
        var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOForm, 'UO_ACCT PERIOD', '', 0)
        sPeriod = sPeriod.substr(4, 2) + '/' + sPeriod.substr(6, 2) + '/' + sPeriod.substr(0, 4)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod, 'COUPON_FORM CPN_PERIOD', '')
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod.substr(6, 4), "COUPON_FORM CPN_YEAR", "")
        ispDisplayProgress('', 'Creating Use and Occupancy Tax Coupon')
        SetupPassFields()
        // parent.DocWin.location.href = '../../PayCoupon/PDFCouponCreate?' + tempParameters
        parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
    }		//DoPrintCoupon

</script>

</head>
<body>
	<div Id="divUOThankYou" style="DISPLAY: none">
		<table cellSpacing="0" cellPadding="1" width="95%" border="0" style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
		  <tr vAlign="top" align="left">
				<td width="75%">
					<p id=hdrThankYou name="hdrThankYou" class="lblTextBlack">Your Return is now being processed. <br />You may want to print a copy of this page for your records.<br />Thank you for filing your <%=(AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> Use and Occupancy Tax Return online.</p>
					<p class='lblTextBlack' style="MARGIN-TOP: 15px; MARGIN-BOTTOM: 0px">Name: 
						<label class='lblTextBlack' id='lblNameTY'></label></p>
					<p class='lblTextBlack' style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px">Account No.: 
						<label class='lblTextBlack' id='lblAcctNo'></label>.</p>
					<p class='lblTextBlack' style="MARGIN-TOP: 0px">Your Confirmation number is
						<label class='lblTextBlack' id=lblConfirmNo></label>.</p>
						<center><p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Payment Options</b></p></center>
<!--EGOVWEB-81 EDD Changed Credit Card Page-->
					 <% Html.RenderAction("CCPage", "CreditCard"); %>				
					<p class='lblTextBlack' style="MARGIN-TOP: 15px"><b>Coupon</b> - 
						<!--EGOVWEB-69 EDD Added the print coupon button-->
						<input class="btnNormal" id="btnPrintCoupon" name="btnPrintCoupon" type="button" value="Print Coupon" onclick="DoPrintCoupon()"> Attach a check for the amount due payable to the "City of Philadelphia" and mail the coupon and check to:</p>
						<center><p class='lblTextBlack' style="MARGIN-TOP: 15px">Philadelphia Department of Revenue<br />P.O. Box 1393<br />Philadelphia, PA 19105-9731</p>
						</center><p class='lblTextBlack'>If you do not have a coupon, print a copy of this page to mail with 
your payment.</p>
			</td>
			<td></td></tr>
		</table>
		<table cellSpacing="0" cellPadding="0" width="80%" border="0" style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
		<tr height=20>
			<td>
				<p class=lblTextBlack>We would appreciate your comments / feedback concerning your online experience.<br />Please enter your comments / feedback below:</p>
				<textarea id=txaComments style="WIDTH: 80%; HEIGHT: 60px" name=txaComments></textarea>
			</td></tr>
		<tr height=20 valign="bottom">
			<td align="middle">
				<p><input class="btnNormal" id="btnUOThankYou" name="btnUOThankYou" type="submit" value="Thank You" onclick="DoThankYou()"></p>
			</td></tr>
		</table>
	</div>
</body>
</html>
