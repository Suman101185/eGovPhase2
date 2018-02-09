﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.BPTezThankYouModel>" %>

<!DOCTYPE html>

<html>
<head >
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
          parent.gsInstructionItem = '';
          $('#AppMessage').html('');
          $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
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
                  $(parent.mnuReNPT).trigger('click');
                  mbFirstTime = false;
              } else if (currentYear == '2008') {
                  $(parent.mnuReNPT).trigger('click');
              } else if (currentYear == '2007') {
                  $(parent.mnuNPTYear05).trigger('click');
              } else {
                  // parent.DocWin.location.href = '../Acct/ApplyMain';
                  parent.setFrameUrl('Acct/ApplyMain');
              }
          } else {
              //parent.DocWin.location.href = '../Acct/ApplyMain';
              parent.setFrameUrl('Acct/ApplyMain');
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
          //parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
          parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
      }//DoPrintCoupon

</script>
    <title></title>
</head>
<body>
     <div style="display: none;" id="divBPTThankYou" class="tab_content">
         <div class="tab_container">
            <h2 ><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
           	
            <div class="thankyou">
            <h4 id=hdrThankYou>Your Return is now being processed. <br>
				You may want to print a copy of this page for your records.<br>
				Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> Business Income and Receipts Tax Return online.</h4>
            
            <p>Name   : <label class='' id='lblNameTY'></label></p>
            <p>Account No.    : <label class='' id='lblAcctNo'></label></p>
            <p>Your Confirmation No. is: <label class='' id='lblConfirmNo'></label></p>
            
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
              <p class="p_space2"> <a class="submit_button_light" onclick="DoPrintCoupon()" id="btnPrintCoupon">Print Coupon </a>
                  
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
            
            <p>If you do not have a coupon, print a copy of this page to mail with
				your payment.</p>
            
            
            <div class="smaller_form">
            	<p >We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
                <textarea class="fulllength" id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></textarea>
            	<div  class="no_border_right"> <input type="button" class="submit_button2" value="Thank You" id="btnBPTThankYou" name="btnSchoolThankYou" onclick="DoThankYou()"/></div>
              
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
             </div>
        </div>
     	
</body>
</html>
