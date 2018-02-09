<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
   
    <title></title>
    <script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/javascript">

        var arrLoginErr = new Array()

        function DisplayThankYou(sLayer) {

            //ForgotPinThankYou.style.display = 'none'
            //LogPinApply.style.display = 'none'
            $('#ForgotPinThankYou').css('display', 'none');
            $('#ForgotPinThankYou').css('display', 'none');
            if (sLayer == 'APPLYPIN') {
                $('#ApplyPinThankYou').css('display', 'block');
            } else {
                ///ForgotPinThankYou.style.display = 'block'
                $('#ForgotPinThankYou').css('display', 'block');
            }		//if
            this.focus()
            $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
            $('#AppHeaderThankyouForgotPin').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
        }		//DisplayApplyPin


        function DoThankYou() {
            $('#ApplyPinThankYou').css('display', 'none')
            //ForgotPinThankYou.style.display = 'none';
            $('#ForgotPinThankYou').css('display', 'none')
            //alert($(parent.MenuWin.document).find('#mnuLogLogout'));
            //parent.MenuWin.mnuLogLogout.click();
            $(parent.document).find('#mnuLogLogout').first().trigger('click');
        }		//if

</script>
</head>
<body>
    
   <div class="tab_container">
        <div style="display: none;" Id="ApplyPinThankYou" class="tab_content">
            <h2 id="AppHeaderThankyou"></h2>
          
            <div class="thankyou">
                
      
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
				<tr vAlign="top" align="left">
					<td width="75%">
                          <h4  id="hdrThankYou" name="hdrThankYou">The PIN is now being generated. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
			<h4 >You must get the PIN from this e-mail before using "Online Services"</h4>
						</td>
				<td></td></tr>
			</table>
      </div>

           
            <form class="smaller_form">
            	
			<input class="submit_button" id="SubbtnExistThankYoumit1" name="btnThankYou"
					 type="button" value ="Thank You" onclick="DoThankYou()" />
               
                <div class="clear"></div>
            </form>
            <div class="clear"></div>
          
          <div class="quicklink_btm_gen"></div>
        </div>
     	
       
       <div style="display: none;" Id="ForgotPinThankYou" class="tab_content">
            <h2 id="AppHeaderThankyouForgotPin"></h2>
          
            <div class="thankyou">
                
      
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
				<tr vAlign="top" align="left">
					<td width="75%">
                          <h4  id="hdrThankYou" name="hdrThankYou">Your PIN is now being retrieved. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
						</td>
				<td></td></tr>
			</table>
      </div>

           
            <form class="smaller_form">
            	
			
               <input class="submit_button" id="btnExistThankYou" name="btnExistThankYou"
			  type="button" value="Thank You" onclick="DoThankYou()">
                <div class="clear"></div>
            </form>
            <div class="clear"></div>
          
          <div class="quicklink_btm_gen"></div>
        </div>  
    </div>
</body>

</html>
