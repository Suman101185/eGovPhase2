<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
  
    <title></title>
    <script id="Script1" language="javascript" type="text/javascript">

        //EDD Added function to print coupon
        function DoPrintCoupon() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'NPT', 'COUPON_FORM CPN_FORM', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '3', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblThankYouName').text(), 'COUPON_FORM CPN_NAME', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.MenuWin.xmlNPT, 'NPT_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "")

            SetupPassFields()
            // parent.DocWin.location.href = '../../PayCoupon/PDFCouponCreate?' + tempParameters
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
        }		//DoPrintCoupon
    </script>
</head>
<body>
   
        <div style="display: none;" id="divNPTThankYou"" class="tab_content">
            <div class="tab_container">
            <h2 ><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
           	
            <div class="thankyou">
            <h4 id=hdrThankYou> Your Return is now being processed.
              <br>
              You may want to print a copy of this page for your records.<br>
              Thank you for filing your <script>document.write(sCurrYear - 1)</script> Net Profit Tax Return online.</h4>
            
            <p>Name   : <label class='lblTextBlack' id='lblThankYouName'></label></p>
            <p>Account No.    : <label class='lblTextBlack' id='lblAcctNo'></label></p>
            <p>Your Confirmation No. is: <label class='lblTextBlack' id='lblConfirmNo'></label></p>
            
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
              <p class="p_space2"> <a class="submit_button_light" onclick="DoPrintCoupon()">Print Coupon </a>
                  
            </p>
                  <div class="clear"></div>
            <p>Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
          <p >Philadelphia Department
				of Revenue<br>
				P.O. Box 1393<br>
				Philadelphia, PA 19105-9731</p>
          
            <div class="clear"></div>
            
            
            <h5>Others</h5>
            
            <p>if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.</p>
            
            
            <div class="smaller_form">
            	<p >We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
                <textarea class="fulllength" id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></textarea>
            	
                <input type="button" class="submit_button2" value="Thank You" id="btnNPTThankYou" name="btnSchoolThankYou" onclick="DoThankYou()"/>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
                </div>
        </div>
     	
    
</body>
</html>
