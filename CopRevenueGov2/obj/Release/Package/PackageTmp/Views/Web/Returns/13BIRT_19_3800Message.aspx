<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    
 
<script language="javascript">
    function btn3800YN_onclick(btnClicked) {
        debugger;
        BirtEz_3800(btnClicked)
    } 	//btn3800YN_onclick
</script>
</head>
<body>
	<div id="BPT_19_3800" style="display:none; MARGIN-LEFT: 4%; width:75%">
		<br />
		<br />
		<p class="lblTextBlack"><b>Philadelphia Code Section 19-3800 Acknowledgement</b></p>
		<div id="div19_3800Msg">
			<p class="lblTextBlack">When you applied for your Business Income and Receipts Tax Account with The Philadelphia Revenue Department, you registered as a New Business as described in Philadelphia Code Section 19-3800.  You agreed to employ three non-family members within your first twelve months in business and to employ six non-family members between your eighteenth and twenty forth months in business. You further agreed that all qualifying employees will work full time and spend at least sixty percent of their time working in Philadelphia. Did you meet or do you plan to meet these hiring requirements to maintain your status as a New Business?</p>
		
			<input id="btnYes" type="radio" value="Yes" style="width:30; margin-left:100" LANGUAGE=javascript onclick="return btn3800YN_onclick(this)" />
			<label class="lblTextBlack">Yes</label>
			<input id="btnNo" type="radio" value="No" style="width:30; margin-left:100"  LANGUAGE=javascript onclick="return btn3800YN_onclick(this)"/>
			<label class="lblTextBlack">No</label>
		</div>
	</div>
</body>
</html>
