
<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.Web.Returns.SchoolThankYouModel>" %>

<!DOCTYPE html>

<html>
<head >
   <script ID="clientEventHandlersJS" LANGUAGE="javascript">

       function DisplaySchoolThankYou() {

           if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2002') {
               //lblName.innerText = lblName_02.innerText
               $('#lblName').text($('#lblName_02').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2003') {
               //lblName.innerText = lblName_03.innerText
               $('#lblName').text($('#lblName_03').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2004') {
               //lblName.innerText = lblName_04.innerText
               $('#lblName').text($('#lblName_04').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2005') {
               //lblName.innerText = lblName_05.innerText
               $('#lblName').text($('#lblName_05').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2006') {
               //lblName.innerText = lblName_05.innerText
               $('#lblName').text($('#lblName_05').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2007') {
               //lblName.innerText = lblName_05.innerText
               $('#lblName').text($('#lblName_05').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2008') {
               //lblName.innerText = lblName_08.innerText
               $('#lblName').text($('#lblName_08').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2009') {
               //lblName.innerText = lblName_08.innerText
               $('#lblName').text($('#lblName_08').text());
           } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0) == '12/31/2010') {
               //lblName.innerText = lblName_08.innerText
               $('#lblName').text($('#lblName_08').text());
           } else {
               //lblName.innerText = lblName_08.innerText
               $('#lblName').text($('#lblName_08').text());
           }		//if

           $('#lblAcctNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0))

           $('#lblConfirmNo').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO ADJUSTMENT_REF_NO', '', 0));
           //divSchoolThankYou.style.display = 'block'
           $('#divSchoolThankYou').css('display', 'block');
           //$('#TABLE1').css("display", 'none');
           this.focus();
           parent.gsInstructionItem = ''
           $('#AppMessage').html('');
           $('#AppHeaderThankyou').html(txtHeader + '<Font >|thank you</Font>');
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

           // parent.DocWin.location.href = '../Acct/ApplyMain'
           parent.setFrameUrl('Acct/ApplyMain');
       }		//DoThankYou

       //EOGVWEB-69 EDD Added function to print coupon
       function DoPrintCoupon() {
           //alert('assfsdf');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'SCHOOL', 'COUPON_FORM CPN_FORM', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '29', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblName').text(), 'COUPON_FORM CPN_NAME', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
           parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlSchool, 'SCHOOL_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "");
           ispDisplayProgress('', 'Creating School Tax Coupon');
           SetupPassFields();//Sangha
          // parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;

           parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
       }		//DoPrintCoupon

       function ispReplace(sInput, sFind, sReplace) {
           ispReplace = sInput.replace(sFind, sReplace);
       }

</script>
    <title></title>
</head>
<body>
   
        <div style="display: block;" id="divSchoolThankYou"" class="tab_content">
            <div class="tab_container">
            <h2 ><span id="AppHeaderThankyou">&nbsp;</span>  </h2>
           	
            <div class="thankyou">
            <h4 id=hdrThankYou>Your Return is now being processed. <br>
				You may want to print a copy of this page for your records.<br>
				Thank you for filing your <%= (AspUtils.Util.GetInt(Model.sCurrentYear) - 1).ToString( )%> School Income Tax Return online.</h4>
            
            <p>Name   : <label class='lblTextBlack' id='lblName'></label></p>
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
              <p class="p_space2"> <a class="submit_button_light" onclick="DoPrintCoupon()">Print Coupon </a>
                  
            </p>
                  <div class="clear"></div>
            <p>Attach a check for	the amount 
				due, payable to the "City of Philadelphia" and mail the coupon and check to:</p>
          <p >Philadelphia Department
				of Revenue<br>
				P.O. Box 389<br>
				Philadelphia, PA 19105-0389</p>
          
            <div class="clear"></div>
            
            
            <h5>Others</h5>
            
            <p>if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.</p>
            
            
            <div class="smaller_form">
            	<p >We would appreciate your comments / feedback concerning your online experience.<br>
						Please enter your comments / feedback below:</p>
                <textarea class="fulllength" id=txaComments style="WIDTH: 80%; height: 60px" name=txaComments></textarea>
            	
                <input type="button" class="submit_button" value="Thank You" id="btnSchoolThankYou" name="btnSchoolThankYou" onclick="DoThankYou()"/>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
                </div>
        </div>
     	
    
</body>
</html>
