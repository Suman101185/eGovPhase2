<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
     <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/global.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>
  
    <script ID="clientEventHandlersJS" language="javascript" type="text/javascript">


        function DisplayMain() {

            LogMain.style.display = 'block'
            $('#AppHeader').html('Online Services');  //+	txtHeader + '<Font class=hdrMeduim>|General</Font>'
            parent.gsInstructionItem = '';
        }		//DisplayMain

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
                    } else if (sourceid == 'lnkWage') {
                        gsLoginPage = 'WAGE';
                    } else if (sourceid == 'lnkBPTez') {
                        gsLoginPage = 'BPTez';
                    } else if (sourceid == 'lnkBPTlf') {
                        gsLoginPage = 'BPTlf';
                    } else if (sourceid == 'lnkNPT') {
                        gsLoginPage = 'NPT';
                    } else if (sourceid == 'lnkU&O') {
                        gsLoginPage = 'U&O';
                    } else if (sourceid == 'lnkTOB') {
                        gsLoginPage = 'TOB';
                    } else if (sourceid == 'lnkDelPay') {
                        gsLoginPage = 'DELPAY';
                    }
                    $('#mnuLogLogon').css("cursor", "pointer");
                    $('#mnuLogLogon').css("color", "blue");
                    // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogLogon)

                    ShowForm('LogLogin');
                    break;
                case 'lnkPIN':
                    $('#mnuLogPinApply').css("cursor", "pointer");
                    $('#mnuLogPinApply').css("color", "blue");
                    //  parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogPinApply)
                    ShowForm('LogPinApply');
                    break;
                case 'lnkID':
                    //   parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogNewAcct)

                    $('#mnuLogNewAcct').css("cursor", "pointer");
                    $('#mnuLogNewAcct').css("color", "blue");
                    ShowForm('LogApplyFirst');
                    break;
                case 'lnkCoupon':
                case 'lnkNTL':
                    $('#mnuLogPayCoupon').css("cursor", "pointer");
                    $('#mnuLogPayCoupon').css("color", "blue");
                    // parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogPayCoupon)
                    if (sourceid == 'lnkNTL') {
                        bNtlOnly = 'TRUE';
                    } 	//if
                    ShowForm('LogCoupon');
                    //			parent.DocWin.location.href = '../PayCoupon/Login_paycoupon.asp'
                    break;
            } 	//switch
        } 	//MainLinks
        </script>
   
</head>
<body>
    <div id="LogMain" style="DISPLAY: block; margin:0; padding:0;">
  <div class="blocks_holder">
    
    	<div class="white_block" id="lnkInstruction" onclick="parent.InstructionLinks()"> 
       	  <h3> Frequenty  ASKed  Questions </h3>
         <img src="../Content/images/question.jpg" width="119" height="96" alt="" />
         	
            <p>  Instructions &amp; Frequently Asked Questions  </p>
         
         </div>
    	
        <div class="white_block norightmargin" id="lnkID" onclick="MainLinks()"> 
        
         <h3>Register  FOR  TAX ACCOUNT NO</h3>
         <img src="../Content/images/monitor.jpg" width="119" height="96" alt="" />
         	
            <p> After successful 
				registration, you will receive an e-mail confirmation that includes your account number and PIN.</p>
         
        
         </div>
        
        <div class="white_block" id="lnkCoupon" onclick="MainLinks()"> 
        
         <h3>Print A payment Coupon</h3>
         <img src="../Content/images/print.jpg" width="119" height="96" alt="" />
         	
            <p> You must be registered 
						for the tax type in order to print a coupon. School Income Tax and Earnings Tax coupons require
						a PIN number.  </p>
         
        
        </div>
        
        <div class="white_block norightmargin" id="lnkNTL" onclick="MainLinks()"> 
        
         <h3>Report No tax liability</h3>
         <img src="../Content/images/payment.jpg" width="119" height="96" alt="" />
         	
            <p>If you do not have
						payroll for a reporting period, you must file a coupon indicating no tax due to prevent a non-
						filer notice.  </p>
         
        
        </div>
        
        <div class="clear"></div>
        
        
        
        
        
    </div>
    
    <div class="rightblock_holder">
    
    	<div class="quicklink_header">Quick Links</div>
        
        <div class="quicklink_body">
        
        	<ul class="checkmarks">
            	<li><a id="lnkSIT" onclick="MainLinks()">School Income Tax </a></li>
                <li><a id="lnkWage" onclick="MainLinks()">Wage Tax Annual Reconciliation  </a></li>
                <li><a id="lnkBPTez" onclick="MainLinks()">Business Income and Receipts EZ Return </a></li>
                <li><a id="lnkBPTlf" onclick="MainLinks()">Business Income and Receipts Tax Long Form  </a></li>
                <li><a id="lnkNPT" onclick="MainLinks()">Net Profits Tax Return </li>

                <li><a id="lnkU&O" onclick="MainLinks()">Use & Occupancy Tax Return </a></li>
                <li><a id="lnkTOB" onclick="MainLinks()">Tobacco Tax Return </a></li>
                <li><a id="lnkDelPay" onclick="MainLinks()">Pay Delinquent Tax Bill </a></li>
            </ul>
        
        </div>
        
       	<div class="quicklink_btm"></div>
    
    
    </div>

    </div>
   
</body>
</html>
