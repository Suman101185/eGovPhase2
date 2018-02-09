<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:700,300,600,400' rel='stylesheet' type='text/css'/>
    <link href="Content/Styles/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="Content/Scripts/JqueryMin.js"></script>
     <%-- <script type="text/javascript" language="javascript" src="Content/Scripts/treeMenu.js"></script>--%>
     <script type="text/javascript" language="javascript" src="Content/Scripts/jquery.browser.min.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/global.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/ispFunctions.js"></script>
    <!-- Bootstrap Core CSS -->
    <link type="text/css" href="Content/Styles/bootstrap.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link type="text/css" href="Content/Styles/copegov.css" rel="stylesheet" />
    <link type="text/css" href="Content/Styles/style.css" rel="stylesheet" />
    <link href="../Content/Styles/Font.css" rel="stylesheet" />
    <link type="text/css" href="Content/Styles/jPushMenu.css" rel="stylesheet" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="Content/js/jquery.js"></script>
    <script type="text/javascript" src="Content/js/iframe.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script type="text/javascript" src="Content/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="Content/js/jPushMenu.js"></script>
    <%--<script type="text/javascript" src="Content/js/jquery.nanoscroller.js"></script>--%>
    <!--call jPushMenu, required-->
    <%--  <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('.toggle-menu').jPushMenu();
        });
    </script>--%>
    <!-- FOR TREE MENU -->
    <%--<script type="text/javascript" src="Content/js/treeMenu.js"></script>--%>
    <!-- FOR TREE MENU -->
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
            //setErrorMessage("");
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
                //iFrameID.height = "";
                //iFrameID.height = (iFrameID.contentWindow.document.body.scrollHeight + 12) + "px";
                //alert("hi");
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


    <div class="container-fluid no-margin">
        <div class="row block1 sticky-header">

            <div class="col-lg-4">
                <div class="logo_placer">
                    <img src="Content/images/logo.png" width="" height="" alt="" /></div>
            </div>

        </div>

        <!-- FOR Header SECTION -->

        <!-- FOR Welcome SECTION -->
        <div class="row block2 sticky-margin">

            <div class="col-lg-3 col-md-6 col-sm-6" style="display: block;">
                <h2 id="hwelcomeText">Welcome</h2>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-5 right_area pull-right text-right">
                <h2 id="hdateTime"></h2>
                <img src="Content/images/question.png" alt="" />
                <img src="Content/images/print.png" alt="" onclick="doPrintDocWin()" />

                <a class="button_1" id="ancLogin" onclick="loadLogin()">Login</a>

            </div>

        </div>

        <!-- FOR Welcome SECTION -->
    </div>
    <!-- FOR Menu and docwin SECTION -->
    <div class="container-fluid no-padding">

         <!-- FOR Menu SECTION -->

                <% Html.RenderAction("Menu", "Menu"); %>
         <!-- FOR Menu SECTION -->
        
      <%--  <div class="block3">

            <!-- FOR Docwin SECTION -->
            <div class="container-fluid">--%>
                <div class="row">
                    <!--Error Section starts here-->
                  
                        <div id="AppError" class="col-lg-12 bg-danger-custom" style="display:block;">
                        
                           </div>
                   
                    <!--Error Section starts here-->
                    <div class="clear"></div>

                    <iframe id="ifrmDocwin" src="Login/MainAsp" style="background: #F1f1f1;" class="iframe embed-responsive" allowtransparency="true"></iframe>

                </div>
            </div>
            <!-- FOR Docwin SECTION -->


            <%--<div class="clear"></div>--%>
      <%--  </div>
        <!-- FOR Menu and docwin SECTION -->
    </div>--%>
    <!-- FOR Footer SECTION -->
    <footer>
     	<div class="block4">&nbsp;</div>
     </footer>
    <!-- FOR Footer SECTION -->

    <%--   <script>
        jQuery(document).ready(function ($) {
            $('.toggle-menu').jPushMenu();
        });
    </script--%>
    <!-- FOR TREE MENU -->
   <%-- <script type="text/javascript" src="js/treeMenu.js"></script>--%>
    <!-- FOR TREE MENU -->
    <%--<script type="text/javascript">
        $(function () {
            $(".nano").nanoScroller();
 
        });

</script>--%>
</body>
</html>

