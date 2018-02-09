<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <% Response.Buffer = true; %>

    <%
        Session["Redirect"] = "";
        if (Request.QueryString.Count != 0)
        {
            if (Request.QueryString["coupon"] == "yes")
            {
                Session["Redirect"] = "COUPON";
            }
        }

    %>

    <title><%= COPSession.TITLE %></title>
    <%--<link href="Content/Styles/style.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript" language="javascript" src="Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/global.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/treeMenu.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/jquery.browser.min.js"></script> 
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">
        
        var $g = new global();
        var $x = new xmlProc($g);

        var DocHeight;

        var gTitle = '<%= COPSession.TITLE %>';
        var gEnvironment = '<%= COPSession.ENVIRONMENT %>';
        var gUserAddr = '<%  Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>';
        var gMerchant_ID = '<%= COPSession.CC_Rev_MerchantID %>';
        var gBPT_SourceCodeIndex = '<%= COPSession.CC_BPT_SourceCodeIndex %>';
        var gBPT_LicenseFee = '<%= COPSession.CC_BPT_LicenseFee %>';


        function window_onload() {
            MenuWin.height = Main.scrollHeight - 60;
        }


        $(document).ready(function () {
            output = getCurrentDate();
            $("#hdateTime").text(output);
            setErrorMessage("");
            //setFrameUrl("Content/DemoDocWinHtmls/BPTezForm.html");
            // setFrameUrl("Acct/ApplyMain");
            $("#ifrmDocwin").load(function () {
            
                if ($.browser.firefox || $.browser.mozilla || $.browser.opera || $.browser.safari ) {
                   
                    try {
                       

                        $(this).height($(this).contents().find("html").height() + 100);
                    }
                    catch (ee) {
                        var iFrameID1 = document.getElementById('ifrmDocwin');

                        iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 100) + "px";

                    }
                }
                else if($.browser.chrome)
                {
                    try {
                        var iFrameID = parent.window.frames['ifrmDocwin'];

                        $(iFrameID).height($(iFrameID).contents().find("html").height() + 100);
                    }
                    catch (ee) {
                        var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                        iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 100) + "px";

                    }
                }
                else {
                   
                    var iFrameID1 = document.getElementById('ifrmDocwin');
                
                    if (iFrameID1) {
                        // here you can make the height, I delete it first, then I make it again
                        // iFrameID.height = "2500px";
                        iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 100) + "px";

                    }
                }
               
            }); //binoy
        });

        //Global Functions starts here

        //Set Iframe url [url Path- Folder/Page]
        function setFrameUrl(url) {
            var $iframe = $('#ifrmDocwin');
            if ($iframe.length) {
                $iframe.attr('src', url);
                return false;
            }
            return true;
        }

        //Fill user welcome section [WelcomeTextControl ID-hwelcomeText, LoginTextControl ID-ancLogin] 
        function fillUserAfterLogin(isLoggedIn, uName) {

            if (isLoggedIn) {
                $("#hwelcomeText").text('Welcome   ' + uName);

                $("#ancLogin").text("Logout");
            } else {
                $("#ancLogin").text("Login");
                $("#hwelcomeText").text('Welcome   ' + uName);
            }
        }

        //Get current date in MDY(US) format
        function getCurrentDate() {
            var d = new Date();
            var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = months[month - 1] + ' ' + (day < 10 ? '0' : '') + day + ' ' + d.getFullYear();
            return output;

        }
        //Check main iframe load [ID: ifrmDocwin] 
        function iframeLoaded() {

            var iFrameID = document.getElementById('ifrmDocwin');

            if (iFrameID) {
                // here you can make the height, I delete it first, then I make it again
               // iFrameID.height = "";
               // iFrameID.height = (iFrameID.contentWindow.document.body.scrollHeight + 12) + "px";
            }
        }

        //Print the contents of the Iframe [ID: ifrmDocwin]
        function doPrintDocWin() {
            var browser = navigator.appName;
            var PDF = document.getElementById('ifrmDocwin'); //Iframe ID
            PDF.focus();
            PDF.contentWindow.print();
        }

        //Setting error message [divId-AppError]
        function setErrorMessage(errMessage) {
            $("#AppError").text(" ");
            if (errMessage != "") {
                $("#AppError").text(errMessage);
            } else {
                $("#AppError").text(" ");
            }
        }

        //Setting warning message [divId-AppError]
        function setWarningMesage(warMessage) {
            $("#AppError").text(" ");
            if (warMessage != "") {
                $("#AppError").text(warMessage);
            } else {
                $("#AppError").text("Warning");
            }
        }

        //Setting success message [divId-AppError]
        function setSuccessMessage(successMessage) {
            $("#AppError").text(" ");
            if (successMessage != "") {
                $("#AppError").text(successMessage);
            } else {
                $("#AppError").text("Success");
            }
        }

        //Setting clear message [divId-AppError]
        function setClearMessage() {
            $("#AppError").text(" ");
        }

        //Load Login section
        function loadLogin() {
            var isLoggedin = $("#ancLogin").text();

            if (isLoggedin == 'Logout') {
                var menu_logout = document.getElementById('mnuLogLogout');     //sangha

                ispMenu_onclick(menu_logout);
                fillUserAfterLogin(false, '');
                setFrameUrl('Login/MainAsp');
            }
            else {
                document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogLogin');
            }
        }
        //Global Functions starts here
    </script>
</head>






<body>
<!-- FOR Header SECTION -->
<div class="block1">
	<%--<% Html.RenderAction("HeaderNew", "Home"); %>--%>
<div class="logo_placer">
<img width="460" height="67" alt="" src="Content/images/logo.png">
</div>
</div>
<!-- FOR Header SECTION -->

 <!-- FOR Welcome SECTION -->
    <div class="block2">

        <div class="wrap_section_further" style="display:block">

            <h2 id="hwelcomeText">Welcome</h2>

            <div class="right_area">

                <h2 id="hdateTime"></h2>
                <img src="Content/images/question.png" width="31" height="32" alt="" />
                <img src="Content/images/print.png" width="31" height="32" alt="" onclick="doPrintDocWin()" />

                <a  class="button_1" id="ancLogin" onclick="loadLogin()">Login</a>

            </div>

        </div>


    </div>
    <!-- FOR Welcome SECTION -->

<!-- FOR Menu and docwin SECTION -->
<div class="block3">

<!-- FOR Menu SECTION -->
<%--	<div class="nav_holder">
       
        <% Html.RenderAction("Menu", "Menu"); %>
    	
        
    </div>--%>
 <!-- FOR Menu SECTION -->
 
 <!-- FOR Docwin SECTION -->
    <div class="after_login_holder">
	<!--Error Section starts here-->
            <div class="" >
                <p id="AppError" class="errMessages ErrorBox" style="display:block;"></p>
            </div>
            <!--Error Section starts here-->
        <div class="clear"></div>

        <iframe id="ifrmDocwin" src="Login/MainAsp"  style="border:none; width:100%; overflow:hidden; "  scrolling="no" ></iframe> 
    </div>
   <!-- FOR Docwin SECTION -->
    
   
   <div class="clear"></div>
</div>
<!-- FOR Menu and docwin SECTION -->

<!-- FOR Footer SECTION -->
<div class="block4">&nbsp;</div>
<!-- FOR Footer SECTION -->

</body>
</html>

