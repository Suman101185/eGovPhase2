<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    
    <title></title>
</head>
<body>
    <div style="display: none;" id="divNtlThankYou" class="tab_content">
            <h2 ><span id="AppHeaderThankyou">No Tax Liability - Payment Reciept</span>  </h2>
           	
            <div class="thankyou">
            <h4 id=hdrThankYou>Your No Tax Liability Payment Coupon has been posted. <br>
					You may want to print a copy of this page for your records.<br>
					Thank you for posting your
                <label class='lblTextBlack' id='lblPeriod'></label>&nbsp;No Tax Liability coupon online.
            </h4>
            
            <p>Name   : <label class='lblTextBlack' id='lblName'></label></p>
            <p>Account No.    : <label class='lblTextBlack' id='lblAcctNo'></label></p>
            <p>Your Confirmation No. is: <label class='lblTextBlack' id='lblConfirmNo'></label></p>
            
        
          
            <div class="clear"></div>
            
            
        
            
            <div class="smaller_form">
            	
            	
                <input type="button" class="submit_button" value="Thank You" id="btnNtlThankYou" name="btnNtlThankYou" onclick="DoThankYou()"/>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
        </div>
     	
</body>
</html>
