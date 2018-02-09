<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.UOThankYouModelNew>" %>

<!DOCTYPE html>

<html>
<head >
    
    <title></title>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        function UOThankYouDisplayNew() {
            // frmePay.imgCards.src = '../../Images/ePay.gif'
            //$(frmePay.imgCards).attr("src", "../../../../Content/Images/ePay.gif");
            //xmlCC.src = '../../xml/CCBilling.xml'
            //xmlCCTemplate.src = '../../xml/CCBilling.xml'

            $('#lblNameTY').text($('#lblName').text());

            //parent.$x.ispXmlGetFieldVal(parent.$g.xmlWage, 'ERROR_INFO ERROR', "", 0)
            var abc = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ACCOUNT_ID', "", 0);
            //alert(abc);
            $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ACCOUNT_ID', '', 0));
            if (parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0) != '') {
                $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ADJUSTMENT_REF_NO', '', 0));
            } else {
                $('#lblConfirmNo').text($('#lblAcctNo').text())
                //lblConfirmNo.innerText = lblAcctNo.innerText	
            }		//if Adjustment reference number
            $('#divUOThankYou').css("display", "block");

            this.focus()
            parent.gsInstructionItem = ''
            $('#AppMessage').html('');
            $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
            $('#ccFeeText').text('A user fee of 2.49% will be charged in addition to the amount of tax due.');
            var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT PERIOD', '', 0);
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

                ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, '../MailPIN.asp', '')
            }		//if
            // parent.DocWin.location.href = '../../Acct/ApplyMain.asp'
            parent.setFrameUrl('Acct/ApplyMain');
        }		//DoThankYou

        //EOGVWEB-69 EDD Added function to print coupon
        function DoPrintCoupon() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'UO', 'COUPON_FORM CPN_FORM', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '84', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', '0'), 'COUPON_FORM CPN_NAME', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
            //Period for UO (YYYYMMDD) different from other types (MM/DD/YYYY) - Coupon needs (MM/DD/YYYY)
            var sPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.oUOFormNew, 'UO_ACCT PERIOD', '', 0)
            sPeriod = sPeriod.substr(4, 2) + '/' + sPeriod.substr(6, 2) + '/' + sPeriod.substr(0, 4)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod, 'COUPON_FORM CPN_PERIOD', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, sPeriod.substr(6, 4), "COUPON_FORM CPN_YEAR", "")
            ispDisplayProgress('', 'Creating Use and Occupancy Tax Coupon')
            SetupPassFields()
           // parent.DocWin.location.href = '../../PayCoupon/PDFCouponCreate.asp?' + tempParameters
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
        }		//DoPrintCoupon

</script>
<%--<script id="clientEventHandlersVB" language="vbscript" type="text/vbscript">

Function ispReplace(sInput, sFind, sReplace)
	ispReplace = Replace(sInput, sFind, sReplace)
End Function

</script>--%>
</head>
<body>
   
        <div <%--style="display: none;"--%> id="divUOThankYou"" class="tab_content">
            <h2 ><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
           	
            <div class="thankyou">
            <h4 id=hdrThankYou>Your Return is now being processed. <br />You may want to print a copy of this page for your records.<br />Thank you for filing your <%=(AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%>  Use and Occupancy Tax Return online.</h4>
            
            <p>Name   : <label class='lblTextBlack' id='lblNameTY'></label></p>
            <p>Account No.    : <label class='lblTextBlack' id='lblAcctNo'></label></p>
            <p>Your Confirmation No. is: <label class='lblTextBlack' id=lblConfirmNo></label></p>
            
           <center><h3>Payment Option</h3></center> 
           <%-- sangha--%>
                <div>  <% Html.RenderAction("CCPage", "CreditCard"); %> </div>
           <%-- <h5>Credit Card / e-Check</h5>
          
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries</p>
            <div class="clear"></div>
            <p class="p_space"> <a href="#" class="submit_button_light">Pay by Credit Card or e Check  (e Pay) </a>
            <a href="#" class="submit_button">American Express , Discover ,Master Card</a> </p>
            <div class="clear"></div>
            
             <h5>Note </h5>
            
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries</p>
            --%>
             <%-- sangha--%>
             <h5>Coupon</h5>
              <p class="p_space2"> <a class="submit_button_light" id="btnPrintCoupon" onclick="DoPrintCoupon()">Print Coupon </a>
                  
            </p>
                  <div class="clear"></div>
            <p>Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
          <p >Philadelphia Department
				of Revenue<br>
				P.O. Box 1393<br>
				Philadelphia, PA 19105-9731</p>
          
            <div class="clear"></div>
            
            
           <%-- <h5>Others</h5>
            
            <p>if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.</p>--%>
            
            
            <div class="smaller_form">
            	<p >We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
                <textarea class="fulllength" id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></textarea>
            	
                <input type="button" class="submit_button" value="Thank You" id="btnUOThankYou" name="btnUOThankYou" onclick="DoThankYou()"/>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
        </div>
     	
    
</body>
</html>
