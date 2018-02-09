<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<%
    Session["AccNum"] = "";
%>


<script type="text/javascript" language="javascript" src="../Content/Scripts/jquerymin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/global.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>

<%--<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />--%>

<script type="text/javascript" language="javascript">
    var txtHeader = 'Taxpayer Information';
    var gsLoginPage = '';
    var regInteger = new RegExp("[0-9]{1,13}");

    function isLoaded() {
        if (parent.document.readyState != 'complete') {
            setTimeout('isLoaded()', 100);
        }		//if
    }		//isLoaded



    $(document).ready(function () {

        setTimeout('isLoaded()', 100);
        //parent.NavWin.ClearImages();//Sanghamitra
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ENTITY_INFO ENTITY_ID", '', 0) == '') {
            ShowForm('LogMain');
        } else if (parent.bChangePin == true) {

            ShowForm('LogChangePin');
            parent.bChangePin = false;
        }		//if

        if ('<%= CopMvcUtil.GetString(Session["Redirect"]) %>' == 'COUPON' || parent.bLoadCoupon == true) {
               
			<% Session["Redirect"] = ""; %>
            parent.bLoadCoupon = false;
            ShowForm('LogCoupon');

            // parent.ispHighlightMenu(parent.mnuLogPayCoupon);//Sanghamitra

        }		//if

        parent.document.title = parent.window.gTitle;

    });


    function ShowForm(id) {
        //alert(id);
        $(parent.AppError).text('');
        $('#LogMain').css('display', 'none');
        $('#LogPinApply').css('display', 'none');
        $('#LogLogin').css('display', 'none');
        $('#LogChangePin').css('display', 'none');
        $('#LogApplyFirst').css('display', 'none');
        $('#divForgotPin').css('display', 'none');
        $('#ApplyPinThankYou').css('display', 'none');
        $('#LogCoupon').css('display', 'none');
        $('#divPinApply').css('display', 'none');
        $('#divLogin').css('display', 'none');
        $('#divApplyFirst').css('display','none');


        try {
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
        catch (exp) {

            alert('ShowForm : ' + exp);
        }
        //var iFrameID = parent.window.frames['ifrmDocwin'];
        //$(iFrameID).height($(iFrameID).contents().find("html").height() + 597);
        //alert ($(iFrameID).height()+"l1");
        //   loadiframe(); // binoy
    }

    function loadiframe() {


        if ($.browser.firefox || $.browser.mozilla || $.browser.opera || $.browser.safari || $.browser.chrome) {

            var iFrameID = parent.window.frames['ifrmDocwin'];

            // $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);

        }
        else {

            var iFrameID1 = document.getElementById('ifrmDocwin');

            if (iFrameID1) {
                // here you can make the height, I delete it first, then I make it again
                // iFrameID.height = "2500px";
                //iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

            }
        }
    } // binoy


</script>




<div>
    <%
        
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
</div>
