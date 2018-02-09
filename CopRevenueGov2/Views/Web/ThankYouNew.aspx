<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    
    <title></title>
    <script ID="clientEventHandlersJS" LANGUAGE="javascript">

        var arrLoginErr = new Array()

        function DisplayThankYou(sLayer) {
            ForgotPinThankYou.style.display = 'none'
            LogPinApply.style.display = 'none'
            if (sLayer == 'APPLYPIN') {
                ApplyPinThankYou.style.display = 'block'
            } else {
                ForgotPinThankYou.style.display = 'block'
            }		//if
            this.focus()
            AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|thank you</Font>'
        }		//DisplayApplyPin


        function DoThankYou() {
            ApplyPinThankYou.style.display = 'none'
            ForgotPinThankYou.style.display = 'none'
            parent.mnuLogLogout.click()
        }		//if

</script>
</head>
<body>
    <div class="tab_container">
        <div style="display: none;" Id="" class="tab_content">
            <h2 id="AppHeaderThankyou"></h2>
          
            <div class="thankyou">
               
      <div Id="ApplyPinThankYou" Name="ApplyPinThankYou" style="DISPLAY: none; VISIBILTY: visible">
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
				<tr vAlign="top" align="left">
					<td width="75%">
                          <h4  id="hdrThankYou" name="hdrThankYou">The PIN is now being generated. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
                        <h4>You must get the PIN from this e-mail before using "Online Services"</h4>
						</td>
				<td></td></tr>
			</table>

          <table cellSpacing="0" cellPadding="0" width="60%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=40 valign="bottom">
		<td align="middle">
            <input class="submit_button" id="btnThankYou" name="btnThankYou"
					 type="submit" value ="Thank You" onclick="DoThankYou()" />
		</td></tr>
</table>
      </div>

       <div Id="ForgotPinThankYou" Name="AcctExistThankYou" style="DISPLAY: none; VISIBILTY: visible">
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
				<tr vAlign="top" align="left">
					<td width="75%">
						
                     <h4  id="hdrThankYou1" name="hdrThankYou">Your PIN is now being retrieved. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
						</td>
				<td></td></tr>
				</table>
		</div>
           <table cellSpacing="0" cellPadding="0" width="60%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=40 valign="bottom">
		<td align="middle">
           	<input class="submit_button" id="btnExistThankYou" name="btnExistThankYou"
			  type="submit" value="Thank You" onclick="DoThankYou()">
		</td></tr>
</table>
		    
 
            
            <div class="clear"></div>
            </div>
            <div class="quicklink_btm_gen"></div>
        </div>
     	
    </div>
</body>
</html>
