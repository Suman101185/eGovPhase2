﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.BPTezThankYouModel>" %>


<html>
<head>
<title></title>
<script id="jsBPTezThankYouEventHandlers" language="javascript" type="text/javascript">

    function DisplayBPTezThankYou() {

        $('#lblNameTY').text($('#lblName').text());

        if (mbFirstTime == true && $(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('3')")) {
            btnBPTThankYou.value = 'File Net Profit Tax';
        } else if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('3')")) {
            btnBPTThankYou.value = 'Update Net Profit Tax';
        }

        var btpInfo_ACCOUNT_ID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ACCOUNT_ID', '', 0);
        $('#lblAcctNo').text(btpInfo_ACCOUNT_ID);

        var bptInfo_ADJUSTMENT_REF_NO = parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ADJUSTMENT_REF_NO', '', 0);
        if (bptInfo_ADJUSTMENT_REF_NO != '') {
            $('#lblConfirmNo').text(bptInfo_ADJUSTMENT_REF_NO);
        } else {
            $('#lblConfirmNo').text(btpInfo_ACCOUNT_ID);
        }

        $('#divBPTThankYou').show();
        this.focus();
        parent.MenuWin.gsInstructionItem = '';
        $('#AppMessage').html('');
        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
        $('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');
    }//DisplayThankyou


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

            sEmailMsg = sEmailMsg.replace('>', '&GT&');
            sEmailMsg = sEmailMsg.replace('<', '&LT&');

            parent.$x.ispXmlSetFieldVal(oEmail, 'COMMENT', 'FUNCTION', '', 0);
            parent.$x.ispXmlSetFieldVal(oEmail, sEmailMsg, 'DATA', '', 0);

            ispCallXMLForm(oEmail, oEmail, '../MailPIN', '');
        }

        var currentYear = parseInt(sCurrYear) - 1;

        if ($(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('3')")) {
            if (mbFirstTime == true) {
                $(parent.MenuWin.mnuReNPT).trigger('click');
                mbFirstTime = false;
            } else if (currentYear == '2008') {
                $(parent.MenuWin.mnuReNPT).trigger('click');
            } else if (currentYear == '2007') {
                $(parent.MenuWin.mnuNPTYear05).trigger('click');
            } else {
                parent.DocWin.location.href = '../Acct/ApplyMain';
            }
        } else {
            parent.DocWin.location.href = '../Acct/ApplyMain';
        }
    }//DoThankYou

    //EOGVWEB-69 EDD Added function to print coupon
    function DoPrintCoupon() {
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'BPTEZ', 'COUPON_FORM CPN_FORM', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '24', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, lblName.innerText, 'COUPON_FORM CPN_NAME', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlBPTez, 'BPT_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "");
        ispDisplayProgress('', 'Creating Business Income and Receipts Tax Coupon');
        SetupPassFields();
        parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
    }//DoPrintCoupon

</script>
</head>
<BODY>

<DIV Id="divBPTThankYou" Name="divBPTThankYou" style="DISPLAY: none; VISIBILTY: visible">
<table cellSpacing="0" cellPadding="1" width="95%" border="0"
		 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
    <td width="75%">
      <p id=hdrThankYou name="hdrThankYou" class="lblTextBlack">
				Your Return is now being processed. <br>
				You may want to print a copy of this page for your records.<br>
				Thank you for filing your <%=(AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> Business Income and Receipts Tax Return online.</p>
			<p class='lblTextBlack' style="MARGIN-TOP: 15px; MARGIN-BOTTOM: 0px" 
     >Name: 
				<label class='lblTextBlack' id='lblNameTY'></label></p>
			<p class='lblTextBlack' style="MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px" 
     >Account No.: 
				<label class='lblTextBlack' id='lblAcctNo'></label>.</p>
			<p class='lblTextBlack' style="MARGIN-TOP: 0px">Your Confirmation number is
				<label class='lblTextBlack' id=lblConfirmNo></label>.</p>
			<center><p class='lblTextBlack' style="MARGIN-TOP:15px"><b>Payment Options</b></p></center>
<!--EGOVWEB-81 EDD Changed Credit Card Page-->
			 <% Html.RenderAction("CCPage", "CreditCard"); %>		
			<p class='lblTextBlack' style="MARGIN-TOP: 15px"><b>Coupon</b> - 
			<!--EGOVWEB-69 EDD Added the print coupon button-->
			<input class="btnNormal" id="btnPrintCoupon" name="btnPrintCoupon" type="button" value="Print Coupon" onclick="DoPrintCoupon()">
<!--				If there is a tax due for this return, use
				the coupon from the tax package that was sent to you, -->Attach a check for
				the amount due payable to the "City of Philadelphia" and mail the coupon and check to:</p>
			<center><p class='lblTextBlack' style="MARGIN-TOP: 15px" 
     >Philadelphia Department of Revenue<br>
				P.O. Box 1393<br>
				Philadelphia, PA 19105-9731</p></center>
			<p class='lblTextBlack'>If you do not have a coupon, print a copy of this page to mail with
				your payment.</p></td>
	  <td></td></tr>
  </table>
<table cellSpacing="0" cellPadding="0" width="80%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=20>
		<td><p class=lblTextBlack>We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p><TEXTAREA id=txaComments style="WIDTH: 80%; HEIGHT: 60px" name=txaComments></TEXTAREA>
  <tr height=20 valign="bottom">
		<td align="middle"><p><input class="btnNormal" id="btnBPTThankYou" name="btnBPTThankYou"
			  type="submit" value="Thank You" onclick="DoThankYou()"></p></td></tr>
</table>
</DIV>
   
</BODY>
</html>