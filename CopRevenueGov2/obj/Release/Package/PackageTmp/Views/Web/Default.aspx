<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%; margin: 0;">
<head>   
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />  

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
   
    <link href="Content/Styles/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="Content/Scripts/JqueryMin.js"></script> 
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

  
    <script type="text/javascript" src="Content/js/jquery.js"></script>
    <script type="text/javascript" src="Content/js/iframe.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script type="text/javascript" src="Content/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="Content/js/jPushMenu.js"></script>
 
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
            MenuWin.height = Main.scrollHeight - 60; //found one
           
        }
        $(document).ready(function () {
            output = getCurrentDate();
            $("#hdateTime").text(output);           
            getURL();
        });

        function getURL() {
            debugger;
            //''''''Sudipta''''''''''''''
            var currenturl = window.location.search;
            if (currenturl.indexOf("?status=true") !== -1) {
                redirectURL = 'Login/MainAsp?status=true';
                $('#divPayments').css("display", "block");
                $('#divPayments').each(function () {
                    $(this).css("display", "block");
                });
                $('#divPayments1').css("display", "block");
                $('#divPayments1').each(function () {
                    $(this).css("display", "block");
                });
                $('#divReturns').css("display", "block");
                $('#divReturns li').each(function () {
                    $(this).css("display", "block");
                });

            }
            if (currenturl.indexOf("?status=false") !== -1) {
                redirectURL = 'Login/MainAsp?status=false';
                $('#divPayments').css("display", "block");
                $('#divPayments').each(function () {
                    $(this).css("display", "block");
                });
                $('#divPayments1').css("display", "block");
                $('#divPayments1').each(function () {
                    $(this).css("display", "block");
                });
                $('#divReturns').css("display", "block");
                $('#divReturns li').each(function () {
                    $(this).css("display", "block");
                });
            }

            if (currenturl.indexOf("?status=false") == -1 && currenturl.indexOf("?status=true") == -1) {
                redirectURL = 'Login/MainAsp';
                $('#divPayments').css("display", "none");
                $('#divPayments1').css("display", "none");
                $('#divReturns').css("display", "none");
            }
            var $iframe = $('#ifrmDocwin');
            if ($iframe.length) {
                $iframe.attr('src', redirectURL);
            }
           
            
        }


        //Global Functions starts here

        //Set Iframe url [url Path- Folder/Page]
        function setFrameUrl(url) {
            debugger;
            var $iframe = $('#ifrmDocwin');
            if ($iframe.length) {
                var currenturl = window.location.search;
                if (currenturl.indexOf("?status=false") != -1 || currenturl.indexOf("?status=true") != -1) {
                    localStorage.setItem("AccountNumber", '');
                    localStorage.setItem("Pin", '');                    
                    history.pushState(null, null, 'http://' + window.location.host + '/');
                  
                }
                $iframe.attr('src', url);
                return false;
                    
            }
            return true;
        }

       
        function fillUserAfterLogin(isLoggedIn, uName) {

            if (isLoggedIn) {
                var uNamelink = "<a style=\"cursor: pointer\" onclick=\"setFrameUrl('Acct/ApplyMain')\">" + uName + "</a>";
                $("#hwelcomeText").html('Welcome   ' + uNamelink);              
                $("#ancLogin").css("display", "block");
                $("#ancLogin").text("Logout");
            } else {
                $("#ancLogin").text("Login");
                $("#ancLogin").css("display", "none");
                $("#hwelcomeText").text("");
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
                //'''''Sudipta''''''''''''''
                localStorage.setItem("AccountNumber", '');
                localStorage.setItem("Pin", '');
                localStorage.setItem("AccountName", '');
                var var_origin = window.location.origin;
              
                if (var_origin == null) {                    
                    window.location.replace('http://' + window.location.host + '/');
                }
                else {                 
                    window.location.replace(window.location.origin + '/');
                }
                //''''''''''''''
                setFrameUrl('Login/MainAsp');
                document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogLogin');
            }
            else {
              
               
                if ((document.getElementById('ifrmDocwin').src == 'http://' + window.location.host + '/CopRevenue2Test/PayCoupon/PayCoupon' + '?y=aaa=1&el_payc_ind=1') || 
                    (document.getElementById('ifrmDocwin').src == 'http://' + window.location.host + '/CopRevenue2Test/PayCoupon/PayCoupon' + '?y=aaa=2&el_payc_ind=2'))
                    {
                    setFrameUrl('Login/MainAsp');
                    document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogLogin');
                    //$('#LogMain').css('display', 'block');
                }            
                else
                {
                    document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogLogin');
                }
                
            }
        }
        //Global Functions starts here

        function ScrollTop(value) {
            if (value != '')//by manoranjan
            {
                $('html,body').animate({ scrollTop: $('#tab').offset().top }, 500);
            }
        }
        function loadimage() {
            
        }


        function ClickHelp() {
            window.open(window.location.origin+"/PDF/Online Services Instructions 20160209.pdf")
        }
    </script>
   
</head>


<body style="height:100%; margin: 0;">
    <!-- FOR Header SECTION -->

    <div style="min-height: 100%;  margin-bottom: -50px;">


    <div class="container-fluid no-margin"  id="tab" >
        <div class="row block1 sticky-header">

            <div class="col-lg-4">
                <div class="logo_placer">
                   <a> <img src="Content/images/logo.png" width="" height="" alt="" /></a>

                </div>
               
            </div>
           <%-- <div class="col-lg-8">
                 <p style="color:white;font: 14px/18px Verdana;padding-top:22px">2009-2011 returns must be download from https://beta.phila.gov/services/payments-assistance-taxes/tax-forms-instructions/ then mailed into the office. Returns prior 2009 can be obtained via customer service at 215 686-6600 or revenue@phila.gov. </p>
            </div>--%>
        </div>

        <!-- FOR Header SECTION -->

        <!-- FOR Welcome SECTION -->
        <div class="row block2 sticky-margin">

            <div class="col-lg-3 col-md-6 col-sm-6" style="display: block;">
                <h2 id="hwelcomeText"></h2>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-5 right_area pull-right text-right">
                <h2 id="hdateTime"></h2>
               <a href="#" onclick="ClickHelp()"> <img src="Content/images/question.png" alt="" /></a>
                <img src="Content/images/print.png" alt="" onclick="doPrintDocWin()" style="display:none" />

                <a class="button_1" id="ancLogin" onclick="loadLogin()" style="display:none; width:94px; float:right; margin-top:7px; padding-top:7px; padding-bottom:5px; margin-left:8px;">Login</a>

            </div>

        </div>

        <!-- FOR Welcome SECTION -->
    </div>
    <!-- FOR Menu and docwin SECTION -->
    <div class="container no-padding">

         <!-- FOR Menu SECTION -->

                <% Html.RenderAction("Menu", "Menu"); %>
         <!-- FOR Menu SECTION -->
        

                <div class="row">
                  
                    <div class="clear"></div>

                    <iframe id="ifrmDocwin"  style="background: #F1f1f1;" class="iframe embed-responsive" allowtransparency="true"></iframe>

                </div>
            </div>
            <!-- FOR Docwin SECTION -->

</div>
          
      
    <!-- FOR Footer SECTION -->
    <footer>
     	<div class="block4">&nbsp;</div>
     </footer>
   
</body>
</html>

