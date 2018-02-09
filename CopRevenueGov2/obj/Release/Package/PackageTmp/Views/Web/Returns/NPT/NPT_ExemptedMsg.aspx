<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
    <title></title>
    <script language="javascript">
        function btnOk_onclick(btnClicked) {
            $(parent.document).find('#mnuAcctInfo').first().trigger('click');
            //$(parent.MenuWin.mnuAcctInfo).trigger('click');
        }

        function btn3800YN_onclick(btnClicked) {
            NPT_Exempted(btnClicked);
        }

</script>
</head>
<body>
   <div id="NPTExemptedMsg" style="display:none; MARGIN-LEFT: 4%; width:75%">
		<br />
		<br />
		<p class="lblTextBlack"><b>Account Exempted Acknowledgement</b></p>
		<div id="div19_3800Msg">
			<p class="lblTextBlack">
			If a business has completed the new business app and the account has the indicator, 
			the account should file BIRT and NPT where needed. 
			Once the account files the returns on-line they will be required to answer a question if they have met all criteria. 
			If they have, they will complete the BIRT and NPT as usual but the calculations for tax due will be zero on both returns. 
			If they answer the question No, the tax will calculate at the regular rate. </p>
			
			<input id="btnYes" type="radio" style="width:30px; margin-left:100px"  onclick="return btn3800YN_onclick(this)" />
			<label class="lblTextBlack">Yes</label>
			<input id="btnNo" type="radio" style="width:30px; margin-left:100px"   onclick="return btn3800YN_onclick(this)"/>
			<label class="lblTextBlack">No</label>
		</div>
	</div>
</body>
</html>
