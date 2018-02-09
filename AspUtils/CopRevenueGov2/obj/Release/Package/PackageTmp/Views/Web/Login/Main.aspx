<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<%
    Session["AccNum"] = "";
%>

<html>
<head>

<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />

<script type="text/javascript" language="javascript">
    var txtHeader = 'Taxpayer Information';
    var gsLoginPage = '';
    var regInteger = new RegExp("[0-9]{1,13}");

    function isLoaded() {
        if (parent.MenuWin.document.readyState != 'complete' && 
                parent.HeaderWin.document.readyState != 'complete' &&
                parent.NavWin.document.readyState != 'complete') {
            setTimeout('isLoaded()',100);
        }		//if
    }		//isLoaded


   


    $(document).ready(function(){
        setTimeout('isLoaded()', 100);
        parent.NavWin.ClearImages();
        if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount,"ENTITY_INFO ENTITY_ID",'',0) == '') {
            ShowForm('LogMain');
        } else if (parent.MenuWin.bChangePin == true){
            ShowForm('LogChangePin');
            parent.MenuWin.bChangePin = false;
        }		//if
		
        if ('<%= CopMvcUtil.GetString(Session["Redirect"]) %>' == 'COUPON' || parent.MenuWin.bLoadCoupon == true) {
			<% Session["Redirect"] = ""; %>
		    parent.MenuWin.bLoadCoupon = false;
		    ShowForm('LogCoupon');
		    parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogPayCoupon);
		}		//if
		
    parent.document.title = parent.window.gTitle;	

});


    function ShowForm(id) {
    
        $('#AppError').text('');

        $('#LogMain').css('display', 'none');
        //LogPinApply.style.display = 'none';
        $('#LogPinApply').css('display', 'none');
        //LogLogin.style.display = 'none';
        $('#LogLogin').css('display', 'none');
        //LogChangePin.style.display = 'none';
        $('#LogChangePin').css('display', 'none');
        //LogApplyFirst.style.display = 'none';
        $('#LogApplyFirst').css('display', 'none');
        //divForgotPin.style.display = 'none';
        $('#divForgotPin').css('display', 'none');
        //ApplyPinThankYou.style.display = 'none';
        $('#ApplyPinThankYou').css('display', 'none');
        //LogCoupon.style.display = 'none';
        $('#LogCoupon').css('display', 'none');
	
	
        try{
            if (id == 'LogMain') {
                DisplayMain();
            } 
            else if (id == 'LogPinApply') {
                DisplayPinApply();
            } 
            else if (id == 'LogLogin') {
                DisplayLogin();
            } 
            else if (id == 'LogChangePin') {
                //alert('LogChangePin : ' + id);
                DisplayChangePin();
            } 
            else if (id == 'LogApplyFirst') {
                DisplayApplyFirst();
            } 
            else if (id == 'divForgotPin') {
                DisplayForgotPin();
            } 
            else if (id == 'ApplyPinThankYou') {		
                DisplayThankYou('');		
            } 
            else if (id == 'LogCoupon') {
                DisplayCoupLogin();
            }
        }
        catch(exp)
        {
            alert('ShowForm : ' + exp);
        }
    }		

</script>



<title></title>
</head>
<body>

    <%
        Html.RenderAction("AppHeader", "INC");
        Html.RenderAction("Main", "Login");
        Html.RenderAction("Login", "Login");
        Html.RenderAction("PayCoupon", "Login");
        Html.RenderAction("PinApply", "Login");
        Html.RenderAction("ApplyFirst", "Login");
        Html.RenderAction("ChangePin", "Login");
        Html.RenderAction("ForgotPin", "Login");
        Html.RenderAction("ThankYou", "Login");
        Html.RenderAction("Email", "Login"); 
        
        
    %>
     

</body>
</html>
