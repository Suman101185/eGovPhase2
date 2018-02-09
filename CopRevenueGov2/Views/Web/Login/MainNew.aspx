<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<html>
    <head>
        <title></title>

     <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />



    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/global.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jqueryminlatest.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/BootstrapMin.js"></script>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>
     <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via filD:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  
    <script ID="clientEventHandlersJS" language="javascript" type="text/javascript">

     
        
        function DisplayMain() {
            PaymentDone.style.display = 'none';
            //LogMain.style.display = 'block'
            $('#AppHeader').html('Online Services');  
            parent.gsInstructionItem = '';
        }		//DisplayMain


        //''''Sudipta'''''''''
        function DisplaySuccess() {
            LogMain.style.display = 'none'
            PaymentDone.style.display = 'block'
            $('#accountID').html(localStorage.getItem("AccountNumber"));
            $('#name').html(localStorage.getItem("AccountName"));
            $('#AppHeader').html('Online Services');  
            var currenturl = window.location.search;
            if (currenturl.indexOf("?status=true") !== -1) {
                failure.style.display = 'none';
                success.style.display = 'block';


            }

            if (currenturl.indexOf("?status=false") !== -1) {
                success.style.display = 'none';
                failure.style.display = 'block';



            }
           
        }
        //'''''''''''''''''


        function MainLinks() {
           
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = evt.target || evt.srcElement;
            sourceid = source.id;
            gsLoginPage = '';
          
            switch (sourceid) {
                case 'lnkProfile':
                case 'lnkSIT':
                case 'lnkWage':
                case 'lnkBPTez':
                case 'lnkBPTlf':
                case 'lnkNPT':
                case 'lnkU&O':
                case 'lnkTOB':
                case 'lnkDelPay':
               
                    if (sourceid == 'lnkProfile') {
                        gsLoginPage = 'PROFILE';
                    } else if (sourceid == 'lnkSIT') {
                      
                        gsLoginPage = 'SIT';                      
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) {
                                $(parent.document).find('#mnuReSchool').first().trigger('click');
                            }

                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                        //added manoranjan    
                    }
                    else if (sourceid == 'lnkWage') {
                        gsLoginPage = 'WAGE';
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) {
                                $(parent.document).find('#mnuReWage').first().trigger('click');
                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkBPTez') {
                        gsLoginPage = 'BPTez';
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {
                                $(parent.document).find('#mnuReBPTez').first().trigger('click');
                            }
                            else if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {
                                $(parent.document).find('#mnuReNPT').first().trigger('click');

                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkBPTlf') {
                        gsLoginPage = 'BPTlf';
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {
                                $(parent.document).find('#mnuBPTlf').first().trigger('click');
                            }
                            else if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {
                                $(parent.document).find('#mnuReNPT').first().trigger('click');
                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkNPT') {
                        gsLoginPage = 'NPT';
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {
                                $(parent.document).find('#mnuReNPT').first().trigger('click');
                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkU&O') {
                        gsLoginPage = 'U&O';
                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '84') == 1) {
                                $(parent.document).find('#mnuUO').first().trigger('click');
                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkTOB') {
                        gsLoginPage = 'TOB';
                      

                        if ($(parent.ancLogin).text() == "Logout") {
                            if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) {

                                $(parent.document).find('#mnuTOB').first().trigger('click');
                            }
                            else {
                                if ($(parent.ancLogin).text() == "Logout")
                                    parent.setFrameUrl('Acct/ApplyMain');
                                else
                                    ShowForm('LogLogin');
                            }
                        }
                        else
                            ShowForm('LogLogin');
                    } else if (sourceid == 'lnkDelPay') {
                        gsLoginPage = 'DELPAY';
                        if ($(parent.ancLogin).text() == "Logout")
                            $(parent.mnuPayBalances).trigger('click');
                        else
                            ShowForm('LogLogin');
                    }
                    $('#mnuLogLogon').css("cursor", "pointer");
                    $('#mnuLogLogon').css("color", "blue");
                   
                    break;
                case 'lnkPIN':
                    $('#mnuLogPinApply').css("cursor", "pointer");
                    $('#mnuLogPinApply').css("color", "blue");
                   
                    ShowForm('LogPinApply');
                    break;
                case 'lnkID':
                case 'imglnkID':
                   
                    $('#mnuLogNewAcct').css("cursor", "pointer");
                    $('#mnuLogNewAcct').css("color", "blue");
                    ShowForm('LogApplyFirst');
                    break;
                case 'lnkCoupon':
                case 'lnkNTL':
                case 'imglnkCoupon':
                case 'imglnkNTL':
                    $('#mnuLogPayCoupon').css("cursor", "pointer");
                    $('#mnuLogPayCoupon').css("color", "blue");
                    
                    if ((sourceid == 'lnkNTL')) {
                        bNtlOnly = 'TRUE';
                    } 	//if
                    ShowForm('LogCoupon');
                   
                    break;
                case 'imglnkEPaymt':
                case 'lnkEPaymt':
                case 'lnkAmu':
                case 'lnkEar':
                case 'lnkLiquor':
                case 'lnkOA':
                case 'lnkPark':
                case 'lnkValet':
                case 'lnkVehicle':
                    $('#mnuLogPayCoupon').css("cursor", "pointer");
                    $('#mnuLogPayCoupon').css("color", "blue");
                    
                    if ((sourceid == 'lnkEPaymt' || sourceid == 'lnkAmu' || sourceid == 'lnkEar' || sourceid == 'lnkLiquor' || sourceid == 'lnkOA' || sourceid == 'lnkPark' || sourceid == 'lnkValet' || sourceid == 'lnkVehicle')) {
                        EPaymt = 'TRUE';
                    }  //if
                    ShowForm('LogCoupon');
                   
                    break;

            } 	//switch
        } 	//MainLinks
        function DisplayModal() {

            var alpha = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h','j', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

            var i, j;

            for (i = 0; i < 6; i++) {
                var a = alpha[Math.floor(Math.random() * alpha.length)];
                var b = alpha[Math.floor(Math.random() * alpha.length)];
                var c = alpha[Math.floor(Math.random() * alpha.length)];
                var d = alpha[Math.floor(Math.random() * alpha.length)];
                var e = alpha[Math.floor(Math.random() * alpha.length)];
                var f = alpha[Math.floor(Math.random() * alpha.length)];
                var g = alpha[Math.floor(Math.random() * alpha.length)];
            }
            var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' ' + f + ' ' + g;
            document.getElementById("mainCaptcha").value = code;

            //$("#myModal").css("display", "block");   //tanu-
            $("#divCaptha_W2").css("display", "block");
            $('#txtInput').val('');
            $("#progress-wrp .progress-bar").css("width", "0%");
            $("#progress-wrp .status").text("0%");
        }
        function CloseModal() {
            $("#divCaptha_W2").css("display", "none");  //tanu
            $('#fileToUpload').val('');
        }

        function CloseModal_W2() {
            $("#myModal_W2").css("display", "none");  //tanu
            //$("#myModal").css("display", "none");
            $('#fileToUpload').val('');
        }
        function Display1099Modal() {

            var alpha = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

            var i, j;
            debugger;
            for (i = 0; i < 6; i++) {
                var a = alpha[Math.floor(Math.random() * alpha.length)];
                var b = alpha[Math.floor(Math.random() * alpha.length)];
                var c = alpha[Math.floor(Math.random() * alpha.length)];
                var d = alpha[Math.floor(Math.random() * alpha.length)];
                var e = alpha[Math.floor(Math.random() * alpha.length)];
                var f = alpha[Math.floor(Math.random() * alpha.length)];
                var g = alpha[Math.floor(Math.random() * alpha.length)];
            }
            var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' ' + f + ' ' + g;
            document.getElementById("mainCaptcha_1099").value = code;


            //$("#myModal1").css("display", "block");
            $("#divCaptha_1099").css("display", "block");
            $('#txtInput_1099').val('');
            $("#progress1099-wrp .progress1099-bar").css("width", "0%");
            $("#progress1099-wrp .status1099").text("0%");
        }
        function Close1099Modal() {
            $("#divCaptha_1099").css("display", "none");
            $('#fileToUpload1').val('');
        }
        function Close1099Modal_1099() {
            $("#myModal_1099").css("display", "none");
            $('#fileToUpload1').val('');
            //$("#myModal1").css("display", "none");
        }
    </script>
   
   
    </head>
    <body>

   
        <div class="greybg" id="LogMain" style="DISPLAY: none; margin:0 0 25px 0; padding:0;">
     <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
     
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
    	<div class="white_block text-center" id="lnkInstruction" onclick="parent.InstructionLinks()"> 
                <figure>
                   <div class="no-padding">
                    <img src="../Content/images/question-landing.png" alt="" class="img-responsive faq-bg"/>
                    <h3 class="faq-bg-h3">Instructions and Frequenty  Asked  Questions </h3>
                        
                    <figcaption class="faq-bg">
                        <p>Instructions &amp; Frequently Asked Questions</p>
                    </figcaption>
                    </div>
                </figure>
            
         </div>
        </div>
    	
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="white_block text-center norightmargin"> 
        
          <figure>
                    <div class="no-padding">
                    <img src="../Content/images/monitor-landing.png" class="tax-bg" />
                    <h3 class="tax-bg-h3">Register for tax account no.</h3>
                        
                    <figcaption id="imglnkID" class="tax-bg" onclick=MainLinks(event)>
                        <p  id="lnkID" onclick="MainLinks(event)"> After successful 
				registration, you will receive an e-mail confirmation that includes your account number and PIN.</p>
                    </figcaption>
                    </div>
                </figure>
            
         </div>
        </div>
           
        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="white_block"> 
        
         <figure>
                    <div class="no-padding">
                    <img src="../Content/images/electronically-file.png" alt="" class="print-bg"/>
                    <h3 class="print-bg-h3">Electronically file your W-2 and 1099 forms</h3>
                        
                  <figcaption id="imglnkfileupload"  class="print-bg" onclick="MainLinks()">
                        <p id="lnkfileupload" onclick="MainLinks(event)" class="electronically-file-p">Click the appropriate link below to electronically file your W-2 and 1099 forms on the City of Philadelphia's secure ftp site.<br />
<a data-toggle="modal" onclick="DisplayModal()">W-2</a> <a href="../PDF/2016-W2-submission-instructions.pdf" target="_blank">Click here</a> for instructions on how to prepare your electronic W2 File.<br />
<a data-toggle="modal"  onclick="Display1099Modal()">1099</a> <a href="../PDF/5126_1099 specifications.pdf" target="_blank">Click here</a> for instructions on how to prepare your electronic 1099 File.
</p>
                    </figcaption>
                    </div>
                </figure>
         
        </div>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
         <div class="white_block norightmargin"> 
              <figure>
                    <div class="no-padding">
                    <img src="../Content/images/electronic-payment.png" alt="" class="tax-liability-bg"/>
                    <h3 class="tax-liability-bg-h3">Make an Electronic Payment</h3>
                        
                    <figcaption id="imglnkEPaymt"  class="tax-liability-bg" onclick="MainLinks()">
                        <p id="lnkEPaymt" onclick="MainLinks(event)" class="electronic-payment-p"> This option requires a Philadelphia Tax account number and a Revenue Department Personal Identification Number (PIN). If you have forgotten your PIN or need to apply for a PIN, click here.</p>
                    </figcaption>
                    </div>
                </figure>
             
         
        
        </div>
         </div>

        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="white_block"> 
        
         <figure>
                    <div class="no-padding">
                    <img src="../Content/images/landing-print.png" alt="" class="print-coupon-bg"/>
                    <h3 class="print-coupon-bg-h3">Print a payment coupon</h3>
                        
                    <figcaption id="imglnkCoupon"  class="print-coupon-bg" onclick="MainLinks()">
                        <p id="lnkCoupon" onclick="MainLinks(event)"> You must be registered 
						for the tax type in order to print a coupon. School Income Tax and Earnings Tax coupons require
						a PIN number.  </p>
                    </figcaption>
                    </div>
                </figure>
         
        </div>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 marginbottomforlastone">
         <div class="white_block norightmargin"> 
              <figure>
                    <div class="no-padding">
                    <img src="../Content/images/landing-report.png" alt="" class="report-tax-liability-bg"/>
                    <h3 class="report-tax-liability-bg">Report no tax liability</h3>
                        
                    <figcaption id="imglnkNTL"  class="report-tax-liability-bg" onclick="MainLinks()">
                        <p id="lnkNTL" onclick="MainLinks(event)"> If you do not have
						payroll for a reporting period, you must file a coupon indicating no tax due to prevent a non-
						filer notice.  </p>
                    </figcaption>
                    </div>
                </figure>
             
         
        
        </div>

          


         </div>
        
        <div class="col-md-12 rightblock_holder" style="padding-top:0px">
            <div class="quicklink_header">
         Pay Outstanding Tax Balances
    	</div>
        
        <div style="font-size:13px; padding:0px 2px;">
        
        	<p>Tax due on these returns or bill can be paid with a credit card or E-Check. A 2.45% user fee will be added to the amount due when paying by credit card. E-check payments are free of charge. There will be a user fee of $5.95 when paying by VISA Debit Card or MasterCard Debit Card. You will receive a confirmation number after filing a return. Please print a copy of your records.</p>
        
        </div>

    </div>
 
        </div>
     <div class="col-lg-4  col-md-4 col-sm-4 col-xs-11 rightblock_holder bottom_margin_sm">
    
    	<div class="quicklink_header">
         File and Pay City Taxes
    	</div>
        
        <div class="quicklink_body">
        
        	<ul class="checkmarks">
            	<li><a id="lnkSIT" onclick="MainLinks()">School Income Tax </a></li>
                <li><a id="lnkWage" onclick="MainLinks()">Wage Tax Annual Reconciliation  </a></li>
                <li><a id="lnkBPTez" onclick="MainLinks()">Business Income and Receipts EZ Return </a></li>
                <li><a id="lnkBPTlf" onclick="MainLinks()">Business Income and Receipts Tax Long Form  </a></li>
                <li><a id="lnkNPT" onclick="MainLinks()">Net Profits Tax Return</a> </li>
                <li><a id="lnkU&O" onclick="MainLinks()">Use & Occupancy Tax Return </a></li>
                <li><a id="lnkTOB" onclick="MainLinks()">Tobacco Tax Return </a></li>
                <li><a id="lnkDelPay" onclick="MainLinks()">Pay Outstanding Tax Balances </a></li>
                <li><a id="lnkAmu" onclick="MainLinks()">Amusement </a></li>
                <li><a id="lnkEar" onclick="MainLinks()">Earnings </a></li>
                <li><a id="lnkLiquor" onclick="MainLinks()">Liquor </a></li>
                <li><a id="lnkOA" onclick="MainLinks()">Outdoor Advertising </a></li>
                <li><a id="lnkPark" onclick="MainLinks()">Parking </a></li>
                <li><a id="lnkValet" onclick="MainLinks()">Valet Parking </a></li>
                <li><a id="lnkVehicle" onclick="MainLinks()">Vehicle Rental</a></li>
            </ul>
        
        </div>

            	<%--<div class="quicklink_header outstanding-tax-heading">
         Pay Outstanding Tax Balances
    	</div>
        
        <div class="quicklink_body outstanding-tax-p">
        
        	<p>Tax due on these returns or bill can be paid with a credit card or E-Check. A 2.45% user fee will be added to the amount due when paying by credit card. E-check payments are free of charge. There will be a user fee of $5.95 when paying by VISA Debit Card or MasterCard Debit Card. You will receive a confirmation number after filing a return. Please print a copy of your records.</p>
        
        </div>--%>
        
       	
        
    </div>

            <div class="clearfix"></div>

    


        </div>
       
   <%--</div>--%>




    <%--Sudipta--%>
         <div class="greybg pay-con-page"  style="DISPLAY: none; padding:0; box-shadow: #999 0 0 5px;" Id="PaymentDone" Name="PaymentDone">
             
            <div class="blue_base_box">
                              <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                   <h2></h2>
                  <div class="inner_white-panel ">
                     
                      <div style="font-size: 17px;">
                          <span>Account ID :</span> <span id="accountID"></span>
                      </div>
                      <div style="font-size: 17px;">
                          <span>Name : </span><span id="name"></span>
                      </div>
                       
                  </div>
            <div id="success" class="inner_white-panel" style ="display:none; height:260px;">
                <h2 style="font-size: 19px; color:#000;">Thank you</h2>

                <p style="font-size: 15px;">Your payment is done successfully</p>
               </div>
            <div id="failure" class="inner_white-panel" style ="display:none; height:260px;">
                <h2 style="font-size: 19px; color:#000;">Payment Failure.</h2>

                <p style="font-size: 15px;">Unfortunately, your payment has not been processed successfuly.</p>
               </div>
     </div>
        
        </div>

        
    
        <div class="clearfix"></div>
    </div>














<%--<div class="modal" id="myModal">--%>
	   <%--tanu-%>
       
              
             <%-- ================================Modal for W2 start=========================================--%>
              <% Html.RenderAction("CapchaFile_W2", "Login"); %>
             <%-- ============================Modal for W2 end=============================================--%>
              
       <%-- </div>--%>
   


<%--<div class="modal" id="myModal1">--%>
	
      
              
             <%-- ================================Modal for 1099 start=========================================--%>
              <% Html.RenderAction("CapchaFile_1099", "Login"); %>
             <%-- ============================Modal for 1099 end=============================================--%>

              
       <%-- </div>--%>
   <%-- </div>--%>
    </body>
</html>

    



